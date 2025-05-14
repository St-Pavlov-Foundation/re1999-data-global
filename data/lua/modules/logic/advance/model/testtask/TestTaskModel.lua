module("modules.logic.advance.model.testtask.TestTaskModel", package.seeall)

local var_0_0 = class("TestTaskModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getTaskData(arg_3_0, arg_3_1)
	return TaskModel.instance:getTaskById(arg_3_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
