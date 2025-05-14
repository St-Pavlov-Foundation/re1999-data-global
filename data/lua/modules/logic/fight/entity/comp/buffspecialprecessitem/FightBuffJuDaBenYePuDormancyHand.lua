module("modules.logic.fight.entity.comp.buffspecialprecessitem.FightBuffJuDaBenYePuDormancyHand", package.seeall)

local var_0_0 = class("FightBuffJuDaBenYePuDormancyHand", FightBuffJuDaBenYePuDormancyTail)

function var_0_0.getPlayValue(arg_1_0)
	local var_1_0 = MaterialUtil.getPropValueFromMat(arg_1_0._entityMat, "_TempOffset3", "Vector4")
	local var_1_1 = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,0,%f,0", var_1_0.z))
	local var_1_2 = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,1,%f,0", var_1_0.z))

	return var_1_1, var_1_2
end

function var_0_0.getCloseValue(arg_2_0)
	local var_2_0 = MaterialUtil.getPropValueFromMat(arg_2_0._entityMat, "_TempOffset3", "Vector4")
	local var_2_1 = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,1,%f,0", var_2_0.z))
	local var_2_2 = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,0,%f,0", var_2_0.z))

	return var_2_1, var_2_2
end

return var_0_0
