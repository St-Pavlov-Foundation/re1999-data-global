module("modules.logic.fight.entity.comp.buff.FightBuffLuXiUpgradeEffect", package.seeall)

local var_0_0 = class("FightBuffLuXiUpgradeEffect", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = 1

	for iter_1_0, iter_1_1 in pairs(arg_1_3) do
		var_1_0 = iter_1_1.effectType

		break
	end

	local var_1_1 = var_1_0 == 1 and FightBuffLuXiUpgradeEffect1 or FightBuffLuXiUpgradeEffect2

	arg_1_0:newClass(var_1_1, arg_1_1, arg_1_2, arg_1_3)
end

return var_0_0
