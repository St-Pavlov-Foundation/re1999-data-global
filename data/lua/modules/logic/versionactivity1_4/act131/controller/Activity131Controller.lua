module("modules.logic.versionactivity1_4.act131.controller.Activity131Controller", package.seeall)

local var_0_0 = class("Activity131Controller", BaseController)

function var_0_0.openActivity131GameView(arg_1_0, arg_1_1)
	if arg_1_1 and arg_1_1.episodeId then
		if not Activity131Model.instance:isEpisodeUnlock(arg_1_1.episodeId) then
			GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)

			return
		else
			Activity131Model.instance:setCurEpisodeId(arg_1_1.episodeId)
		end
	end

	var_0_0.instance:dispatchEvent(Activity131Event.ShowLevelScene, false)
	ViewMgr.instance:openView(ViewName.Activity131GameView, arg_1_1)
end

function var_0_0.enterActivity131(arg_2_0)
	local var_2_0 = PlayerPrefsKey.Version1_4_Act131Tips .. "#" .. tostring(VersionActivity1_4Enum.ActivityId.Role6) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local var_2_1 = PlayerPrefsHelper.getNumber(var_2_0, 0) == 1

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act131OpenTips) or var_2_1 then
		arg_2_0:_getActInfoBeforeEnter()

		return
	end

	local var_2_2 = OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.Act131OpenTips).episodeId
	local var_2_3 = DungeonConfig.instance:getEpisodeCO(var_2_2)
	local var_2_4 = DungeonController.getEpisodeName(var_2_3)

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130OpenTips, MsgBoxEnum.BoxType.Yes_No, function()
		PlayerPrefsHelper.setNumber(var_2_0, 1)
		arg_2_0:_getActInfoBeforeEnter()
	end, nil, nil, nil, nil, nil, var_2_4)
end

function var_0_0._getActInfoBeforeEnter(arg_4_0)
	Activity131Rpc.instance:sendGet131InfosRequest(VersionActivity1_4Enum.ActivityId.Role6, arg_4_0._onReceiveInfo, arg_4_0)
end

function var_0_0._onReceiveInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:openActivity131LevelView()
end

function var_0_0.openActivity131LevelView(arg_6_0, arg_6_1)
	local var_6_0 = ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role6).storyId

	if var_6_0 > 0 and not StoryModel.instance:isStoryFinished(var_6_0) then
		StoryController.instance:playStory(var_6_0, nil, function()
			arg_6_0:_realOpenLevelView(arg_6_1)
		end, nil)

		return
	end

	arg_6_0:_realOpenLevelView(arg_6_1)
end

function var_0_0._realOpenLevelView(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.Activity131LevelView, arg_8_1)
end

function var_0_0.openActivity131DialogView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.Activity131DialogView, arg_9_1)
end

function var_0_0.openActivity131TaskView(arg_10_0)
	ViewMgr.instance:openView(ViewName.Activity131TaskView)
end

function var_0_0.delayReward(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._act131TaskMO == nil and arg_11_2 then
		arg_11_0._act131TaskMO = arg_11_2

		TaskDispatcher.runDelay(arg_11_0._onPreFinish, arg_11_0, arg_11_1)

		return true
	end

	return false
end

function var_0_0._onPreFinish(arg_12_0)
	local var_12_0 = arg_12_0._act131TaskMO

	arg_12_0._act131TaskMO = nil

	if var_12_0 and (var_12_0.id == Activity131Enum.TaskMOAllFinishId or var_12_0:alreadyGotReward()) then
		Activity131TaskListModel.instance:preFinish(var_12_0)

		arg_12_0._act131TaskId = var_12_0.id

		TaskDispatcher.runDelay(arg_12_0._onRewardTask, arg_12_0, Activity131Enum.AnimatorTime.TaskRewardMoveUp)
	end
end

function var_0_0._onRewardTask(arg_13_0)
	local var_13_0 = arg_13_0._act131TaskId

	arg_13_0._act131TaskId = nil

	if var_13_0 then
		if var_13_0 == Activity131Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity131)
		else
			TaskRpc.instance:sendFinishTaskRequest(var_13_0)
		end
	end
end

function var_0_0.oneClaimReward(arg_14_0, arg_14_1)
	local var_14_0 = Activity131TaskListModel.instance:getList()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if iter_14_1:alreadyGotReward() and iter_14_1.id ~= Activity131Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(iter_14_1.id)
		end
	end
end

function var_0_0.enterFight(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.chapterId
	local var_15_1 = arg_15_1.id
	local var_15_2 = arg_15_1.battleId

	if var_15_0 and var_15_1 and var_15_2 then
		DungeonFightController.instance:enterFightByBattleId(var_15_0, var_15_1, var_15_2)
	else
		logError("副本关卡表配置错误,%s的chapterId或battleId为空", var_15_1)
	end
end

function var_0_0.openLogView(arg_16_0)
	ViewMgr.instance:openView(ViewName.Activity131LogView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
