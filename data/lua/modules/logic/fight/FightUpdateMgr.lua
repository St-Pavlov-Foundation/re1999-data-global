module("modules.logic.fight.FightUpdateMgr", package.seeall)

slot0 = class("FightUpdateMgr")
slot1 = {}
slot2 = 0
slot3 = 10

function slot0.registUpdate(slot0, slot1, slot2)
	slot3 = FightUpdateItem.New(slot0, slot1, slot2)

	table.insert(uv0, slot3)

	return slot3
end

function slot0.cancelUpdate(slot0)
	if not slot0 then
		return
	end

	slot0.isDone = true
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
