module("modules.logic.main.view.MainBannerView", package.seeall)

local var_0_0 = class("MainBannerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._clickbag = arg_1_0:getUserDataTb_()
	arg_1_0._iconbag = arg_1_0:getUserDataTb_()
	arg_1_0._bgbag = arg_1_0:getUserDataTb_()
	arg_1_0._banners = {}
	arg_1_0._willDisapearBanner = 0

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:_clearAllClick()
end

function var_0_0._bannerOnClick(arg_4_0, arg_4_1)
	local var_4_0 = MainBannerConfig.instance:getbannerCO(tonumber(arg_4_1))

	if string.split(var_4_0.vanishingRule, "#")[1] == "2" then
		MainBannerModel.instance:addNotShowid(arg_4_1)
		arg_4_0:_refreshBanner()
	end

	if var_4_0.jumpId ~= 0 then
		GameFacade.jump(var_4_0.jumpId)
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_7_0._onCloseFullView, arg_7_0)
	arg_7_0:_refreshBanner()
end

function var_0_0._setBanner(arg_8_0, arg_8_1)
	local var_8_0 = MainBannerConfig.instance:getBannersCo()
	local var_8_1 = MainBannerConfig.instance:getNowBanner(arg_8_1)

	for iter_8_0 = 1, 3 do
		arg_8_0:_clearClick(iter_8_0)

		local var_8_2 = gohelper.findChild(arg_8_0.viewGO, "left/#go_banners/banner" .. iter_8_0)

		gohelper.setActive(var_8_2, false)
	end

	arg_8_0._banners = {}

	for iter_8_1, iter_8_2 in pairs(var_8_1) do
		if iter_8_2 ~= nil then
			local var_8_3 = gohelper.findChild(arg_8_0.viewGO, "left/#go_banners/banner" .. iter_8_1)

			gohelper.setActive(var_8_3, true)

			local var_8_4 = SLFramework.UGUI.UIClickListener.Get(var_8_3)
			local var_8_5 = gohelper.findChildSingleImage(var_8_3, "bannericon")

			var_8_5:LoadImage(ResUrl.getBannerIcon(var_8_0[iter_8_2].icon))
			table.insert(arg_8_0._iconbag, var_8_5)

			local var_8_6 = {
				var_8_4,
				iter_8_2
			}

			table.insert(arg_8_0._clickbag, var_8_6)
			table.insert(arg_8_0._banners, var_8_0[iter_8_2].id)
		end
	end

	for iter_8_3, iter_8_4 in pairs(arg_8_0._clickbag) do
		iter_8_4[1]:AddClickListener(arg_8_0._bannerOnClick, arg_8_0, iter_8_4[2])
	end
end

function var_0_0._setTimer(arg_9_0, arg_9_1)
	TaskDispatcher.cancelTask(arg_9_0._refreshBanner, arg_9_0)

	local var_9_0 = MainBannerConfig.instance:getNearTime(arg_9_1, arg_9_0._banners)

	if var_9_0 ~= nil then
		TaskDispatcher.runDelay(arg_9_0._refreshBanner, arg_9_0, var_9_0.time - arg_9_1 + 3)

		arg_9_0._willDisapearBanner = var_9_0.id
	end
end

function var_0_0._disapearBanner(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._banners) do
		if iter_10_1 == arg_10_0._willDisapearBanner then
			arg_10_0:_clearClick(iter_10_0)

			local var_10_0 = gohelper.findChild(arg_10_0.viewGO, "left/banners/banner" .. iter_10_0)

			gohelper.setActive(var_10_0, false)
		end
	end

	arg_10_0:_setTimer(ServerTime.now())
end

function var_0_0._refreshBanner(arg_11_0)
	local var_11_0 = ServerTime.now()

	arg_11_0:_setBanner(var_11_0)
	arg_11_0:_setTimer(var_11_0)
end

function var_0_0._clearClick(arg_12_0, arg_12_1)
	if arg_12_0._clickbag and arg_12_0._clickbag[arg_12_1] then
		arg_12_0._clickbag[arg_12_1][1]:RemoveClickListener()
	end
end

function var_0_0._clearAllClick(arg_13_0)
	if arg_13_0._clickbag then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._clickbag) do
			iter_13_1[1]:RemoveClickListener()
		end
	end
end

function var_0_0._onCloseFullView(arg_14_0, arg_14_1)
	if not ViewMgr.instance:hasOpenFullView() then
		arg_14_0:_refreshBanner()
	end
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_15_0._onCloseFullView, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._refreshBanner, arg_16_0)

	for iter_16_0, iter_16_1 in pairs(arg_16_0._iconbag) do
		iter_16_1:UnLoadImage()
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_0._bgbag) do
		iter_16_3:UnLoadImage()
	end
end

return var_0_0
