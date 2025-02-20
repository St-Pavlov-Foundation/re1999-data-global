module("modules.logic.versionactivity1_8.dungeon.controller.Activity157GameRule", package.seeall)

slot0 = class("Activity157GameRule")
slot1 = ArmPuzzlePipeEnum.dir.left
slot2 = ArmPuzzlePipeEnum.dir.right
slot3 = ArmPuzzlePipeEnum.dir.down
slot4 = ArmPuzzlePipeEnum.dir.up
slot5 = 0

function slot0.ctor(slot0)
	slot0._ruleChange = {
		[0] = 0,
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
		[2468.0] = 2468
	}
	slot0._ruleConnect = {}

	for slot4, slot5 in pairs(slot0._ruleChange) do
		slot6 = {}
		slot7 = slot4

		while slot7 > 0 do
			slot7 = math.floor(slot7 / 10)
			slot6[slot7 % 10] = true
		end

		slot0._ruleConnect[slot4] = slot6
	end

	slot0._ruleConnect[uv0] = {
		[uv1] = false,
		[uv2] = false,
		[uv3] = false,
		[uv4] = false
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
	if slot1.typeId == ArmPuzzlePipeEnum.type.first or slot1.typeId == ArmPuzzlePipeEnum.type.last then
		return slot1.entryCount >= 1
	end

	return ArmPuzzlePipeEnum.pipeEntryClearCount <= slot1.entryCount and ArmPuzzlePipeEnum.pipeEntryClearDecimal <= slot1:getConnectValue()
end

function slot0.getReachTable(slot0)
	slot1 = {
		[slot10] = slot0:_getSearchPipeResult(slot10, slot3)
	}
	slot2 = {
		[slot10] = slot12
	}
	slot3 = {}
	slot4 = {}
	slot5 = Activity157RepairGameModel.instance:getEntryList()
	slot9 = uv0._sortOrderList

	table.sort(slot5, slot9)

	for slot9, slot10 in ipairs(slot5) do
		table.insert(slot3, slot10)

		slot10.entryCount = #slot12

		if slot10.pathType == ArmPuzzlePipeEnum.PathType.Order then
			table.insert(slot4, slot10)
		end
	end

	if #slot4 > 0 then
		slot0:_mergeReachDir(slot1)
		table.sort(slot4, uv0._sortOrderList)

		slot6 = false

		for slot10, slot11 in ipairs(slot4) do
			if slot11.typeId == ArmPuzzlePipeEnum.type.first then
				slot6 = slot11.entryCount > 0
			else
				if not slot6 then
					slot11:cleanEntrySet()

					slot11.entryCount = 0
					slot2[slot11] = {}
					slot1[slot11] = {}
				end

				if slot6 and not slot0:getIsEntryClear(slot11) then
					slot6 = false
				end
			end
		end

		slot0:_cleaConnMark()
	end

	return slot1, slot2
end

function slot0._cleaConnMark(slot0)
	for slot4 = 1, slot0._gameWidth do
		for slot8 = 1, slot0._gameHeight do
			slot9 = Activity157RepairGameModel.instance:getData(slot4, slot8)

			slot9:cleanEntrySet()

			slot9.entryCount = slot9.entryCount
		end
	end
end

function slot0._sortOrderList(slot0, slot1)
	if slot0.pathIndex ~= slot1.pathIndex then
		return slot0.pathIndex < slot1.pathIndex
	end

	if slot0.numIndex ~= slot1.numIndex then
		return slot0.numIndex < slot1.numIndex
	end
end

function slot0._getSearchPipeResult(slot0, slot1, slot2)
	slot3 = {}
	slot4 = {}

	while #slot2 > 0 do
		slot0:_addToOpenSet(table.remove(slot2), slot4, slot2, slot3)
	end

	for slot8 = #slot3, 1, -1 do
		if not slot0:_checkEntryConnect(slot1, slot3[slot8]) or slot1 == slot9 then
			slot4[slot9] = nil

			table.remove(slot3, slot8)
		end
	end

	if #slot3 < 1 then
		slot4 = {}
	end

	return slot4, slot3
end

function slot0._checkEntryConnect(slot0, slot1, slot2)
	if slot2.pathIndex ~= slot1.pathIndex or slot2.pathType ~= slot1.pathType then
		return false
	end

	if slot2.pathType == ArmPuzzlePipeEnum.PathType.Order then
		slot3 = Activity157RepairGameModel.instance

		if math.abs(slot3:getIndexByMO(slot1) - slot3:getIndexByMO(slot2)) ~= 1 then
			return false
		end
	end

	return true
end

function slot0._addToOpenSet(slot0, slot1, slot2, slot3, slot4)
	for slot8, slot9 in pairs(slot1.connectSet) do
		slot10, slot11, slot12 = uv0.getIndexByDir(slot1.x, slot1.y, slot8)

		if slot10 > 0 and slot10 <= slot0._gameWidth and slot11 > 0 and slot11 <= slot0._gameHeight and not slot2[Activity157RepairGameModel.instance:getData(slot10, slot11)] then
			slot2[slot13] = true

			if slot13:isEntry() then
				table.insert(slot4, slot13)
			else
				table.insert(slot3, slot13)
			end
		end
	end

	slot2[slot1] = true
end

function slot0._mergeReachDir(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(slot1) do
		table.insert(slot2, slot8)
		table.insert({}, slot7)
	end

	for slot8 = 1, #slot2 do
		slot9 = {}

		for slot13 = slot8 + 1, slot4 do
			if slot0:_checkEntryConnect(slot3[slot8], slot3[slot13]) then
				for slot21, slot22 in pairs(slot2[slot8]) do
					if slot2[slot13][slot21] then
						slot9[slot21] = slot14.pathIndex
					end
				end

				slot0:_markReachDir(slot9)
			end
		end
	end
end

function slot0._markReachDir(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		for slot10, slot11 in pairs(slot5.connectSet) do
			slot12, slot13, slot14 = uv0.getIndexByDir(slot5.x, slot5.y, slot10)

			if slot12 > 0 and slot12 <= slot0._gameWidth and slot13 > 0 and slot13 <= slot0._gameHeight and slot1[Activity157RepairGameModel.instance:getData(slot12, slot13)] then
				slot5.entryConnect[slot10] = true
				slot15.entryConnect[slot14] = true
				slot5.connectPathIndex = slot6
				slot15.connectPathIndex = slot6
			end
		end
	end
end

function slot0._unmarkBranch(slot0)
	for slot4 = 1, slot0._gameWidth do
		for slot8 = 1, slot0._gameHeight do
			slot0:_unmarkSearchNode(Activity157RepairGameModel.instance:getData(slot4, slot8))
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
			slot7 = Activity157RepairGameModel.instance:getData(slot4, slot5)
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

		if slot0._ruleConnect[Activity157RepairGameModel.instance:getData(slot1, slot2).value][slot3] and slot0._ruleConnect[slot5.value][slot4] then
			slot6.connectSet[slot3] = true
			slot5.connectSet[slot4] = true
		else
			slot6.connectSet[slot3] = nil
			slot5.connectSet[slot4] = nil
		end
	end
end

function slot0.changeDirection(slot0, slot1, slot2)
	if slot0._ruleChange[Activity157RepairGameModel.instance:getData(slot1, slot2).value] then
		slot3.value = slot4
	end

	return slot3
end

function slot0.getRandomSkipSet(slot0)
	slot1 = {
		[slot7] = true
	}

	for slot6, slot7 in ipairs(Activity157RepairGameModel.instance:getEntryList()) do
		slot8 = slot7.x
		slot9 = slot7.y

		slot0:_insertToSet(slot8 - 1, slot9, slot1)
		slot0:_insertToSet(slot8 + 1, slot9, slot1)
		slot0:_insertToSet(slot8, slot9 - 1, slot1)
		slot0:_insertToSet(slot8, slot9 + 1, slot1)
	end

	return slot1
end

function slot0._insertToSet(slot0, slot1, slot2, slot3)
	if slot1 > 0 and slot1 <= slot0._gameWidth and slot2 > 0 and slot2 <= slot0._gameHeight then
		slot3[Activity157RepairGameModel.instance:getData(slot1, slot2)] = true
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
