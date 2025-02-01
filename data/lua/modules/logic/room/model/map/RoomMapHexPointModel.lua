module("modules.logic.room.model.map.RoomMapHexPointModel", package.seeall)

slot0 = class("RoomMapHexPointModel", BaseModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._rangeHexPointsDict = {}
	slot0._zeroList = {}
	slot0._hexPointDict = {}
	slot0._hexPointList = {}
	slot0._indexDict = {}
	slot0._rangesHexPointsDic = {}
	slot0._outIndex2HexDict = {}
end

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
end

function slot0.init(slot0)
	slot2 = HexPoint(0, 0)
	slot0._zeroList = {
		slot2
	}
	slot0._hexPointList = {
		slot2
	}
	slot3 = slot0._rangesHexPointsDic

	for slot7 = 1, CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius) or 10 do
		if not slot3[slot7] then
			slot3[slot7] = slot2:getOnRanges(slot7)
		end

		tabletool.addValues(slot0._hexPointList, slot8)
	end

	slot0._hexPointDict = {}
	slot0._indexDict = {}

	for slot7, slot8 in ipairs(slot0._hexPointList) do
		slot0:_add2KeyValue(slot0._hexPointDict, slot8.x, slot8.y, slot8)
		slot0:_add2KeyValue(slot0._indexDict, slot8.x, slot8.y, slot7)
	end
end

function slot0.getIndex(slot0, slot1, slot2)
	if not slot0:_get2KeyValue(slot0._indexDict, slot1, slot2) then
		slot0:_add2KeyValue(slot0._indexDict, slot1, slot2, HexMath.hexXYToSpiralIndex(slot1, slot2))
	end

	return slot3
end

function slot0.getHexPoint(slot0, slot1, slot2)
	if not slot0:_get2KeyValue(slot0._hexPointDict, slot1, slot2) then
		slot0:_add2KeyValue(slot0._hexPointDict, slot1, slot2, HexPoint(slot1, slot2))
	end

	return slot3
end

function slot0.getHexPointByIndex(slot0, slot1)
	return slot0._hexPointList[slot1]
end

function slot0.getHexPointList(slot0)
	return slot0._hexPointList
end

function slot0.getOnRangeHexPointList(slot0, slot1)
	if slot1 < 1 then
		return slot0._zeroList
	end

	return slot0._rangesHexPointsDic[slot1]
end

function slot0._add2KeyValue(slot0, slot1, slot2, slot3, slot4)
	slot1[slot2] = slot1[slot2] or {}
	slot1[slot2][slot3] = slot4
end

function slot0._get2KeyValue(slot0, slot1, slot2, slot3)
	return slot1[slot2] and slot4[slot3]
end

slot0.instance = slot0.New()

return slot0
