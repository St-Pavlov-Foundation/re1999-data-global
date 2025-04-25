module("modules.logic.fight.entity.comp.FightEntitySummonedComp", package.seeall)

slot0 = class("FightEntitySummonedComp", FightBaseClass)

function slot0.onAwake(slot0, slot1)
	slot0._entity = slot1

	slot0:com_registFightEvent(FightEvent.SummonedAdd, slot0._onSummonedAdd)
	slot0:_refreshSummoned()
end

function slot0._refreshSummoned(slot0)
	for slot7, slot8 in pairs(slot0._entity:getMO():getSummonedInfo():getDataDic()) do
		slot0:_instantiateSummoned(slot8)
	end
end

function slot0._instantiateSummoned(slot0, slot1)
	if _G["FightEntitySummonedItem" .. slot1.summonedId] then
		slot0:newClass(_G[slot2], slot0._entity, slot1)
	else
		slot0:newClass(FightEntitySummonedItem, slot0._entity, slot1)
	end
end

function slot0._onSummonedAdd(slot0, slot1, slot2)
	if slot1 ~= slot0._entity.id then
		return
	end

	slot0:_instantiateSummoned(slot2)
end

function slot0.releaseSelf(slot0)
end

return slot0
