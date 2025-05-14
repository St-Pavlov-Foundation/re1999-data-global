module("modules.logic.versionactivity1_4.act130.controller.Activity130Controller", package.seeall)

local var_0_0 = class("Activity130Controller", BaseController)

function var_0_0.openActivity130GameView(arg_1_0, arg_1_1)
	if arg_1_1 and arg_1_1.episodeId then
		if not Activity130Model.instance:isEpisodeUnlock(arg_1_1.episodeId) then
			GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)

			return
		else
			Activity130Model.instance:setCurEpisodeId(arg_1_1.episodeId)
		end
	end

	var_0_0.instance:dispatchEvent(Activity130Event.ShowLevelScene, false)
	ViewMgr.instance:openView(ViewName.Activity130GameView, arg_1_1, true)
end

function var_0_0.openPuzzleView(arg_2_0, arg_2_1)
	Role37PuzzleModel.instance:setErrorCnt(0)
	ViewMgr.instance:openView(ViewName.Role37PuzzleView, arg_2_1)
end

function var_0_0.enterActivity130(arg_3_0)
	local var_3_0 = PlayerPrefsKey.Version1_4_Act130Tips .. "#" .. tostring(VersionActivity1_4Enum.ActivityId.Role37) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local var_3_1 = PlayerPrefsHelper.getNumber(var_3_0, 0) == 1

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act130OpenTips) or var_3_1 then
		arg_3_0:_getActInfoBeforeEnter()

		return
	end

	local var_3_2 = OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.Act130OpenTips).episodeId
	local var_3_3 = DungeonConfig.instance:getEpisodeCO(var_3_2)
	local var_3_4 = DungeonController.getEpisodeName(var_3_3)

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130OpenTips, MsgBoxEnum.BoxType.Yes_No, function()
		PlayerPrefsHelper.setNumber(var_3_0, 1)
		arg_3_0:_getActInfoBeforeEnter()
	end, nil, nil, nil, nil, nil, var_3_4)
end

function var_0_0._getActInfoBeforeEnter(arg_5_0)
	Activity130Rpc.instance:sendGet130InfosRequest(VersionActivity1_4Enum.ActivityId.Role37, arg_5_0.openActivity130LevelView, arg_5_0)
end

function var_0_0.openActivity130LevelView(arg_6_0)
	local var_6_0 = ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role37).storyId

	if var_6_0 > 0 and not StoryModel.instance:isStoryFinished(var_6_0) then
		StoryController.instance:playStory(var_6_0, nil, function()
			Activity130Model.instance:setNewFinishEpisode(0)
			Activity130Model.instance:setNewUnlockEpisode(1)

			local var_7_0 = {}

			var_7_0.episodeId = 0

			arg_6_0:_realOpenLevelView(var_7_0)
		end, nil)

		return
	end

	arg_6_0:_realOpenLevelView()
end

function var_0_0._realOpenLevelView(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.Activity130LevelView, arg_8_1)
end

function var_0_0.openActivity130DialogView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.Activity130DialogView, arg_9_1)
end

function var_0_0.openActivity130CollectView(arg_10_0)
	ViewMgr.instance:openView(ViewName.Activity130CollectView)
end

function var_0_0.openActivity130TaskView(arg_11_0)
	ViewMgr.instance:openView(ViewName.Activity130TaskView)
end

function var_0_0.delayReward(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._act130TaskMO == nil and arg_12_2 then
		arg_12_0._act130TaskMO = arg_12_2

		TaskDispatcher.runDelay(arg_12_0._onPreFinish, arg_12_0, arg_12_1)

		return true
	end

	return false
end

function var_0_0._onPreFinish(arg_13_0)
	local var_13_0 = arg_13_0._act130TaskMO

	arg_13_0._act130TaskMO = nil

	if var_13_0 and (var_13_0.id == Activity130Enum.TaskMOAllFinishId or var_13_0:alreadyGotReward()) then
		Activity130TaskListModel.instance:preFinish(var_13_0)

		arg_13_0._act130TaskId = var_13_0.id

		TaskDispatcher.runDelay(arg_13_0._onRewardTask, arg_13_0, Activity130Enum.AnimatorTime.TaskRewardMoveUp)
	end
end

function var_0_0._onRewardTask(arg_14_0)
	local var_14_0 = arg_14_0._act130TaskId

	arg_14_0._act130TaskId = nil

	if var_14_0 then
		if var_14_0 == Activity130Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity130)
		else
			TaskRpc.instance:sendFinishTaskRequest(var_14_0)
		end
	end
end

function var_0_0.oneClaimReward(arg_15_0, arg_15_1)
	local var_15_0 = Activity130TaskListModel.instance:getList()

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		if iter_15_1:alreadyGotReward() and iter_15_1.id ~= Activity130Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(iter_15_1.id)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
