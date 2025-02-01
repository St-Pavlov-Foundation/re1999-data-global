module("modules.logic.versionactivity1_9.enter.view.subview.V1a9_DungeonEnterView", package.seeall)

slot0 = class("V1a9_DungeonEnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "logo/#simage_title")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "logo/#txt_dec")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "logo/timebg")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "logo/timebg/#txt_time")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_enter")
	slot0._btnFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_Finished")
	slot0._btnStore = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_store")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_task")
	slot0._goTaskRedDot = gohelper.findChild(slot0.viewGO, "entrance/#btn_task/#go_reddot")
	slot0._goEnterRedDot = gohelper.findChild(slot0.viewGO, "entrance/#btn_enter/#go_reddot")
	slot0._txtStoreNum = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/normal/#txt_num")
	slot0._txtStoreTime = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/#go_time/#txt_time")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnStore:AddClickListener(slot0.onClickStoreBtn, slot0)
	slot0._btnEnter:AddClickListener(slot0.onClickMainActivity, slot0)
	slot0._btnTask:AddClickListener(slot0.onClickTaskBtn, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnStore:RemoveClickListener()
	slot0._btnEnter:RemoveClickListener()
	slot0._btnTask:RemoveClickListener()
end

function slot0.onClickStoreBtn(slot0)
	VersionActivity1_9DungeonController.instance:openStoreView()
end

function slot0.onClickMainActivity(slot0)
	VersionActivity1_9DungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0.onClickTaskBtn(slot0)
	VersionActivity1_9DungeonController.instance:openTaskView()
end

function slot0._editableInitView(slot0)
	if DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_7) then
		slot0._simagebg:LoadImage("singlebg/v1a9_mainactivity_singlebg/v1a9_enterview_fullbg2.png")
	else
		slot0._simagebg:LoadImage("singlebg/v1a9_mainactivity_singlebg/v1a9_enterview_fullbg.png")
	end

	slot0._simagetitle:LoadImage("singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_title.png")

	slot0.goEnter = slot0._btnEnter.gameObject
	slot0.goFinish = slot0._btnFinish.gameObject
	slot0.actId = VersionActivity1_9Enum.ActivityId.Dungeon
	slot0.actCo = ActivityConfig.instance:getActivityCo(slot0.actId)
	slot0.goTaskBg = gohelper.findChild(slot0.viewGO, "entrance/#btn_task/normal/bg")
	slot0.goTaskIcon = gohelper.findChild(slot0.viewGO, "entrance/#btn_task/normal/icon")
	slot0.goTaskTxt = gohelper.findChild(slot0.viewGO, "entrance/#btn_task/normal/txt_shop")
	slot0.animComp = VersionActivitySubAnimatorComp.get(slot0.viewGO, slot0)

	RedDotController.instance:addRedDot(slot0._goTaskRedDot, RedDotEnum.DotNode.V1a9DungeonTask)
	RedDotController.instance:addRedDot(slot0._goEnterRedDot, RedDotEnum.DotNode.V1a9ToughBattle)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshStoreCurrency, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
end

function slot0.onRefreshActivity(slot0, slot1)
	if slot1 ~= slot0.actId then
		return
	end

	slot0:refreshBtnStatus()
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
	slot0.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(slot0.everyMinuteCall, slot0, TimeUtil.OneMinuteSecond)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._txtdesc.text = slot0.actCo.actDesc

	slot0:refreshBtnStatus()
	slot0:refreshRemainTime()
	slot0:refreshStoreCurrency()
end

function slot0.refreshBtnStatus(slot0)
	slot2 = ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(slot0.goEnter, slot2)
	gohelper.setActive(slot0.goFinish, not slot2)
	ZProj.UGUIHelper.SetGrayscale(slot0.goTaskBg, not slot2)
	ZProj.UGUIHelper.SetGrayscale(slot0.goTaskIcon, not slot2)
	ZProj.UGUIHelper.SetGrayscale(slot0.goTaskTxt, not slot2)
	gohelper.setActive(slot0._goTaskRedDot, slot2)
	gohelper.setActive(slot0._goEnterRedDot, slot2)

	slot3 = slot1 == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(slot0._btnTask, not slot3)
	gohelper.setActive(slot0._gotime, not slot3)
end

function slot0.everyMinuteCall(slot0)
	slot0:refreshRemainTime()
end

function slot0.refreshStoreCurrency(slot0)
	slot0._txtStoreNum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a9Dungeon) and slot1.quantity or 0)
end

function slot0.refreshRemainTime(slot0)
	slot0._txttime.text = TimeUtil.SecondToActivityTimeFormat(ActivityModel.instance:getActivityInfo()[slot0.actId]:getRealEndTimeStamp() - ServerTime.now())
	slot0._txtStoreTime.text = ActivityModel.instance:getActivityInfo()[VersionActivity1_9Enum.ActivityId.DungeonStore]:getRemainTimeStr2ByEndTime(true)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everyMinuteCall, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagetitle:UnLoadImage()
	slot0.animComp:destroy()
end

return slot0
