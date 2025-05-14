module("modules.logic.activity.controller.warmup.ActivityWarmUpTaskController", package.seeall)

local var_0_0 = class("ActivityWarmUpTaskController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._actId = arg_3_1

	ActivityWarmUpTaskListModel.instance:setSelectedDay(arg_3_2 or 1)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_3_0.updateDatas, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_3_0.updateDatas, arg_3_0)
end

function var_0_0.release(arg_4_0)
	arg_4_0._actId = nil

	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, arg_4_0.updateDatas, arg_4_0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, arg_4_0.updateDatas, arg_4_0)
	ActivityWarmUpTaskListModel.instance:release()
end

function var_0_0.updateDatas(arg_5_0)
	if not arg_5_0._actId then
		logNormal("no actId enable!")

		return
	end

	ActivityWarmUpTaskListModel.instance:init(arg_5_0._actId)
	ActivityWarmUpTaskListModel.instance:updateDayList()
	arg_5_0:dispatchEvent(ActivityWarmUpEvent.TaskListUpdated)
	arg_5_0:dispatchEvent(ActivityWarmUpEvent.TaskListInit)
end

function var_0_0.changeSelectedDay(arg_6_0, arg_6_1)
	ActivityWarmUpTaskListModel.instance:setSelectedDay(arg_6_1)
	ActivityWarmUpTaskListModel.instance:updateDayList()
	arg_6_0:dispatchEvent(ActivityWarmUpEvent.TaskDayChanged)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
