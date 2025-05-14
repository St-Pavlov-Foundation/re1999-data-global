module("modules.logic.versionactivity2_4.enter.view.subview.VersionActivity2_4DungeonEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_4DungeonEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "logo/actbg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/actbg/#txt_time")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_task")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_task/#go_reddot")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtStoreNum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_1_0._txtStoreTime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/#go_reddot")
	arg_1_0._btnFinished = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Finished")
	arg_1_0._imagestoreicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "entrance/#btn_store/normal/icon")

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
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshStoreCurrency, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.onRefreshActivity, arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
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

function var_0_0._btntaskOnClick(arg_5_0)
	VersionActivity2_4DungeonController.instance:openTaskView()
end

function var_0_0._btnstoreOnClick(arg_6_0)
	VersionActivity2_4DungeonController.instance:openStoreView()
end

function var_0_0._btnenterOnClick(arg_7_0)
	VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._btnFinishedOnClick(arg_8_0)
	GameFacade.showToast(ToastEnum.ActivityEnd)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._txtstorename = gohelper.findChildText(arg_9_0.viewGO, "entrance/#btn_store/normal/txt_shop")
	arg_9_0.actId = VersionActivity2_4Enum.ActivityId.Dungeon
	arg_9_0.animComp = VersionActivity2_4SubAnimatorComp.get(arg_9_0.viewGO, arg_9_0)
	arg_9_0.goEnter = arg_9_0._btnenter.gameObject
	arg_9_0.goFinish = arg_9_0._btnFinished.gameObject
	arg_9_0.goStore = arg_9_0._btnstore.gameObject
	arg_9_0.actId = VersionActivity2_4Enum.ActivityId.Dungeon
	arg_9_0.actCo = ActivityConfig.instance:getActivityCo(arg_9_0.actId)

	arg_9_0:_setDesc()
	RedDotController.instance:addRedDot(arg_9_0._goreddot, RedDotEnum.DotNode.V2a4DungeonEnter)
	RedDotController.instance:addRedDot(arg_9_0._gotaskreddot, RedDotEnum.DotNode.V2a4DungeonTask)
	gohelper.setActive(arg_9_0._btntask.gameObject, false)

	local var_9_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V2a4Dungeon)

	if var_9_0 then
		local var_9_1 = var_9_0 and var_9_0.icon

		arg_9_0._imagestoreicon:LoadImage(ResUrl.getCurrencyItemIcon(var_9_1))
	end
end

function var_0_0._setDesc(arg_10_0)
	if not arg_10_0.actCo or not arg_10_0._txtdesc then
		return
	end

	arg_10_0._txtdesc.text = arg_10_0.actCo.actDesc
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0:refreshUI()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:refreshUI()
	arg_12_0.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(arg_12_0.everyMinuteCall, arg_12_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.everyMinuteCall(arg_13_0)
	arg_13_0:refreshUI()
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0:refreshRemainTime()
	arg_14_0:refreshActivityState()
	arg_14_0:refreshStoreCurrency()
end

function var_0_0.refreshRemainTime(arg_15_0)
	local var_15_0 = ActivityModel.instance:getActivityInfo()[arg_15_0.actId]:getRealEndTimeStamp() - ServerTime.now()

	if var_15_0 > 0 then
		local var_15_1 = TimeUtil.SecondToActivityTimeFormat(var_15_0)

		arg_15_0._txttime.text = var_15_1

		gohelper.setActive(arg_15_0._txttime, true)
	else
		gohelper.setActive(arg_15_0._txttime, false)
	end

	local var_15_2 = ActivityModel.instance:getActivityInfo()[VersionActivity2_4Enum.ActivityId.DungeonStore]

	arg_15_0._txtstorename.text = var_15_2.config.name
	arg_15_0._txtStoreTime.text = var_15_2:getRemainTimeStr2ByEndTime(true)
end

function var_0_0.refreshActivityState(arg_16_0)
	local var_16_0 = ActivityHelper.getActivityStatusAndToast(arg_16_0.actId)
	local var_16_1 = var_16_0 == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_16_0.goEnter, var_16_1)
	gohelper.setActive(arg_16_0.goFinish, not var_16_1)

	local var_16_2 = var_16_0 == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(arg_16_0._gotime, not var_16_2)

	local var_16_3 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_4Enum.ActivityId.DungeonStore) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_16_0.goStore, var_16_3)
end

function var_0_0.refreshStoreCurrency(arg_17_0)
	local var_17_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a4Dungeon)
	local var_17_1 = var_17_0 and var_17_0.quantity or 0

	arg_17_0._txtStoreNum.text = GameUtil.numberDisplay(var_17_1)
end

function var_0_0.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.everyMinuteCall, arg_18_0)
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._imagestoreicon:UnLoadImage()
	arg_19_0.animComp:destroy()
end

return var_0_0
