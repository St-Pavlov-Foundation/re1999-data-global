module("modules.logic.room.utils.RoomBlockHelper", package.seeall)

local var_0_0 = {}

function var_0_0.getNearBlockEntity(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = {}
	local var_1_1 = GameSceneMgr.instance:getCurScene()
	local var_1_2 = arg_1_0 and var_0_0._getMapEmptyBlockMO or var_0_0._getMapBlockMO
	local var_1_3 = arg_1_0 and SceneTag.RoomEmptyBlock or SceneTag.RoomMapBlock

	for iter_1_0 = arg_1_3 and 1 or 0, 6 do
		local var_1_4 = HexPoint.directions[iter_1_0]
		local var_1_5 = var_1_2(var_1_4.x + arg_1_1.x, var_1_4.y + arg_1_1.y, arg_1_4)

		if var_1_5 then
			local var_1_6 = var_1_1.mapmgr:getBlockEntity(var_1_5.id, var_1_3)

			if var_1_6 then
				table.insert(var_1_0, var_1_6)
			end
		end
	end

	return var_1_0
end

function var_0_0.getNearBlockEntityByBuilding(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {}
	local var_2_1 = RoomResourceModel.instance
	local var_2_2 = GameSceneMgr.instance:getCurScene()
	local var_2_3 = RoomBuildingHelper.getOccupyDict(arg_2_1, arg_2_2, arg_2_3)
	local var_2_4 = arg_2_0 and var_0_0._getMapEmptyBlockMO or var_0_0._getMapBlockMO
	local var_2_5 = arg_2_0 and SceneTag.RoomEmptyBlock or SceneTag.RoomMapBlock
	local var_2_6 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_3) do
		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			for iter_2_4 = 0, 6 do
				local var_2_7 = HexPoint.directions[iter_2_4]
				local var_2_8 = iter_2_0 + var_2_7.x
				local var_2_9 = iter_2_2 + var_2_7.y
				local var_2_10 = var_2_1:getIndexByXY(var_2_8, var_2_9)

				if not var_2_6[var_2_10] then
					local var_2_11 = var_2_4(var_2_8, var_2_9)
					local var_2_12 = var_2_11 and var_2_2.mapmgr:getBlockEntity(var_2_11.id, var_2_5)

					if var_2_12 then
						var_2_6[var_2_10] = true

						table.insert(var_2_0, var_2_12)
					end
				end
			end
		end
	end

	return var_2_0
end

function var_0_0.getBlockMOListByPlaceBuilding(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = RoomMapModel.instance:getBuildingConfigParam(arg_3_0)

	if not var_3_0 or var_3_0.replaceBlockCount and var_3_0.replaceBlockCount < 1 then
		return arg_3_3, arg_3_4
	end

	arg_3_3 = arg_3_3 or {}
	arg_3_4 = {} or {}

	local var_3_1 = RoomResourceModel.instance
	local var_3_2 = GameSceneMgr.instance:getCurScene()
	local var_3_3 = RoomBuildingHelper.getOccupyDict(arg_3_0, arg_3_1, arg_3_2)
	local var_3_4 = var_0_0._getMapBlockMO

	for iter_3_0, iter_3_1 in pairs(var_3_3) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			for iter_3_4 = 0, 6 do
				local var_3_5 = HexPoint.directions[iter_3_4]
				local var_3_6 = iter_3_0 + var_3_5.x
				local var_3_7 = var_3_5.y + iter_3_2
				local var_3_8 = var_3_1:getIndexByXY(var_3_6, var_3_7)

				if not arg_3_4[var_3_8] then
					local var_3_9 = var_3_4(var_3_6, var_3_7, iter_3_4 ~= 0)

					if var_3_9 then
						arg_3_4[var_3_8] = true

						table.insert(arg_3_3, var_3_9)
					end
				end
			end
		end
	end

	return arg_3_3, arg_3_4
end

function var_0_0._getMapEmptyBlockMO(arg_4_0, arg_4_1)
	local var_4_0 = RoomMapBlockModel.instance:getBlockMO(arg_4_0, arg_4_1)

	if var_4_0 == nil then
		return
	end

	if var_4_0.blockState ~= RoomBlockEnum.BlockState.Water then
		return
	end

	return var_4_0
end

function var_0_0._getMapBlockMO(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = RoomMapBlockModel.instance:getBlockMO(arg_5_0, arg_5_1)

	if var_5_0 == nil then
		return
	end

	if var_5_0.blockState == RoomBlockEnum.BlockState.Water then
		return
	end

	if arg_5_2 and var_5_0:getRiverCount() < 6 then
		return
	end

	return var_5_0
end

function var_0_0.refreshBlockEntity(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0 == nil or #arg_6_0 < 1 then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		local var_6_0 = iter_6_1[arg_6_1]

		if var_6_0 then
			if arg_6_2 then
				var_6_0(iter_6_1, unpack(arg_6_2))
			else
				var_6_0(iter_6_1)
			end
		end
	end
end

function var_0_0.refreshBlockResourceType(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		local var_7_0 = RoomMapBlockModel.instance:getFullBlockMOById(iter_7_1.id)

		if var_7_0 then
			var_7_0:refreshRiver()
		end
	end
end

function var_0_0.getMapResourceId(arg_8_0)
	if arg_8_0.blockState == RoomBlockEnum.BlockState.Water then
		return RoomResourceEnum.ResourceId.Empty
	end

	if arg_8_0.blockState == RoomBlockEnum.BlockState.Fake then
		return RoomResourceEnum.ResourceId.None
	end

	local var_8_0 = RoomMapBuildingModel.instance:getAllOccupyDict()
	local var_8_1 = var_8_0[arg_8_0.hexPoint.x] and var_8_0[arg_8_0.hexPoint.x][arg_8_0.hexPoint.y]
	local var_8_2 = var_8_1 and var_8_1.buildingUid
	local var_8_3 = var_8_2 and RoomMapBuildingModel.instance:getBuildingMOById(var_8_2)
	local var_8_4 = var_8_3 and RoomBuildingHelper.getCostResourceId(var_8_3.buildingId)

	if var_8_4 and var_8_4 ~= RoomResourceEnum.ResourceId.None then
		return var_8_4
	end

	local var_8_5 = {}
	local var_8_6 = {}

	for iter_8_0 = 0, 6 do
		local var_8_7 = ResourcePoint(arg_8_0.hexPoint, iter_8_0)
		local var_8_8 = RoomResourceModel.instance:getResourceArea(var_8_7)

		if var_8_8 and not var_8_6[var_8_8.index] then
			var_8_6[var_8_8.index] = true
			var_8_5[var_8_8.resourceId] = var_8_5[var_8_8.resourceId] or {}
			var_8_5[var_8_8.resourceId].linkOut = var_8_5[var_8_8.resourceId].linkOut or var_8_8.linkOut
			var_8_5[var_8_8.resourceId].isCenter = var_8_5[var_8_8.resourceId].isCenter or iter_8_0 == 0
		end
	end

	local var_8_9 = RoomResourceEnum.ResourceId.None
	local var_8_10

	for iter_8_1, iter_8_2 in pairs(var_8_5) do
		if not var_8_10 then
			var_8_10 = iter_8_2
			var_8_9 = iter_8_1
		elseif not var_8_10.linkOut and iter_8_2.linkOut then
			var_8_10 = iter_8_2
			var_8_9 = iter_8_1
		elseif var_8_10.linkOut and not iter_8_2.linkOut then
			-- block empty
		elseif not var_8_10.linkOut and not iter_8_2.linkOut and iter_8_2.isCenter then
			var_8_10 = iter_8_2
			var_8_9 = iter_8_1
		end
	end

	return var_8_9
end

function var_0_0.getResourcePath(arg_9_0, arg_9_1)
	if arg_9_0:getResourceId(arg_9_1, true, true) == RoomResourceEnum.ResourceId.River then
		local var_9_0, var_9_1, var_9_2 = arg_9_0:getResourceTypeRiver(arg_9_1, true)

		if not var_9_0 then
			return nil
		end

		var_9_1 = var_9_1 or arg_9_0:getDefineBlockType()

		local var_9_3 = arg_9_0:getDefineWaterType()
		local var_9_4, var_9_5 = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, RoomRiverEnum.LakeBlockType[var_9_0], var_9_3)
		local var_9_6, var_9_7 = RoomResHelper.getMapRiverFloorResPath(RoomRiverEnum.LakeFloorType[var_9_0], var_9_1)
		local var_9_8
		local var_9_9

		if var_9_2 and RoomRiverEnum.LakeFloorBType[var_9_0] then
			var_9_8, var_9_9 = RoomResHelper.getMapRiverFloorResPath(RoomRiverEnum.LakeFloorBType[var_9_0], var_9_2)
		end

		return var_9_4, var_9_6, var_9_8, var_9_5, var_9_7, var_9_9
	end

	return nil
end

function var_0_0.getCenterResourcePoint(arg_10_0)
	if not arg_10_0 or #arg_10_0 <= 0 then
		return nil
	end

	if #arg_10_0 <= 2 then
		return arg_10_0[1]
	end

	local var_10_0 = HexPoint(0, 0)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0) do
		var_10_0 = var_10_0 + (HexPoint(iter_10_1.x, iter_10_1.y) + HexPoint.directions[iter_10_1.direction] * 0.4)
	end

	local var_10_1 = var_10_0.x / #arg_10_0
	local var_10_2 = var_10_0.y / #arg_10_0
	local var_10_3 = HexPoint(var_10_1, var_10_2)
	local var_10_4 = 0
	local var_10_5

	for iter_10_2, iter_10_3 in ipairs(arg_10_0) do
		local var_10_6 = HexMath.resourcePointToHexPoint(iter_10_3, 0.33)
		local var_10_7 = HexPoint.DirectDistance(var_10_6, var_10_3)

		if not var_10_5 or var_10_7 < var_10_4 then
			var_10_5 = iter_10_3
			var_10_4 = var_10_7
		end
	end

	return var_10_5
end

function var_0_0.findSelectInvenBlockSameResId()
	local var_11_0 = RoomInventoryBlockModel.instance
	local var_11_1 = var_11_0:getSelectResId()

	if not var_11_1 then
		return nil
	end

	local var_11_2 = var_11_0:getCurPackageMO()

	if not var_11_2 then
		return nil
	end

	local var_11_3 = var_11_0:findFristUnUseBlockMO(var_11_2.packageId, var_11_1)

	return var_11_3 and var_11_3.id or nil
end

function var_0_0.isInBoundary(arg_12_0)
	return CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius) >= math.max(math.abs(arg_12_0.x), math.abs(arg_12_0.y), math.abs(arg_12_0.z))
end

function var_0_0.isCanPlaceBlock()
	if RoomController.instance:isEditMode() then
		local var_13_0 = RoomMapBlockModel.instance:isBackMore()
		local var_13_1 = RoomBuildingController.instance:isBuildingListShow()
		local var_13_2 = RoomWaterReformModel.instance:isWaterReform()
		local var_13_3 = RoomTransportController.instance:isTransportPathShow()

		if not var_13_0 and not var_13_1 and not var_13_2 and not var_13_3 then
			return true
		end
	elseif RoomController.instance:isDebugMode() and RoomDebugController.instance:isDebugPlaceListShow() then
		return true
	end

	return false
end

return var_0_0
