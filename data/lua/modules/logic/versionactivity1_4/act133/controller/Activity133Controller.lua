module("modules.logic.versionactivity1_4.act133.controller.Activity133Controller", package.seeall)

local var_0_0 = class("Activity133Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_3_0._onUpdateTaskList, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.OnDeleteTask, arg_3_0._onDeleteTaskList, arg_3_0)
end

function var_0_0._onUpdateTaskList(arg_4_0, arg_4_1)
	if Activity133Model.instance:setTasksInfo(arg_4_1.taskInfo) then
		var_0_0.instance:dispatchEvent(Activity133Event.OnTaskUpdate)
	end
end

function var_0_0._onDeleteTaskList(arg_5_0, arg_5_1)
	if Activity133Model.instance:deleteInfo(arg_5_1.taskIds) then
		var_0_0.instance:dispatchEvent(Activity133Event.OnTaskUpdate)
	end
end

function var_0_0.openActivity133MainView(arg_6_0, arg_6_1)
	Activity133Rpc.instance:sendGet133InfosRequest(arg_6_1, function()
		ViewMgr.instance:openView(ViewName.Activity133View, {
			actId = arg_6_1
		})
	end)
end

function var_0_0.openActivity133TaskView(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.Activity133TaskView, {
		actId = arg_8_1
	})
end

function var_0_0.reInit(arg_9_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
