module("modules.logic.versionactivity1_8.enter.view.subview.V1a8_DungeonEnterView", package.seeall)

slot0 = class("V1a8_DungeonEnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "logo/#txt_dec")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "logo/timebg")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "logo/timebg/#txt_time")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_task")
	slot0._gotaskreddot = gohelper.findChild(slot0.viewGO, "entrance/#btn_task/#go_reddot")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_store")
	slot0._txtStoreNum = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/normal/#txt_num")
	slot0._txtStoreTime = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	slot0._btnenter = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_enter")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "entrance/#btn_enter/#go_reddot")
	slot0._btnFinished = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_Finished")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshStoreCurrency, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btnstore:AddClickListener(slot0._btnstoreOnClick, slot0)
	slot0._btnenter:AddClickListener(slot0._btnenterOnClick, slot0)
	slot0._btnFinished:AddClickListener(slot0._btnFinishedOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshStoreCurrency, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
	slot0._btntask:RemoveClickListener()
	slot0._btnstore:RemoveClickListener()
	slot0._btnenter:RemoveClickListener()
	slot0._btnFinished:RemoveClickListener()
end

function slot0.onRefreshActivity(slot0, slot1)
	if slot1 ~= slot0.actId then
		return
	end

	slot0:refreshActivityState()
end

function slot0._btntaskOnClick(slot0)
	VersionActivity1_8DungeonController.instance:openTaskView()
end

function slot0._btnstoreOnClick(slot0)
	VersionActivity1_8DungeonController.instance:openStoreView()
end

function slot0._btnenterOnClick(slot0)
	VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0._btnFinishedOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0.actId = VersionActivity1_8Enum.ActivityId.Dungeon
	slot0.animComp = VersionActivitySubAnimatorComp.get(slot0.viewGO, slot0)
	slot0.goEnter = slot0._btnenter.gameObject
	slot0.goFinish = slot0._btnFinished.gameObject
	slot0.goStore = slot0._btnstore.gameObject
	slot0.actId = VersionActivity1_8Enum.ActivityId.Dungeon
	slot0.actCo = ActivityConfig.instance:getActivityCo(slot0.actId)

	slot0:_setDesc()
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.V1a8DungeonEnter)
end

function slot0._setDesc(slot0)
	if not slot0.actCo or not slot0._txtdesc then
		return
	end

	slot0._txtdesc.text = slot0.actCo.actDesc
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
	slot0.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(slot0.everyMinuteCall, slot0, TimeUtil.OneMinuteSecond)
end

function slot0.everyMinuteCall(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshRemainTime()
	slot0:refreshActivityState()
	slot0:refreshStoreCurrency()
end

function slot0.refreshRemainTime(slot0)
	if ActivityModel.instance:getActivityInfo()[slot0.actId]:getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0._txttime.text = TimeUtil.SecondToActivityTimeFormat(slot2)

		gohelper.setActive(slot0._txttime, true)
	else
		gohelper.setActive(slot0._txttime, false)
	end

	slot0._txtStoreTime.text = ActivityModel.instance:getActivityInfo()[VersionActivity1_8Enum.ActivityId.DungeonStore]:getRemainTimeStr2ByEndTime(true)
end

function slot0.refreshActivityState(slot0)
	slot2 = ActivityHelper.getActivityStatusAndToast(slot0.actId) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(slot0.goEnter, slot2)
	gohelper.setActive(slot0.goFinish, not slot2)
	gohelper.setActive(slot0._gotime, not (slot1 == ActivityEnum.ActivityStatus.Expired))
	gohelper.setActive(slot0.goStore, ActivityHelper.getActivityStatusAndToast(VersionActivity1_8Enum.ActivityId.DungeonStore) == ActivityEnum.ActivityStatus.Normal)
end

function slot0.refreshStoreCurrency(slot0)
	slot0._txtStoreNum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a8Dungeon) and slot1.quantity or 0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everyMinuteCall, slot0)
end

function slot0.onDestroyView(slot0)
	slot0.animComp:destroy()
end

return slot0
