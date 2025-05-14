module("modules.logic.versionactivity2_1.aergusi.controller.AergusiController", package.seeall)

local var_0_0 = class("AergusiController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_1_0._checkActivityInfo, arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._delayGetInfo, arg_2_0)
end

function var_0_0._checkActivityInfo(arg_3_0)
	if ActivityModel.instance:isActOnLine(VersionActivity2_1Enum.ActivityId.Aergusi) then
		TaskDispatcher.cancelTask(arg_3_0._delayGetInfo, arg_3_0)
		TaskDispatcher.runDelay(arg_3_0._delayGetInfo, arg_3_0, 0.2)
	end
end

function var_0_0._delayGetInfo(arg_4_0)
	Activity163Rpc.instance:sendGet163InfosRequest(VersionActivity2_1Enum.ActivityId.Aergusi)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity163
	})
end

function var_0_0.openAergusiLevelView(arg_5_0)
	ViewMgr.instance:openView(ViewName.AergusiLevelView)
end

function var_0_0.openAergusiTaskView(arg_6_0)
	ViewMgr.instance:openView(ViewName.AergusiTaskView)
end

function var_0_0.openAergusiDialogView(arg_7_0, arg_7_1)
	ViewMgr.instance:openView(ViewName.AergusiDialogView, arg_7_1)
end

function var_0_0.openAergusiClueView(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.AergusiClueView, arg_8_1)
end

function var_0_0.openAergusiFailView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.AergusiFailView, arg_9_1)
end

function var_0_0.openAergusiDialogStartView(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = {
		groupId = arg_10_1,
		callback = arg_10_2,
		callbackObj = arg_10_3
	}

	ViewMgr.instance:openView(ViewName.AergusiDialogStartView, var_10_0)
end

function var_0_0.openAergusiDialogEndView(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {
		episodeId = arg_11_1,
		callback = arg_11_2,
		callbackObj = arg_11_3
	}

	ViewMgr.instance:openView(ViewName.AergusiDialogEndView, var_11_0)
end

function var_0_0.delayReward(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._actTaskMO == nil and arg_12_2 then
		arg_12_0._actTaskMO = arg_12_2

		TaskDispatcher.runDelay(arg_12_0._onPreFinish, arg_12_0, arg_12_1)

		return true
	end

	return false
end

function var_0_0._onPreFinish(arg_13_0)
	local var_13_0 = arg_13_0._actTaskMO

	arg_13_0._actTaskMO = nil

	if var_13_0 and (var_13_0.id == AergusiEnum.TaskMOAllFinishId or var_13_0:alreadyGotReward()) then
		AergusiTaskListModel.instance:preFinish(var_13_0)

		arg_13_0._actTaskId = var_13_0.id

		TaskDispatcher.runDelay(arg_13_0._onRewardTask, arg_13_0, AergusiEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function var_0_0._onRewardTask(arg_14_0)
	local var_14_0 = arg_14_0._actTaskId

	arg_14_0._actTaskId = nil

	if var_14_0 then
		if var_14_0 == AergusiEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity163)
		else
			TaskRpc.instance:sendFinishTaskRequest(var_14_0)
		end
	end
end

function var_0_0.oneClaimReward(arg_15_0, arg_15_1)
	local var_15_0 = AergusiTaskListModel.instance:getList()

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		if iter_15_1:alreadyGotReward() and iter_15_1.id ~= AergusiEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(iter_15_1.id)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
