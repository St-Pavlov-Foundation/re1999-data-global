module("modules.logic.fight.model.data.FightHeroSpAttributeData", package.seeall)

local var_0_0 = FightDataClass("FightHeroSpAttributeData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.revive = arg_1_1.revive
	arg_1_0.heal = arg_1_1.heal
	arg_1_0.absorb = arg_1_1.absorb
	arg_1_0.defenseIgnore = arg_1_1.defenseIgnore
	arg_1_0.clutch = arg_1_1.clutch
	arg_1_0.finalAddDmg = arg_1_1.finalAddDmg
	arg_1_0.finalDropDmg = arg_1_1.finalDropDmg
	arg_1_0.normalSkillRate = arg_1_1.normalSkillRate
	arg_1_0.playAddRate = arg_1_1.playAddRate
	arg_1_0.playDropRate = arg_1_1.playDropRate
	arg_1_0.dizzyResistances = arg_1_1.dizzyResistances
	arg_1_0.sleepResistances = arg_1_1.sleepResistances
	arg_1_0.petrifiedResistances = arg_1_1.petrifiedResistances
	arg_1_0.frozenResistances = arg_1_1.frozenResistances
	arg_1_0.disarmResistances = arg_1_1.disarmResistances
	arg_1_0.forbidResistances = arg_1_1.forbidResistances
	arg_1_0.sealResistances = arg_1_1.sealResistances
	arg_1_0.cantGetExskillResistances = arg_1_1.cantGetExskillResistances
	arg_1_0.delExPointResistances = arg_1_1.delExPointResistances
	arg_1_0.stressUpResistances = arg_1_1.stressUpResistances
	arg_1_0.controlResilience = arg_1_1.controlResilience
	arg_1_0.delExPointResilience = arg_1_1.delExPointResilience
	arg_1_0.stressUpResilience = arg_1_1.stressUpResilience
	arg_1_0.charmResistances = arg_1_1.charmResistances
	arg_1_0.reboundDmg = arg_1_1.reboundDmg
	arg_1_0.extraDmg = arg_1_1.extraDmg
	arg_1_0.reuseDmg = arg_1_1.reuseDmg
	arg_1_0.bigSkillRate = arg_1_1.bigSkillRate
end

return var_0_0
