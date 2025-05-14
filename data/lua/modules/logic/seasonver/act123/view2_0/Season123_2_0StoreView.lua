module("modules.logic.seasonver.act123.view2_0.Season123_2_0StoreView", package.seeall)

local var_0_0 = class("Season123_2_0StoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
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
	arg_6_0:refreshStoreContent()
end

function var_0_0._onGet107GoodsInfo(arg_7_0, arg_7_1)
	if arg_7_1 ~= arg_7_0.actId then
		return
	end

	arg_7_0:refreshStoreContent()
end

function var_0_0._onBuyGoodsSuccess(arg_8_0, arg_8_1)
	if arg_8_1 ~= arg_8_0.actId then
		return
	end

	arg_8_0:refreshStoreContent()
end

function var_0_0.refreshStoreContent(arg_9_0)
	local var_9_0 = ActivityStoreConfig.instance:getActivityStoreGroupDict(arg_9_0.actId)
	local var_9_1 = {}

	if var_9_0 then
		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			for iter_9_2, iter_9_3 in pairs(iter_9_1) do
				table.insert(var_9_1, iter_9_3)
			end
		end
	end

	Season123StoreModel.instance:setStoreItemList(var_9_1)
end

function var_0_0.refreshTime(arg_10_0)
	local var_10_0 = ActivityModel.instance:getActMO(arg_10_0.actId):getRealEndTimeStamp() - ServerTime.now()
	local var_10_1 = Mathf.Floor(var_10_0 / TimeUtil.OneDaySecond)
	local var_10_2 = var_10_0 % TimeUtil.OneDaySecond
	local var_10_3 = Mathf.Floor(var_10_2 / TimeUtil.OneHourSecond)
	local var_10_4 = var_10_2 % TimeUtil.OneHourSecond
	local var_10_5 = Mathf.Ceil(var_10_4 / TimeUtil.OneMinuteSecond)

	arg_10_0._txttime.text = string.format(luaLang("versionactivitystoreview_remaintime"), var_10_1, var_10_3, var_10_5)
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.refreshTime, arg_11_0)
	arg_11_0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnGet107GoodsInfo, arg_11_0._onGet107GoodsInfo, arg_11_0)
	arg_11_0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_11_0._onBuyGoodsSuccess, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
