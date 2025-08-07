module("modules.logic.mainuiswitch.view.SwitchMainActExtraDisplay", package.seeall)

local var_0_0 = class("SwitchMainActExtraDisplay", BaseView)

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
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	local var_4_0 = ActivityConfig.instance:getSesonActivityConfig()

	arg_4_0._seasonActId = var_4_0 and var_4_0.id or Season123Model.instance:getCurSeasonId() or Season166Model.instance:getCurSeasonId()

	local var_4_1 = ActivityConfig.instance:getRougeActivityConfig()

	arg_4_0._rougeActId = var_4_1 and var_4_1.id
	arg_4_0._douququActId = VersionActivity2_3Enum.ActivityId.Act174
	arg_4_0._act178ActId = VersionActivity2_4Enum.ActivityId.Pinball
	arg_4_0._act182ActId = VersionActivity2_5Enum.ActivityId.AutoChess

	arg_4_0:_initActs()
end

function var_0_0._initActs(arg_5_0)
	arg_5_0._actHandler = {}
	arg_5_0._actGetStartTimeHandler = {}
	arg_5_0._actClickHandler = {}
	arg_5_0._actRefreshBtnHandler = {}

	arg_5_0:_addActHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_5_0._getRoleStoryActivityStatus, arg_5_0._getRoleStoryActivityStartTime)
	arg_5_0:_addActHandler(ActivityEnum.MainViewActivityState.Reactivity, arg_5_0._getReactivityStatus, arg_5_0._getReactivityStartTime)
	arg_5_0:_addActHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_5_0._getSeasonActivityStatus, arg_5_0._getSeasonActivityStartTime)
	arg_5_0:_addActHandler(ActivityEnum.MainViewActivityState.Rouge, arg_5_0._getRougeStatus, arg_5_0._getRougeStartTime)
	arg_5_0:_addActHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_5_0._getDouQuQuStatus, arg_5_0._getDouQuQuStartTime)
	arg_5_0:_addActHandler(ActivityEnum.MainViewActivityState.Act178, arg_5_0._getAct178Status, arg_5_0._getAct178StartTime)
	arg_5_0:_addActHandler(ActivityEnum.MainViewActivityState.Act182, arg_5_0._getAct182Status, arg_5_0._getAct182StartTime)
	arg_5_0:_addActHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_5_0._getWeekWalkHeartStatus, arg_5_0._getWeekWalkHeartStartTime)
	arg_5_0:_addActHandler(ActivityEnum.MainViewActivityState.Act191, arg_5_0._getAct191Status, arg_5_0._getAct191StartTime)
	arg_5_0:_addClickHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_5_0._onRoleStoryClick)
	arg_5_0:_addClickHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_5_0._onSeasonClick)
	arg_5_0:_addClickHandler(ActivityEnum.MainViewActivityState.Rouge, arg_5_0._onRougeClick)
	arg_5_0:_addClickHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_5_0._onDouQuQuClick)
	arg_5_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act178, arg_5_0._onAct178Click)
	arg_5_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act182, arg_5_0._onAct182Click)
	arg_5_0:_addClickHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_5_0._onWeekWalkHeartClick)
	arg_5_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act191, arg_5_0._onAct191Click)
	arg_5_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_5_0.refreshRoleStoryBtn)
	arg_5_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_5_0.refreshSeasonBtn)
	arg_5_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Rouge, arg_5_0.refreshRougeBtn)
	arg_5_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_5_0.refreshDouQuQuBtn)
	arg_5_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act178, arg_5_0.refreshAct178Btn)
	arg_5_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act182, arg_5_0.refreshAct182Btn)
	arg_5_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.WeekWalkHeart, arg_5_0.refreshWeekWalkHeartBtn)
	arg_5_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act191, arg_5_0.refreshAct191Btn)
end

function var_0_0._addRefreshBtnHandler(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._actRefreshBtnHandler[arg_6_1] = arg_6_2
end

function var_0_0._addClickHandler(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._actClickHandler[arg_7_1] = arg_7_2
end

function var_0_0._addActHandler(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._actHandler[arg_8_1] = arg_8_2
	arg_8_0._actGetStartTimeHandler[arg_8_1] = arg_8_3
end

function var_0_0._getSeasonActivityStatus(arg_9_0)
	local var_9_0 = arg_9_0._seasonActId

	return (var_9_0 and ActivityHelper.getActivityStatus(var_9_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getSeasonActivityStartTime(arg_10_0)
	local var_10_0 = arg_10_0._seasonActId

	return var_10_0 and ActivityModel.instance:getActStartTime(var_10_0)
end

function var_0_0._getReactivityStatus(arg_11_0)
	local var_11_0 = ReactivityController.instance:getCurReactivityId()
	local var_11_1 = var_11_0 and ReactivityEnum.ActivityDefine[var_11_0]
	local var_11_2 = var_11_1 and var_11_1.storeActId

	return (var_11_2 and ActivityHelper.getActivityStatus(var_11_2)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getReactivityStartTime(arg_12_0)
	local var_12_0 = ReactivityController.instance:getCurReactivityId()
	local var_12_1 = ReactivityEnum.ActivityDefine[var_12_0]
	local var_12_2 = var_12_1 and var_12_1.storeActId
	local var_12_3 = var_12_2 and ActivityModel.instance:getActMO(var_12_2)

	return var_12_3 and var_12_3:getRealStartTimeStamp() * 1000
end

function var_0_0._getRoleStoryActivityStatus(arg_13_0)
	local var_13_0 = RoleStoryModel.instance:getCurActStoryId()

	return var_13_0 and var_13_0 > 0 or false
end

function var_0_0._getRoleStoryActivityStartTime(arg_14_0)
	local var_14_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_14_1 = (var_14_0 and var_14_0 > 0 or false) and RoleStoryModel.instance:getMoById(var_14_0)

	return var_14_1 and var_14_1:getActTime() * 1000
end

function var_0_0._getRougeStatus(arg_15_0)
	local var_15_0 = arg_15_0._rougeActId

	return (var_15_0 and ActivityHelper.getActivityStatus(var_15_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getRougeStartTime(arg_16_0)
	local var_16_0 = arg_16_0._rougeActId
	local var_16_1 = ActivityModel.instance:getActMO(var_16_0)

	return var_16_1 and var_16_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getDouQuQuStatus(arg_17_0)
	local var_17_0 = arg_17_0._douququActId

	return (var_17_0 and ActivityHelper.getActivityStatus(var_17_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getDouQuQuStartTime(arg_18_0)
	local var_18_0 = arg_18_0._douququActId
	local var_18_1 = ActivityModel.instance:getActMO(var_18_0)

	return var_18_1 and var_18_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct178Status(arg_19_0)
	local var_19_0 = arg_19_0._act178ActId

	return (var_19_0 and ActivityHelper.getActivityStatus(var_19_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct178StartTime(arg_20_0)
	local var_20_0 = arg_20_0._act178ActId
	local var_20_1 = ActivityModel.instance:getActMO(var_20_0)

	return var_20_1 and var_20_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct182Status(arg_21_0)
	local var_21_0 = arg_21_0._act182ActId

	return (var_21_0 and ActivityHelper.getActivityStatus(var_21_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct182StartTime(arg_22_0)
	local var_22_0 = arg_22_0._act182ActId
	local var_22_1 = ActivityModel.instance:getActMO(var_22_0)

	return var_22_1 and var_22_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getWeekWalkHeartStatus(arg_23_0)
	local var_23_0 = arg_23_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)

	return (var_23_0 and ActivityHelper.getActivityStatus(var_23_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getWeekWalkHeartStartTime(arg_24_0)
	local var_24_0 = arg_24_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)
	local var_24_1 = ActivityModel.instance:getActMO(var_24_0)

	return var_24_1 and var_24_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct191Status(arg_25_0)
	local var_25_0 = arg_25_0:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)

	return (var_25_0 and ActivityHelper.getActivityStatus(var_25_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct191StartTime(arg_26_0)
	local var_26_0 = arg_26_0:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)
	local var_26_1 = ActivityModel.instance:getActMO(var_26_0)

	return var_26_1 and var_26_1:getRealStartTimeStamp() * 1000
end

function var_0_0._onStoryChange(arg_27_0)
	arg_27_0:onRefreshActivityState()
end

function var_0_0._onStoryNewChange(arg_28_0)
	arg_28_0:refreshRoleStoryRed()
end

function var_0_0._roleStoryLoadImage(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if string.nilorempty(arg_29_1) then
		logError("SwitchMainActExtraDisplay:_roleStoryLoadImage path nil")

		return
	end

	arg_29_0._simagerolestory:LoadImage(arg_29_1, arg_29_2, arg_29_3)
end

function var_0_0.refreshRougeBtn(arg_30_0)
	gohelper.setActive(arg_30_0._btnrolestory, true)

	local var_30_0 = ActivityConfig.instance:getRougeActivityConfig()

	arg_30_0:_roleStoryLoadImage(var_30_0.extraDisplayIcon, arg_30_0.onLoadImage, arg_30_0)

	arg_30_0._txtrolestory.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("mainview_rougeactextradisplay"), var_30_0.tabName)
end

function var_0_0.refreshDouQuQuBtn(arg_31_0)
	gohelper.setActive(arg_31_0._btnrolestory, true)

	local var_31_0 = ActivityConfig.instance:getActivityCo(arg_31_0._douququActId)

	arg_31_0:_roleStoryLoadImage(var_31_0.extraDisplayIcon, arg_31_0.onLoadImage, arg_31_0)

	arg_31_0._txtrolestory.text = ""
end

function var_0_0.refreshAct178Btn(arg_32_0)
	gohelper.setActive(arg_32_0._btnrolestory, true)

	local var_32_0 = ActivityConfig.instance:getActivityCo(arg_32_0._act178ActId)

	arg_32_0:_roleStoryLoadImage(var_32_0.extraDisplayIcon, arg_32_0.onLoadImage, arg_32_0)

	arg_32_0._txtrolestory.text = ""
end

function var_0_0.refreshAct182Btn(arg_33_0)
	gohelper.setActive(arg_33_0._btnrolestory, true)

	local var_33_0 = ActivityConfig.instance:getActivityCo(arg_33_0._act182ActId)

	arg_33_0:_roleStoryLoadImage(var_33_0.extraDisplayIcon, arg_33_0.onLoadImage, arg_33_0)

	arg_33_0._txtrolestory.text = ""
end

function var_0_0.refreshWeekWalkHeartBtn(arg_34_0)
	gohelper.setActive(arg_34_0._btnrolestory, true)

	local var_34_0 = arg_34_0:_getBindActivityId(ActivityEnum.MainViewActivityState.WeekWalkHeart)
	local var_34_1 = ActivityConfig.instance:getActivityCo(var_34_0)

	arg_34_0:_roleStoryLoadImage(var_34_1.extraDisplayIcon, arg_34_0.onLoadImage, arg_34_0)

	local var_34_2 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.WeekWalkHeartShow)

	arg_34_0._txtrolestory.text = var_34_2.name
end

function var_0_0.refreshAct191Btn(arg_35_0)
	gohelper.setActive(arg_35_0._btnrolestory, true)

	local var_35_0 = arg_35_0:_getBindActivityId(ActivityEnum.MainViewActivityState.Act191)
	local var_35_1 = ActivityConfig.instance:getActivityCo(var_35_0)

	arg_35_0:_roleStoryLoadImage(var_35_1.extraDisplayIcon, arg_35_0.onLoadImage, arg_35_0)

	arg_35_0._txtrolestory.text = ""
end

function var_0_0.onLoadImage(arg_36_0)
	arg_36_0._imagerolestory:SetNativeSize()
end

function var_0_0.refreshSeasonBtn(arg_37_0)
	gohelper.setActive(arg_37_0._btnrolestory, true)

	local var_37_0 = ActivityConfig.instance:getSesonActivityConfig()

	arg_37_0:_roleStoryLoadImage(var_37_0.extraDisplayIcon, arg_37_0.onLoadImage, arg_37_0)

	arg_37_0._txtrolestory.text = var_37_0.name

	local var_37_1 = arg_37_0._seasonActId
	local var_37_2 = ActivityConfig.instance:getActivityCo(var_37_1)

	RedDotController.instance:addRedDot(arg_37_0._gorolestoryred, var_37_2.redDotId)

	local var_37_3 = ActivityStageHelper.checkOneActivityStageHasChange(var_37_1)

	gohelper.setActive(arg_37_0._gorolestorynew, var_37_3)
	gohelper.setActive(arg_37_0._gorolestoryred, not var_37_3)
end

function var_0_0.refreshRoleStoryBtn(arg_38_0)
	local var_38_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_38_1 = var_38_0 > 0

	gohelper.setActive(arg_38_0._btnrolestory, var_38_1)

	if var_38_1 then
		local var_38_2 = RoleStoryConfig.instance:getStoryById(var_38_0)

		arg_38_0:_roleStoryLoadImage(string.format("singlebg/dungeon/rolestory_singlebg/%s.png", var_38_2.main_pic), arg_38_0.onLoadImage, arg_38_0)

		local var_38_3 = var_38_2.mainviewName

		if string.nilorempty(var_38_3) then
			var_38_3 = var_38_2.name
		end

		arg_38_0._txtrolestory.text = var_38_3

		RedDotController.instance:addRedDot(arg_38_0._gorolestoryred, RedDotEnum.DotNode.RoleStoryActivity)
	end

	arg_38_0:refreshRoleStoryRed()
end

function var_0_0.refreshRoleStoryRed(arg_39_0)
	if arg_39_0.activityShowState ~= ActivityEnum.MainViewActivityState.RoleStoryActivity then
		return
	end

	local var_39_0 = false
	local var_39_1 = RoleStoryModel.instance:getCurActStoryId()

	if not (var_39_1 > 0) then
		return
	end

	local var_39_2 = RoleStoryModel.instance:getMoById(var_39_1).cfg.activityId
	local var_39_3 = ActivityStageHelper.checkOneActivityStageHasChange(var_39_2)

	gohelper.setActive(arg_39_0._gorolestorynew, var_39_3)
	gohelper.setActive(arg_39_0._gorolestoryred, not var_39_3)
end

function var_0_0.refreshReactivityBtn(arg_40_0)
	local var_40_0 = ReactivityController.instance:getCurReactivityId()
	local var_40_1 = var_40_0 and ActivityHelper.getActivityStatusAndToast(var_40_0)
	local var_40_2 = arg_40_0.activityShowState == ActivityEnum.MainViewActivityState.Reactivity

	gohelper.setActive(arg_40_0._btnreactivity, var_40_2)

	if var_40_2 then
		local var_40_3 = ActivityConfig.instance:getActivityCo(var_40_0)

		arg_40_0._txtreactivity.text = var_40_3 and var_40_3.name or ""

		local var_40_4 = var_40_1 == ActivityEnum.ActivityStatus.Normal and ActivityStageHelper.checkOneActivityStageHasChange(var_40_0)

		gohelper.setActive(arg_40_0._goreactivityred, not var_40_4)
		gohelper.setActive(arg_40_0._goreactivitynew, var_40_4)
		gohelper.setActive(arg_40_0._goreactivitylocked, var_40_1 == ActivityEnum.ActivityStatus.NotUnlock)
		arg_40_0:addReactivityRed()
	end
end

function var_0_0.addReactivityRed(arg_41_0)
	local var_41_0 = ReactivityController.instance:getCurReactivityId()

	if var_41_0 then
		local var_41_1 = ActivityConfig.instance:getActivityCo(var_41_0)

		if var_41_1 and var_41_1.redDotId > 0 then
			RedDotController.instance:addRedDot(arg_41_0._goreactivityred, var_41_1.redDotId)
		end
	end
end

function var_0_0.checkShowActivityEnter(arg_42_0)
	local var_42_0 = ActivityEnum.MainViewActivityState.None

	arg_42_0._curActDisplayConfig = nil

	local var_42_1 = 0
	local var_42_2 = ActivityConfig.instance:getMainActExtraDisplayList()

	for iter_42_0, iter_42_1 in ipairs(var_42_2) do
		local var_42_3 = arg_42_0._actHandler[iter_42_1.id]

		if not var_42_3 then
			logError("SwitchMainActExtraDisplay 活动没有对应的handler id:" .. tostring(iter_42_1.id))
		end

		if var_42_3 and var_42_3(arg_42_0) then
			local var_42_4 = arg_42_0._actGetStartTimeHandler[iter_42_1.id](arg_42_0)

			if var_42_1 <= var_42_4 then
				var_42_1 = var_42_4
				var_42_0 = iter_42_1.id
				arg_42_0._curActDisplayConfig = iter_42_1
			end
		end
	end

	arg_42_0.activityShowState = var_42_0

	recthelper.setAnchorY(arg_42_0._goright.transform, arg_42_0.activityShowState == ActivityEnum.MainViewActivityState.None and 0 or -40)

	if SLFramework.FrameworkSettings.IsEditor then
		logNormal("SwitchMainActExtraDisplay:checkShowActivityEnter showState:" .. tostring(var_42_0))
	end
end

function var_0_0.check2_0DungeonReddot(arg_43_0)
	if ActivityHelper.getActivityStatus(VersionActivity2_0Enum.ActivityId.Dungeon) == ActivityEnum.ActivityStatus.Normal then
		Activity161Controller.instance:checkHasUnDoElement()
	end
end

function var_0_0._getCurBindActivityId(arg_44_0)
	return arg_44_0:_getBindActivityId(arg_44_0.activityShowState)
end

function var_0_0._getBindActivityId(arg_45_0, arg_45_1)
	local var_45_0 = ActivityConfig.instance:getActivityByExtraDisplayId(arg_45_1)

	return var_45_0 and var_45_0.id
end

function var_0_0.onRefreshActivityState(arg_46_0)
	arg_46_0:checkShowActivityEnter()
	arg_46_0:refreshReactivityBtn()
	arg_46_0:_refreshBtns()
	arg_46_0:check2_0DungeonReddot()
end

function var_0_0._refreshBtns(arg_47_0)
	gohelper.setActive(arg_47_0._btnrolestory, false)

	if not arg_47_0._curActDisplayConfig then
		return
	end

	local var_47_0 = arg_47_0._actRefreshBtnHandler[arg_47_0.activityShowState]

	if var_47_0 then
		var_47_0(arg_47_0)
	end
end

function var_0_0.onOpen(arg_48_0)
	arg_48_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, arg_48_0._onStoryChange, arg_48_0)
	arg_48_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.StoryNewChange, arg_48_0._onStoryNewChange, arg_48_0)
	arg_48_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_48_0.onRefreshActivityState, arg_48_0)
	arg_48_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_48_0.onRefreshActivityState, arg_48_0)
	arg_48_0:addEventCb(ActivityController.instance, ActivityEvent.ChangeActivityStage, arg_48_0.onRefreshActivityState, arg_48_0)
	arg_48_0:onRefreshActivityState()
	arg_48_0:showKeyTips()
end

function var_0_0.showKeyTips(arg_49_0)
	arg_49_0._keytipsReactivity = gohelper.findChild(arg_49_0._btnreactivity.gameObject, "#go_pcbtn")
	arg_49_0._keytipsRoleStory = gohelper.findChild(arg_49_0._btnrolestory.gameObject, "#go_pcbtn")

	PCInputController.instance:showkeyTips(arg_49_0._keytipsReactivity, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
	PCInputController.instance:showkeyTips(arg_49_0._keytipsRoleStory, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
end

function var_0_0.onClose(arg_50_0)
	return
end

function var_0_0.onDestroyView(arg_51_0)
	if arg_51_0._simagerolestory then
		arg_51_0._simagerolestory:UnLoadImage()
	end
end

return var_0_0
