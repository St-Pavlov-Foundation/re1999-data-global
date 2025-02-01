module("modules.logic.fight.system.work.FightWorkCardAConvertCardBContainer", package.seeall)

slot0 = class("FightWorkCardAConvertCardBContainer", FightStepEffectFlow)
slot1 = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true,
	[FightEnum.EffectType.CHANGEHERO] = true
}

function slot0.onStart(slot0)
	slot0:playAdjacentParallelEffect(uv0, true)
end

function slot0.clearWork(slot0)
end

return slot0
