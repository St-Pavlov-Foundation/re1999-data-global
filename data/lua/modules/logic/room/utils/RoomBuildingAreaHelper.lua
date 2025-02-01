module("modules.logic.room.utils.RoomBuildingAreaHelper", package.seeall)

return {
	checkBuildingArea = function (slot0, slot1, slot2)
		if RoomConfig.instance:getBuildingConfig(slot0) and RoomBuildingEnum.BuildingArea[slot3.buildingType] and slot3.isAreaMainBuilding == false then
			if not RoomMapBuildingAreaModel.instance:getAreaMOByBType(slot3.buildingType) then
				return false, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.NoAreaMainBuilding
			end

			if RoomMapModel.instance:getBuildingPointList(slot0, slot2) then
				slot6 = nil

				for slot10 = 1, #slot5 do
					slot6 = slot5[slot10]

					if slot4:isInRangesByHexXY(slot6.x + slot1.x, slot6.y + slot1.y) then
						return true
					end
				end
			end

			return false, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.OutSizeAreaBuilding
		end

		return true
	end,
	isBuildingArea = function (slot0)
		if RoomConfig.instance:getBuildingConfig(slot0) and RoomBuildingEnum.BuildingArea[slot1.buildingType] then
			return true
		end

		return false
	end,
	isAreaMainBuilding = function (slot0)
		if RoomConfig.instance:getBuildingConfig(slot0) and RoomBuildingEnum.BuildingArea[slot1.buildingType] and slot1.isAreaMainBuilding == true then
			return true
		end

		return false
	end,
	formatBuildingMOListNameStr = function (slot0)
		if not slot0 or #slot0 < 1 then
			return ""
		end

		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			if not slot1[slot6.buildingId] then
				slot1[slot7] = 1
			else
				slot1[slot7] = slot1[slot7] + 1
			end
		end

		slot2 = {}

		for slot6, slot7 in pairs(slot1) do
			if RoomConfig.instance:getBuildingConfig(slot6) then
				if slot7 == 1 then
					table.insert(slot2, slot8.name)
				elseif slot7 > 1 then
					table.insert(slot2, string.format("%s * %s", slot8.name, slot7))
				end
			end
		end

		return table.concat(slot2, luaLang("room_levelup_init_and1"))
	end,
	findTempOutBuildingMOList = function (slot0)
		if not RoomMapBuildingAreaModel.instance:getTempAreaMO() then
			return nil
		end

		for slot8 = 1, #RoomMapBuildingModel.instance:getBuildingMOList() do
			if slot4[slot8] and slot9:checkSameType(slot1.buildingType) and not slot9:isAreaMainBuilding() and (slot0 == true or not slot1:isInRangesByHexPoint(slot9.hexPoint)) then
				table.insert(slot2 or {}, slot9)
			end
		end

		return slot2
	end,
	isHasWorkingByType = function (slot0)
		if not RoomMapBuildingAreaModel.instance:getAreaMOByBType(slot0) then
			return false
		end

		for slot6 = 1, #slot1:getBuildingMOList(true) do
			if slot2[slot6]:getManufactureState() ~= RoomManufactureEnum.SlotState.Stop then
				return true
			end
		end

		return false
	end,
	findTempOutTransportMOList = function (slot0)
		if not RoomMapBuildingAreaModel.instance:getTempAreaMO() then
			return nil
		end

		slot3 = slot1.buildingType

		for slot8 = 1, #RoomMapTransportPathModel.instance:getTransportPathMOList() do
			if slot4[slot8] and (slot9.fromType == slot3 and (slot0 == true or not slot1:isInRangesByHexPoint(slot9:getFirstHexPoint())) or slot9.toType == slot3 and (slot0 == true or not slot1:isInRangesByHexPoint(slot9:getLastHexPoint()))) then
				table.insert(slot2 or {}, slot9)
			end
		end

		return slot2
	end,
	logTestAreaMO = function (slot0)
		if not slot0 then
			return
		end

		if not slot0:getMainBuildingCfg() then
			return
		end

		slot4 = slot0.mainBuildingMO.hexPoint

		for slot8, slot9 in ipairs(slot0:getRangesHexPointList() or {}) do
			if slot9 then
				slot3 = string.format("%s (%s,%s)", string.format("%s (%s,%s)  | ", string.format("name:%s id:%s -->", slot1.name, slot1.id), slot4.x, slot4.y), slot9.x, slot9.y)
			end
		end

		logNormal(slot3)
	end
}
