module("modules.logic.room.utils.RoomBlockHelper", package.seeall)

return {
	getNearBlockEntity = function (slot0, slot1, slot2, slot3, slot4)
		slot5 = {}

		for slot13 = slot3 and 1 or 0, 6 do
			slot14 = HexPoint.directions[slot13]

			if slot0 and uv0._getMapEmptyBlockMO or uv0._getMapBlockMO(slot14.x + slot1.x, slot14.y + slot1.y, slot4) and GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(slot15.id, slot0 and SceneTag.RoomEmptyBlock or SceneTag.RoomMapBlock) then
				table.insert(slot5, slot16)
			end
		end

		return slot5
	end,
	getNearBlockEntityByBuilding = function (slot0, slot1, slot2, slot3)
		slot4 = {}
		slot5 = RoomResourceModel.instance
		slot6 = GameSceneMgr.instance:getCurScene()
		slot8 = slot0 and uv0._getMapEmptyBlockMO or uv0._getMapBlockMO
		slot9 = slot0 and SceneTag.RoomEmptyBlock or SceneTag.RoomMapBlock
		slot10 = {}

		for slot14, slot15 in pairs(RoomBuildingHelper.getOccupyDict(slot1, slot2, slot3)) do
			for slot19, slot20 in pairs(slot15) do
				for slot24 = 0, 6 do
					slot25 = HexPoint.directions[slot24]

					if not slot10[slot5:getIndexByXY(slot14 + slot25.x, slot19 + slot25.y)] and slot8(slot26, slot27) and slot6.mapmgr:getBlockEntity(slot29.id, slot9) then
						slot10[slot28] = true

						table.insert(slot4, slot30)
					end
				end
			end
		end

		return slot4
	end,
	getBlockMOListByPlaceBuilding = function (slot0, slot1, slot2, slot3, slot4)
		if not RoomMapModel.instance:getBuildingConfigParam(slot0) or slot5.replaceBlockCount and slot5.replaceBlockCount < 1 then
			return slot3, slot4
		end

		slot3 = slot3 or {}
		slot4 = {} or {}
		slot6 = RoomResourceModel.instance
		slot7 = GameSceneMgr.instance:getCurScene()
		slot9 = uv0._getMapBlockMO

		for slot13, slot14 in pairs(RoomBuildingHelper.getOccupyDict(slot0, slot1, slot2)) do
			for slot18, slot19 in pairs(slot14) do
				for slot23 = 0, 6 do
					slot24 = HexPoint.directions[slot23]

					if not slot4[slot6:getIndexByXY(slot13 + slot24.x, slot24.y + slot18)] and slot9(slot25, slot26, slot23 ~= 0) then
						slot4[slot27] = true

						table.insert(slot3, slot28)
					end
				end
			end
		end

		return slot3, slot4
	end,
	_getMapEmptyBlockMO = function (slot0, slot1)
		if RoomMapBlockModel.instance:getBlockMO(slot0, slot1) == nil then
			return
		end

		if slot2.blockState ~= RoomBlockEnum.BlockState.Water then
			return
		end

		return slot2
	end,
	_getMapBlockMO = function (slot0, slot1, slot2)
		if RoomMapBlockModel.instance:getBlockMO(slot0, slot1) == nil then
			return
		end

		if slot3.blockState == RoomBlockEnum.BlockState.Water then
			return
		end

		if slot2 and slot3:getRiverCount() < 6 then
			return
		end

		return slot3
	end,
	refreshBlockEntity = function (slot0, slot1, slot2)
		if slot0 == nil or #slot0 < 1 then
			return
		end

		for slot6, slot7 in ipairs(slot0) do
			if slot7[slot1] then
				if slot2 then
					slot8(slot7, unpack(slot2))
				else
					slot8(slot7)
				end
			end
		end
	end,
	refreshBlockResourceType = function (slot0)
		for slot4, slot5 in ipairs(slot0) do
			if RoomMapBlockModel.instance:getFullBlockMOById(slot5.id) then
				slot6:refreshRiver()
			end
		end
	end,
	getMapResourceId = function (slot0)
		if slot0.blockState == RoomBlockEnum.BlockState.Water then
			return RoomResourceEnum.ResourceId.Empty
		end

		if slot0.blockState == RoomBlockEnum.BlockState.Fake then
			return RoomResourceEnum.ResourceId.None
		end

		slot2 = RoomMapBuildingModel.instance:getAllOccupyDict()[slot0.hexPoint.x] and slot1[slot0.hexPoint.x][slot0.hexPoint.y]
		slot3 = slot2 and slot2.buildingUid
		slot4 = slot3 and RoomMapBuildingModel.instance:getBuildingMOById(slot3)

		if slot4 and RoomBuildingHelper.getCostResourceId(slot4.buildingId) and slot5 ~= RoomResourceEnum.ResourceId.None then
			return slot5
		end

		slot6 = {}
		slot7 = {}

		for slot11 = 0, 6 do
			if RoomResourceModel.instance:getResourceArea(ResourcePoint(slot0.hexPoint, slot11)) and not slot7[slot13.index] then
				slot7[slot13.index] = true
				slot6[slot13.resourceId] = slot6[slot13.resourceId] or {}
				slot6[slot13.resourceId].linkOut = slot6[slot13.resourceId].linkOut or slot13.linkOut
				slot6[slot13.resourceId].isCenter = slot6[slot13.resourceId].isCenter or slot11 == 0
			end
		end

		slot8 = RoomResourceEnum.ResourceId.None

		for slot13, slot14 in pairs(slot6) do
			if not nil then
				slot9 = slot14
				slot8 = slot13
			elseif not slot9.linkOut and slot14.linkOut then
				slot9 = slot14
				slot8 = slot13
			elseif slot9.linkOut and not slot14.linkOut then
				-- Nothing
			elseif not slot9.linkOut and not slot14.linkOut and slot14.isCenter then
				slot9 = slot14
				slot8 = slot13
			end
		end

		return slot8
	end,
	getResourcePath = function (slot0, slot1)
		if slot0:getResourceId(slot1, true, true) == RoomResourceEnum.ResourceId.River then
			slot3, slot4, slot5 = slot0:getResourceTypeRiver(slot1, true)

			if not slot3 then
				return nil
			end

			slot7, slot8 = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, RoomRiverEnum.LakeBlockType[slot3], slot0:getDefineWaterType())
			slot9, slot10 = RoomResHelper.getMapRiverFloorResPath(RoomRiverEnum.LakeFloorType[slot3], slot4 or slot0:getDefineBlockType())
			slot11, slot12 = nil

			if slot5 and RoomRiverEnum.LakeFloorBType[slot3] then
				slot11, slot12 = RoomResHelper.getMapRiverFloorResPath(RoomRiverEnum.LakeFloorBType[slot3], slot5)
			end

			return slot7, slot9, slot11, slot8, slot10, slot12
		end

		return nil
	end,
	getCenterResourcePoint = function (slot0)
		if not slot0 or #slot0 <= 0 then
			return nil
		end

		if #slot0 <= 2 then
			return slot0[1]
		end

		for slot5, slot6 in ipairs(slot0) do
			slot1 = HexPoint(0, 0) + HexPoint(slot6.x, slot6.y) + HexPoint.directions[slot6.direction] * 0.4
		end

		for slot9, slot10 in ipairs(slot0) do
			slot12 = HexPoint.DirectDistance(HexMath.resourcePointToHexPoint(slot10, 0.33), HexPoint(slot1.x / #slot0, slot1.y / #slot0))

			if not nil or slot12 < 0 then
				slot5 = slot10
				slot4 = slot12
			end
		end

		return slot5
	end,
	findSelectInvenBlockSameResId = function ()
		if not RoomInventoryBlockModel.instance:getSelectResId() then
			return nil
		end

		if not slot0:getCurPackageMO() then
			return nil
		end

		return slot0:findFristUnUseBlockMO(slot2.packageId, slot1) and slot3.id or nil
	end,
	isInBoundary = function (slot0)
		return math.max(math.abs(slot0.x), math.abs(slot0.y), math.abs(slot0.z)) <= CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius)
	end,
	isCanPlaceBlock = function ()
		if RoomController.instance:isEditMode() then
			if not RoomMapBlockModel.instance:isBackMore() and not RoomBuildingController.instance:isBuildingListShow() and not RoomWaterReformModel.instance:isWaterReform() and not RoomTransportController.instance:isTransportPathShow() then
				return true
			end
		elseif RoomController.instance:isDebugMode() and RoomDebugController.instance:isDebugPlaceListShow() then
			return true
		end

		return false
	end
}
