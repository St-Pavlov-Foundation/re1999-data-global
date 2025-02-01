module("modules.logic.fight.system.work.FightWorkDeadContainer", package.seeall)

slot0 = class("FightWorkDeadContainer", FightStepEffectFlow)
slot1 = {
	[FightEnum.EffectType.DEAD] = true,
	[FightEnum.EffectType.KILL] = true,
	[FightEnum.EffectType.REMOVEENTITYCARDS] = true
}

function slot0.onStart(slot0)
	slot0:playAdjacentParallelEffect(uv0, true)
end

function slot0.clearWork(slot0)
end

return slot0
