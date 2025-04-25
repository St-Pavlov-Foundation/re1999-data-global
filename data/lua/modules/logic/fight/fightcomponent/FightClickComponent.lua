module("modules.logic.fight.fightcomponent.FightClickComponent", package.seeall)

slot0 = class("FightClickComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0._clickDic = {}
end

function slot0.registClick(slot0, slot1, slot2, slot3, slot4)
	slot0._clickDic[slot1:GetInstanceID()] = slot1

	slot1:AddClickListener(slot2, slot3, slot4)
end

function slot0.removeClick(slot0, slot1)
	if slot0._clickDic[slot1:GetInstanceID()] then
		slot0._clickDic[slot2]:RemoveClickListener()

		slot0._clickDic[slot2] = nil
	end
end

function slot0.onDestructor(slot0)
	for slot4, slot5 in pairs(slot0._clickDic) do
		slot5:RemoveClickListener()
	end
end

return slot0
