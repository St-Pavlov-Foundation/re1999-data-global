module("modules.logic.versionactivity2_5.enter.view.subview.VersionActivity2_5DungeonEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_5DungeonEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "logo/actbg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/time/#txt_time")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_task")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_task/#go_reddot")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtStoreNum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_1_0._txtStoreTime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/#go_reddot")
	arg_1_0._btnFinished = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Finished")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Locked")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshStoreCurrency, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivity, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnstoreOnClick, arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
	arg_2_0._btnFinished:AddClickListener(arg_2_0._btnFinishedOnClick, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._btnLockedOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshStoreCurrency, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.onRefreshActivity, arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnenter:RemoveClickListener()
	arg_3_0._btnFinished:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
end

function var_0_0.onRefreshActivity(arg_4_0, arg_4_1)
	if arg_4_1 ~= arg_4_0.actId then
		return
	end

	arg_4_0:refreshActivityState()
end

function var_0_0._btntaskOnClick(arg_5_0)
	VersionActivity2_5DungeonController.instance:openTaskView()
end

function var_0_0._btnstoreOnClick(arg_6_0)
	VersionActivity2_5DungeonController.instance:openStoreView()
end

function var_0_0._btnenterOnClick(arg_7_0)
	VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._btnFinishedOnClick(arg_8_0)
	GameFacade.showToast(ToastEnum.ActivityEnd)
end

function var_0_0._btnLockedOnClick(arg_9_0)
	GameFacade.showToast(ToastEnum.ActivityNotOpen)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._txtstorename = gohelper.findChildText(arg_10_0.viewGO, "entrance/#btn_store/normal/txt_shop")
	arg_10_0.actId = VersionActivity2_5Enum.ActivityId.Dungeon
	arg_10_0.animComp = VersionActivity2_5SubAnimatorComp.get(arg_10_0.viewGO, arg_10_0)
	arg_10_0.goEnter = arg_10_0._btnenter.gameObject
	arg_10_0.goFinish = arg_10_0._btnFinished.gameObject
	arg_10_0.goStore = arg_10_0._btnstore.gameObject
	arg_10_0.goLock = arg_10_0._btnLocked.gameObject
	arg_10_0.actId = VersionActivity2_5Enum.ActivityId.Dungeon
	arg_10_0.actCo = ActivityConfig.instance:getActivityCo(arg_10_0.actId)

	arg_10_0:_setDesc()
	RedDotController.instance:addRedDot(arg_10_0._goreddot, RedDotEnum.DotNode.V2a5DungeonEnter)
	RedDotController.instance:addRedDot(arg_10_0._gotaskreddot, RedDotEnum.DotNode.V2a5DungeonTask)
	gohelper.setActive(arg_10_0._btntask.gameObject, false)
end

function var_0_0._setDesc(arg_11_0)
	if not arg_11_0.actCo or not arg_11_0._txtdesc then
		return
	end

	arg_11_0._txtdesc.text = arg_11_0.actCo.actDesc
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:refreshUI()
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:refreshUI()
	arg_13_0.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(arg_13_0.everyMinuteCall, arg_13_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.everyMinuteCall(arg_14_0)
	arg_14_0:refreshUI()
end

function var_0_0.refreshUI(arg_15_0)
	arg_15_0:refreshRemainTime()
	arg_15_0:refreshActivityState()
	arg_15_0:refreshStoreCurrency()
end

function var_0_0.refreshRemainTime(arg_16_0)
	local var_16_0 = ActivityModel.instance:getActivityInfo()[arg_16_0.actId]:getRealEndTimeStamp() - ServerTime.now()

	if var_16_0 > 0 then
		local var_16_1 = TimeUtil.SecondToActivityTimeFormat(var_16_0)

		arg_16_0._txttime.text = var_16_1

		gohelper.setActive(arg_16_0._txttime, true)
	else
		gohelper.setActive(arg_16_0._txttime, false)
	end

	local var_16_2 = ActivityModel.instance:getActivityInfo()[VersionActivity2_5Enum.ActivityId.DungeonStore]

	arg_16_0._txtstorename.text = var_16_2.config.name
	arg_16_0._txtStoreTime.text = var_16_2:getRemainTimeStr2ByEndTime(true)
end

function var_0_0.refreshActivityState(arg_17_0)
	local var_17_0 = ActivityHelper.getActivityStatusAndToast(arg_17_0.actId)
	local var_17_1 = var_17_0 == ActivityEnum.ActivityStatus.Normal
	local var_17_2 = var_17_0 == ActivityEnum.ActivityStatus.NotOpen

	gohelper.setActive(arg_17_0.goEnter, var_17_1)
	gohelper.setActive(arg_17_0.goFinish, not var_17_2 and not var_17_1)
	gohelper.setActive(arg_17_0.goLock, var_17_2)

	local var_17_3 = var_17_0 == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(arg_17_0._gotime, not var_17_3)

	local var_17_4 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_5Enum.ActivityId.DungeonStore) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_17_0.goStore, var_17_4)
end

function var_0_0.refreshStoreCurrency(arg_18_0)
	local var_18_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a5Dungeon)
	local var_18_1 = var_18_0 and var_18_0.quantity or 0

	arg_18_0._txtStoreNum.text = GameUtil.numberDisplay(var_18_1)
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.everyMinuteCall, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0.animComp:destroy()
end

return var_0_0
