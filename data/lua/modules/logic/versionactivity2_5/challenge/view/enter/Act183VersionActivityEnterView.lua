module("modules.logic.versionactivity2_5.challenge.view.enter.Act183VersionActivityEnterView", package.seeall)

local var_0_0 = class("Act183VersionActivityEnterView", BaseViewExtended)
local var_0_1 = 0.8
local var_0_2 = 0.8

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_limittime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._btnReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Reward")
	arg_1_0._gorewardreddot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Reward/#go_rewardreddot")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_Tips")
	arg_1_0._txtUnLocked = gohelper.findChildText(arg_1_0.viewGO, "Right/#btn_Enter/#go_Tips/#txt_UnLocked")
	arg_1_0._gostore = gohelper.findChild(arg_1_0.viewGO, "Right/#go_store")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
	arg_2_0._btnReward:AddClickListener(arg_2_0._btnRewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnReward:RemoveClickListener()
end

function var_0_0._btnEnterOnClick(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = ActivityHelper.getActivityStatusAndToast(arg_4_0.actId)

	if var_4_0 ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(var_4_1, var_4_2)

		return
	end

	Act183Controller.instance:openAct183MainView()
end

function var_0_0._btnRewardOnClick(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = ActivityHelper.getActivityStatusAndToast(arg_5_0.actId)

	if var_5_0 ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(var_5_1, var_5_2)

		return
	end

	Act183Controller.instance:openAct183TaskView()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = arg_6_0.viewContainer.activityId

	Act183Model.instance:setActivityId(arg_6_0.actId)

	arg_6_0.config = ActivityConfig.instance:getActivityCo(arg_6_0.actId)
	arg_6_0._txtDescr.text = arg_6_0.config.actDesc
	arg_6_0._animator = gohelper.onceAddComponent(arg_6_0.viewGO, gohelper.Type_Animator)
	arg_6_0._rewardReddotAnim = gohelper.findChildComponent(arg_6_0._btnReward.gameObject, "ani", gohelper.Type_Animator)

	RedDotController.instance:addRedDot(arg_6_0._gorewardreddot, RedDotEnum.DotNode.V2a5_Act183Task, nil, arg_6_0._taskReddotFunc, arg_6_0)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.V2a5_Act183Task
	})

	arg_6_0._imagetaskicon = gohelper.findChildImage(arg_6_0.viewGO, "Right/#btn_Reward/ani/baoxiang")

	arg_6_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_6_0._onActStatusChange, arg_6_0)
	arg_6_0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, arg_6_0.onSelectActId, arg_6_0, LuaEventSystem.Low)
end

function var_0_0._taskReddotFunc(arg_7_0, arg_7_1)
	arg_7_1:defaultRefreshDot()
	arg_7_0._rewardReddotAnim:Play(arg_7_1.show and "loop" or "idle", 0, 0)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:_freshLockStatus()
	arg_8_0:_showLeftTime()
	TaskDispatcher.runRepeat(arg_8_0._showLeftTime, arg_8_0, 1)
	arg_8_0:openExclusiveView(nil, 1, Act183StoreEntry, Act183Enum.StoreEntryPrefabUrl, arg_8_0._gostore)
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._showLeftTime, arg_9_0)
end

function var_0_0._freshLockStatus(arg_10_0)
	local var_10_0 = ActivityHelper.getActivityStatus(arg_10_0.actId) == ActivityEnum.ActivityStatus.NotUnlock

	ZProj.UGUIHelper.SetGrayscale(arg_10_0._btnEnter.gameObject, var_10_0)
	ZProj.UGUIHelper.SetGrayscale(arg_10_0._imagetaskicon.gameObject, var_10_0)
	gohelper.setActive(arg_10_0._goTips, var_10_0)

	if var_10_0 then
		ZProj.UGUIHelper.SetGrayFactor(arg_10_0._btnEnter.gameObject, var_0_1)
		ZProj.UGUIHelper.SetGrayFactor(arg_10_0._imagetaskicon.gameObject, var_0_2)

		arg_10_0._txtUnLocked.text = OpenHelper.getActivityUnlockTxt(arg_10_0.config.openId)
	end
end

function var_0_0._showLeftTime(arg_11_0)
	arg_11_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_11_0.actId)
end

function var_0_0._onActStatusChange(arg_12_0)
	arg_12_0:_freshLockStatus()
end

function var_0_0.onSelectActId(arg_13_0, arg_13_1)
	if arg_13_0.actId ~= arg_13_1 then
		return
	end

	arg_13_0._animator:Play("open", 0, 0)
end

return var_0_0
