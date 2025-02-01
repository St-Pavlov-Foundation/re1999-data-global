module("modules.logic.fight.FightTimer", package.seeall)

slot0 = class("FightTimer")
slot1 = {}
slot2 = 0
slot3 = 10

function slot0.registTimer(slot0, slot1, slot2, slot3)
	return uv0.registRepeatTimer(slot0, slot1, slot2, 1, slot3)
end

function slot0.registRepeatTimer(slot0, slot1, slot2, slot3, slot4)
	slot5 = FightTimerItem.New(slot2, slot3, slot0, slot1, slot4)

	table.insert(uv0, slot5)

	return slot5
end

function slot0.cancelTimer(slot0)
	if not slot0 then
		return
	end

	slot0.isDone = true
end

function slot0.restartRepeatTimer(slot0, slot1, slot2, slot3)
	slot0:restart(slot1, slot2, slot3)
	table.insert(uv0, slot0)

	return slot0
end

function slot0.update()
	slot0 = Time.deltaTime

	for slot4, slot5 in ipairs(uv0) do
		slot5:update(slot0)
	end

	uv1 = uv1 + slot0

	if uv2 < uv1 then
		uv1 = 0

		for slot4 = #uv0, 1, -1 do
			if uv0[slot4].isDone then
				table.remove(uv0, slot4)
			end
		end
	end
end

UpdateBeat:Add(slot0.update, slot0)

return slot0
