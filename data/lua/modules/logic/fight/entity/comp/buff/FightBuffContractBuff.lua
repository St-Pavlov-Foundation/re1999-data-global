module("modules.logic.fight.entity.comp.buff.FightBuffContractBuff", package.seeall)

slot0 = class("FightBuffContractBuff")

function slot0.ctor(slot0)
end

function slot0.onBuffStart(slot0, slot1, slot2)
	FightModel.instance:setContractEntityUid(slot1.id)
end

function slot0.onBuffEnd(slot0)
	FightModel.instance:setContractEntityUid(nil)
end

return slot0
