module("modules.logic.fight.system.work.FightWorkInjuryBankHealContainer", package.seeall)

slot0 = class("FightWorkInjuryBankHealContainer", FightStepEffectFlow)
slot1 = {
	[FightEnum.EffectType.FIGHTSTEP] = true
}

function slot0.onStart(slot0)
	slot0:playAdjacentParallelEffect(uv0, true)
end

function slot0.clearWork(slot0)
end

return slot0
