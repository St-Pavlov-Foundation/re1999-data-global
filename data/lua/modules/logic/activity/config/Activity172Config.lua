module("modules.logic.activity.config.Activity172Config", package.seeall)

local var_0_0 = class("Activity172Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._act172Task = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity172_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity172_task" then
		arg_3_0._act172Task = arg_3_2
	end
end

function var_0_0.getAct172TaskById(arg_4_0, arg_4_1)
	return arg_4_0._act172Task.configDict[arg_4_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
