module("modules.logic.fight.fightcomponent.FightDragComponent", package.seeall)

slot0 = class("FightDragComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0._dragDic = {}
end

function slot0.registDragBegin(slot0, slot1, slot2, slot3, slot4)
	slot0._dragDic[slot1:GetInstanceID()] = slot1

	slot1:AddDragBeginListener(slot2, slot3, slot4)
end

function slot0.registDrag(slot0, slot1, slot2, slot3, slot4)
	slot0._dragDic[slot1:GetInstanceID()] = slot1

	slot1:AddDragListener(slot2, slot3, slot4)
end

function slot0.registDragEnd(slot0, slot1, slot2, slot3, slot4)
	slot0._dragDic[slot1:GetInstanceID()] = slot1

	slot1:AddDragEndListener(slot2, slot3, slot4)
end

function slot0.removeDragBegin(slot0, slot1)
	if slot0._dragDic[slot1:GetInstanceID()] then
		slot0._dragDic[slot2]:RemoveDragBeginListener()
	end
end

function slot0.removeDrag(slot0, slot1)
	if slot0._dragDic[slot1:GetInstanceID()] then
		slot0._dragDic[slot2]:RemoveDragListener()
	end
end

function slot0.removeDragEnd(slot0, slot1)
	if slot0._dragDic[slot1:GetInstanceID()] then
		slot0._dragDic[slot2]:RemoveDragEndListener()
	end
end

function slot0.onDestructor(slot0)
	for slot4, slot5 in pairs(slot0._dragDic) do
		slot5:RemoveDragBeginListener()
		slot5:RemoveDragListener()
		slot5:RemoveDragEndListener()
	end
end

return slot0
