module("modules.logic.dungeon.controller.DungeonPuzzlePipeRule", package.seeall)

slot0 = class("DungeonPuzzlePipeRule")
slot1 = DungeonPuzzleEnum.dir.left
slot2 = DungeonPuzzleEnum.dir.right
slot3 = DungeonPuzzleEnum.dir.down
slot4 = DungeonPuzzleEnum.dir.up

function slot0.ctor(slot0)
	slot0._ruleChange = {
		[28.0] = 46,
		[248.0] = 468,
		[24.0] = 48,
		[46.0] = 28,
		[48.0] = 68,
		[246.0] = 248,
		[268.0] = 246,
		[468.0] = 268,
		[26.0] = 24,
		[68.0] = 26,
		[DungeonPuzzlePipeModel.constEntry] = DungeonPuzzlePipeModel.constEntry
	}
	slot0._ruleConnect = {}

	for slot4, slot5 in pairs(slot0._ruleChange) do
		if slot4 ~= 0 then
			slot6 = {}
			slot7 = slot4

			while slot7 > 0 do
				slot8 = slot7 % 10
				slot7 = (slot7 - slot8) / 10
				slot6[slot8] = true
			end

			slot0._ruleConnect[slot4] = slot6
		end
	end

	slot0._ruleConnect[DungeonPuzzlePipeModel.constEntry] = {
		[uv0] = true,
		[uv1] = true,
		[uv2] = true,
		[uv3] = true
	}
end

function slot0.setGameSize(slot0, slot1, slot2)
	slot0._gameWidth = slot1
	slot0._gameHeight = slot2
end

function slot0.isGameClear(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if not slot0:getIsEntryClear(slot5) then
			return false
		end
	end

	return true
end

function slot0.getIsEntryClear(slot0, slot1)
	return DungeonPuzzleEnum.pipeEntryClearCount <= slot1.entryCount and DungeonPuzzleEnum.pipeEntryClearDecimal <= slot1:getConnectValue()
end

function slot0.getReachTable(slot0)
	slot3 = {}

	for slot8, slot9 in ipairs(DungeonPuzzlePipeModel.instance:getEntryList()) do
		table.insert(slot3, slot9)

		slot9.entryCount = #slot11
	end

	return {
		[slot9] = slot0:_getSearchPipeResult(slot9, slot3)
	}, {
		[slot9] = slot11
	}
end

function slot0._getSearchPipeResult(slot0, slot1, slot2)
	slot3 = {}
	slot4 = {}

	while #slot2 > 0 do
		if table.remove(slot2):isEntry() and slot5 ~= slot1 then
			if not slot4[slot5] then
				table.insert(slot3, slot5)
			end
		else
			slot0:_addToOpenSet(slot5, slot4, slot2)
		end

		slot4[slot5] = true
	end

	return slot4, slot3
end

function slot0._addToOpenSet(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(slot1.connectSet) do
		slot9, slot10, slot11 = uv0.getIndexByDir(slot1.x, slot1.y, slot7)

		if slot9 > 0 and slot9 <= slot0._gameWidth and slot10 > 0 and slot10 <= slot0._gameHeight and not slot2[DungeonPuzzlePipeModel.instance:getData(slot9, slot10)] then
			table.insert(slot3, slot12)
		end
	end
end

function slot0._mergeReachDir(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, slot7)
	end

	for slot7 = 1, #slot2 do
		slot8 = {}

		for slot12 = slot7 + 1, slot3 do
			for slot18, slot19 in pairs(slot2[slot7]) do
				if slot2[slot12][slot18] then
					slot8[slot18] = 1
				end
			end

			slot0:_markReachDir(slot8)
		end
	end
end

function slot0._markReachDir(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		for slot10, slot11 in pairs(slot5.connectSet) do
			slot12, slot13, slot14 = uv0.getIndexByDir(slot5.x, slot5.y, slot10)

			if slot12 > 0 and slot12 <= slot0._gameWidth and slot13 > 0 and slot13 <= slot0._gameHeight and slot1[DungeonPuzzlePipeModel.instance:getData(slot12, slot13)] then
				slot5.entryConnect[slot10] = true
				slot15.entryConnect[slot14] = true
			end
		end
	end
end

function slot0._unmarkBranch(slot0)
	for slot4 = 1, slot0._gameWidth do
		for slot8 = 1, slot0._gameHeight do
			slot0:_unmarkSearchNode(DungeonPuzzlePipeModel.instance:getData(slot4, slot8))
		end
	end
end

function slot0._unmarkSearchNode(slot0, slot1)
	slot2 = slot1

	while slot2 ~= nil do
		if tabletool.len(slot2.entryConnect) == 1 and not slot2:isEntry() then
			slot3 = nil

			for slot7, slot8 in pairs(slot2.entryConnect) do
				slot3 = slot7
			end

			slot4, slot5, slot6 = uv0.getIndexByDir(slot2.x, slot2.y, slot3)
			slot7 = DungeonPuzzlePipeModel.instance:getData(slot4, slot5)
			slot2.entryConnect[slot3] = nil
			slot7.entryConnect[slot6] = nil
			slot2 = slot7
		else
			slot2 = nil
		end
	end
end

function slot0.setSingleConnection(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 > 0 and slot1 <= slot0._gameWidth and slot2 > 0 and slot2 <= slot0._gameHeight then
		slot10 = slot6.connectSet[slot3] == true

		if slot0._ruleConnect[DungeonPuzzlePipeModel.instance:getData(slot1, slot2).value][slot3] and slot0._ruleConnect[slot5.value][slot4] then
			slot6.connectSet[slot3] = true
			slot5.connectSet[slot4] = true
		else
			slot6.connectSet[slot3] = nil
			slot5.connectSet[slot4] = nil
		end
	end
end

function slot0.changeDirection(slot0, slot1, slot2)
	if slot0._ruleChange[DungeonPuzzlePipeModel.instance:getData(slot1, slot2).value] then
		slot3.value = slot4
	end

	return slot3
end

function slot0.getRandomSkipSet(slot0)
	slot1 = {
		[slot9] = true
	}
	slot3, slot4 = DungeonPuzzlePipeModel.instance:getGameSize()

	for slot8, slot9 in ipairs(DungeonPuzzlePipeModel.instance:getEntryList()) do
		slot10 = slot9.x
		slot11 = slot9.y

		slot0:_insertToSet(slot10 - 1, slot11, slot1)
		slot0:_insertToSet(slot10 + 1, slot11, slot1)
		slot0:_insertToSet(slot10, slot11 - 1, slot1)
		slot0:_insertToSet(slot10, slot11 + 1, slot1)
	end

	return slot1
end

function slot0._insertToSet(slot0, slot1, slot2, slot3)
	if slot1 > 0 and slot1 <= slot0._gameWidth and slot2 > 0 and slot2 <= slot0._gameHeight then
		slot3[DungeonPuzzlePipeModel.instance:getData(slot1, slot2)] = true
	end
end

function slot0.getIndexByDir(slot0, slot1, slot2)
	if slot2 == uv0 then
		return slot0 - 1, slot1, uv1
	elseif slot2 == uv1 then
		return slot0 + 1, slot1, uv0
	elseif slot2 == uv2 then
		return slot0, slot1 + 1, uv3
	elseif slot2 == uv3 then
		return slot0, slot1 - 1, uv2
	end
end

return slot0
