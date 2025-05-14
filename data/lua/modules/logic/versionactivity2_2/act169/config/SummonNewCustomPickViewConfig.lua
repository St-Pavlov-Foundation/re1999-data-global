module("modules.logic.versionactivity2_2.act169.config.SummonNewCustomPickViewConfig", package.seeall)

local var_0_0 = class("SummonNewCustomPickViewConfig", BaseConfig)

var_0_0.ACTIVITY_CONFIG_169 = "activity169"

function var_0_0.reqConfigNames(arg_1_0)
	return {
		arg_1_0.ACTIVITY_CONFIG_169
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._summonNewPickConfig = nil
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == arg_3_0.ACTIVITY_CONFIG_169 then
		arg_3_0._summonNewPickConfig = arg_3_2
	end
end

function var_0_0.getAllConfig(arg_4_0)
	return arg_4_0._summonNewPickConfig.configList
end

function var_0_0.getSummonConfig(arg_5_0)
	return arg_5_0._summonNewPickConfig
end

function var_0_0.getSummonConfigById(arg_6_0, arg_6_1)
	return arg_6_0._summonNewPickConfig.configDict[arg_6_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
