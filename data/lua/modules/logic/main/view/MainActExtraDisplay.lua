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

	arg_4_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_4_0, true)
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
	RoleStoryController.instance:openRoleStoryDispatchMainView()
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

function var_0_0._onDouQuQuClick(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_10_0 = arg_10_0._douququActId

	arg_10_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_10_0)
end

function var_0_0._onAct178Click(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_11_0 = arg_11_0._act178ActId

	arg_11_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_11_0)
end

function var_0_0._onAct182Click(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_12_0 = arg_12_0._act182ActId

	arg_12_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_12_0)
end

function var_0_0._onWeekWalkHeartClick(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_13_0 = ActivityEnum.Activity.WeekWalkHeartShow

	arg_13_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_13_0)
end

function var_0_0._getEnterController(arg_14_0)
	return arg_14_0.viewContainer:getMainActivityEnterView():getCurEnterController()
end

function var_0_0._editableInitView(arg_15_0)
	local var_15_0 = ActivityConfig.instance:getSesonActivityConfig()

	arg_15_0._seasonActId = var_15_0 and var_15_0.id or Season123Model.instance:getCurSeasonId() or Season166Model.instance:getCurSeasonId()

	local var_15_1 = ActivityConfig.instance:getRougeActivityConfig()

	arg_15_0._rougeActId = var_15_1 and var_15_1.id
	arg_15_0._douququActId = VersionActivity2_3Enum.ActivityId.Act174
	arg_15_0._act178ActId = VersionActivity2_4Enum.ActivityId.Pinball
	arg_15_0._act182ActId = VersionActivity2_5Enum.ActivityId.AutoChess

	arg_15_0:_initActs()
end

function var_0_0._initActs(arg_16_0)
	arg_16_0._actHandler = {}
	arg_16_0._actGetStartTimeHandler = {}
	arg_16_0._actClickHandler = {}
	arg_16_0._actRefreshBtnHandler = {}

	arg_16_0:_addActHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_16_0._getRoleStoryActivityStatus, arg_16_0._getRoleStoryActivityStartTime)
	arg_16_0:_addActHandler(ActivityEnum.MainViewActivityState.Reactivity, arg_16_0._getReactivityStatus, arg_16_0._getReactivityStartTime)
	arg_16_0:_addActHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_16_0._getSeasonActivityStatus, arg_16_0._getSeasonActivityStartTime)
	arg_16_0:_addActHandler(ActivityEnum.MainViewActivityState.Rouge, arg_16_0._getRougeStatus, arg_16_0._getRougeStartTime)
	arg_16_0:_addActHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_16_0._getDouQuQuStatus, arg_16_0._getDouQuQuStartTime)
	arg_16_0:_addActHandler(ActivityEnum.MainViewActivityState.Act178, arg_16_0._getAct178Status, arg_16_0._getAct178StartTime)
	arg_16_0:_addActHandler(ActivityEnum.MainViewActivityState.Act182, arg_16_0._getAct182Status, arg_16_0._getAct182StartTime)
	arg_16_0:_addActHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_16_0._getWeekWalkHeartStatus, arg_16_0._getWeekWalkHeartStartTime)
	arg_16_0:_addClickHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_16_0._onRoleStoryClick)
	arg_16_0:_addClickHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_16_0._onSeasonClick)
	arg_16_0:_addClickHandler(ActivityEnum.MainViewActivityState.Rouge, arg_16_0._onRougeClick)
	arg_16_0:_addClickHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_16_0._onDouQuQuClick)
	arg_16_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act178, arg_16_0._onAct178Click)
	arg_16_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act182, arg_16_0._onAct182Click)
	arg_16_0:_addClickHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_16_0._onWeekWalkHeartClick)
	arg_16_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_16_0.refreshRoleStoryBtn)
	arg_16_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_16_0.refreshSeasonBtn)
	arg_16_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Rouge, arg_16_0.refreshRougeBtn)
	arg_16_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_16_0.refreshDouQuQuBtn)
	arg_16_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act178, arg_16_0.refreshAct178Btn)
	arg_16_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act182, arg_16_0.refreshAct182Btn)
	arg_16_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_16_0.refreshWeekWalkHeartBtn)
end

function var_0_0._addRefreshBtnHandler(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._actRefreshBtnHandler[arg_17_1] = arg_17_2
end

function var_0_0._addClickHandler(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._actClickHandler[arg_18_1] = arg_18_2
end

function var_0_0._addActHandler(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0._actHandler[arg_19_1] = arg_19_2
	arg_19_0._actGetStartTimeHandler[arg_19_1] = arg_19_3
end

function var_0_0._getSeasonActivityStatus(arg_20_0)
	local var_20_0 = arg_20_0._seasonActId

	return (var_20_0 and ActivityHelper.getActivityStatus(var_20_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getSeasonActivityStartTime(arg_21_0)
	local var_21_0 = arg_21_0._seasonActId

	return var_21_0 and ActivityModel.instance:getActStartTime(var_21_0)
end

function var_0_0._getReactivityStatus(arg_22_0)
	local var_22_0 = ReactivityController.instance:getCurReactivityId()
	local var_22_1 = var_22_0 and ReactivityEnum.ActivityDefine[var_22_0]
	local var_22_2 = var_22_1 and var_22_1.storeActId

	return (var_22_2 and ActivityHelper.getActivityStatus(var_22_2)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getReactivityStartTime(arg_23_0)
	local var_23_0 = ReactivityController.instance:getCurReactivityId()
	local var_23_1 = ReactivityEnum.ActivityDefine[var_23_0]
	local var_23_2 = var_23_1 and var_23_1.storeActId
	local var_23_3 = var_23_2 and ActivityModel.instance:getActMO(var_23_2)

	return var_23_3 and var_23_3:getRealStartTimeStamp() * 1000
end

function var_0_0._getRoleStoryActivityStatus(arg_24_0)
	local var_24_0 = RoleStoryModel.instance:getCurActStoryId()

	return var_24_0 and var_24_0 > 0 or false
end

function var_0_0._getRoleStoryActivityStartTime(arg_25_0)
	local var_25_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_25_1 = (var_25_0 and var_25_0 > 0 or false) and RoleStoryModel.instance:getMoById(var_25_0)

	return var_25_1 and var_25_1:getActTime() * 1000
end

function var_0_0._getRougeStatus(arg_26_0)
	local var_26_0 = arg_26_0._rougeActId

	return (var_26_0 and ActivityHelper.getActivityStatus(var_26_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getRougeStartTime(arg_27_0)
	local var_27_0 = arg_27_0._rougeActId
	local var_27_1 = ActivityModel.instance:getActMO(var_27_0)

	return var_27_1 and var_27_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getDouQuQuStatus(arg_28_0)
	local var_28_0 = arg_28_0._douququActId

	return (var_28_0 and ActivityHelper.getActivityStatus(var_28_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getDouQuQuStartTime(arg_29_0)
	local var_29_0 = arg_29_0._douququActId
	local var_29_1 = ActivityModel.instance:getActMO(var_29_0)

	return var_29_1 and var_29_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct178Status(arg_30_0)
	local var_30_0 = arg_30_0._act178ActId

	return (var_30_0 and ActivityHelper.getActivityStatus(var_30_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct178StartTime(arg_31_0)
	local var_31_0 = arg_31_0._act178ActId
	local var_31_1 = ActivityModel.instance:getActMO(var_31_0)

	return var_31_1 and var_31_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct182Status(arg_32_0)
	local var_32_0 = arg_32_0._act182ActId

	return (var_32_0 and ActivityHelper.getActivityStatus(var_32_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct182StartTime(arg_33_0)
	local var_33_0 = arg_33_0._act182ActId
	local var_33_1 = ActivityModel.instance:getActMO(var_33_0)

	return var_33_1 and var_33_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getWeekWalkHeartStatus(arg_34_0)
	local var_34_0 = arg_34_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)

	return (var_34_0 and ActivityHelper.getActivityStatus(var_34_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getWeekWalkHeartStartTime(arg_35_0)
	local var_35_0 = arg_35_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)
	local var_35_1 = ActivityModel.instance:getActMO(var_35_0)

	return var_35_1 and var_35_1:getRealStartTimeStamp() * 1000
end

function var_0_0._onStoryChange(arg_36_0)
	arg_36_0:onRefreshActivityState()
end

function var_0_0._onStoryNewChange(arg_37_0)
	arg_37_0:refreshRoleStoryRed()
end

function var_0_0._roleStoryLoadImage(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if string.nilorempty(arg_38_1) then
		logError("MainActExtraDisplay:_roleStoryLoadImage path nil")

		return
	end

	arg_38_0._simagerolestory:LoadImage(arg_38_1, arg_38_2, arg_38_3)
end

function var_0_0.refreshRougeBtn(arg_39_0)
	gohelper.setActive(arg_39_0._btnrolestory, true)

	local var_39_0 = ActivityConfig.instance:getRougeActivityConfig()

	arg_39_0:_roleStoryLoadImage(var_39_0.extraDisplayIcon, arg_39_0.onLoadImage, arg_39_0)

	arg_39_0._txtrolestory.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("mainview_rougeactextradisplay"), var_39_0.tabName)
end

function var_0_0.refreshDouQuQuBtn(arg_40_0)
	gohelper.setActive(arg_40_0._btnrolestory, true)

	local var_40_0 = ActivityConfig.instance:getActivityCo(arg_40_0._douququActId)

	arg_40_0:_roleStoryLoadImage(var_40_0.extraDisplayIcon, arg_40_0.onLoadImage, arg_40_0)

	arg_40_0._txtrolestory.text = ""
end

function var_0_0.refreshAct178Btn(arg_41_0)
	gohelper.setActive(arg_41_0._btnrolestory, true)

	local var_41_0 = ActivityConfig.instance:getActivityCo(arg_41_0._act178ActId)

	arg_41_0:_roleStoryLoadImage(var_41_0.extraDisplayIcon, arg_41_0.onLoadImage, arg_41_0)

	arg_41_0._txtrolestory.text = ""
end

function var_0_0.refreshAct182Btn(arg_42_0)
	gohelper.setActive(arg_42_0._btnrolestory, true)

	local var_42_0 = ActivityConfig.instance:getActivityCo(arg_42_0._act182ActId)

	arg_42_0:_roleStoryLoadImage(var_42_0.extraDisplayIcon, arg_42_0.onLoadImage, arg_42_0)

	arg_42_0._txtrolestory.text = ""
end

function var_0_0.refreshWeekWalkHeartBtn(arg_43_0)
	gohelper.setActive(arg_43_0._btnrolestory, true)

	local var_43_0 = arg_43_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)
	local var_43_1 = ActivityConfig.instance:getActivityCo(var_43_0)

	arg_43_0:_roleStoryLoadImage(var_43_1.extraDisplayIcon, arg_43_0.onLoadImage, arg_43_0)

	local var_43_2 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.WeekWalkHeartShow)

	arg_43_0._txtrolestory.text = var_43_2.name
end

function var_0_0.onLoadImage(arg_44_0)
	arg_44_0._imagerolestory:SetNativeSize()
end

function var_0_0.refreshSeasonBtn(arg_45_0)
	gohelper.setActive(arg_45_0._btnrolestory, true)

	local var_45_0 = ActivityConfig.instance:getSesonActivityConfig()

	arg_45_0:_roleStoryLoadImage(var_45_0.extraDisplayIcon, arg_45_0.onLoadImage, arg_45_0)

	arg_45_0._txtrolestory.text = var_45_0.name

	local var_45_1 = arg_45_0._seasonActId
	local var_45_2 = ActivityConfig.instance:getActivityCo(var_45_1)

	RedDotController.instance:addRedDot(arg_45_0._gorolestoryred, var_45_2.redDotId)

	local var_45_3 = ActivityStageHelper.checkOneActivityStageHasChange(var_45_1)

	gohelper.setActive(arg_45_0._gorolestorynew, var_45_3)
	gohelper.setActive(arg_45_0._gorolestoryred, not var_45_3)
end

function var_0_0.refreshRoleStoryBtn(arg_46_0)
	local var_46_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_46_1 = var_46_0 > 0

	gohelper.setActive(arg_46_0._btnrolestory, var_46_1)

	if var_46_1 then
		local var_46_2 = RoleStoryConfig.instance:getStoryById(var_46_0)

		arg_46_0:_roleStoryLoadImage(string.format("singlebg/dungeon/rolestory_singlebg/%s.png", var_46_2.main_pic), arg_46_0.onLoadImage, arg_46_0)

		local var_46_3 = var_46_2.mainviewName

		if string.nilorempty(var_46_3) then
			var_46_3 = var_46_2.name
		end

		arg_46_0._txtrolestory.text = var_46_3

		RedDotController.instance:addRedDot(arg_46_0._gorolestoryred, RedDotEnum.DotNode.RoleStoryActivity)
	end

	arg_46_0:refreshRoleStoryRed()
end

function var_0_0.refreshRoleStoryRed(arg_47_0)
	if arg_47_0.activityShowState ~= ActivityEnum.MainViewActivityState.RoleStoryActivity then
		return
	end

	local var_47_0 = false
	local var_47_1 = RoleStoryModel.instance:getCurActStoryId()

	if not (var_47_1 > 0) then
		return
	end

	local var_47_2 = RoleStoryModel.instance:getMoById(var_47_1).cfg.activityId
	local var_47_3 = ActivityStageHelper.checkOneActivityStageHasChange(var_47_2)

	gohelper.setActive(arg_47_0._gorolestorynew, var_47_3)
	gohelper.setActive(arg_47_0._gorolestoryred, not var_47_3)
end

function var_0_0.refreshReactivityBtn(arg_48_0)
	local var_48_0 = ReactivityController.instance:getCurReactivityId()
	local var_48_1 = var_48_0 and ActivityHelper.getActivityStatusAndToast(var_48_0)
	local var_48_2 = arg_48_0.activityShowState == ActivityEnum.MainViewActivityState.Reactivity

	gohelper.setActive(arg_48_0._btnreactivity, var_48_2)

	if var_48_2 then
		local var_48_3 = ActivityConfig.instance:getActivityCo(var_48_0)

		arg_48_0._txtreactivity.text = var_48_3 and var_48_3.name or ""

		local var_48_4 = var_48_1 == ActivityEnum.ActivityStatus.Normal and ActivityStageHelper.checkOneActivityStageHasChange(var_48_0)

		gohelper.setActive(arg_48_0._goreactivityred, not var_48_4)
		gohelper.setActive(arg_48_0._goreactivitynew, var_48_4)
		gohelper.setActive(arg_48_0._goreactivitylocked, var_48_1 == ActivityEnum.ActivityStatus.NotUnlock)
		arg_48_0:addReactivityRed()
	end
end

function var_0_0.addReactivityRed(arg_49_0)
	local var_49_0 = ReactivityController.instance:getCurReactivityId()

	if var_49_0 then
		local var_49_1 = ActivityConfig.instance:getActivityCo(var_49_0)

		if var_49_1 and var_49_1.redDotId > 0 then
			RedDotController.instance:addRedDot(arg_49_0._goreactivityred, var_49_1.redDotId)
		end
	end
end

function var_0_0.checkShowActivityEnter(arg_50_0)
	local var_50_0 = ActivityEnum.MainViewActivityState.None

	arg_50_0._curActDisplayConfig = nil

	local var_50_1 = 0
	local var_50_2 = ActivityConfig.instance:getMainActExtraDisplayList()

	for iter_50_0, iter_50_1 in ipairs(var_50_2) do
		local var_50_3 = arg_50_0._actHandler[iter_50_1.id]

		if not var_50_3 then
			logError("MainActExtraDisplay 活动没有对应的handler id:" .. tostring(iter_50_1.id))
		end

		if var_50_3 and var_50_3(arg_50_0) then
			local var_50_4 = arg_50_0._actGetStartTimeHandler[iter_50_1.id](arg_50_0)

			if var_50_1 <= var_50_4 then
				var_50_1 = var_50_4
				var_50_0 = iter_50_1.id
				arg_50_0._curActDisplayConfig = iter_50_1
			end
		end
	end

	arg_50_0.activityShowState = var_50_0

	recthelper.setAnchorY(arg_50_0._goright.transform, arg_50_0.activityShowState == ActivityEnum.MainViewActivityState.None and 0 or -40)

	if SLFramework.FrameworkSettings.IsEditor then
		logNormal("MainActExtraDisplay:checkShowActivityEnter showState:" .. tostring(var_50_0))
	end
end

function var_0_0._getCurBindActivityId(arg_51_0)
	return arg_51_0:_getBindActivityId(arg_51_0.activityShowState)
end

function var_0_0._getBindActivityId(arg_52_0, arg_52_1)
	local var_52_0 = ActivityConfig.instance:getActivityByExtraDisplayId(arg_52_1)

	return var_52_0 and var_52_0.id
end

function var_0_0.onRefreshActivityState(arg_53_0)
	arg_53_0:checkShowActivityEnter()
	arg_53_0:refreshReactivityBtn()
	arg_53_0:_refreshBtns()
end

function var_0_0._refreshBtns(arg_54_0)
	gohelper.setActive(arg_54_0._btnrolestory, false)

	if not arg_54_0._curActDisplayConfig then
		return
	end

	local var_54_0 = arg_54_0._actRefreshBtnHandler[arg_54_0.activityShowState]

	if var_54_0 then
		var_54_0(arg_54_0)
	end
end

function var_0_0.onOpen(arg_55_0)
	arg_55_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, arg_55_0._onStoryChange, arg_55_0)
	arg_55_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.StoryNewChange, arg_55_0._onStoryNewChange, arg_55_0)
	arg_55_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_55_0.onRefreshActivityState, arg_55_0)
	arg_55_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_55_0.onRefreshActivityState, arg_55_0)
	arg_55_0:addEventCb(ActivityController.instance, ActivityEvent.ChangeActivityStage, arg_55_0.onRefreshActivityState, arg_55_0)
	arg_55_0:onRefreshActivityState()
	arg_55_0:showKeyTips()
end

function var_0_0.showKeyTips(arg_56_0)
	arg_56_0._keytipsReactivity = gohelper.findChild(arg_56_0._btnreactivity.gameObject, "#go_pcbtn")
	arg_56_0._keytipsRoleStory = gohelper.findChild(arg_56_0._btnrolestory.gameObject, "#go_pcbtn")

	PCInputController.instance:showkeyTips(arg_56_0._keytipsReactivity, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
	PCInputController.instance:showkeyTips(arg_56_0._keytipsRoleStory, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
end

function var_0_0.onClose(arg_57_0)
	return
end

function var_0_0.onDestroyView(arg_58_0)
	if arg_58_0._simagerolestory then
		arg_58_0._simagerolestory:UnLoadImage()
	end
end

return var_0_0
