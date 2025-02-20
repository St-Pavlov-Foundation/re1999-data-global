module("modules.logic.fight.system.work.FightWorkDeadlyPoisonCritContainer", package.seeall)

slot0 = class("FightWorkDeadlyPoisonCritContainer", FightWorkDeadlyPoisonContainer)

function slot0.getEffectType(slot0)
	return FightEnum.EffectType.DEADLYPOISONORIGINCRIT
end

function slot0.getFloatType(slot0)
	return FightEnum.FloatType.crit_damage_origin
end

return slot0
