module("modules.logic.explore.model.ExploreTaskModel", package.seeall)

local var_0_0 = class("ExploreTaskModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0._models = {}
end

function var_0_0.getTaskList(arg_2_0, arg_2_1)
	if not arg_2_0._models[arg_2_1] then
		arg_2_0._models[arg_2_1] = ListScrollModel.New()
	end

	return arg_2_0._models[arg_2_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
