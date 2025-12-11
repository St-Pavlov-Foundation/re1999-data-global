module("modules.logic.fight.system.work.FightWorkDeadlyPoisonOriginCrit264Parallel", package.seeall)

local var_0_0 = class("FightWorkDeadlyPoisonOriginCrit264Parallel", FightWorkDeadlyPoisonOriginDamage263Parallel)

function var_0_0.getEffectType(arg_1_0)
	return FightEnum.EffectType.DEADLYPOISONORIGINCRIT
end

function var_0_0.getFloatType(arg_2_0)
	return FightEnum.FloatType.crit_damage_origin
end

return var_0_0
