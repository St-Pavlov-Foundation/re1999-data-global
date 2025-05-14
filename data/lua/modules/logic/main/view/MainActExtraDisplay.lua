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

function var_0_0._getEnterController(arg_13_0)
	return arg_13_0.viewContainer:getMainActivityEnterView():getCurEnterController()
end

function var_0_0._editableInitView(arg_14_0)
	local var_14_0 = ActivityConfig.instance:getSesonActivityConfig()

	arg_14_0._seasonActId = var_14_0 and var_14_0.id or Season123Model.instance:getCurSeasonId() or Season166Model.instance:getCurSeasonId()

	local var_14_1 = ActivityConfig.instance:getRougeActivityConfig()

	arg_14_0._rougeActId = var_14_1 and var_14_1.id
	arg_14_0._douququActId = VersionActivity2_3Enum.ActivityId.Act174
	arg_14_0._act178ActId = VersionActivity2_4Enum.ActivityId.Pinball
	arg_14_0._act182ActId = VersionActivity2_5Enum.ActivityId.AutoChess

	arg_14_0:_initActs()
end

function var_0_0._initActs(arg_15_0)
	arg_15_0._actHandler = {}
	arg_15_0._actGetStartTimeHandler = {}
	arg_15_0._actClickHandler = {}
	arg_15_0._actRefreshBtnHandler = {}

	arg_15_0:_addActHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_15_0._getRoleStoryActivityStatus, arg_15_0._getRoleStoryActivityStartTime)
	arg_15_0:_addActHandler(ActivityEnum.MainViewActivityState.Reactivity, arg_15_0._getReactivityStatus, arg_15_0._getReactivityStartTime)
	arg_15_0:_addActHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_15_0._getSeasonActivityStatus, arg_15_0._getSeasonActivityStartTime)
	arg_15_0:_addActHandler(ActivityEnum.MainViewActivityState.Rouge, arg_15_0._getRougeStatus, arg_15_0._getRougeStartTime)
	arg_15_0:_addActHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_15_0._getDouQuQuStatus, arg_15_0._getDouQuQuStartTime)
	arg_15_0:_addActHandler(ActivityEnum.MainViewActivityState.Act178, arg_15_0._getAct178Status, arg_15_0._getAct178StartTime)
	arg_15_0:_addActHandler(ActivityEnum.MainViewActivityState.Act182, arg_15_0._getAct182Status, arg_15_0._getAct182StartTime)
	arg_15_0:_addClickHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_15_0._onRoleStoryClick)
	arg_15_0:_addClickHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_15_0._onSeasonClick)
	arg_15_0:_addClickHandler(ActivityEnum.MainViewActivityState.Rouge, arg_15_0._onRougeClick)
	arg_15_0:_addClickHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_15_0._onDouQuQuClick)
	arg_15_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act178, arg_15_0._onAct178Click)
	arg_15_0:_addClickHandler(ActivityEnum.MainViewActivityState.Act182, arg_15_0._onAct182Click)
	arg_15_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.RoleStoryActivity, arg_15_0.refreshRoleStoryBtn)
	arg_15_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.SeasonActivity, arg_15_0.refreshSeasonBtn)
	arg_15_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Rouge, arg_15_0.refreshRougeBtn)
	arg_15_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.DouQuQu, arg_15_0.refreshDouQuQuBtn)
	arg_15_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act178, arg_15_0.refreshAct178Btn)
	arg_15_0:_addRefreshBtnHandler(ActivityEnum.MainViewActivityState.Act182, arg_15_0.refreshAct182Btn)
end

function var_0_0._addRefreshBtnHandler(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._actRefreshBtnHandler[arg_16_1] = arg_16_2
end

function var_0_0._addClickHandler(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._actClickHandler[arg_17_1] = arg_17_2
end

function var_0_0._addActHandler(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0._actHandler[arg_18_1] = arg_18_2
	arg_18_0._actGetStartTimeHandler[arg_18_1] = arg_18_3
end

function var_0_0._getSeasonActivityStatus(arg_19_0)
	local var_19_0 = arg_19_0._seasonActId

	return (var_19_0 and ActivityHelper.getActivityStatus(var_19_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getSeasonActivityStartTime(arg_20_0)
	local var_20_0 = arg_20_0._seasonActId

	return var_20_0 and ActivityModel.instance:getActStartTime(var_20_0)
end

function var_0_0._getReactivityStatus(arg_21_0)
	local var_21_0 = ReactivityController.instance:getCurReactivityId()
	local var_21_1 = var_21_0 and ReactivityEnum.ActivityDefine[var_21_0]
	local var_21_2 = var_21_1 and var_21_1.storeActId

	return (var_21_2 and ActivityHelper.getActivityStatus(var_21_2)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getReactivityStartTime(arg_22_0)
	local var_22_0 = ReactivityController.instance:getCurReactivityId()
	local var_22_1 = ReactivityEnum.ActivityDefine[var_22_0]
	local var_22_2 = var_22_1 and var_22_1.storeActId
	local var_22_3 = var_22_2 and ActivityModel.instance:getActMO(var_22_2)

	return var_22_3 and var_22_3:getRealStartTimeStamp() * 1000
end

function var_0_0._getRoleStoryActivityStatus(arg_23_0)
	local var_23_0 = RoleStoryModel.instance:getCurActStoryId()

	return var_23_0 and var_23_0 > 0 or false
end

function var_0_0._getRoleStoryActivityStartTime(arg_24_0)
	local var_24_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_24_1 = (var_24_0 and var_24_0 > 0 or false) and RoleStoryModel.instance:getMoById(var_24_0)

	return var_24_1 and var_24_1:getActTime() * 1000
end

function var_0_0._getRougeStatus(arg_25_0)
	local var_25_0 = arg_25_0._rougeActId

	return (var_25_0 and ActivityHelper.getActivityStatus(var_25_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getRougeStartTime(arg_26_0)
	local var_26_0 = arg_26_0._rougeActId
	local var_26_1 = ActivityModel.instance:getActMO(var_26_0)

	return var_26_1 and var_26_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getDouQuQuStatus(arg_27_0)
	local var_27_0 = arg_27_0._douququActId

	return (var_27_0 and ActivityHelper.getActivityStatus(var_27_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getDouQuQuStartTime(arg_28_0)
	local var_28_0 = arg_28_0._douququActId
	local var_28_1 = ActivityModel.instance:getActMO(var_28_0)

	return var_28_1 and var_28_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct178Status(arg_29_0)
	local var_29_0 = arg_29_0._act178ActId

	return (var_29_0 and ActivityHelper.getActivityStatus(var_29_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct178StartTime(arg_30_0)
	local var_30_0 = arg_30_0._act178ActId
	local var_30_1 = ActivityModel.instance:getActMO(var_30_0)

	return var_30_1 and var_30_1:getRealStartTimeStamp() * 1000
end

function var_0_0._getAct182Status(arg_31_0)
	local var_31_0 = arg_31_0._act182ActId

	return (var_31_0 and ActivityHelper.getActivityStatus(var_31_0)) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0._getAct182StartTime(arg_32_0)
	local var_32_0 = arg_32_0._act182ActId
	local var_32_1 = ActivityModel.instance:getActMO(var_32_0)

	return var_32_1 and var_32_1:getRealStartTimeStamp() * 1000
end

function var_0_0._onStoryChange(arg_33_0)
	arg_33_0:onRefreshActivityState()
end

function var_0_0._onStoryNewChange(arg_34_0)
	arg_34_0:refreshRoleStoryRed()
end

function var_0_0._roleStoryLoadImage(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if string.nilorempty(arg_35_1) then
		logError("MainActExtraDisplay:_roleStoryLoadImage path nil")

		return
	end

	arg_35_0._simagerolestory:LoadImage(arg_35_1, arg_35_2, arg_35_3)
end

function var_0_0.refreshRougeBtn(arg_36_0)
	gohelper.setActive(arg_36_0._btnrolestory, true)

	local var_36_0 = ActivityConfig.instance:getRougeActivityConfig()

	arg_36_0:_roleStoryLoadImage(var_36_0.extraDisplayIcon, arg_36_0.onLoadImage, arg_36_0)

	arg_36_0._txtrolestory.text = ""
end

function var_0_0.refreshDouQuQuBtn(arg_37_0)
	gohelper.setActive(arg_37_0._btnrolestory, true)

	local var_37_0 = ActivityConfig.instance:getActivityCo(arg_37_0._douququActId)

	arg_37_0:_roleStoryLoadImage(var_37_0.extraDisplayIcon, arg_37_0.onLoadImage, arg_37_0)

	arg_37_0._txtrolestory.text = ""
end

function var_0_0.refreshAct178Btn(arg_38_0)
	gohelper.setActive(arg_38_0._btnrolestory, true)

	local var_38_0 = ActivityConfig.instance:getActivityCo(arg_38_0._act178ActId)

	arg_38_0:_roleStoryLoadImage(var_38_0.extraDisplayIcon, arg_38_0.onLoadImage, arg_38_0)

	arg_38_0._txtrolestory.text = ""
end

function var_0_0.refreshAct182Btn(arg_39_0)
	gohelper.setActive(arg_39_0._btnrolestory, true)

	local var_39_0 = ActivityConfig.instance:getActivityCo(arg_39_0._act182ActId)

	arg_39_0:_roleStoryLoadImage(var_39_0.extraDisplayIcon, arg_39_0.onLoadImage, arg_39_0)

	arg_39_0._txtrolestory.text = ""
end

function var_0_0.onLoadImage(arg_40_0)
	arg_40_0._imagerolestory:SetNativeSize()
end

function var_0_0.refreshSeasonBtn(arg_41_0)
	gohelper.setActive(arg_41_0._btnrolestory, true)

	local var_41_0 = ActivityConfig.instance:getSesonActivityConfig()

	arg_41_0:_roleStoryLoadImage(var_41_0.extraDisplayIcon, arg_41_0.onLoadImage, arg_41_0)

	arg_41_0._txtrolestory.text = var_41_0.name

	local var_41_1 = arg_41_0._seasonActId
	local var_41_2 = ActivityConfig.instance:getActivityCo(var_41_1)

	RedDotController.instance:addRedDot(arg_41_0._gorolestoryred, var_41_2.redDotId)

	local var_41_3 = ActivityStageHelper.checkOneActivityStageHasChange(var_41_1)

	gohelper.setActive(arg_41_0._gorolestorynew, var_41_3)
	gohelper.setActive(arg_41_0._gorolestoryred, not var_41_3)
end

function var_0_0.refreshRoleStoryBtn(arg_42_0)
	local var_42_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_42_1 = var_42_0 > 0

	gohelper.setActive(arg_42_0._btnrolestory, var_42_1)

	if var_42_1 then
		local var_42_2 = RoleStoryConfig.instance:getStoryById(var_42_0)

		arg_42_0:_roleStoryLoadImage(string.format("singlebg/dungeon/rolestory_singlebg/%s.png", var_42_2.main_pic), arg_42_0.onLoadImage, arg_42_0)

		local var_42_3 = var_42_2.mainviewName

		if string.nilorempty(var_42_3) then
			var_42_3 = var_42_2.name
		end

		arg_42_0._txtrolestory.text = var_42_3

		RedDotController.instance:addRedDot(arg_42_0._gorolestoryred, RedDotEnum.DotNode.RoleStoryActivity)
	end

	arg_42_0:refreshRoleStoryRed()
end

function var_0_0.refreshRoleStoryRed(arg_43_0)
	if arg_43_0.activityShowState ~= ActivityEnum.MainViewActivityState.RoleStoryActivity then
		return
	end

	local var_43_0 = false
	local var_43_1 = RoleStoryModel.instance:getCurActStoryId()

	if not (var_43_1 > 0) then
		return
	end

	local var_43_2 = RoleStoryModel.instance:getMoById(var_43_1).cfg.activityId
	local var_43_3 = ActivityStageHelper.checkOneActivityStageHasChange(var_43_2)

	gohelper.setActive(arg_43_0._gorolestorynew, var_43_3)
	gohelper.setActive(arg_43_0._gorolestoryred, not var_43_3)
end

function var_0_0.refreshReactivityBtn(arg_44_0)
	local var_44_0 = ReactivityController.instance:getCurReactivityId()
	local var_44_1 = var_44_0 and ActivityHelper.getActivityStatusAndToast(var_44_0)
	local var_44_2 = arg_44_0.activityShowState == ActivityEnum.MainViewActivityState.Reactivity

	gohelper.setActive(arg_44_0._btnreactivity, var_44_2)

	if var_44_2 then
		local var_44_3 = ActivityConfig.instance:getActivityCo(var_44_0)

		arg_44_0._txtreactivity.text = var_44_3 and var_44_3.name or ""

		local var_44_4 = var_44_1 == ActivityEnum.ActivityStatus.Normal and ActivityStageHelper.checkOneActivityStageHasChange(var_44_0)

		gohelper.setActive(arg_44_0._goreactivityred, not var_44_4)
		gohelper.setActive(arg_44_0._goreactivitynew, var_44_4)
		gohelper.setActive(arg_44_0._goreactivitylocked, var_44_1 == ActivityEnum.ActivityStatus.NotUnlock)
		arg_44_0:addReactivityRed()
	end
end

function var_0_0.addReactivityRed(arg_45_0)
	local var_45_0 = ReactivityController.instance:getCurReactivityId()

	if var_45_0 then
		local var_45_1 = ActivityConfig.instance:getActivityCo(var_45_0)

		if var_45_1 and var_45_1.redDotId > 0 then
			RedDotController.instance:addRedDot(arg_45_0._goreactivityred, var_45_1.redDotId)
		end
	end
end

function var_0_0.checkShowActivityEnter(arg_46_0)
	local var_46_0 = ActivityEnum.MainViewActivityState.None

	arg_46_0._curActDisplayConfig = nil

	local var_46_1 = 0
	local var_46_2 = ActivityConfig.instance:getMainActExtraDisplayList()

	for iter_46_0, iter_46_1 in ipairs(var_46_2) do
		local var_46_3 = arg_46_0._actHandler[iter_46_1.id]

		if not var_46_3 then
			logError("MainActExtraDisplay 活动没有对应的handler id:" .. tostring(iter_46_1.id))
		end

		if var_46_3 and var_46_3(arg_46_0) then
			local var_46_4 = arg_46_0._actGetStartTimeHandler[iter_46_1.id](arg_46_0)

			if var_46_1 <= var_46_4 then
				var_46_1 = var_46_4
				var_46_0 = iter_46_1.id
				arg_46_0._curActDisplayConfig = iter_46_1
			end
		end
	end

	arg_46_0.activityShowState = var_46_0

	recthelper.setAnchorY(arg_46_0._goright.transform, arg_46_0.activityShowState == ActivityEnum.MainViewActivityState.None and 0 or -40)
end

function var_0_0.onRefreshActivityState(arg_47_0)
	arg_47_0:checkShowActivityEnter()
	arg_47_0:refreshReactivityBtn()
	arg_47_0:_refreshBtns()
end

function var_0_0._refreshBtns(arg_48_0)
	gohelper.setActive(arg_48_0._btnrolestory, false)

	if not arg_48_0._curActDisplayConfig then
		return
	end

	local var_48_0 = arg_48_0._actRefreshBtnHandler[arg_48_0.activityShowState]

	if var_48_0 then
		var_48_0(arg_48_0)
	end
end

function var_0_0.onOpen(arg_49_0)
	arg_49_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, arg_49_0._onStoryChange, arg_49_0)
	arg_49_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.StoryNewChange, arg_49_0._onStoryNewChange, arg_49_0)
	arg_49_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_49_0.onRefreshActivityState, arg_49_0)
	arg_49_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_49_0.onRefreshActivityState, arg_49_0)
	arg_49_0:addEventCb(ActivityController.instance, ActivityEvent.ChangeActivityStage, arg_49_0.onRefreshActivityState, arg_49_0)
	arg_49_0:onRefreshActivityState()
	arg_49_0:showKeyTips()
end

function var_0_0.showKeyTips(arg_50_0)
	arg_50_0._keytipsReactivity = gohelper.findChild(arg_50_0._btnreactivity.gameObject, "#go_pcbtn")
	arg_50_0._keytipsRoleStory = gohelper.findChild(arg_50_0._btnrolestory.gameObject, "#go_pcbtn")

	PCInputController.instance:showkeyTips(arg_50_0._keytipsReactivity, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
	PCInputController.instance:showkeyTips(arg_50_0._keytipsRoleStory, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.curActivity)
end

function var_0_0.onClose(arg_51_0)
	return
end

function var_0_0.onDestroyView(arg_52_0)
	if arg_52_0._simagerolestory then
		arg_52_0._simagerolestory:UnLoadImage()
	end
end

return var_0_0
