module("modules.logic.character.model.extra.CharacterWeaponEffectMO", package.seeall)

local var_0_0 = class("CharacterWeaponEffectMO")

function var_0_0.initMo(arg_1_0, arg_1_1)
	arg_1_0.co = arg_1_1
	arg_1_0.firstId = arg_1_1.firstId
	arg_1_0.secondId = arg_1_1.secondId
end

function var_0_0.getSecondDesc(arg_2_0)
	return arg_2_0.co and arg_2_0.co.secondDesc or ""
end

return var_0_0
