module("modules.logic.versionactivity2_1.aergusi.controller.AergusiController", package.seeall)

local var_0_0 = class("AergusiController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openAergusiLevelView(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1 = arg_3_1 or VersionActivity2_1Enum.ActivityId.Aergusi

	if arg_3_2 then
		Activity163Rpc.instance:sendGet163InfosRequest(arg_3_1, function(arg_4_0, arg_4_1, arg_4_2)
			if arg_4_1 == 0 then
				ViewMgr.instance:openView(ViewName.AergusiLevelView)
			end
		end)
	else
		ViewMgr.instance:openView(ViewName.AergusiLevelView)
	end
end

function var_0_0.openAergusiTaskView(arg_5_0)
	ViewMgr.instance:openView(ViewName.AergusiTaskView)
end

function var_0_0.openAergusiDialogView(arg_6_0, arg_6_1)
	ViewMgr.instance:openView(ViewName.AergusiDialogView, arg_6_1)
end

function var_0_0.openAergusiClueView(arg_7_0, arg_7_1)
	ViewMgr.instance:openView(ViewName.AergusiClueView, arg_7_1)
end

function var_0_0.openAergusiFailView(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.AergusiFailView, arg_8_1)
end

function var_0_0.openAergusiDialogStartView(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {
		groupId = arg_9_1,
		callback = arg_9_2,
		callbackObj = arg_9_3
	}

	ViewMgr.instance:openView(ViewName.AergusiDialogStartView, var_9_0)
end

function var_0_0.openAergusiDialogEndView(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = {
		episodeId = arg_10_1,
		callback = arg_10_2,
		callbackObj = arg_10_3
	}

	ViewMgr.instance:openView(ViewName.AergusiDialogEndView, var_10_0)
end

function var_0_0.delayReward(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._actTaskMO == nil and arg_11_2 then
		arg_11_0._actTaskMO = arg_11_2

		TaskDispatcher.runDelay(arg_11_0._onPreFinish, arg_11_0, arg_11_1)

		return true
	end

	return false
end

function var_0_0._onPreFinish(arg_12_0)
	local var_12_0 = arg_12_0._actTaskMO

	arg_12_0._actTaskMO = nil

	if var_12_0 and (var_12_0.id == AergusiEnum.TaskMOAllFinishId or var_12_0:alreadyGotReward()) then
		AergusiTaskListModel.instance:preFinish(var_12_0)

		arg_12_0._actTaskId = var_12_0.id

		TaskDispatcher.runDelay(arg_12_0._onRewardTask, arg_12_0, AergusiEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function var_0_0._onRewardTask(arg_13_0)
	local var_13_0 = arg_13_0._actTaskId

	arg_13_0._actTaskId = nil

	if var_13_0 then
		if var_13_0 == AergusiEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity163)
		else
			TaskRpc.instance:sendFinishTaskRequest(var_13_0)
		end
	end
end

function var_0_0.oneClaimReward(arg_14_0, arg_14_1)
	local var_14_0 = AergusiTaskListModel.instance:getList()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if iter_14_1:alreadyGotReward() and iter_14_1.id ~= AergusiEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(iter_14_1.id)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
