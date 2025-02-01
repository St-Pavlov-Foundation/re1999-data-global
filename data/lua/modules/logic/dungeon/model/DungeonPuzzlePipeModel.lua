module("modules.logic.dungeon.model.DungeonPuzzlePipeModel", package.seeall)

slot0 = class("DungeonPuzzlePipeModel", BaseModel)
slot0.constWidth = 7
slot0.constHeight = 5
slot0.constEntry = 0

function slot0.reInit(slot0)
	slot0:release()
end

function slot0.release(slot0)
	slot0._cfgElement = nil
	slot0._startX = nil
	slot0._startY = nil
	slot0._gridDatas = nil
	slot0._isGameClear = false
	slot0._entryList = nil
end

function slot0.initByElementCo(slot0, slot1)
	slot0._cfgElement = slot1

	if slot0._cfgElement then
		slot0:initData()

		if not string.nilorempty(slot0._cfgElement.param) then
			slot0:initPuzzle(slot0._cfgElement.param)
		end
	end
end

function slot0.initData(slot0)
	slot0._gridDatas = {}
	slot1, slot2 = slot0:getGameSize()
	slot3 = nil

	for slot7 = 1, slot1 do
		for slot11 = 1, slot2 do
			slot0._gridDatas[slot7] = slot0._gridDatas[slot7] or {}
			slot3 = DungeonPuzzlePipeMO.New()

			slot3:init(slot7, slot11)

			slot0._gridDatas[slot7][slot11] = slot3
		end
	end

	slot0._startX = -slot1 * 0.5 - 0.5
	slot0._startY = -slot2 * 0.5 - 0.5
end

function slot0.initPuzzle(slot0, slot1)
	slot0._entryList = {}
	slot3 = 0
	slot4, slot5 = slot0:getGameSize()

	if #string.splitToNumber(slot1, ",") >= slot4 * slot5 then
		slot6 = 1

		for slot10 = 1, slot4 do
			for slot14 = 1, slot5 do
				slot15 = slot2[slot6]
				slot0._gridDatas[slot10][slot14].value = slot15

				if slot15 == uv0.constEntry then
					table.insert(slot0._entryList, slot16)
				end

				slot6 = slot6 + 1
			end
		end
	end
end

function slot0.resetEntryConnect(slot0)
	slot1, slot2 = slot0:getGameSize()

	for slot6 = 1, slot1 do
		for slot10 = 1, slot2 do
			slot0._gridDatas[slot6][slot10]:cleanEntrySet()
		end
	end
end

function slot0.setGameClear(slot0, slot1)
	slot0._isGameClear = slot1
end

function slot0.getData(slot0, slot1, slot2)
	return slot0._gridDatas[slot1][slot2]
end

function slot0.getGameSize(slot0)
	return uv0.constWidth, uv0.constHeight
end

function slot0.getGameClear(slot0)
	return slot0._isGameClear
end

function slot0.getEntryList(slot0)
	return slot0._entryList
end

function slot0.getElementCo(slot0)
	return slot0._cfgElement
end

function slot0.getRelativePosition(slot0, slot1, slot2, slot3, slot4)
	return (slot0._startX + slot1) * slot3, (slot0._startY + slot2) * slot4
end

function slot0.getIndexByTouchPos(slot0, slot1, slot2, slot3, slot4)
	slot6 = math.floor((slot2 - (slot0._startY + 0.5) * slot4) / slot4)
	slot7, slot8 = slot0:getGameSize()

	if math.floor((slot1 - (slot0._startX + 0.5) * slot3) / slot3) >= 0 and slot5 < slot7 and slot6 >= 0 and slot6 < slot8 then
		return slot5 + 1, slot6 + 1
	end

	return -1, -1
end

slot0.instance = slot0.New()

return slot0
