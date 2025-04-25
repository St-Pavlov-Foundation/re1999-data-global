module("modules.logic.main.view.MainActExtraDisplay", package.seeall)

slot0 = class("MainActExtraDisplay", BaseView)

function slot0.onInitView(slot0)
	slot0._goright = gohelper.findChild(slot0.viewGO, "right")
	slot0._btnrolestory = gohelper.findChildButton(slot0.viewGO, "right/#btn_rolestory")
	slot0._simagerolestory = gohelper.findChildSingleImage(slot0.viewGO, "right/#btn_rolestory/#simage_rolestory")
	slot0._imagerolestory = gohelper.findChildImage(slot0.viewGO, "right/#btn_rolestory/#simage_rolestory")
	slot0._gorolestoryred = gohelper.findChild(slot0.viewGO, "right/#btn_rolestory/#go_activityreddot")
	slot0._txtrolestory = gohelper.findChildTextMesh(slot0.viewGO, "right/#btn_rolestory/txt")
	slot0._gorolestorynew = gohelper.findChild(slot0.viewGO, "right/#btn_rolestory/new")
	slot0._btnreactivity = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_activityreprint")
	slot0._imagereactivity = gohelper.findChildImage(slot0.viewGO, "right/#btn_activityreprint/image_activityreprint")
	slot0._goreactivityred = gohelper.findChild(slot0.viewGO, "right/#btn_activityreprint/#go_activityreprintreddot")
	slot0._txtreactivity = gohelper.findChildTextMesh(slot0.viewGO, "right/#btn_activityreprint/txt")
	slot0._goreactivitynew = gohelper.findChild(slot0.viewGO, "right/#btn_activityreprint/new")
	slot0._goreactivitylocked = gohelper.findChild(slot0.viewGO, "right/#btn_activityreprint/#go_Locked")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrolestory:AddClickListener(slot0._btnrolestoryOnClick, slot0)
	slot0._btnreactivity:AddClickListener(slot0._btnreactivityOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterCurActivity, slot0.OnNotifyEnterCurActivity, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrolestory:RemoveClickListener()
	slot0._btnreactivity:RemoveClickListener()
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterCurActivity, slot0.OnNotifyEnterCurActivity, slot0)
end

function slot0._btnreactivityOnClick(slot0)
	slot0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, , ReactivityController.instance:getCurReactivityId(), true)
end

function slot0.OnNotifyEnterCurActivity(slot0)
	if slot0._btnreactivity.gameObject.activeSelf then
		slot0:_btnreactivityOnClick()
	end

	slot0:_btnrolestoryOnClick()
end

function slot0._btnrolestoryOnClick(slot0)
	if slot0._actClickHandler[slot0.activityShowState] then
		slot1(slot0)
	end
end

function slot0._onRoleStoryClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)
	RoleStoryController.instance:openRoleStoryDispatchMainView()
end

function slot0._onSeasonClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	slot0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, , slot0._seasonActId)
end

function slot0._onRougeClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	RougeController.instance:openRougeMainView()
end

function slot0._onDouQuQuClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	slot0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, , slot0._douququActId)
end

function slot0._onAct178Click(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	slot0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, , slot0._act178ActId)
end

function slot0._onAct182Click(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	slot0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, , slot0._act182ActId)
end

function slot0._getEnterController(slot0)
	return slot0.viewContainer:getMainActivityEnterView():getCurEnterController()
end

function slot0._editableInitView(slot0)
	slot0._seasonActId = ActivityConfig.instance:getSesonActivityConfig() and slot1.id or Season123Model.instance:getCurSeasonId() or Season166Model.instance:getCurSeasonId()
	slot0._rougeActId = ActivityConfig.instance:getRougeActivityConfig() and slot2.id
	slot0._douququActId = VersionActivity2_3Enum.ActivityId.Act174
	slot0._act178ActId = VersionActivity2_4Enum.ActivityId.Pinball
	slot0._act182ActId = VersionActivity2_5Enum.ActivityId.AutoChess

	slot0:_initActs()
end

function slot0._initActs(slot0)
	slot0._actHandler = {}
	slot0._actGetStartTimeHandler = {}
	slot0._actClickHandler = {}
	slot0._actRefreshBtnHandler = {}

	slot0:_addActHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, slot0._getRoleStoryActivityStatus, slot0._getRoleStoryActivityStartTime)
	slot0:_addActHandler(ActivityEnum.MainViewActivityState.Reactivity, slot0._getReactivityStatus, slot0._getReactivityStartTime)
	slot0:_addActHandler(ActivityEnum.MainViewActivityState.SeasonActivity, slot0._getSeasonActivityStatus, slot0._getSeasonActivityStartTime)
	slot0:_addActHandler(ActivityEnum.MainViewActivityState.Rouge, slot0._getRougeStatus, slot0._getRougeStartTime)
	slot0:_addActHandler(ActivityEnum.MainViewActivityState.DouQuQu, slot0._getDouQuQuStatus, slot0._getDouQuQuStartTime)
	slot0:_addActHandler(ActivityEnum.MainViewActivityState.Act178, slot0._getAct178Status, slot0._getAct178StartTime)
	slot0:_addActHandler(ActivityEnum.MainViewActivityState.Act182, slot0._getAct182Status, slot0._getAct182StartTime)
	slot0:_addClickHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, slot0._onRoleStoryClick)
	slot0:_addClickHandler(ActivityEnum.MainViewActivityState.SeasonActivity, slot0._onSeasonClick)
	slot0:_addClickHandler(ActivityEnum.MainViewActivityState.Rouge, slot0._onRougeClick)
	slot0:_addClickHandler(ActivityEnum.MainViewActivityState.DouQuQu, slot0._onDouQuQuClick)
	slot0:_addClickHandler(ActivityEnum.MainViewActivityState.Act178, slot0._onAct178Click)
	slot0:_addClickHandler(ActivityEnum.MainViewActivityState.Act182, slot0._onAct182Click)
	slot0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, slot0.refreshRoleStoryBtn)
	slot0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.SeasonActivity, slot0.refreshSeasonBtn)
	slot0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Rouge, slot0.refreshRougeBtn)
	slot0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.DouQuQu, slot0.refreshDouQuQuBtn)
	slot0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act178, slot0.refreshAct178Btn)
	slot0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act182, slot0.refreshAct182Btn)
end

function slot0._addRefreshBtnHandler(slot0, slot1, slot2)
	slot0._actRefreshBtnHandler[slot1] = slot2
end

function slot0._addClickHandler(slot0, slot1, slot2)
	slot0._actClickHandler[slot1] = slot2
end

function slot0._addActHandler(slot0, slot1, slot2, slot3)
	slot0._actHandler[slot1] = slot2
	slot0._actGetStartTimeHandler[slot1] = slot3
end

function slot0._getSeasonActivityStatus(slot0)
	return (slot0._seasonActId and ActivityHelper.getActivityStatus(slot1)) == ActivityEnum.ActivityStatus.Normal
end

function slot0._getSeasonActivityStartTime(slot0)
	return slot0._seasonActId and ActivityModel.instance:getActStartTime(slot1)
end

function slot0._getReactivityStatus(slot0)
	slot2 = ReactivityController.instance:getCurReactivityId() and ReactivityEnum.ActivityDefine[slot1]
	slot3 = slot2 and slot2.storeActId

	return (slot3 and ActivityHelper.getActivityStatus(slot3)) == ActivityEnum.ActivityStatus.Normal
end

function slot0._getReactivityStartTime(slot0)
	slot3 = ReactivityEnum.ActivityDefine[ReactivityController.instance:getCurReactivityId()] and slot2.storeActId
	slot4 = slot3 and ActivityModel.instance:getActMO(slot3)

	return slot4 and slot4:getRealStartTimeStamp() * 1000
end

function slot0._getRoleStoryActivityStatus(slot0)
	return RoleStoryModel.instance:getCurActStoryId() and slot1 > 0 or false
end

function slot0._getRoleStoryActivityStartTime(slot0)
	slot3 = (RoleStoryModel.instance:getCurActStoryId() and slot1 > 0 or false) and RoleStoryModel.instance:getMoById(slot1)

	return slot3 and slot3:getActTime() * 1000
end

function slot0._getRougeStatus(slot0)
	return (slot0._rougeActId and ActivityHelper.getActivityStatus(slot1)) == ActivityEnum.ActivityStatus.Normal
end

function slot0._getRougeStartTime(slot0)
	return ActivityModel.instance:getActMO(slot0._rougeActId) and slot2:getRealStartTimeStamp() * 1000
end

function slot0._getDouQuQuStatus(slot0)
	return (slot0._douququActId and ActivityHelper.getActivityStatus(slot1)) == ActivityEnum.ActivityStatus.Normal
end

function slot0._getDouQuQuStartTime(slot0)
	return ActivityModel.instance:getActMO(slot0._douququActId) and slot2:getRealStartTimeStamp() * 1000
end

function slot0._getAct178Status(slot0)
	return (slot0._act178ActId and ActivityHelper.getActivityStatus(slot1)) == ActivityEnum.ActivityStatus.Normal
end

function slot0._getAct178StartTime(slot0)
	return ActivityModel.instance:getActMO(slot0._act178ActId) and slot2:getRealStartTimeStamp() * 1000
end

function slot0._getAct182Status(slot0)
	return (slot0._act182ActId and ActivityHelper.getActivityStatus(slot1)) == ActivityEnum.ActivityStatus.Normal
end

function slot0._getAct182StartTime(slot0)
	return ActivityModel.instance:getActMO(slot0._act182ActId) and slot2:getRealStartTimeStamp() * 1000
end

function slot0._onStoryChange(slot0)
	slot0:onRefreshActivityState()
end

function slot0._onStoryNewChange(slot0)
	slot0:refreshRoleStoryRed()
end

function slot0._roleStoryLoadImage(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot1) then
		logError("MainActExtraDisplay:_roleStoryLoadImage path nil")

		return
	end

	slot0._simagerolestory:LoadImage(slot1, slot2, slot3)
end

function slot0.refreshRougeBtn(slot0)
	gohelper.setActive(slot0._btnrolestory, true)
	slot0:_roleStoryLoadImage(ActivityConfig.instance:getRougeActivityConfig().extraDisplayIcon, slot0.onLoadImage, slot0)

	slot0._txtrolestory.text = ""
end

function slot0.refreshDouQuQuBtn(slot0)
	gohelper.setActive(slot0._btnrolestory, true)
	slot0:_roleStoryLoadImage(ActivityConfig.instance:getActivityCo(slot0._douququActId).extraDisplayIcon, slot0.onLoadImage, slot0)

	slot0._txtrolestory.text = ""
end

function slot0.refreshAct178Btn(slot0)
	gohelper.setActive(slot0._btnrolestory, true)
	slot0:_roleStoryLoadImage(ActivityConfig.instance:getActivityCo(slot0._act178ActId).extraDisplayIcon, slot0.onLoadImage, slot0)

	slot0._txtrolestory.text = ""
end

function slot0.refreshAct182Btn(slot0)
	gohelper.setActive(slot0._btnrolestory, true)
	slot0:_roleStoryLoadImage(ActivityConfig.instance:getActivityCo(slot0._act182ActId).extraDisplayIcon, slot0.onLoadImage, slot0)

	slot0._txtrolestory.text = ""
end

function slot0.onLoadImage(slot0)
	slot0._imagerolestory:SetNativeSize()
end

function slot0.refreshSeasonBtn(slot0)
	gohelper.setActive(slot0._btnrolestory, true)

	slot1 = ActivityConfig.instance:getSesonActivityConfig()

	slot0:_roleStoryLoadImage(slot1.extraDisplayIcon, slot0.onLoadImage, slot0)

	slot0._txtrolestory.text = slot1.name
	slot2 = slot0._seasonActId

	RedDotController.instance:addRedDot(slot0._gorolestoryred, ActivityConfig.instance:getActivityCo(slot2).redDotId)

	slot4 = ActivityStageHelper.checkOneActivityStageHasChange(slot2)

	gohelper.setActive(slot0._gorolestorynew, slot4)
	gohelper.setActive(slot0._gorolestoryred, not slot4)
end

function slot0.refreshRoleStoryBtn(slot0)
	slot2 = RoleStoryModel.instance:getCurActStoryId() > 0

	gohelper.setActive(slot0._btnrolestory, slot2)

	if slot2 then
		slot3 = RoleStoryConfig.instance:getStoryById(slot1)

		slot0:_roleStoryLoadImage(string.format("singlebg/dungeon/rolestory_singlebg/%s.png", slot3.main_pic), slot0.onLoadImage, slot0)

		if string.nilorempty(slot3.mainviewName) then
			slot4 = slot3.name
		end

		slot0._txtrolestory.text = slot4

		RedDotController.instance:addRedDot(slot0._gorolestoryred, RedDotEnum.DotNode.RoleStoryActivity)
	end

	slot0:refreshRoleStoryRed()
end

function slot0.refreshRoleStoryRed(slot0)
	if slot0.activityShowState ~= ActivityEnum.MainViewActivityState.RoleStoryActivity then
		return
	end

	slot1 = false

	if not (RoleStoryModel.instance:getCurActStoryId() > 0) then
		return
	end

	slot6 = ActivityStageHelper.checkOneActivityStageHasChange(RoleStoryModel.instance:getMoById(slot2).cfg.activityId)

	gohelper.setActive(slot0._gorolestorynew, slot6)
	gohelper.setActive(slot0._gorolestoryred, not slot6)
end

function slot0.refreshReactivityBtn(slot0)
	slot2 = ReactivityController.instance:getCurReactivityId() and ActivityHelper.getActivityStatusAndToast(slot1)
	slot3 = slot0.activityShowState == ActivityEnum.MainViewActivityState.Reactivity

	gohelper.setActive(slot0._btnreactivity, slot3)

	if slot3 then
		slot0._txtreactivity.text = ActivityConfig.instance:getActivityCo(slot1) and slot4.name or ""
		slot5 = slot2 == ActivityEnum.ActivityStatus.Normal and ActivityStageHelper.checkOneActivityStageHasChange(slot1)

		gohelper.setActive(slot0._goreactivityred, not slot5)
		gohelper.setActive(slot0._goreactivitynew, slot5)
		gohelper.setActive(slot0._goreactivitylocked, slot2 == ActivityEnum.ActivityStatus.NotUnlock)
		slot0:addReactivityRed()
	end
end

function slot0.addReactivityRed(slot0)
	if ReactivityController.instance:getCurReactivityId() and ActivityConfig.instance:getActivityCo(slot1) and slot2.redDotId > 0 then
		RedDotController.instance:addRedDot(slot0._goreactivityred, slot2.redDotId)
	end
end

function slot0.checkShowActivityEnter(slot0)
	slot1 = ActivityEnum.MainViewActivityState.None
	slot0._curActDisplayConfig = nil
	slot2 = 0

	for slot7, slot8 in ipairs(ActivityConfig.instance:getMainActExtraDisplayList()) do
		if not slot0._actHandler[slot8.id] then
			logError("MainActExtraDisplay 活动没有对应的handler id:" .. tostring(slot8.id))
		end

		if slot9 and slot9(slot0) and slot2 <= slot0._actGetStartTimeHandler[slot8.id](slot0) then
			slot2 = slot11
			slot1 = slot8.id
			slot0._curActDisplayConfig = slot8
		end
	end

	slot0.activityShowState = slot1

	recthelper.setAnchorY(slot0._goright.transform, slot0.activityShowState == ActivityEnum.MainViewActivityState.None and 0 or -40)
end

function slot0.onRefreshActivityState(slot0)
	slot0:checkShowActivityEnter()
	slot0:refreshReactivityBtn()
	slot0:_refreshBtns()
end

function slot0._refreshBtns(slot0)
	gohelper.setActive(slot0._btnrolestory, false)

	if not slot0._curActDisplayConfig then
		return
	end

	if slot0._actRefreshBtnHandler[slot0.activityShowState] then
		slot1(slot0)
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, slot0._onStoryChange, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.StoryNewChange, slot0._onStoryNewChange, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivityState, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0.onRefreshActivityState, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.ChangeActivityStage, slot0.onRefreshActivityState, slot0)
	slot0:onRefreshActivityState()
	slot0:showKeyTips()
end

function slot0.showKeyTips(slot0)
	slot0._keytipsReactivity = gohelper.findChild(slot0._btnreactivity.gameObject, "#go_pcbtn")
	slot0._keytipsRoleStory = gohelper.findChild(slot0._btnrolestory.gameObject, "#go_pcbtn")

	PCInputController.instance:showkeyTips(slot0._keytipsReactivity, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
	PCInputController.instance:showkeyTips(slot0._keytipsRoleStory, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._simagerolestory then
		slot0._simagerolestory:UnLoadImage()
	end
end

return slot0
