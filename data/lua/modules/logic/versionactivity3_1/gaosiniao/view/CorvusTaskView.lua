module("modules.logic.versionactivity3_1.gaosiniao.view.CorvusTaskView", package.seeall)

local var_0_0 = class("CorvusTaskView", BaseView)

function var_0_0.onOpen(arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_1_0._refresh, arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, arg_1_0._refresh, arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_1_0._onUpdateTaskList, arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, arg_1_0._onFinishTask, arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, arg_1_0._onFinishTask, arg_1_0)
	arg_1_0:onUpdateParam()
end

function var_0_0.onUpdateParam(arg_2_0)
	arg_2_0.viewContainer:sendGetTaskInfoRequest(arg_2_0._refresh, arg_2_0)
end

function var_0_0.onClose(arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, arg_3_0._refresh, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, arg_3_0._refresh, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, arg_3_0._onUpdateTaskList, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, arg_3_0._onFinishTask, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, arg_3_0._onFinishTask, arg_3_0)
end

function var_0_0._setTaskList(arg_4_0)
	local var_4_0 = arg_4_0.viewContainer

	var_4_0:scrollModel():setTaskListWithGetAll(var_4_0:taskType(), var_4_0:actId())
end

function var_0_0._refresh(arg_5_0)
	arg_5_0:_setTaskList()
end

function var_0_0._onUpdateTaskList(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.taskInfo
	local var_6_1 = arg_6_0:taskType()

	for iter_6_0, iter_6_1 in ipairs(var_6_0 or {}) do
		if iter_6_1.type == var_6_1 then
			arg_6_0:_refresh()

			break
		end
	end
end

function var_0_0._onFinishTask(arg_7_0)
	arg_7_0:_refresh()
end

function var_0_0.taskType(arg_8_0)
	return arg_8_0.viewContainer:taskType()
end

function var_0_0.actId(arg_9_0)
	return arg_9_0.viewContainer:actId()
end

function var_0_0.getActivityRemainTimeStr(arg_10_0)
	return arg_10_0.viewContainer:getActivityRemainTimeStr()
end

return var_0_0
