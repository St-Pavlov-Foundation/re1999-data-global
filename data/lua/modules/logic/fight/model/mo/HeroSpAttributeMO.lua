module("modules.logic.fight.model.mo.HeroSpAttributeMO", package.seeall)

local var_0_0 = pureTable("HeroSpAttributeMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.uid = arg_1_1
	arg_1_0.revive = arg_1_2.revive
	arg_1_0.heal = arg_1_2.heal
	arg_1_0.absorb = arg_1_2.absorb
	arg_1_0.defenseIgnore = arg_1_2.defenseIgnore
	arg_1_0.clutch = arg_1_2.clutch
	arg_1_0.finalAddDmg = arg_1_2.finalAddDmg
	arg_1_0.finalDropDmg = arg_1_2.finalDropDmg
	arg_1_0.normalSkillRate = arg_1_2.normalSkillRate
	arg_1_0.playAddRate = arg_1_2.playAddRate
	arg_1_0.playDropRate = arg_1_2.playDropRate
	arg_1_0.dizzyResistances = arg_1_2.dizzyResistances
	arg_1_0.sleepResistances = arg_1_2.sleepResistances
	arg_1_0.petrifiedResistances = arg_1_2.petrifiedResistances
	arg_1_0.frozenResistances = arg_1_2.frozenResistances
	arg_1_0.disarmResistances = arg_1_2.disarmResistances
	arg_1_0.forbidResistances = arg_1_2.forbidResistances
	arg_1_0.sealResistances = arg_1_2.sealResistances
	arg_1_0.cantGetExskillResistances = arg_1_2.cantGetExskillResistances
	arg_1_0.delExPointResistances = arg_1_2.delExPointResistances
	arg_1_0.stressUpResistances = arg_1_2.stressUpResistances
	arg_1_0.controlResilience = arg_1_2.controlResilience
	arg_1_0.delExPointResilience = arg_1_2.delExPointResilience
	arg_1_0.stressUpResilience = arg_1_2.stressUpResilience
	arg_1_0.charmResistances = arg_1_2.charmResistances
end

return var_0_0
