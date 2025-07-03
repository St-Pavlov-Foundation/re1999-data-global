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

function var_0_0._onAct191Click(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_14_0 = arg_14_0:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)

	arg_14_0:_getEnterController():openVersionActivityEnterViewIfNotOpened(nil, nil, var_14_0)
end

function var_0_0._getEnterController(arg_15_0)
	return arg_15_0.viewContainer:getMainActivityEnterView():getCurEnterController()
end

function var_0_0._editableInitView(arg_16_0)
	local var_16_0 = ActivityConfig.instance:getSesonActivityConfig()

	arg_16_0._seasonActId = var_16_0 and var_16_0.id or Season123Model.instance:getCurSeasonId() or Season166Model.instance:getCurSeasonId()

	local var_16_1 = ActivityConfig.instance:getRougeActivityConfig()

	arg_16_0._rougeActId = var_16_1 and var_16_1.id
	arg_16_0._douququActId = VersionActivity2_3Enum.ActivityId.Act174
	arg_16_0._act178ActId = VersionActivity2_4Enum.ActivityId.Pinball
	arg_16_0._act182ActId = VersionActivity2_5Enum.ActivityId.AutoChess

	arg_16_0:_initActs()
end

function var_0_0._initActs(arg_17_0)
	arg_17_0._actHandler = {}
	arg_17_0._actGetStartTimeHandler = {}
	arg_17_0._actClickHandler = {}
	arg_17_0._actRefreshBtnHandler = {}

	arg_17_0:_addActHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_17_0._getRoleStoryActivityStatus, arg_17_0._getRoleStoryActivityStartTime)
	arg_17_0:_addActHandler(ActivityEnum.MainViewActivityState.Reactivity, arg_17_0._getReactivityStatus, arg_17_0._getReactivityStartTime)
	arg_17_0:_addActHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_17_0._getSeasonActivityStatus, arg_17_0._getSeasonActivityStartTime)
	arg_17_0:_addActHandler(ActivityEnum.MainViewActivityState.Rouge, arg_17_0._getRougeStatus, arg_17_0._getRougeStartTime)
	arg_17_0:_addActHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_17_0._getDouQuQuStatus, arg_17_0._getDouQuQuStartTime)
	arg_17_0:_addActHandler(ActivityEnum.MainViewActivityState.Act178, arg_17_0._getAct178Status, arg_17_0._getAct178StartTime)
	arg_17_0:_addActHandler(ActivityEnum.MainViewActivityState.Act182, arg_17_0._getAct182Status, arg_17_0._getAct182StartTime)
	arg_17_0:_addActHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_17_0._getWeekWalkHeartStatus, arg_17_0._getWeekWalkHeartStartTime)
	arg_17_0:_addActHandler(ActivityEnum.MainViewActivityState.Act191, arg_17_0._getAct191Status, arg_17_0._getAct191StartTime)
	arg_17_0:_addClickHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_17_0._onRoleStoryClick)
	arg_17_0:_addClickHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_17_0._onSeasonClick)
	arg_17_0:_addClickHandler(ActivityEnum.MainViewActivityState.Rouge, arg_17_0._onRougeClick)
	arg_17_0:_addClickHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_17_0._onDouQuQuClick)
	arg_17_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act178, arg_17_0._onAct178Click)
	arg_17_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act182, arg_17_0._onAct182Click)
	arg_17_0:_addClickHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_17_0._onWeekWalkHeartClick)
	arg_17_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act191, arg_17_0._onAct191Click)
	arg_17_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_17_0.refreshRoleStoryBtn)
	arg_17_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_17_0.refreshSeasonBtn)
	arg_17_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Rouge, arg_17_0.refreshRougeBtn)
	arg_17_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_17_0.refreshDouQuQuBtn)
	arg_17_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act178, arg_17_0.refreshAct178Btn)
	arg_17_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act182, arg_17_0.refreshAct182Btn)
	arg_17_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_17_0.refreshWeekWalkHeartBtn)
	arg_17_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act191, arg_17_0.refreshAct191Btn)
end

function var_0_0._addRefreshBtnHandler(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._actRefreshBtnHandler[arg_18_1] = arg_18_2
end

function var_0_0._addClickHandler(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._actClickHandler[arg_19_1] = arg_19_2
end

function var_0_0._addActHandler(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0._actHandler[arg_20_1] = arg_20_2
	arg_20_0._actGetStartTimeHandler[arg_20_1] = arg_20_3
end

function var_0_0._getSeasonActivityStatus(arg_21_0)
	local var_21_0 = arg_21_0._seasonActId

	return (var_21_0 and ActivityHelper.getActivityStatus(var_21_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getSeasonActivityStartTime(arg_22_0)
	local var_22_0 = arg_22_0._seasonActId

	return var_22_0 and ActivityModel.instance:getActStartTime(var_22_0)
end

function var_0_0._getReactivityStatus(arg_23_0)
	local var_23_0 = ReactivityController.instance:getCurReactivityId()
	local var_23_1 = var_23_0 and ReactivityEnum.ActivityDefine[var_23_0]
	local var_23_2 = var_23_1 and var_23_1.storeActId

	return (var_23_2 and ActivityHelper.getActivityStatus(var_23_2)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getReactivityStartTime(arg_24_0)
	local var_24_0 = ReactivityController.instance:getCurReactivityId()
	local var_24_1 = ReactivityEnum.ActivityDefine[var_24_0]
	local var_24_2 = var_24_1 and var_24_1.storeActId
	local var_24_3 = var_24_2 and ActivityModel.instance:getActMO(var_24_2)

	return var_24_3 and var_24_3:getRealStartTimeStamp() * 1000
end

function var_0_0._getRoleStoryActivityStatus(arg_25_0)
	local var_25_0 = RoleStoryModel.instance:getCurActStoryId()

	return var_25_0 and var_25_0 > 0 or false
end

function var_0_0._getRoleStoryActivityStartTime(arg_26_0)
	local var_26_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_26_1 = (var_26_0 and var_26_0 > 0 or false) and RoleStoryModel.instance:getMoById(var_26_0)

	return var_26_1 and var_26_1:getActTime() * 1000
end

function var_0_0._getRougeStatus(arg_27_0)
	local var_27_0 = arg_27_0._rougeActId

	return (var_27_0 and ActivityHelper.getActivityStatus(var_27_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getRougeStartTime(arg_28_0)
	local var_28_0 = arg_28_0._rougeActId
	local var_28_1 = ActivityModel.instance:getActMO(var_28_0)

	return var_28_1 and var_28_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getDouQuQuStatus(arg_29_0)
	local var_29_0 = arg_29_0._douququActId

	return (var_29_0 and ActivityHelper.getActivityStatus(var_29_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getDouQuQuStartTime(arg_30_0)
	local var_30_0 = arg_30_0._douququActId
	local var_30_1 = ActivityModel.instance:getActMO(var_30_0)

	return var_30_1 and var_30_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct178Status(arg_31_0)
	local var_31_0 = arg_31_0._act178ActId

	return (var_31_0 and ActivityHelper.getActivityStatus(var_31_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct178StartTime(arg_32_0)
	local var_32_0 = arg_32_0._act178ActId
	local var_32_1 = ActivityModel.instance:getActMO(var_32_0)

	return var_32_1 and var_32_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct182Status(arg_33_0)
	local var_33_0 = arg_33_0._act182ActId

	return (var_33_0 and ActivityHelper.getActivityStatus(var_33_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct182StartTime(arg_34_0)
	local var_34_0 = arg_34_0._act182ActId
	local var_34_1 = ActivityModel.instance:getActMO(var_34_0)

	return var_34_1 and var_34_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getWeekWalkHeartStatus(arg_35_0)
	local var_35_0 = arg_35_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)

	return (var_35_0 and ActivityHelper.getActivityStatus(var_35_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getWeekWalkHeartStartTime(arg_36_0)
	local var_36_0 = arg_36_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)
	local var_36_1 = ActivityModel.instance:getActMO(var_36_0)

	return var_36_1 and var_36_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct191Status(arg_37_0)
	local var_37_0 = arg_37_0:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)

	return (var_37_0 and ActivityHelper.getActivityStatus(var_37_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct191StartTime(arg_38_0)
	local var_38_0 = arg_38_0:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)
	local var_38_1 = ActivityModel.instance:getActMO(var_38_0)

	return var_38_1 and var_38_1:getRealStartTimeStamp() * 1000
end

function var_0_0._onStoryChange(arg_39_0)
	arg_39_0:onRefreshActivityState()
end

function var_0_0._onStoryNewChange(arg_40_0)
	arg_40_0:refreshRoleStoryRed()
end

function var_0_0._roleStoryLoadImage(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	if string.nilorempty(arg_41_1) then
		logError("MainActExtraDisplay:_roleStoryLoadImage path nil")

		return
	end

	arg_41_0._simagerolestory:LoadImage(arg_41_1, arg_41_2, arg_41_3)
end

function var_0_0.refreshRougeBtn(arg_42_0)
	gohelper.setActive(arg_42_0._btnrolestory, true)

	local var_42_0 = ActivityConfig.instance:getRougeActivityConfig()

	arg_42_0:_roleStoryLoadImage(var_42_0.extraDisplayIcon, arg_42_0.onLoadImage, arg_42_0)

	arg_42_0._txtrolestory.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("mainview_rougeactextradisplay"), var_42_0.tabName)
end

function var_0_0.refreshDouQuQuBtn(arg_43_0)
	gohelper.setActive(arg_43_0._btnrolestory, true)

	local var_43_0 = ActivityConfig.instance:getActivityCo(arg_43_0._douququActId)

	arg_43_0:_roleStoryLoadImage(var_43_0.extraDisplayIcon, arg_43_0.onLoadImage, arg_43_0)

	arg_43_0._txtrolestory.text = ""
end

function var_0_0.refreshAct178Btn(arg_44_0)
	gohelper.setActive(arg_44_0._btnrolestory, true)

	local var_44_0 = ActivityConfig.instance:getActivityCo(arg_44_0._act178ActId)

	arg_44_0:_roleStoryLoadImage(var_44_0.extraDisplayIcon, arg_44_0.onLoadImage, arg_44_0)

	arg_44_0._txtrolestory.text = ""
end

function var_0_0.refreshAct182Btn(arg_45_0)
	gohelper.setActive(arg_45_0._btnrolestory, true)

	local var_45_0 = ActivityConfig.instance:getActivityCo(arg_45_0._act182ActId)

	arg_45_0:_roleStoryLoadImage(var_45_0.extraDisplayIcon, arg_45_0.onLoadImage, arg_45_0)

	arg_45_0._txtrolestory.text = ""
end

function var_0_0.refreshWeekWalkHeartBtn(arg_46_0)
	gohelper.setActive(arg_46_0._btnrolestory, true)

	local var_46_0 = arg_46_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)
	local var_46_1 = ActivityConfig.instance:getActivityCo(var_46_0)

	arg_46_0:_roleStoryLoadImage(var_46_1.extraDisplayIcon, arg_46_0.onLoadImage, arg_46_0)

	local var_46_2 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.WeekWalkHeartShow)

	arg_46_0._txtrolestory.text = var_46_2.name
end

function var_0_0.refreshAct191Btn(arg_47_0)
	gohelper.setActive(arg_47_0._btnrolestory, true)

	local var_47_0 = arg_47_0:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)
	local var_47_1 = ActivityConfig.instance:getActivityCo(var_47_0)

	arg_47_0:_roleStoryLoadImage(var_47_1.extraDisplayIcon, arg_47_0.onLoadImage, arg_47_0)

	arg_47_0._txtrolestory.text = ""
end

function var_0_0.onLoadImage(arg_48_0)
	arg_48_0._imagerolestory:SetNativeSize()
end

function var_0_0.refreshSeasonBtn(arg_49_0)
	gohelper.setActive(arg_49_0._btnrolestory, true)

	local var_49_0 = ActivityConfig.instance:getSesonActivityConfig()

	arg_49_0:_roleStoryLoadImage(var_49_0.extraDisplayIcon, arg_49_0.onLoadImage, arg_49_0)

	arg_49_0._txtrolestory.text = var_49_0.name

	local var_49_1 = arg_49_0._seasonActId
	local var_49_2 = ActivityConfig.instance:getActivityCo(var_49_1)

	RedDotController.instance:addRedDot(arg_49_0._gorolestoryred, var_49_2.redDotId)

	local var_49_3 = ActivityStageHelper.checkOneActivityStageHasChange(var_49_1)

	gohelper.setActive(arg_49_0._gorolestorynew, var_49_3)
	gohelper.setActive(arg_49_0._gorolestoryred, not var_49_3)
end

function var_0_0.refreshRoleStoryBtn(arg_50_0)
	local var_50_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_50_1 = var_50_0 > 0

	gohelper.setActive(arg_50_0._btnrolestory, var_50_1)

	if var_50_1 then
		local var_50_2 = RoleStoryConfig.instance:getStoryById(var_50_0)

		arg_50_0:_roleStoryLoadImage(string.format("singlebg/dungeon/rolestory_singlebg/%s.png", var_50_2.main_pic), arg_50_0.onLoadImage, arg_50_0)

		local var_50_3 = var_50_2.mainviewName

		if string.nilorempty(var_50_3) then
			var_50_3 = var_50_2.name
		end

		arg_50_0._txtrolestory.text = var_50_3

		RedDotController.instance:addRedDot(arg_50_0._gorolestoryred, RedDotEnum.DotNode.RoleStoryActivity)
	end

	arg_50_0:refreshRoleStoryRed()
end

function var_0_0.refreshRoleStoryRed(arg_51_0)
	if arg_51_0.activityShowState ~= ActivityEnum.MainViewActivityState.RoleStoryActivity then
		return
	end

	local var_51_0 = false
	local var_51_1 = RoleStoryModel.instance:getCurActStoryId()

	if not (var_51_1 > 0) then
		return
	end

	local var_51_2 = RoleStoryModel.instance:getMoById(var_51_1).cfg.activityId
	local var_51_3 = ActivityStageHelper.checkOneActivityStageHasChange(var_51_2)

	gohelper.setActive(arg_51_0._gorolestorynew, var_51_3)
	gohelper.setActive(arg_51_0._gorolestoryred, not var_51_3)
end

function var_0_0.refreshReactivityBtn(arg_52_0)
	local var_52_0 = ReactivityController.instance:getCurReactivityId()
	local var_52_1 = var_52_0 and ActivityHelper.getActivityStatusAndToast(var_52_0)
	local var_52_2 = arg_52_0.activityShowState == ActivityEnum.MainViewActivityState.Reactivity

	gohelper.setActive(arg_52_0._btnreactivity, var_52_2)

	if var_52_2 then
		local var_52_3 = ActivityConfig.instance:getActivityCo(var_52_0)

		arg_52_0._txtreactivity.text = var_52_3 and var_52_3.name or ""

		local var_52_4 = var_52_1 == ActivityEnum.ActivityStatus.Normal and ActivityStageHelper.checkOneActivityStageHasChange(var_52_0)

		gohelper.setActive(arg_52_0._goreactivityred, not var_52_4)
		gohelper.setActive(arg_52_0._goreactivitynew, var_52_4)
		gohelper.setActive(arg_52_0._goreactivitylocked, var_52_1 == ActivityEnum.ActivityStatus.NotUnlock)
		arg_52_0:addReactivityRed()
	end
end

function var_0_0.addReactivityRed(arg_53_0)
	local var_53_0 = ReactivityController.instance:getCurReactivityId()

	if var_53_0 then
		local var_53_1 = ActivityConfig.instance:getActivityCo(var_53_0)

		if var_53_1 and var_53_1.redDotId > 0 then
			RedDotController.instance:addRedDot(arg_53_0._goreactivityred, var_53_1.redDotId)
		end
	end
end

function var_0_0.checkShowActivityEnter(arg_54_0)
	local var_54_0 = ActivityEnum.MainViewActivityState.None

	arg_54_0._curActDisplayConfig = nil

	local var_54_1 = 0
	local var_54_2 = ActivityConfig.instance:getMainActExtraDisplayList()

	for iter_54_0, iter_54_1 in ipairs(var_54_2) do
		local var_54_3 = arg_54_0._actHandler[iter_54_1.id]

		if not var_54_3 then
			logError("MainActExtraDisplay 活动没有对应的handler id:" .. tostring(iter_54_1.id))
		end

		if var_54_3 and var_54_3(arg_54_0) then
			local var_54_4 = arg_54_0._actGetStartTimeHandler[iter_54_1.id](arg_54_0)

			if var_54_1 <= var_54_4 then
				var_54_1 = var_54_4
				var_54_0 = iter_54_1.id
				arg_54_0._curActDisplayConfig = iter_54_1
			end
		end
	end

	arg_54_0.activityShowState = var_54_0

	recthelper.setAnchorY(arg_54_0._goright.transform, arg_54_0.activityShowState == ActivityEnum.MainViewActivityState.None and 0 or -40)

	if SLFramework.FrameworkSettings.IsEditor then
		logNormal("MainActExtraDisplay:checkShowActivityEnter showState:" .. tostring(var_54_0))
	end
end

function var_0_0.check2_0DungeonReddot(arg_55_0)
	if ActivityHelper.getActivityStatus(VersionActivity2_0Enum.ActivityId.Dungeon) == ActivityEnum.ActivityStatus.Normal then
		Activity161Controller.instance:checkHasUnDoElement()
	end
end

function var_0_0._getCurBindActivityId(arg_56_0)
	return arg_56_0:_getBindActivityId(arg_56_0.activityShowState)
end

function var_0_0._getBindActivityId(arg_57_0, arg_57_1)
	local var_57_0 = ActivityConfig.instance:getActivityByExtraDisplayId(arg_57_1)

	return var_57_0 and var_57_0.id
end

function var_0_0.onRefreshActivityState(arg_58_0)
	arg_58_0:checkShowActivityEnter()
	arg_58_0:refreshReactivityBtn()
	arg_58_0:_refreshBtns()
	arg_58_0:check2_0DungeonReddot()
end

function var_0_0._refreshBtns(arg_59_0)
	gohelper.setActive(arg_59_0._btnrolestory, false)

	if not arg_59_0._curActDisplayConfig then
		return
	end

	local var_59_0 = arg_59_0._actRefreshBtnHandler[arg_59_0.activityShowState]

	if var_59_0 then
		var_59_0(arg_59_0)
	end
end

function var_0_0.onOpen(arg_60_0)
	arg_60_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, arg_60_0._onStoryChange, arg_60_0)
	arg_60_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.StoryNewChange, arg_60_0._onStoryNewChange, arg_60_0)
	arg_60_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_60_0.onRefreshActivityState, arg_60_0)
	arg_60_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_60_0.onRefreshActivityState, arg_60_0)
	arg_60_0:addEventCb(ActivityController.instance, ActivityEvent.ChangeActivityStage, arg_60_0.onRefreshActivityState, arg_60_0)
	arg_60_0:onRefreshActivityState()
	arg_60_0:showKeyTips()
end

function var_0_0.showKeyTips(arg_61_0)
	arg_61_0._keytipsReactivity = gohelper.findChild(arg_61_0._btnreactivity.gameObject, "#go_pcbtn")
	arg_61_0._keytipsRoleStory = gohelper.findChild(arg_61_0._btnrolestory.gameObject, "#go_pcbtn")

	PCInputController.instance:showkeyTips(arg_61_0._keytipsReactivity, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
	PCInputController.instance:showkeyTips(arg_61_0._keytipsRoleStory, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
end

function var_0_0.onClose(arg_62_0)
	return
end

function var_0_0.onDestroyView(arg_63_0)
	if arg_63_0._simagerolestory then
		arg_63_0._simagerolestory:UnLoadImage()
	end
end

return var_0_0
