module("modules.logic.advance.controller.testtask.TestTaskController", package.seeall)

local var_0_0 = class("TestTaskController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openTestTaskView(arg_3_0)
	arg_3_0:_openTestTaskView()
end

function var_0_0._openTestTaskView(arg_4_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TestTask
	}, function()
		ViewMgr.instance:openView(ViewName.TestTaskView)
	end)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
