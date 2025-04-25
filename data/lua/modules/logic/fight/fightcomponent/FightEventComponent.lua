module("modules.logic.fight.fightcomponent.FightEventComponent", package.seeall)

slot0 = class("FightEventComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0._eventItems = {}
end

function slot0.registEvent(slot0, slot1, slot2, slot3, slot4, slot5)
	for slot9, slot10 in ipairs(slot0._eventItems) do
		if slot1 == slot10[1] and slot2 == slot10[2] and slot3 == slot10[3] and slot4 == slot10[4] then
			return
		end
	end

	slot1:registerCallback(slot2, slot3, slot4, slot5)
	table.insert(slot0._eventItems, {
		slot1,
		slot2,
		slot3,
		slot4,
		slot5
	})
end

function slot0.cancelEvent(slot0, slot1, slot2, slot3, slot4)
	for slot8 = #slot0._eventItems, 1, -1 do
		if slot1 == slot0._eventItems[slot8][1] and slot2 == slot9[2] and slot3 == slot9[3] and slot4 == slot9[4] then
			slot1:unregisterCallback(slot2, slot3, slot4)
			table.remove(slot0._eventItems, slot8)
		end
	end
end

function slot0.lockEvent(slot0)
	if slot0.LOCK then
		return
	end

	slot0.LOCK = true

	for slot4 = #slot0._eventItems, 1, -1 do
		slot5 = slot0._eventItems[slot4]

		slot5[1]:unregisterCallback(slot5[2], slot5[3], slot5[4])
	end
end

function slot0.unlockEvent(slot0)
	if not slot0.LOCK then
		return
	end

	slot0.LOCK = nil

	for slot4 = 1, #slot0._eventItems do
		slot5 = slot0._eventItems[slot4]

		slot5[1]:registerCallback(slot5[2], slot5[3], slot5[4], slot5[5])
	end
end

function slot0.onDestructor(slot0)
	for slot4 = #slot0._eventItems, 1, -1 do
		slot5 = slot0._eventItems[slot4]

		slot5[1]:unregisterCallback(slot5[2], slot5[3], slot5[4])
	end

	slot0._eventItems = nil
end

return slot0
