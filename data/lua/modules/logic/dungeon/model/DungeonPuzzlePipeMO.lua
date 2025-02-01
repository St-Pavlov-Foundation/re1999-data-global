module("modules.logic.dungeon.model.DungeonPuzzlePipeMO", package.seeall)

slot0 = pureTable("DungeonPuzzlePipeMO")

function slot0.init(slot0, slot1, slot2)
	slot0.x = slot1
	slot0.y = slot2
	slot0.value = 0
	slot0.connectSet = {}
	slot0.entryConnect = {}
	slot0.entryCount = 0
end

slot1 = {}

function slot0.getConnectValue(slot0)
	slot1 = 0
	slot2 = 0

	if slot0.entryConnect then
		for slot6, slot7 in pairs(slot0.entryConnect) do
			table.insert(uv0, slot6)

			slot1 = slot1 + 1
		end

		table.sort(uv0)

		for slot6, slot7 in ipairs(uv0) do
			slot2 = slot2 * 10 + slot7
		end

		for slot6 = 1, slot1 do
			uv0[slot6] = nil
		end
	end

	return slot2
end

function slot0.cleanEntrySet(slot0)
	for slot4, slot5 in pairs(slot0.entryConnect) do
		slot0.entryConnect[slot4] = nil
	end

	slot0.entryCount = 0
end

function slot0.isEntry(slot0)
	return DungeonPuzzlePipeModel.constEntry == slot0.value
end

return slot0
