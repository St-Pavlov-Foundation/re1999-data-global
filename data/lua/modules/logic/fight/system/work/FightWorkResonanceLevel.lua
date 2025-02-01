module("modules.logic.fight.system.work.FightWorkResonanceLevel", package.seeall)

slot0 = class("FightWorkResonanceLevel", FightEffectBase)

function slot0.onStart(slot0)
	FightRoundSequence.roundTempData.ResonanceLevel = slot0._actEffectMO.effectNum

	FightController.instance:dispatchEvent(FightEvent.ResonanceLevel, slot0._actEffectMO.effectNum)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
