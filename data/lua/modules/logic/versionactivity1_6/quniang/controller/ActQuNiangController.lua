module("modules.logic.versionactivity1_6.quniang.controller.ActQuNiangController", package.seeall)

local var_0_0 = class("ActQuNiangController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_2_0.OnUpdateDungeonInfo, arg_2_0)
end

function var_0_0.OnUpdateDungeonInfo(arg_3_0, arg_3_1)
	if arg_3_1 then
		ActQuNiangModel.instance:checkFinishLevel(arg_3_1.episodeId, arg_3_1.star)
	end
end

function var_0_0.delayReward(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._actTaskMO == nil and arg_4_2 then
		arg_4_0._actTaskMO = arg_4_2

		TaskDispatcher.runDelay(arg_4_0._onPreFinish, arg_4_0, arg_4_1)

		return true
	end

	return false
end

function var_0_0._onPreFinish(arg_5_0)
	local var_5_0 = arg_5_0._actTaskMO

	arg_5_0._actTaskMO = nil

	if var_5_0 and (var_5_0.id == ActQuNiangEnum.TaskMOAllFinishId or var_5_0:alreadyGotReward()) then
		ActQuNiangTaskListModel.instance:preFinish(var_5_0)

		arg_5_0._actTaskId = var_5_0.id

		TaskDispatcher.runDelay(arg_5_0._onRewardTask, arg_5_0, ActQuNiangEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function var_0_0._onRewardTask(arg_6_0)
	local var_6_0 = arg_6_0._actTaskId

	arg_6_0._actTaskId = nil

	if var_6_0 then
		if var_6_0 == ActQuNiangEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, nil, nil, nil, ActQuNiangEnum.ActivityId)
		else
			TaskRpc.instance:sendFinishTaskRequest(var_6_0)
		end
	end
end

function var_0_0.oneClaimReward(arg_7_0, arg_7_1)
	local var_7_0 = ActQuNiangTaskListModel.instance:getList()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1:alreadyGotReward() and iter_7_1.id ~= ActQuNiangEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(iter_7_1.id)
		end
	end
end

function var_0_0.enterActivity(arg_8_0)
	local var_8_0 = ActivityConfig.instance:getActivityCo(ActQuNiangEnum.ActivityId).storyId

	if var_8_0 > 0 and not StoryModel.instance:isStoryFinished(var_8_0) then
		StoryController.instance:playStory(var_8_0, nil, arg_8_0.storyCallback, arg_8_0)
		ActQuNiangModel.instance:setFirstEnter()
	else
		arg_8_0:_drirectOpenLevelView()
	end
end

function var_0_0.storyCallback(arg_9_0)
	arg_9_0:_drirectOpenLevelView()
end

function var_0_0.openLevelView(arg_10_0, arg_10_1)
	if ViewMgr.instance:isOpen(ViewName.ActQuNiangLevelView) then
		if arg_10_1 ~= nil then
			arg_10_0:dispatchEvent(ActQuNiangEvent.TabSwitch, arg_10_1.needShowFight)
		end
	else
		arg_10_0:_drirectOpenLevelView(arg_10_1)
	end
end

function var_0_0._drirectOpenLevelView(arg_11_0, arg_11_1)
	ViewMgr.instance:openView(ViewName.ActQuNiangLevelView, arg_11_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_story_open)
end

var_0_0.instance = var_0_0.New()

return var_0_0
