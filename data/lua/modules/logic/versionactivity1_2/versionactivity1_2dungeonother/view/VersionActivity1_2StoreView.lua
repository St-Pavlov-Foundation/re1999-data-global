module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2StoreView", package.seeall)

local var_0_0 = class("VersionActivity1_2StoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._scrollstore = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_store")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content")
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	arg_1_0._gostoregoodsitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "title/time/#txt_time")
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
	arg_4_0._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("linzhonggelou_bj"))
	gohelper.setActive(arg_4_0._gostoreItem, false)

	arg_4_0.storeItemList = {}
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)

	arg_6_0.actId = VersionActivity1_2Enum.ActivityId.DungeonStore

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(arg_6_0.actId, arg_6_0._onOpen, arg_6_0)
end

function var_0_0._onOpen(arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0.refreshTime, arg_7_0, TimeUtil.OneMinuteSecond)
	arg_7_0:refreshTime()
	arg_7_0:refreshStoreContent()
	arg_7_0:scrollToFirstNoSellOutStore()
end

function var_0_0.refreshTime(arg_8_0)
	local var_8_0 = ActivityModel.instance:getActivityInfo()[arg_8_0.actId]:getRealEndTimeStamp() - ServerTime.now()
	local var_8_1 = Mathf.Floor(var_8_0 / TimeUtil.OneDaySecond)
	local var_8_2 = var_8_0 % TimeUtil.OneDaySecond
	local var_8_3 = Mathf.Floor(var_8_2 / TimeUtil.OneHourSecond)

	if var_8_1 >= 1 then
		if LangSettings.instance:isEn() then
			arg_8_0._txttime.text = string.format(luaLang("remain"), string.format("%s%s %s%s", var_8_1, luaLang("time_day"), var_8_3, luaLang("time_hour2")))
		else
			arg_8_0._txttime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", var_8_1, luaLang("time_day"), var_8_3, luaLang("time_hour2")))
		end

		return
	end

	if var_8_3 >= 1 then
		arg_8_0._txttime.text = string.format(luaLang("remain"), var_8_3 .. luaLang("time_hour2"))

		return
	end

	local var_8_4 = var_8_2 % TimeUtil.OneHourSecond
	local var_8_5 = Mathf.Floor(var_8_4 / TimeUtil.OneMinuteSecond)

	if var_8_5 >= 1 then
		arg_8_0._txttime.text = string.format(luaLang("remain"), var_8_5 .. luaLang("time_minute2"))

		return
	end

	arg_8_0._txttime.text = string.format(luaLang("remain"), "<1" .. luaLang("time_minute2"))
end

function var_0_0.refreshStoreContent(arg_9_0)
	local var_9_0 = ActivityStoreConfig.instance:getActivityStoreGroupDict(arg_9_0.actId)
	local var_9_1

	for iter_9_0 = 1, #var_9_0 do
		local var_9_2 = arg_9_0.storeItemList[iter_9_0]

		if not var_9_2 then
			var_9_2 = VersionActivity1_2StoreItem.New()

			var_9_2:onInitView(gohelper.cloneInPlace(arg_9_0._gostoreItem))
			table.insert(arg_9_0.storeItemList, var_9_2)
		end

		var_9_2:updateInfo(iter_9_0, var_9_0[iter_9_0])
	end
end

function var_0_0.scrollToFirstNoSellOutStore(arg_10_0)
	local var_10_0 = arg_10_0:getFirstNoSellOutGroup()

	if var_10_0 <= 1 then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(arg_10_0._goContent.transform)

	local var_10_1 = recthelper.getHeight(arg_10_0._scrollstore.gameObject.transform)
	local var_10_2 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.storeItemList) do
		if var_10_0 < iter_10_0 then
			break
		end

		var_10_2 = var_10_2 + iter_10_1:getHeight()
	end

	arg_10_0._scrollstore.verticalNormalizedPosition = 1 - (var_10_2 - var_10_1) / (recthelper.getHeight(arg_10_0._goContent.transform) - var_10_1)
end

function var_0_0.getFirstNoSellOutGroup(arg_11_0)
	local var_11_0 = ActivityStoreConfig.instance:getActivityStoreGroupDict(arg_11_0.actId)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
			if iter_11_3.maxBuyCount == 0 then
				return iter_11_0
			end

			if iter_11_3.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(arg_11_0.actId, iter_11_3.id) > 0 then
				return iter_11_0
			end
		end
	end

	return 1
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.refreshTime, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simagebg:UnLoadImage()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.storeItemList) do
		iter_13_1:onDestroy()
	end

	arg_13_0.storeItemList = nil
end

return var_0_0
