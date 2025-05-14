module("modules.logic.character.model.HeroAttributeMO", package.seeall)

local var_0_0 = pureTable("HeroAttributeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.original_max_hp = arg_1_1.hp
	arg_1_0.hp = arg_1_1.hp
	arg_1_0.attack = arg_1_1.attack
	arg_1_0.defense = arg_1_1.defense
	arg_1_0.mdefense = arg_1_1.mdefense
	arg_1_0.technic = arg_1_1.technic
	arg_1_0.multiHpIdx = arg_1_1.multiHpIdx
	arg_1_0.multiHpNum = arg_1_1.multiHpNum
end

function var_0_0.getCurMultiHpIndex(arg_2_0)
	return arg_2_0.multiHpIdx
end

return var_0_0
