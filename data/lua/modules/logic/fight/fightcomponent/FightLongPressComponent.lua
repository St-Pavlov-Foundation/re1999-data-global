module("modules.logic.fight.fightcomponent.FightLongPressComponent", package.seeall)

slot0 = class("FightLongPressComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0._longPressArr = {
		0.5,
		99999
	}
	slot0._pressDic = {}
end

function slot0.registLongPress(slot0, slot1, slot2, slot3, slot4)
	slot0._pressDic[slot1:GetInstanceID()] = slot1

	slot1:SetLongPressTime(slot0._longPressArr)
	slot1:AddLongPressListener(slot2, slot3, slot4)
end

function slot0.registHover(slot0, slot1, slot2, slot3)
	slot0._pressDic[slot1:GetInstanceID()] = slot1

	slot1:AddHoverListener(slot2, slot3)
end

function slot0.removeLongPress(slot0, slot1)
	if slot0._pressDic[slot1:GetInstanceID()] then
		slot0._pressDic[slot2]:RemoveLongPressListener()
	end
end

function slot0.removeHover(slot0, slot1)
	if slot0._pressDic[slot1:GetInstanceID()] then
		slot0._pressDic[slot2]:RemoveHoverListener()
	end
end

function slot0.onDestructor(slot0)
	for slot4, slot5 in pairs(slot0._pressDic) do
		slot5:RemoveLongPressListener()
		slot5:RemoveHoverListener()
	end
end

return slot0
