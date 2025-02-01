module("modules.logic.dungeon.controller.DungeonPuzzleCircuitRule", package.seeall)

slot0 = class("DungeonPuzzleCircuitRule")
slot1 = DungeonPuzzleCircuitEnum.dir.left
slot2 = DungeonPuzzleCircuitEnum.dir.right
slot3 = DungeonPuzzleCircuitEnum.dir.down
slot4 = DungeonPuzzleCircuitEnum.dir.up

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
		[68.0] = 26
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

	slot0._ruleTypeConnect = {
		[DungeonPuzzleCircuitEnum.type.power1] = {
			[uv0] = true,
			[uv1] = true
		},
		[DungeonPuzzleCircuitEnum.type.power2] = {
			[uv2] = true,
			[uv3] = true
		},
		[DungeonPuzzleCircuitEnum.type.capacitance] = {
			[uv0] = true,
			[uv1] = true,
			[uv2] = true,
			[uv3] = true
		},
		[DungeonPuzzleCircuitEnum.type.wrong] = {
			[uv0] = true,
			[uv1] = true,
			[uv2] = true,
			[uv3] = true
		}
	}
end

function slot0.changeDirection(slot0, slot1, slot2)
	if not DungeonPuzzleCircuitModel.instance:getData(slot1, slot2) then
		return
	end

	if slot0._ruleChange[slot3.value] then
		slot3.value = slot4
	end

	return slot3
end

function slot0.getOldCircuitList(slot0)
	return slot0._oldCircuiteList
end

function slot0.getOldCapacitanceList(slot0)
	return slot0._oldCapacitanceList
end

function slot0.getOldWrongList(slot0)
	return slot0._oldWrongList
end

function slot0.getCircuitList(slot0)
	return slot0._circuitList
end

function slot0.getCapacitanceList(slot0)
	return slot0._capacitanceList
end

function slot0.getWrongList(slot0)
	return slot0._wrongList
end

function slot0.isWin(slot0)
	return slot0._win
end

function slot0.refreshAllConnection(slot0)
	slot0._oldCircuiteList = slot0._circuitList
	slot0._oldCapacitanceList = slot0._capacitanceList

	slot0:_powerConnect()

	slot0._oldWrongList = slot0._wrongList

	slot0:_wrongConnect()
end

function slot0._wrongConnect(slot0)
	slot0._wrongList = {}

	for slot5, slot6 in ipairs(DungeonPuzzleCircuitModel.instance:getWrongList()) do
		slot7 = slot6.x
		slot8 = slot6.y

		slot0:_addWrongList(slot0:_findSingle(slot7 - 1, slot8, uv0, uv1, slot6))
		slot0:_addWrongList(slot0:_findSingle(slot7 + 1, slot8, uv1, uv0, slot6))
		slot0:_addWrongList(slot0:_findSingle(slot7, slot8 + 1, uv2, uv3, slot6))
		slot0:_addWrongList(slot0:_findSingle(slot7, slot8 - 1, uv3, uv2, slot6))
	end
end

function slot0._addWrongList(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._wrongList[slot1.id] = slot1
end

function slot0._powerConnect(slot0)
	slot0._closeList = {}
	slot0._powerList = {}
	slot0._capacitanceList = {}
	slot0._circuitList = {}

	for slot6, slot7 in ipairs(DungeonPuzzleCircuitModel.instance:getPowerList()) do
		if slot7.type == DungeonPuzzleCircuitEnum.type.power1 then
			slot0:_findConnectPath(slot7)

			if #slot0._powerList == #slot1 and #slot0._capacitanceList == #DungeonPuzzleCircuitModel.instance:getCapacitanceList() then
				slot0._win = true

				return
			end
		end
	end
end

function slot0._findConnectPath(slot0, slot1)
	slot2 = {
		slot1
	}

	while #slot2 > 0 do
		if not slot0._closeList[table.remove(slot2).id] then
			if slot3.type == DungeonPuzzleCircuitEnum.type.power1 or slot3.type == DungeonPuzzleCircuitEnum.type.power2 then
				table.insert(slot0._powerList, slot3)
			elseif slot3.type == DungeonPuzzleCircuitEnum.type.capacitance then
				table.insert(slot0._capacitanceList, slot3)
			end
		end

		slot0._closeList[slot3.id] = slot3

		if slot3.type ~= DungeonPuzzleCircuitEnum.type.capacitance and slot3.type ~= DungeonPuzzleCircuitEnum.type.wrong then
			if DungeonPuzzleCircuitEnum.type.straight <= slot3.type and slot3.type <= DungeonPuzzleCircuitEnum.type.t_shape then
				table.insert(slot0._circuitList, slot3)
			end

			slot4 = slot3.x
			slot5 = slot3.y

			slot0:_addToOpenList(slot0:_findSingle(slot4 - 1, slot5, uv0, uv1, slot3), slot2, slot0._closeList)
			slot0:_addToOpenList(slot0:_findSingle(slot4 + 1, slot5, uv1, uv0, slot3), slot2, slot0._closeList)
			slot0:_addToOpenList(slot0:_findSingle(slot4, slot5 + 1, uv2, uv3, slot3), slot2, slot0._closeList)
			slot0:_addToOpenList(slot0:_findSingle(slot4, slot5 - 1, uv3, uv2, slot3), slot2, slot0._closeList)
		end
	end
end

function slot0._addToOpenList(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 or not slot3 or slot3[slot1.id] then
		return
	end

	table.insert(slot2, slot1)
end

function slot0._findAround(slot0, slot1)
	slot2 = slot1.x
	slot3 = slot1.y

	slot0:_findSingle(slot2 - 1, slot3, uv0, uv1, slot1)
	slot0:_findSingle(slot2 + 1, slot3, uv1, uv0, slot1)
	slot0:_findSingle(slot2, slot3 + 1, uv2, uv3, slot1)
	slot0:_findSingle(slot2, slot3 - 1, uv3, uv2, slot1)
end

function slot0._findSingle(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 > 0 and slot1 <= DungeonPuzzleCircuitModel.constHeight and slot2 > 0 and slot2 <= DungeonPuzzleCircuitModel.constWidth then
		if not DungeonPuzzleCircuitModel.instance:getData(slot1, slot2) then
			return
		end

		return slot0:_getConnectRule(slot6)[slot3] and slot0:_getConnectRule(slot5)[slot4] and slot6
	end
end

function slot0._getConnectRule(slot0, slot1)
	return slot0._ruleConnect[slot1.value] or slot0._ruleTypeConnect[slot1.type]
end

return slot0
