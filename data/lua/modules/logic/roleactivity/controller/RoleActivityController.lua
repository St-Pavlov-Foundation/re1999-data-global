module("modules.logic.roleactivity.controller.RoleActivityController", package.seeall)

local var_0_0 = class("RoleActivityController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_2_0.OnUpdateDungeonInfo, arg_2_0)
end

function var_0_0.OnUpdateDungeonInfo(arg_3_0, arg_3_1)
	if arg_3_1 then
		RoleActivityModel.instance:checkFinishLevel(arg_3_1.episodeId, arg_3_1.star)
	end
end

function var_0_0.enterActivity(arg_4_0, arg_4_1)
	local var_4_0 = ActivityConfig.instance:getActivityCo(arg_4_1).storyId

	if var_4_0 > 0 and not StoryModel.instance:isStoryFinished(var_4_0) then
		StoryController.instance:playStory(var_4_0, nil, arg_4_0._drirectOpenLevelView, arg_4_0, {
			_actId = arg_4_1
		})
	else
		arg_4_0:_drirectOpenLevelView({
			_actId = arg_4_1
		})
	end
end

function var_0_0.openLevelView(arg_5_0, arg_5_1)
	local var_5_0 = RoleActivityEnum.LevelView[arg_5_1.actId]

	if ViewMgr.instance:isOpen(var_5_0) then
		return
	end

	ViewMgr.instance:openView(var_5_0, arg_5_1)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
end

function var_0_0._drirectOpenLevelView(arg_6_0, arg_6_1)
	local var_6_0 = RoleActivityEnum.LevelView[arg_6_1._actId]

	ViewMgr.instance:openView(var_6_0)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
end

function var_0_0.delayReward(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.actId = RoleActivityTaskListModel.instance:getActivityId()

	if arg_7_0._actTaskMO == nil and arg_7_2 and arg_7_0.actId then
		arg_7_0._actTaskMO = arg_7_2

		TaskDispatcher.runDelay(arg_7_0._onPreFinish, arg_7_0, arg_7_1)

		return true
	end

	return false
end

function var_0_0._onPreFinish(arg_8_0)
	local var_8_0 = arg_8_0._actTaskMO

	arg_8_0._actTaskMO = nil

	if var_8_0 and (var_8_0.id == 0 or var_8_0.hasFinished) then
		RoleActivityTaskListModel.instance:preFinish(var_8_0)

		arg_8_0._actTaskId = var_8_0.id

		TaskDispatcher.runDelay(arg_8_0._onRewardTask, arg_8_0, RoleActivityEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function var_0_0._onRewardTask(arg_9_0)
	local var_9_0 = arg_9_0._actTaskId

	arg_9_0._actTaskId = nil

	if var_9_0 then
		if var_9_0 == 0 then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, nil, nil, nil, arg_9_0.actId)
		else
			TaskRpc.instance:sendFinishTaskRequest(var_9_0)
		end
	end

	arg_9_0.actId = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
