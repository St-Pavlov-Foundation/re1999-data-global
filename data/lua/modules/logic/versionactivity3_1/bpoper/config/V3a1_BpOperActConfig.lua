module("modules.logic.versionactivity3_1.bpoper.config.V3a1_BpOperActConfig", package.seeall)

local var_0_0 = class("V3a1_BpOperActConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._taskConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity214_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity214_task" then
		arg_3_0._taskConfig = arg_3_2
	end
end

function var_0_0.getTaskCO(arg_4_0, arg_4_1)
	return arg_4_0._taskConfig.configDict[arg_4_1]
end

function var_0_0.getTaskCos(arg_5_0)
	return arg_5_0._taskConfig.configDict
end

var_0_0.instance = var_0_0.New()

return var_0_0
