module("modules.logic.summonsimulationpick.config.SummonSimulationPickConfig", package.seeall)

local var_0_0 = class("SummonSimulationPickConfig", BaseConfig)

var_0_0.ACTIVITY_CONFIG_170 = "activity170"

function var_0_0.reqConfigNames(arg_1_0)
	return {
		arg_1_0.ACTIVITY_CONFIG_170
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._summonSimulationPickConfig = nil
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == arg_3_0.ACTIVITY_CONFIG_170 then
		arg_3_0._summonSimulationPickConfig = arg_3_2
	end
end

function var_0_0.getAllConfig(arg_4_0)
	return arg_4_0._summonSimulationPickConfig.configList
end

function var_0_0.getSummonConfig(arg_5_0)
	return arg_5_0._summonSimulationPickConfig
end

function var_0_0.getSummonConfigById(arg_6_0, arg_6_1)
	return arg_6_0._summonSimulationPickConfig.configDict[arg_6_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
