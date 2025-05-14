module("modules.logic.fight.model.mo.FightHeroAttribute", package.seeall)

local var_0_0 = pureTable("FightHeroAttribute")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.hp = arg_1_1.hp
	arg_1_0.attack = arg_1_1.attack
	arg_1_0.defense = arg_1_1.defense
	arg_1_0.crit = arg_1_1.crit
	arg_1_0.crit_damage = arg_1_1.crit_damage
end

return var_0_0
