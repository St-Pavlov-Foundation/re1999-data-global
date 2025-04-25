module("modules.logic.fight.system.work.FightWorkRoundOffset", package.seeall)

slot0 = class("FightWorkRoundOffset", FightEffectBase)

function slot0.onStart(slot0)
	slot2 = slot0._actEffectMO.effectNum
	FightModel.instance.maxRound = FightModel.instance:getMaxRound() + slot2

	FightModel.instance:setRoundOffset(slot2)
	FightController.instance:dispatchEvent(FightEvent.RefreshUIRound)

	return slot0:onDone(true)
end

return slot0
