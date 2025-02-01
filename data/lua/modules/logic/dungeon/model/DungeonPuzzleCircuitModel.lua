module("modules.logic.dungeon.model.DungeonPuzzleCircuitModel", package.seeall)

slot0 = class("DungeonPuzzleCircuitModel", BaseModel)
slot0.constWidth = 10
slot0.constHeight = 6

function slot0.reInit(slot0)
	slot0:release()
end

function slot0.release(slot0)
	slot0._cfgElement = nil
	slot0._gridDatas = nil
end

function slot0.getElementCo(slot0)
	return slot0._cfgElement
end

function slot0.getEditIndex(slot0)
	return slot0._editIndex
end

function slot0.setEditIndex(slot0, slot1)
	slot0._editIndex = slot1
end

function slot0.initByElementCo(slot0, slot1)
	slot0._cfgElement = slot1

	if slot0._cfgElement then
		slot0:initPuzzle(slot0._cfgElement.param)
	end
end

function slot0.initPuzzle(slot0, slot1)
	slot0._powerList = {}
	slot0._wrongList = {}
	slot0._capacitanceList = {}
	slot0._gridDatas = {}
	slot2 = string.split(slot1, ",")
	slot3 = 0
	slot4, slot5 = slot0:getGameSize()
	slot6 = 1

	for slot10 = 1, slot5 do
		for slot14 = 1, slot4 do
			slot16 = string.splitToNumber(slot2[slot6 + 1], "#")
			slot18 = slot16[2]

			if slot16[1] and slot17 > 0 then
				slot19 = slot0:_getMo(slot10, slot14)
				slot19.type = slot17
				slot19.value = slot18
				slot19.rawValue = slot18

				if slot17 == DungeonPuzzleCircuitEnum.type.power1 or slot17 == DungeonPuzzleCircuitEnum.type.power2 then
					table.insert(slot0._powerList, slot19)
				elseif slot17 == DungeonPuzzleCircuitEnum.type.wrong then
					table.insert(slot0._wrongList, slot19)
				elseif slot17 == DungeonPuzzleCircuitEnum.type.capacitance then
					table.insert(slot0._capacitanceList, slot19)
				end
			end
		end
	end
end

function slot0.getPowerList(slot0)
	return slot0._powerList
end

function slot0.getWrongList(slot0)
	return slot0._wrongList
end

function slot0.getCapacitanceList(slot0)
	return slot0._capacitanceList
end

function slot0._getMo(slot0, slot1, slot2)
	slot0._gridDatas[slot1] = slot0._gridDatas[slot1] or {}
	slot3 = DungeonPuzzleCircuitMO.New()

	slot3:init(slot1, slot2)

	slot0._gridDatas[slot1][slot2] = slot3

	return slot3
end

function slot0.debugData(slot0)
	slot1 = nil
	slot2, slot3 = slot0:getGameSize()

	for slot7 = 1, slot3 do
		for slot11 = 1, slot2 do
			slot13 = nil
			slot1 = string.format("%s%s", slot1 and slot1 .. "," or "", (slot0:getData(slot7, slot11) and slot12.type > 0 or string.format("%s", 0)) and (DungeonPuzzleCircuitEnum.type.straight > slot12.type or slot12.type > DungeonPuzzleCircuitEnum.type.t_shape or string.format("%s#%s", slot12.type, slot12.value)) and string.format("%s", slot12.type))
		end
	end

	print("data:", slot1)
end

function slot0.getData(slot0, slot1, slot2)
	return slot0._gridDatas[slot1] and slot3[slot2]
end

function slot0.getGameSize(slot0)
	return uv0.constWidth, uv0.constHeight
end

function slot0.getRelativePosition(slot0, slot1, slot2, slot3, slot4)
	return (slot2 - 1) * slot3, (slot1 - 1) * -slot4
end

function slot0.getIndexByTouchPos(slot0, slot1, slot2, slot3, slot4)
	slot5 = math.floor(math.abs(slot2 - 0.5 * slot4) / slot4)
	slot7, slot8 = slot0:getGameSize()

	if math.floor(math.abs(slot1 + 0.5 * slot3) / slot3) >= 0 and slot6 < slot7 and slot5 >= 0 and slot5 < slot8 then
		return slot5 + 1, slot6 + 1
	end

	return -1, -1
end

slot0.instance = slot0.New()

return slot0
