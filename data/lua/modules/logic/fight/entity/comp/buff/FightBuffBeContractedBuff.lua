module("modules.logic.fight.entity.comp.buff.FightBuffBeContractedBuff", package.seeall)

slot0 = class("FightBuffBeContractedBuff")

function slot0.ctor(slot0)
end

function slot0.onBuffStart(slot0, slot1, slot2)
	FightModel.instance:setBeContractEntityUid(slot1.id)
	FightController.instance:dispatchEvent(FightEvent.BeContract, slot1.id)
end

function slot0.onBuffEnd(slot0)
	FightModel.instance:setBeContractEntityUid(nil)
end

return slot0
