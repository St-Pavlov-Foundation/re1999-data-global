module("modules.logic.fight.fightcomponent.FightUpdateComponent", package.seeall)

slot0 = class("FightUpdateComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0._updateItemList = {}
end

function slot0.registUpdate(slot0, slot1, slot2, slot3)
	slot4 = FightUpdateMgr.registUpdate(slot1, slot2, slot3)

	table.insert(slot0._updateItemList, slot4)

	return slot4
end

function slot0.cancelUpdate(slot0, slot1)
	return FightUpdateMgr.cancelUpdate(slot1)
end

function slot0.onDestructor(slot0)
	for slot4, slot5 in ipairs(slot0._updateItemList) do
		slot5.isDone = true
	end
end

return slot0
