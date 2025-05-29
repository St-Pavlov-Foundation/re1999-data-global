module("modules.logic.fight.model.data.FightHeroAttributeData", package.seeall)

local var_0_0 = FightDataClass("FightHeroAttributeData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.hp = arg_1_1.hp
	arg_1_0.attack = arg_1_1.attack
	arg_1_0.defense = arg_1_1.defense
	arg_1_0.mdefense = arg_1_1.mdefense
	arg_1_0.technic = arg_1_1.technic
	arg_1_0.multiHpIdx = arg_1_1.multiHpIdx
	arg_1_0.multiHpNum = arg_1_1.multiHpNum
end

return var_0_0
