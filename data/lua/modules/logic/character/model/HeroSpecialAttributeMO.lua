module("modules.logic.character.model.HeroSpecialAttributeMO", package.seeall)

local var_0_0 = pureTable("HeroSpecialAttributeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.revive = arg_1_1.revive
	arg_1_0.heal = arg_1_1.heal
	arg_1_0.absorb = arg_1_1.absorb
	arg_1_0.defenseIgnore = arg_1_1.defenseIgnore
	arg_1_0.clutch = arg_1_1.clutch
	arg_1_0.finalAddDmg = arg_1_1.finalAddDmg
	arg_1_0.finalDropDmg = arg_1_1.finalDropDmg
end

return var_0_0
