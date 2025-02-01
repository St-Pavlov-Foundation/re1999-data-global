module("modules.logic.versionactivity1_8.dungeon.model.Activity157RepairGameModel", package.seeall)

slot0 = class("Activity157RepairGameModel", BaseModel)

function slot1(slot0, slot1)
	return slot0 < slot1
end

function slot0.onInit(slot0)
	slot0._startX = nil
	slot0._startY = nil
	slot0._mapPipeGridDict = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.setGameDataBeforeEnter(slot0, slot1)
	slot2 = Activity157Model.instance:getActId()

	slot0:setCurComponentId(slot1)
	slot0:initMapGrid()
	slot0:initPuzzle(Activity157Config.instance:getAct157RepairMapTilebase(slot2, slot1))
	slot0:initPuzzlePlace(Activity157Config.instance:getAct157RepairMapObjects(slot2, slot1))
end

function slot0.setCurComponentId(slot0, slot1)
	slot0._curComponentId = slot1
end

function slot0.resetGameData(slot0)
	slot0:setGameDataBeforeEnter(slot0:getCurComponentId())
end

function slot0.setGameClear(slot0, slot1)
	slot0._isGameClear = slot1
end

function slot0.initMapGrid(slot0)
	slot0._mapPipeGridDict = {}
	slot1, slot2 = slot0:getGameSize()
	slot3 = nil

	for slot7 = 1, slot1 do
		for slot11 = 1, slot2 do
			slot0._mapPipeGridDict[slot7] = slot0._mapPipeGridDict[slot7] or {}
			slot3 = Activity157PipeGridMo.New()

			slot3:init(slot7, slot11)

			slot0._mapPipeGridDict[slot7][slot11] = slot3
		end
	end

	slot0._startX = -slot1 * 0.5 - 0.5
	slot0._startY = -slot2 * 0.5 - 0.5
end

function slot0.initPuzzle(slot0, slot1)
	slot0._entryList = {}
	slot0._pathIndexList = {}
	slot0._pathIndexDict = {}
	slot0._pathNumListDict = {}
	slot0._placeDataDict = {}
	slot3, slot4 = slot0:getGameSize()

	if #string.split(slot1, ",") >= slot3 * slot4 then
		slot5 = 1

		for slot9 = 1, slot3 do
			for slot13 = 1, slot4 do
				slot15 = slot0._mapPipeGridDict[slot9][slot13]

				slot15:setParamStr(slot2[slot5])

				if slot15:isEntry() then
					table.insert(slot0._entryList, slot15)
					slot0:_initPathByMO(slot15)
				end

				if slot15.typeId == ArmPuzzlePipeEnum.type.zhanwei then
					slot0._placeDataDict[slot15] = slot14
					slot0._isHasPlaceOP = true
				end

				slot5 = slot5 + 1
			end
		end
	end

	for slot8, slot9 in pairs(slot0._pathNumListDict) do
		if slot9 and #slot9 > 1 then
			table.sort(slot9, uv0)
		end
	end
end

function slot0._initPathByMO(slot0, slot1)
	if slot1:isEntry() then
		if not slot0._pathIndexDict[slot1.pathIndex] then
			slot0._pathIndexDict[slot1.pathIndex] = true

			table.insert(slot0._pathIndexList, slot1.pathIndex)
		end

		if slot1.pathType == ArmPuzzlePipeEnum.PathType.Order then
			slot0._pathNumListDict[slot2] = slot0._pathNumListDict[slot1.pathIndex] or {}

			if tabletool.indexOf(slot0._pathNumListDict[slot2], slot1.numIndex) == nil then
				table.insert(slot0._pathNumListDict[slot2], slot3)
			end
		end
	end
end

function slot0.initPuzzlePlace(slot0, slot1)
	slot0._placeTypeDataDict = {
		[ArmPuzzlePipeEnum.type.straight] = 0,
		[ArmPuzzlePipeEnum.type.corner] = 0,
		[ArmPuzzlePipeEnum.type.t_shape] = 0
	}

	if GameUtil.splitString2(slot1, true, ",", "#") then
		for slot6, slot7 in ipairs(slot2) do
			if #slot7 >= 2 and slot0._placeTypeDataDict[slot7[1]] then
				slot0._isHasPlaceOP = true
				slot0._placeTypeDataDict[slot7[1]] = slot7[2]
			end
		end
	end
end

function slot0.resetEntryConnect(slot0)
	slot1, slot2 = slot0:getGameSize()

	for slot6 = 1, slot1 do
		for slot10 = 1, slot2 do
			slot0._mapPipeGridDict[slot6][slot10]:cleanEntrySet()
		end
	end
end

function slot0.getGameSize(slot0)
	slot1 = 0
	slot2 = 0

	if not string.nilorempty(Activity157Config.instance:getAct157Const(Activity157Model.instance:getActId(), Activity157Enum.ConstId.FactoryRepairGameMapSize)) then
		slot1 = tonumber(string.split(slot4, "#")[1]) or 0
		slot2 = tonumber(slot5[2]) or 0
	end

	return slot1, slot2
end

function slot0.getIndexByTouchPos(slot0, slot1, slot2, slot3, slot4)
	slot6 = math.floor((slot2 - (slot0._startY + 0.5) * slot4) / slot4)
	slot7, slot8 = slot0:getGameSize()

	if math.floor((slot1 - (slot0._startX + 0.5) * slot3) / slot3) >= 0 and slot5 < slot7 and slot6 >= 0 and slot6 < slot8 then
		return slot5 + 1, slot6 + 1
	end

	return -1, -1
end

function slot0.getRelativePosition(slot0, slot1, slot2, slot3, slot4)
	return (slot0._startX + slot1) * slot3, (slot0._startY + slot2) * slot4
end

function slot0.getEntryList(slot0)
	return slot0._entryList
end

function slot0.getData(slot0, slot1, slot2)
	return slot0._mapPipeGridDict[slot1][slot2]
end

function slot0.getIndexByMO(slot0, slot1)
	if slot1.pathType == ArmPuzzlePipeEnum.PathType.Order and slot0._pathNumListDict[slot1.pathIndex] then
		return tabletool.indexOf(slot0._pathNumListDict[slot1.pathIndex], slot1.numIndex) or -1
	end

	return 0
end

function slot0.getGameClear(slot0)
	return slot0._isGameClear
end

function slot0.getCurComponentId(slot0)
	return slot0._curComponentId
end

function slot0.isHasPlace(slot0)
	return slot0._isHasPlaceOP
end

function slot0.isHasPlaceByTypeId(slot0, slot1)
	if slot0._placeTypeDataDict and slot0._placeTypeDataDict[slot1] > 0 then
		return true
	end

	return false
end

function slot0.isPlaceByXY(slot0, slot1, slot2)
	if slot0:getPlaceStrByXY(slot1, slot2) then
		return true
	end

	return false
end

function slot0.getPlaceStrByXY(slot0, slot1, slot2)
	if slot0._placeDataDict and slot0:getData(slot1, slot2) then
		return slot0._placeDataDict[slot3]
	end
end

function slot0.setPlaceSelectXY(slot0, slot1, slot2)
	slot0._placeSelectX = slot1
	slot0._placeSelectY = slot2
end

function slot0.getPlaceSelectXY(slot0)
	return slot0._placeSelectX, slot0._placeSelectY
end

function slot0.isPlaceSelectXY(slot0, slot1, slot2)
	if slot1 == nil or slot2 == nil then
		return false
	end

	return slot0._placeSelectX == slot1 and slot0._placeSelectY == slot2
end

function slot0.getPlaceNum(slot0, slot1)
	slot2 = 0

	if slot0._placeTypeDataDict and slot0._placeTypeDataDict[slot1] then
		for slot6, slot7 in pairs(slot0._placeDataDict) do
			if slot6.typeId == slot1 then
				slot2 = slot0._placeTypeDataDict[slot1] - 1
			end
		end
	end

	return math.max(0, slot2)
end

slot0.instance = slot0.New()

return slot0
