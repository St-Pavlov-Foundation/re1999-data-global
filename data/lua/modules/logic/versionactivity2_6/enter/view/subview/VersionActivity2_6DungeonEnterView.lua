module("modules.logic.versionactivity2_6.enter.view.subview.VersionActivity2_6DungeonEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_6DungeonEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "logo/actbg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/actbg/#txt_time")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtStoreNum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_1_0._txtStoreTime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/#go_reddot")
	arg_1_0._btnFinished = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Finished")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshStoreCurrency, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivity, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnstoreOnClick, arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
	arg_2_0._btnFinished:AddClickListener(arg_2_0._btnFinishedOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshStoreCurrency, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.onRefreshActivity, arg_3_0)
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnenter:RemoveClickListener()
	arg_3_0._btnFinished:RemoveClickListener()
end

function var_0_0.onRefreshActivity(arg_4_0, arg_4_1)
	if arg_4_1 ~= arg_4_0.actId then
		return
	end

	arg_4_0:refreshActivityState()
end

function var_0_0._btnstoreOnClick(arg_5_0)
	VersionActivity2_6DungeonController.instance:openStoreView()
end

function var_0_0._btnenterOnClick(arg_6_0)
	VersionActivity2_6DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._btnFinishedOnClick(arg_7_0)
	return
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._txtstorename = gohelper.findChildText(arg_8_0.viewGO, "entrance/#btn_store/normal/txt_shop")
	arg_8_0.actId = VersionActivity2_6Enum.ActivityId.Dungeon
	arg_8_0.animComp = VersionActivity2_6SubAnimatorComp.get(arg_8_0.viewGO, arg_8_0)
	arg_8_0.goEnter = arg_8_0._btnenter.gameObject
	arg_8_0.goFinish = arg_8_0._btnFinished.gameObject
	arg_8_0.goStore = arg_8_0._btnstore.gameObject
	arg_8_0.actId = VersionActivity2_6Enum.ActivityId.Dungeon
	arg_8_0.actCo = ActivityConfig.instance:getActivityCo(arg_8_0.actId)

	arg_8_0:_setDesc()
	RedDotController.instance:addRedDot(arg_8_0._goreddot, RedDotEnum.DotNode.V2a6DungeonEnter)
end

function var_0_0._setDesc(arg_9_0)
	if not arg_9_0.actCo or not arg_9_0._txtdesc then
		return
	end

	arg_9_0._txtdesc.text = arg_9_0.actCo.actDesc
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:refreshUI()
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:refreshUI()
	arg_11_0.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(arg_11_0.everyMinuteCall, arg_11_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.everyMinuteCall(arg_12_0)
	arg_12_0:refreshUI()
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0:refreshRemainTime()
	arg_13_0:refreshActivityState()
	arg_13_0:refreshStoreCurrency()
end

function var_0_0.refreshRemainTime(arg_14_0)
	local var_14_0 = ActivityModel.instance:getActivityInfo()[arg_14_0.actId]:getRealEndTimeStamp() - ServerTime.now()

	if var_14_0 > 0 then
		local var_14_1 = TimeUtil.SecondToActivityTimeFormat(var_14_0)

		arg_14_0._txttime.text = var_14_1

		gohelper.setActive(arg_14_0._txttime, true)
	else
		gohelper.setActive(arg_14_0._txttime, false)
	end

	local var_14_2 = ActivityModel.instance:getActivityInfo()[VersionActivity2_6Enum.ActivityId.DungeonStore]

	arg_14_0._txtstorename.text = var_14_2.config.name
	arg_14_0._txtStoreTime.text = var_14_2:getRemainTimeStr2ByEndTime(true)
end

function var_0_0.refreshActivityState(arg_15_0)
	local var_15_0 = ActivityHelper.getActivityStatusAndToast(arg_15_0.actId)
	local var_15_1 = var_15_0 == ActivityEnum.ActivityStatus.Normal

	var_15_1 = var_15_1 or ActivityHelper.getActivityStatusAndToast(VersionActivity2_6Enum.ActivityId.EnterView) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_15_0.goEnter, var_15_1)
	gohelper.setActive(arg_15_0.goFinish, not var_15_1)

	local var_15_2 = var_15_0 == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(arg_15_0._gotime, not var_15_2)

	local var_15_3 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_6Enum.ActivityId.DungeonStore) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_15_0.goStore, var_15_3)
end

function var_0_0.refreshStoreCurrency(arg_16_0)
	local var_16_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a6Dungeon)
	local var_16_1 = var_16_0 and var_16_0.quantity or 0

	arg_16_0._txtStoreNum.text = GameUtil.numberDisplay(var_16_1)
end

function var_0_0.onClose(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.everyMinuteCall, arg_17_0)
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0.animComp:destroy()
end

return var_0_0
