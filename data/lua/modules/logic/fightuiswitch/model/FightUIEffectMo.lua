module("modules.logic.fightuiswitch.model.FightUIEffectMo", package.seeall)

local var_0_0 = class("FightUIEffectMo")

function var_0_0.initMo(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.classify = arg_1_2
	arg_1_0.co = FightUISwitchConfig.instance:getFightUIEffectConfigById(arg_1_1)
end

function var_0_0.getName(arg_2_0)
	return arg_2_0.co and arg_2_0.co.name or ""
end

return var_0_0
