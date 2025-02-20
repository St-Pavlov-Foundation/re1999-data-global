module("modules.logic.room.model.map.RoomMapModel", package.seeall)

slot0 = class("RoomMapModel", BaseModel)

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
	slot0._revertCameraParam = nil
	slot0._buildingConfigParamDict = nil
	slot0._otherLineLevelDict = nil
	slot0._roomLevel = 1
	slot0._roomLeveling = false
end

function slot0.init(slot0)
	slot0:clear()
end

function slot0.updateRoomLevel(slot0, slot1)
	slot0._roomLevel = slot1
end

function slot0.getRoomLevel(slot0)
	return slot0._roomLevel
end

function slot0.saveCameraParam(slot0, slot1)
	slot0._revertCameraParam = LuaUtil.deepCopy(slot1)
end

function slot0.getCameraParam(slot0)
	return slot0._revertCameraParam
end

function slot0.clearCameraParam(slot0)
	slot0._revertCameraParam = nil
end

function slot0.getBuildingConfigParam(slot0, slot1)
	if not slot1 then
		return nil
	end

	slot0._buildingConfigParamDict = slot0._buildingConfigParamDict or {}

	if not slot0._buildingConfigParamDict[slot1] then
		if not RoomConfig.instance:getBuildingConfig(slot1) then
			return nil
		end

		slot2 = {
			onlyDirection = string.splitToNumber(slot4, "#")[3],
			pointList = {},
			crossloadResPointDic = {},
			crossloadResIdList = {},
			replaceBlockDic = {},
			replaceBlockCount = 0,
			canPlaceBlockDic = {},
			levelGroups = (not string.nilorempty(slot3.levelGroups) or {}) and string.splitToNumber(slot12, "#"),
			offset = slot13
		}

		if not string.nilorempty(slot3.center) then
			-- Nothing
		end

		if not string.nilorempty(slot3.costResource) then
			slot2.costResource = string.splitToNumber(slot5, "#")
		else
			slot2.costResource = {}
		end

		if string.nilorempty(slot3.center) then
			slot2.centerPoint = HexPoint(0, 0)
		else
			slot6 = string.splitToNumber(slot6, "#")
			slot2.centerPoint = HexPoint(slot6[1], slot6[2])
		end

		if not string.nilorempty(RoomConfig.instance:getBuildingAreaConfig(slot3.areaId).area) then
			for slot12, slot13 in ipairs(GameUtil.splitString2(slot7.area, true)) do
				table.insert(slot2.pointList, HexPoint(slot13[1], slot13[2]))
			end
		end

		if slot3.crossload and slot3.crossload ~= 0 and RoomBuildingEnum.Crossload[slot1] then
			for slot14, slot15 in ipairs(RoomBuildingEnum.Crossload[slot1].AnimStatus) do
				slot19 = slot15.resId

				table.insert(slot8, slot19)

				for slot19, slot20 in ipairs(slot15.replaceBlockRes) do
					if not slot9[slot20.x] then
						slot9[slot20.x] = {}
					end

					if not slot9[slot20.x][slot20.y] then
						slot9[slot20.x][slot20.y] = {}
					end

					slot9[slot20.x][slot20.y][slot15.resId] = slot20.resPionts
				end
			end
		end

		if not string.nilorempty(slot3.replaceBlock) then
			for slot15, slot16 in ipairs(GameUtil.splitString2(slot3.replaceBlock, true)) do
				if #slot16 >= 3 then
					if not slot10[slot16[1]] then
						slot10[slot16[1]] = {}
					end

					slot10[slot16[1]][slot16[2]] = slot16[3]
					slot2.replaceBlockCount = slot2.replaceBlockCount + 1
				else
					logError(string.format("【小屋】建筑表中id:%s的[replaceBlack]字段配置有误", slot1))
				end
			end
		end

		if not string.nilorempty(slot3.canPlaceBlock) then
			for slot16, slot17 in ipairs(GameUtil.splitString2(slot3.canPlaceBlock, true)) do
				if #slot17 >= 2 then
					if not slot11[slot17[1]] then
						slot11[slot17[1]] = {}
					end

					slot11[slot17[1]][slot17[2]] = true
				else
					logError(string.format("【小屋】建筑表中id:%s的[canPlaceBlock]字段配置有误", slot1))
				end
			end
		end

		slot13 = Vector3.zero

		if not string.nilorempty(slot3.offset) then
			slot13 = Vector3(string.splitToNumber(slot3.offset, "#")[1] or 0, slot14[2] or 0, slot14[3] or 0)
		end

		if #slot2.pointList > 1 and slot2.onlyDirection then
			logError("占多格的建筑配置了指定方向 约定没有这种情况")
		end

		slot0._buildingConfigParamDict[slot1] = slot2
	end

	return slot2
end

function slot0.getBuildingPointList(slot0, slot1, slot2)
	slot0._buildingRotatePointsDict = slot0._buildingRotatePointsDict or {}

	if not slot0._buildingRotatePointsDict[slot1] then
		if not slot0:getBuildingConfigParam(slot1) then
			return nil
		end

		slot0._buildingRotatePointsDict[slot1] = {}

		for slot8 = 0, 5 do
			slot3[slot8] = slot0:_rotatePointList(slot4.pointList, slot4.centerPoint, slot8)
		end
	end

	return slot3[RoomRotateHelper.getMod(slot2, 6)]
end

function slot0._rotatePointList(slot0, slot1, slot2, slot3)
	if slot3 == 0 then
		tabletool.addValues({}, slot1)
	else
		for slot8, slot9 in ipairs(slot1) do
			table.insert(slot4, (slot9 - slot2):Rotate(HexPoint.Zero, slot3, true))
		end
	end

	return slot4
end

function slot0.setOtherLineLevelDict(slot0, slot1)
	slot0._otherLineLevelDict = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot0._otherLineLevelDict[slot6.id] = slot6.level
		end
	end
end

function slot0.getOtherLineLevelDict(slot0)
	return slot0._otherLineLevelDict
end

function slot0.getAllBuildDegree(slot0, slot1)
	slot2 = {}
	slot4 = {
		count = 0,
		degree = 0
	}
	slot5 = 0

	for slot10, slot11 in ipairs(RoomMapBlockModel.instance:getFullBlockMOList()) do
		if slot11.blockState == RoomBlockEnum.BlockState.Map or slot11.blockState == RoomBlockEnum.BlockState.Revert or slot1 and slot11.blockState == RoomBlockEnum.BlockState.Temp then
			slot14 = RoomConfig.instance:getPackageConfigByBlockId(slot11.blockId) and slot13.blockBuildDegree or 0
			slot3 = 0 + RoomBlockEnum.InitBlockDegreeValue + slot14
			slot4.count = slot4.count + (slot13 and 1 or 0)
			slot4.degree = slot4.degree + slot14
		end
	end

	for slot11, slot12 in ipairs(RoomMapBuildingModel.instance:getList()) do
		if slot12.buildingState == RoomBuildingEnum.BuildingState.Map or slot12.buildingState == RoomBuildingEnum.BuildingState.Revert or slot1 and slot12.buildingState == RoomBuildingEnum.BuildingState.Temp then
			slot3 = slot3 + slot12.config.buildDegree
			slot2[slot12.buildingId] = slot2[slot12.buildingId] or {
				count = 0,
				config = slot12.config
			}
			slot2[slot12.buildingId].count = slot2[slot12.buildingId].count + 1
		end
	end

	slot8 = {}

	for slot12, slot13 in pairs(slot2) do
		table.insert(slot8, slot13)
	end

	return slot3, slot4, slot8
end

function slot0.setRoomLeveling(slot0, slot1)
	slot0._roomLeveling = slot1
end

function slot0.isRoomLeveling(slot0)
	return slot0._roomLeveling
end

slot0.instance = slot0.New()

return slot0
