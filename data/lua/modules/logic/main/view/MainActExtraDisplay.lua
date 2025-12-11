module("modules.logic.main.view.MainActExtraDisplay", package.seeall)

local var_0_0 = class("MainActExtraDisplay", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "right")
	arg_1_0._btnrolestory = gohelper.findChildButton(arg_1_0.viewGO, "right/#btn_rolestory")
	arg_1_0._simagerolestory = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#btn_rolestory/#simage_rolestory")
	arg_1_0._imagerolestory = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_rolestory/#simage_rolestory")
	arg_1_0._gorolestoryred = gohelper.findChild(arg_1_0.viewGO, "right/#btn_rolestory/#go_activityreddot")
	arg_1_0._txtrolestory = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/#btn_rolestory/txt")
	arg_1_0._gorolestorynew = gohelper.findChild(arg_1_0.viewGO, "right/#btn_rolestory/new")
	arg_1_0._btnreactivity = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_activityreprint")
	arg_1_0._imagereactivity = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_activityreprint/image_activityreprint")
	arg_1_0._goreactivityred = gohelper.findChild(arg_1_0.viewGO, "right/#btn_activityreprint/#go_activityreprintreddot")
	arg_1_0._txtreactivity = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/#btn_activityreprint/txt")
	arg_1_0._goreactivitynew = gohelper.findChild(arg_1_0.viewGO, "right/#btn_activityreprint/new")
	arg_1_0._goreactivitylocked = gohelper.findChild(arg_1_0.viewGO, "right/#btn_activityreprint/#go_Locked")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrolestory:AddClickListener(arg_2_0._btnrolestoryOnClick, arg_2_0)
	arg_2_0._btnreactivity:AddClickListener(arg_2_0._btnreactivityOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterCurActivity, arg_2_0.OnNotifyEnterCurActivity, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrolestory:RemoveClickListener()
	arg_3_0._btnreactivity:RemoveClickListener()
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterCurActivity, arg_3_0.OnNotifyEnterCurActivity, arg_3_0)
end

function var_0_0._btnreactivityOnClick(arg_4_0)
	local var_4_0 = ReactivityController.instance:getCurReactivityId()

	if GameBranchMgr.instance:isOnVer(2, 9) then
		ActivityStageHelper.recordOneActivityStage(var_4_0)

		if SettingsModel.instance:isOverseas() then
			ViewMgr.instance:openView(ViewName.VersionActivity3_0_v2a1_ReactivityEnterview)
		else
			ViewMgr.instance:openView(ViewName.V2a3_ReactivityEnterview)
		end
	else
		arg_4_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_4_0, true)
	end
end

function var_0_0.OnNotifyEnterCurActivity(arg_5_0)
	if arg_5_0._btnreactivity.gameObject.activeSelf then
		arg_5_0:_btnreactivityOnClick()
	end

	arg_5_0:_btnrolestoryOnClick()
end

function var_0_0._btnrolestoryOnClick(arg_6_0)
	local var_6_0 = arg_6_0._actClickHandler[arg_6_0.activityShowState]

	if var_6_0 then
		var_6_0(arg_6_0)
	end
end

function var_0_0._onRoleStoryClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)

	local var_7_0 = RoleStoryModel.instance:getCurActStoryId()

	if not var_7_0 or var_7_0 == 0 then
		return
	end

	local var_7_1 = RoleStoryConfig.instance:getStoryById(var_7_0)

	arg_7_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_7_1.activityId)
end

function var_0_0._onSeasonClick(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_8_0 = arg_8_0._seasonActId

	arg_8_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_8_0)
end

function var_0_0._onRougeClick(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	RougeController.instance:openRougeMainView()
end

function var_0_0._onSurvivalClick(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	arg_10_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_1Enum.ActivityId.Survival)
end

function var_0_0._onDouQuQuClick(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_11_0 = arg_11_0._douququActId

	arg_11_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_11_0)
end

function var_0_0._onAct178Click(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_12_0 = arg_12_0._act178ActId

	arg_12_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_12_0)
end

function var_0_0._onAct182Click(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_13_0 = arg_13_0._act182ActId

	arg_13_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_13_0)
end

function var_0_0._onWeekWalkHeartClick(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_14_0 = ActivityEnum.Activity.WeekWalkHeartShow

	arg_14_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_14_0)
end

function var_0_0._onAct191Click(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_15_0 = arg_15_0:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)

	arg_15_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_15_0)
end

function var_0_0._getEnterController(arg_16_0)
	return arg_16_0.viewContainer:getMainActivityEnterView():getCurEnterController()
end

function var_0_0._editableInitView(arg_17_0)
	local var_17_0 = ActivityConfig.instance:getSesonActivityConfig()

	arg_17_0._seasonActId = var_17_0 and var_17_0.id or Season123Model.instance:getCurSeasonId() or Season166Model.instance:getCurSeasonId()

	local var_17_1 = ActivityConfig.instance:getRougeActivityConfig()

	arg_17_0._rougeActId = var_17_1 and var_17_1.id
	arg_17_0._douququActId = VersionActivity2_3Enum.ActivityId.Act174
	arg_17_0._act178ActId = VersionActivity2_4Enum.ActivityId.Pinball
	arg_17_0._act182ActId = VersionActivity2_8Enum.ActivityId.AutoChess

	arg_17_0:_initActs()
end

function var_0_0._initActs(arg_18_0)
	arg_18_0._actHandler = {}
	arg_18_0._actGetStartTimeHandler = {}
	arg_18_0._actClickHandler = {}
	arg_18_0._actRefreshBtnHandler = {}

	arg_18_0:_addActHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_18_0._getRoleStoryActivityStatus, arg_18_0._getRoleStoryActivityStartTime)
	arg_18_0:_addActHandler(ActivityEnum.MainViewActivityState.Survival, arg_18_0._getSurvivalStatus, arg_18_0._getSurvivalStartTime)
	arg_18_0:_addActHandler(ActivityEnum.MainViewActivityState.Reactivity, arg_18_0._getReactivityStatus, arg_18_0._getReactivityStartTime)
	arg_18_0:_addActHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_18_0._getSeasonActivityStatus, arg_18_0._getSeasonActivityStartTime)
	arg_18_0:_addActHandler(ActivityEnum.MainViewActivityState.Rouge, arg_18_0._getRougeStatus, arg_18_0._getRougeStartTime)
	arg_18_0:_addActHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_18_0._getDouQuQuStatus, arg_18_0._getDouQuQuStartTime)
	arg_18_0:_addActHandler(ActivityEnum.MainViewActivityState.Act178, arg_18_0._getAct178Status, arg_18_0._getAct178StartTime)
	arg_18_0:_addActHandler(ActivityEnum.MainViewActivityState.Act182, arg_18_0._getAct182Status, arg_18_0._getAct182StartTime)
	arg_18_0:_addActHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_18_0._getWeekWalkHeartStatus, arg_18_0._getWeekWalkHeartStartTime)
	arg_18_0:_addActHandler(ActivityEnum.MainViewActivityState.Act191, arg_18_0._getAct191Status, arg_18_0._getAct191StartTime)
	arg_18_0:_addClickHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_18_0._onRoleStoryClick)
	arg_18_0:_addClickHandler(ActivityEnum.MainViewActivityState.Survival, arg_18_0._onSurvivalClick)
	arg_18_0:_addClickHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_18_0._onSeasonClick)
	arg_18_0:_addClickHandler(ActivityEnum.MainViewActivityState.Rouge, arg_18_0._onRougeClick)
	arg_18_0:_addClickHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_18_0._onDouQuQuClick)
	arg_18_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act178, arg_18_0._onAct178Click)
	arg_18_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act182, arg_18_0._onAct182Click)
	arg_18_0:_addClickHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_18_0._onWeekWalkHeartClick)
	arg_18_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act191, arg_18_0._onAct191Click)
	arg_18_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_18_0.refreshRoleStoryBtn)
	arg_18_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Survival, arg_18_0.refreshSurvivalBtn)
	arg_18_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_18_0.refreshSeasonBtn)
	arg_18_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Rouge, arg_18_0.refreshRougeBtn)
	arg_18_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_18_0.refreshDouQuQuBtn)
	arg_18_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act178, arg_18_0.refreshAct178Btn)
	arg_18_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act182, arg_18_0.refreshAct182Btn)
	arg_18_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_18_0.refreshWeekWalkHeartBtn)
	arg_18_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act191, arg_18_0.refreshAct191Btn)
end

function var_0_0._addRefreshBtnHandler(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._actRefreshBtnHandler[arg_19_1] = arg_19_2
end

function var_0_0._addClickHandler(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._actClickHandler[arg_20_1] = arg_20_2
end

function var_0_0._addActHandler(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0._actHandler[arg_21_1] = arg_21_2
	arg_21_0._actGetStartTimeHandler[arg_21_1] = arg_21_3
end

function var_0_0._getSeasonActivityStatus(arg_22_0)
	local var_22_0 = arg_22_0._seasonActId

	return (var_22_0 and ActivityHelper.getActivityStatus(var_22_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getSeasonActivityStartTime(arg_23_0)
	local var_23_0 = arg_23_0._seasonActId

	return var_23_0 and ActivityModel.instance:getActStartTime(var_23_0)
end

function var_0_0._getReactivityStatus(arg_24_0)
	local var_24_0 = ReactivityController.instance:getCurReactivityId()
	local var_24_1 = var_24_0 and ReactivityEnum.ActivityDefine[var_24_0]
	local var_24_2 = var_24_1 and var_24_1.storeActId

	return (var_24_2 and ActivityHelper.getActivityStatus(var_24_2)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getReactivityStartTime(arg_25_0)
	local var_25_0 = ReactivityController.instance:getCurReactivityId()
	local var_25_1 = ReactivityEnum.ActivityDefine[var_25_0]
	local var_25_2 = var_25_1 and var_25_1.storeActId
	local var_25_3 = var_25_2 and ActivityModel.instance:getActMO(var_25_2)

	return var_25_3 and var_25_3:getRealStartTimeStamp() * 1000
end

function var_0_0._getRoleStoryActivityStatus(arg_26_0)
	local var_26_0 = RoleStoryModel.instance:getCurActStoryId()

	return var_26_0 and var_26_0 > 0 or false
end

function var_0_0._getRoleStoryActivityStartTime(arg_27_0)
	local var_27_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_27_1 = (var_27_0 and var_27_0 > 0 or false) and RoleStoryModel.instance:getMoById(var_27_0)

	return var_27_1 and var_27_1:getActTime() * 1000
end

function var_0_0._getRougeStatus(arg_28_0)
	local var_28_0 = arg_28_0._rougeActId

	return (var_28_0 and ActivityHelper.getActivityStatus(var_28_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getRougeStartTime(arg_29_0)
	local var_29_0 = arg_29_0._rougeActId
	local var_29_1 = ActivityModel.instance:getActMO(var_29_0)

	return var_29_1 and var_29_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getSurvivalStatus(arg_30_0)
	local var_30_0 = VersionActivity3_1Enum.ActivityId.Survival

	return (var_30_0 and ActivityHelper.getActivityStatus(var_30_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getSurvivalStartTime(arg_31_0)
	local var_31_0 = VersionActivity3_1Enum.ActivityId.Survival
	local var_31_1 = ActivityModel.instance:getActMO(var_31_0)

	return var_31_1 and var_31_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getDouQuQuStatus(arg_32_0)
	local var_32_0 = arg_32_0._douququActId

	return (var_32_0 and ActivityHelper.getActivityStatus(var_32_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getDouQuQuStartTime(arg_33_0)
	local var_33_0 = arg_33_0._douququActId
	local var_33_1 = ActivityModel.instance:getActMO(var_33_0)

	return var_33_1 and var_33_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct178Status(arg_34_0)
	local var_34_0 = arg_34_0._act178ActId

	return (var_34_0 and ActivityHelper.getActivityStatus(var_34_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct178StartTime(arg_35_0)
	local var_35_0 = arg_35_0._act178ActId
	local var_35_1 = ActivityModel.instance:getActMO(var_35_0)

	return var_35_1 and var_35_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct182Status(arg_36_0)
	local var_36_0 = arg_36_0._act182ActId

	return (var_36_0 and ActivityHelper.getActivityStatus(var_36_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct182StartTime(arg_37_0)
	local var_37_0 = arg_37_0._act182ActId
	local var_37_1 = ActivityModel.instance:getActMO(var_37_0)

	return var_37_1 and var_37_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getWeekWalkHeartStatus(arg_38_0)
	local var_38_0 = arg_38_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)

	return (var_38_0 and ActivityHelper.getActivityStatus(var_38_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getWeekWalkHeartStartTime(arg_39_0)
	local var_39_0 = arg_39_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)
	local var_39_1 = ActivityModel.instance:getActMO(var_39_0)

	return var_39_1 and var_39_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct191Status(arg_40_0)
	local var_40_0 = arg_40_0:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)

	return (var_40_0 and ActivityHelper.getActivityStatus(var_40_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct191StartTime(arg_41_0)
	local var_41_0 = arg_41_0:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)
	local var_41_1 = ActivityModel.instance:getActMO(var_41_0)

	return var_41_1 and var_41_1:getRealStartTimeStamp() * 1000
end

function var_0_0._onStoryChange(arg_42_0)
	arg_42_0:onRefreshActivityState()
end

function var_0_0._onStoryNewChange(arg_43_0)
	arg_43_0:refreshRoleStoryRed()
end

function var_0_0._roleStoryLoadImage(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	if string.nilorempty(arg_44_1) then
		logError("MainActExtraDisplay:_roleStoryLoadImage path nil")

		return
	end

	arg_44_0._simagerolestory:LoadImage(arg_44_1, arg_44_2, arg_44_3)
end

function var_0_0.refreshRougeBtn(arg_45_0)
	gohelper.setActive(arg_45_0._btnrolestory, true)

	local var_45_0 = ActivityConfig.instance:getRougeActivityConfig()

	arg_45_0:_roleStoryLoadImage(var_45_0.extraDisplayIcon, arg_45_0.onLoadImage, arg_45_0)

	arg_45_0._txtrolestory.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("mainview_rougeactextradisplay"), var_45_0.tabName)
end

function var_0_0.refreshDouQuQuBtn(arg_46_0)
	gohelper.setActive(arg_46_0._btnrolestory, true)

	local var_46_0 = ActivityConfig.instance:getActivityCo(arg_46_0._douququActId)

	arg_46_0:_roleStoryLoadImage(var_46_0.extraDisplayIcon, arg_46_0.onLoadImage, arg_46_0)

	arg_46_0._txtrolestory.text = ""
end

function var_0_0.refreshSurvivalBtn(arg_47_0)
	gohelper.setActive(arg_47_0._btnrolestory, true)

	local var_47_0 = ActivityConfig.instance:getActivityCo(VersionActivity3_1Enum.ActivityId.Survival)

	arg_47_0:_roleStoryLoadImage(var_47_0.extraDisplayIcon, arg_47_0.onLoadImage, arg_47_0)

	arg_47_0._txtrolestory.text = ""
end

function var_0_0.refreshAct178Btn(arg_48_0)
	gohelper.setActive(arg_48_0._btnrolestory, true)

	local var_48_0 = ActivityConfig.instance:getActivityCo(arg_48_0._act178ActId)

	arg_48_0:_roleStoryLoadImage(var_48_0.extraDisplayIcon, arg_48_0.onLoadImage, arg_48_0)

	arg_48_0._txtrolestory.text = ""
end

function var_0_0.refreshAct182Btn(arg_49_0)
	gohelper.setActive(arg_49_0._btnrolestory, true)

	local var_49_0 = ActivityConfig.instance:getActivityCo(arg_49_0._act182ActId)

	arg_49_0:_roleStoryLoadImage(var_49_0.extraDisplayIcon, arg_49_0.onLoadImage, arg_49_0)

	arg_49_0._txtrolestory.text = ""
end

function var_0_0.refreshWeekWalkHeartBtn(arg_50_0)
	gohelper.setActive(arg_50_0._btnrolestory, true)

	local var_50_0 = arg_50_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)
	local var_50_1 = ActivityConfig.instance:getActivityCo(var_50_0)

	arg_50_0:_roleStoryLoadImage(var_50_1.extraDisplayIcon, arg_50_0.onLoadImage, arg_50_0)

	local var_50_2 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.WeekWalkHeartShow)

	arg_50_0._txtrolestory.text = var_50_2.name
end

function var_0_0.refreshAct191Btn(arg_51_0)
	gohelper.setActive(arg_51_0._btnrolestory, true)

	local var_51_0 = arg_51_0:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)
	local var_51_1 = ActivityConfig.instance:getActivityCo(var_51_0)

	arg_51_0:_roleStoryLoadImage(var_51_1.extraDisplayIcon, arg_51_0.onLoadImage, arg_51_0)

	arg_51_0._txtrolestory.text = ""
end

function var_0_0.onLoadImage(arg_52_0)
	arg_52_0._imagerolestory:SetNativeSize()
end

function var_0_0.refreshSeasonBtn(arg_53_0)
	gohelper.setActive(arg_53_0._btnrolestory, true)

	local var_53_0 = ActivityConfig.instance:getSesonActivityConfig()

	arg_53_0:_roleStoryLoadImage(var_53_0.extraDisplayIcon, arg_53_0.onLoadImage, arg_53_0)

	arg_53_0._txtrolestory.text = var_53_0.name

	local var_53_1 = arg_53_0._seasonActId
	local var_53_2 = ActivityConfig.instance:getActivityCo(var_53_1)

	RedDotController.instance:addRedDot(arg_53_0._gorolestoryred, var_53_2.redDotId)

	local var_53_3 = ActivityStageHelper.checkOneActivityStageHasChange(var_53_1)

	gohelper.setActive(arg_53_0._gorolestorynew, var_53_3)
	gohelper.setActive(arg_53_0._gorolestoryred, not var_53_3)
end

function var_0_0.refreshRoleStoryBtn(arg_54_0)
	local var_54_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_54_1 = var_54_0 > 0

	gohelper.setActive(arg_54_0._btnrolestory, var_54_1)

	if var_54_1 then
		local var_54_2 = RoleStoryConfig.instance:getStoryById(var_54_0)

		arg_54_0:_roleStoryLoadImage(string.format("singlebg/dungeon/rolestory_singlebg/%s.png", var_54_2.main_pic), arg_54_0.onLoadImage, arg_54_0)

		local var_54_3 = var_54_2.mainviewName

		if string.nilorempty(var_54_3) then
			var_54_3 = var_54_2.name
		end

		arg_54_0._txtrolestory.text = var_54_3

		RedDotController.instance:addRedDot(arg_54_0._gorolestoryred, RedDotEnum.DotNode.NecrologistStory)
	end

	arg_54_0:refreshRoleStoryRed()
end

function var_0_0.refreshRoleStoryRed(arg_55_0)
	if arg_55_0.activityShowState ~= ActivityEnum.MainViewActivityState.RoleStoryActivity then
		return
	end

	local var_55_0 = RoleStoryModel.instance:getCurActStoryId()

	if not (var_55_0 > 0) then
		return
	end

	local var_55_1 = RoleStoryModel.instance:getMoById(var_55_0).cfg.activityId
	local var_55_2 = ActivityStageHelper.checkOneActivityStageHasChange(var_55_1)

	gohelper.setActive(arg_55_0._gorolestorynew, var_55_2)
	gohelper.setActive(arg_55_0._gorolestoryred, not var_55_2)
end

function var_0_0.refreshReactivityBtn(arg_56_0)
	local var_56_0 = ReactivityController.instance:getCurReactivityId()
	local var_56_1 = var_56_0 and ActivityHelper.getActivityStatusAndToast(var_56_0)
	local var_56_2 = arg_56_0.activityShowState == ActivityEnum.MainViewActivityState.Reactivity

	gohelper.setActive(arg_56_0._btnreactivity, var_56_2)

	if var_56_2 then
		local var_56_3 = ActivityConfig.instance:getActivityCo(var_56_0)

		arg_56_0._txtreactivity.text = var_56_3 and var_56_3.name or ""

		local var_56_4 = var_56_1 == ActivityEnum.ActivityStatus.Normal and ActivityStageHelper.checkOneActivityStageHasChange(var_56_0)

		gohelper.setActive(arg_56_0._goreactivityred, not var_56_4)
		gohelper.setActive(arg_56_0._goreactivitynew, var_56_4)
		gohelper.setActive(arg_56_0._goreactivitylocked, var_56_1 == ActivityEnum.ActivityStatus.NotUnlock)
		arg_56_0:addReactivityRed()
	end
end

function var_0_0.addReactivityRed(arg_57_0)
	local var_57_0 = ReactivityController.instance:getCurReactivityId()

	if var_57_0 then
		local var_57_1 = ActivityConfig.instance:getActivityCo(var_57_0)

		if var_57_1 and var_57_1.redDotId > 0 then
			RedDotController.instance:addRedDot(arg_57_0._goreactivityred, var_57_1.redDotId)
		end
	end
end

function var_0_0.checkShowActivityEnter(arg_58_0)
	local var_58_0 = ActivityEnum.MainViewActivityState.None

	arg_58_0._curActDisplayConfig = nil

	local var_58_1 = 0
	local var_58_2 = ActivityConfig.instance:getMainActExtraDisplayList()

	for iter_58_0, iter_58_1 in ipairs(var_58_2) do
		local var_58_3 = arg_58_0._actHandler[iter_58_1.id]

		if not var_58_3 then
			logError("MainActExtraDisplay 活动没有对应的handler id:" .. tostring(iter_58_1.id))
		end

		if var_58_3 and var_58_3(arg_58_0) then
			local var_58_4 = arg_58_0._actGetStartTimeHandler[iter_58_1.id](arg_58_0)

			if var_58_1 <= var_58_4 then
				var_58_1 = var_58_4
				var_58_0 = iter_58_1.id
				arg_58_0._curActDisplayConfig = iter_58_1
			end
		end
	end

	arg_58_0.activityShowState = var_58_0

	recthelper.setAnchorY(arg_58_0._goright.transform, arg_58_0.activityShowState == ActivityEnum.MainViewActivityState.None and 0 or -40)

	if SLFramework.FrameworkSettings.IsEditor then
		logNormal("MainActExtraDisplay:checkShowActivityEnter showState:" .. tostring(var_58_0))
	end
end

function var_0_0.check2_0DungeonReddot(arg_59_0)
	if ActivityHelper.getActivityStatus(VersionActivity2_0Enum.ActivityId.Dungeon) == ActivityEnum.ActivityStatus.Normal then
		Activity161Controller.instance:checkHasUnDoElement()
	end
end

function var_0_0._getCurBindActivityId(arg_60_0)
	return arg_60_0:_getBindActivityId(arg_60_0.activityShowState)
end

function var_0_0._getBindActivityId(arg_61_0, arg_61_1)
	local var_61_0 = ActivityConfig.instance:getActivityByExtraDisplayId(arg_61_1)

	return var_61_0 and var_61_0.id
end

function var_0_0.onRefreshActivityState(arg_62_0)
	arg_62_0:checkShowActivityEnter()
	arg_62_0:refreshReactivityBtn()
	arg_62_0:_refreshBtns()
	arg_62_0:check2_0DungeonReddot()
end

function var_0_0._refreshBtns(arg_63_0)
	gohelper.setActive(arg_63_0._btnrolestory, false)

	if not arg_63_0._curActDisplayConfig then
		return
	end

	local var_63_0 = arg_63_0._actRefreshBtnHandler[arg_63_0.activityShowState]

	if var_63_0 then
		var_63_0(arg_63_0)
	end
end

function var_0_0.onOpen(arg_64_0)
	arg_64_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, arg_64_0._onStoryChange, arg_64_0)
	arg_64_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.StoryNewChange, arg_64_0._onStoryNewChange, arg_64_0)
	arg_64_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_64_0.onRefreshActivityState, arg_64_0)
	arg_64_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_64_0.onRefreshActivityState, arg_64_0)
	arg_64_0:addEventCb(ActivityController.instance, ActivityEvent.ChangeActivityStage, arg_64_0.onRefreshActivityState, arg_64_0)
	arg_64_0:onRefreshActivityState()
	arg_64_0:showKeyTips()
end

function var_0_0.showKeyTips(arg_65_0)
	arg_65_0._keytipsReactivity = gohelper.findChild(arg_65_0._btnreactivity.gameObject, "#go_pcbtn")
	arg_65_0._keytipsRoleStory = gohelper.findChild(arg_65_0._btnrolestory.gameObject, "#go_pcbtn")

	PCInputController.instance:showkeyTips(arg_65_0._keytipsReactivity, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
	PCInputController.instance:showkeyTips(arg_65_0._keytipsRoleStory, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
end

function var_0_0.onClose(arg_66_0)
	return
end

function var_0_0.onDestroyView(arg_67_0)
	if arg_67_0._simagerolestory then
		arg_67_0._simagerolestory:UnLoadImage()
	end
end

return var_0_0
