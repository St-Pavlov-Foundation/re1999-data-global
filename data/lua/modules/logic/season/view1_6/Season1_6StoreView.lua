module("modules.logic.season.view1_6.Season1_6StoreView", package.seeall)

local var_0_0 = class("Season1_6StoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_time")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_store/Viewport/#go_Content")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(SeasonViewHelper.getSeasonIcon("full/shangcheng_bj.png"))
	gohelper.setActive(arg_4_0._gostoreItem, false)

	arg_4_0.storeItemList = arg_4_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnGet107GoodsInfo, arg_6_0._onGet107GoodsInfo, arg_6_0)
	arg_6_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_6_0._onBuyGoodsSuccess, arg_6_0)

	arg_6_0.actId = arg_6_0.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(arg_6_0.refreshTime, arg_6_0, TimeUtil.OneMinuteSecond)
	arg_6_0:refreshTime()
	arg_6_0:updateView()
end

function var_0_0._onGet107GoodsInfo(arg_7_0, arg_7_1)
	if arg_7_1 ~= arg_7_0.actId then
		return
	end

	arg_7_0:updateView()
end

function var_0_0._onBuyGoodsSuccess(arg_8_0, arg_8_1)
	if arg_8_1 ~= arg_8_0.actId then
		return
	end

	arg_8_0:updateView()
end

function var_0_0.updateView(arg_9_0)
	arg_9_0:refreshStoreContent()
end

function var_0_0.refreshStoreContent(arg_10_0)
	local var_10_0 = ActivityStoreConfig.instance:getActivityStoreGroupDict(arg_10_0.actId)
	local var_10_1 = {}

	if var_10_0 then
		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			for iter_10_2, iter_10_3 in pairs(iter_10_1) do
				table.insert(var_10_1, iter_10_3)
			end
		end
	end

	table.sort(var_10_1, var_0_0.sortGoods)

	for iter_10_4 = 1, math.max(#var_10_1, #arg_10_0.storeItemList) do
		local var_10_2 = arg_10_0.storeItemList[iter_10_4]

		if not var_10_2 then
			var_10_2 = Season1_6StoreItem.New(arg_10_0:getItemGo(iter_10_4))
			arg_10_0.storeItemList[iter_10_4] = var_10_2
		end

		var_10_2:setData(var_10_1[iter_10_4])
	end
end

function var_0_0.sortGoods(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.maxBuyCount ~= 0 and arg_11_0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(arg_11_0.activityId, arg_11_0.id) <= 0

	if var_11_0 ~= (arg_11_1.maxBuyCount ~= 0 and arg_11_1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(arg_11_1.activityId, arg_11_1.id) <= 0) then
		if var_11_0 then
			return false
		end

		return true
	end

	return arg_11_0.id < arg_11_1.id
end

function var_0_0.getItemGo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.viewContainer:getSetting().otherRes.itemPath

	return (arg_12_0.viewContainer:getResInst(var_12_0, arg_12_0._goContent, string.format("item%s", arg_12_1)))
end

function var_0_0.refreshTime(arg_13_0)
	local var_13_0 = ActivityModel.instance:getActMO(arg_13_0.actId):getRealEndTimeStamp() - ServerTime.now()
	local var_13_1 = Mathf.Floor(var_13_0 / TimeUtil.OneDaySecond)
	local var_13_2 = var_13_0 % TimeUtil.OneDaySecond
	local var_13_3 = Mathf.Floor(var_13_2 / TimeUtil.OneHourSecond)
	local var_13_4 = var_13_2 % TimeUtil.OneHourSecond
	local var_13_5 = Mathf.Ceil(var_13_4 / TimeUtil.OneMinuteSecond)

	arg_13_0._txttime.text = string.format(luaLang("versionactivitystoreview_remaintime"), var_13_1, var_13_3, var_13_5)
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.refreshTime, arg_14_0)
	arg_14_0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnGet107GoodsInfo, arg_14_0._onGet107GoodsInfo, arg_14_0)
	arg_14_0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_14_0._onBuyGoodsSuccess, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._simagebg:UnLoadImage()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.storeItemList) do
		iter_15_1:destory()
	end

	arg_15_0.storeItemList = nil
end

return var_0_0
