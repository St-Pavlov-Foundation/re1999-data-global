module("modules.logic.room.model.map.RoomBlockMO", package.seeall)

local var_0_0 = pureTable("RoomBlockMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.blockId
	arg_1_0.blockId = arg_1_1.blockId
	arg_1_0.defineId = arg_1_1.defineId
	arg_1_0.packageId = arg_1_1.packageId
	arg_1_0.packageOrder = arg_1_1.packageOrder
	arg_1_0.mainRes = arg_1_1.mainRes
	arg_1_0.rotate = arg_1_1.rotate or 0
	arg_1_0.blockState = arg_1_1.blockState or RoomBlockEnum.BlockState.Inventory
	arg_1_0.ownType = arg_1_1.ownType or RoomBlockEnum.OwnType.Package
	arg_1_0.useState = arg_1_1.useState or RoomBlockEnum.UseState.Normal
	arg_1_0.blockCleanType = arg_1_1.blockCleanType or 0

	if arg_1_0:isInMap() then
		arg_1_0.hexPoint = HexPoint(arg_1_1.x or 0, arg_1_1.y or 0)
	end

	if arg_1_0.blockState == RoomBlockEnum.BlockState.Water then
		arg_1_0.distanceStyle = arg_1_1.distanceStyle
	end

	arg_1_0._riverTypeDict = nil
	arg_1_0.replaceDefineId = nil
	arg_1_0.replaceRotate = nil

	arg_1_0:setWaterType(arg_1_1.waterType or -1)
	arg_1_0:setTempWaterType()

	arg_1_0._defineWaterType = arg_1_1.defineWaterType
	arg_1_0._resourceListDic = {}
	arg_1_0._isHasLightDic = {}
end

function var_0_0.getMainRes(arg_2_0)
	return arg_2_0.mainRes
end

function var_0_0.getBlockDefineCfg(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getDefineId(arg_3_1)

	if not arg_3_0._blockDefineCfg or arg_3_0._blockDefineCfg.defineId ~= var_3_0 then
		arg_3_0._blockDefineCfg = RoomConfig.instance:getBlockDefineConfig(var_3_0)
	end

	return arg_3_0._blockDefineCfg
end

function var_0_0.getDefineBlockType(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getBlockDefineCfg(arg_4_1)

	return var_4_0 and var_4_0.blockType or 0
end

function var_0_0.getDefineId(arg_5_0, arg_5_1)
	return arg_5_1 and arg_5_0.defineId or arg_5_0.replaceDefineId or arg_5_0.defineId
end

function var_0_0.getRotate(arg_6_0, arg_6_1)
	return arg_6_1 and arg_6_0.rotate or arg_6_0.replaceDefineId and arg_6_0.replaceRotate or arg_6_0.rotate
end

function var_0_0.getDefineWaterType(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 and not arg_7_2 and arg_7_0:isInMapBlock() then
		local var_7_0 = arg_7_0:getTempWaterType()

		if var_7_0 and var_7_0 ~= -1 then
			return var_7_0
		end
	end

	return (arg_7_0:getOriginalWaterType(arg_7_2))
end

function var_0_0.getTempWaterType(arg_8_0)
	return arg_8_0.tempWaterType
end

function var_0_0.getWaterType(arg_9_0)
	return arg_9_0.waterType
end

function var_0_0.getOriginalWaterType(arg_10_0, arg_10_1)
	if not arg_10_1 and arg_10_0:isInMapBlock() then
		local var_10_0 = arg_10_0:getWaterType()

		if var_10_0 and var_10_0 ~= -1 then
			return var_10_0
		end
	end

	local var_10_1 = arg_10_0._defineWaterType

	if not var_10_1 then
		local var_10_2 = arg_10_0:getBlockDefineCfg(arg_10_1)

		var_10_1 = var_10_2 and var_10_2.waterType or 0
	end

	return var_10_1
end

function var_0_0.getDefineWaterAreaType(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getBlockDefineCfg(arg_11_1)

	return var_11_0 and var_11_0.waterAreaType or 0
end

function var_0_0.isFullWater(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getRiverCount(arg_12_1)

	if var_12_0 < 1 and arg_12_0:getResourceCenter(arg_12_1) ~= RoomResourceEnum.ResourceId.River then
		return false
	end

	if var_12_0 >= 6 then
		return true
	end

	return arg_12_0:isHalfLakeWater(arg_12_1)
end

function var_0_0.isHalfLakeWater(arg_13_0, arg_13_1)
	return arg_13_0:getDefineWaterAreaType(arg_13_1) == 1
end

function var_0_0.getResourceList(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getBlockDefineCfg(arg_14_1)

	if not var_14_0 then
		local var_14_1 = -1000

		arg_14_0._isHasLightDic[var_14_1] = false

		return RoomResourceEnum.Block.NoneList
	end

	if not arg_14_0._resourceListDic[arg_14_0._blockDefineCfg.defineId] then
		local var_14_2 = {}
		local var_14_3 = false

		for iter_14_0 = 1, 6 do
			local var_14_4 = var_14_0.resourceIds[iter_14_0 + 1]

			table.insert(var_14_2, var_14_4)

			if not var_14_3 and RoomConfig.instance:isLightByResourceId(var_14_4) then
				var_14_3 = true
			end
		end

		arg_14_0._isHasLightDic[arg_14_0._blockDefineCfg.defineId] = var_14_3
		arg_14_0._resourceListDic[arg_14_0._blockDefineCfg.defineId] = var_14_2
	end

	if arg_14_0:getUseState() == RoomBlockEnum.UseState.TransportPath then
		if var_14_0.resIdCountDict[RoomResourceEnum.ResourceId.River] then
			return RoomResourceEnum.Block.RiverList
		end

		return RoomResourceEnum.Block.NoneList
	end

	return arg_14_0._resourceListDic[arg_14_0._blockDefineCfg.defineId]
end

function var_0_0.isHasLight(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._isHasLightDic[arg_15_0:getDefineId(arg_15_1)]

	if var_15_0 == nil then
		arg_15_0:getResourceList(arg_15_1)

		return arg_15_0._isHasLightDic[arg_15_0:getDefineId(arg_15_1)]
	end

	return var_15_0
end

function var_0_0.getResourceCenter(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getBlockDefineCfg(arg_16_1)

	if not var_16_0 then
		return RoomResourceEnum.ResourceId.None
	end

	if arg_16_0:getUseState() == RoomBlockEnum.UseState.TransportPath then
		if var_16_0.resIdCountDict[RoomResourceEnum.ResourceId.River] then
			return RoomResourceEnum.ResourceId.River
		end

		return RoomResourceEnum.ResourceId.None
	end

	return var_16_0.resourceIds[1]
end

function var_0_0.isInMap(arg_17_0)
	return arg_17_0.blockState == RoomBlockEnum.BlockState.Map or arg_17_0.blockState == RoomBlockEnum.BlockState.Water or arg_17_0.blockState == RoomBlockEnum.BlockState.Temp
end

function var_0_0.isInMapBlock(arg_18_0)
	return arg_18_0.blockState == RoomBlockEnum.BlockState.Map or arg_18_0.blockState == RoomBlockEnum.BlockState.Temp
end

function var_0_0.canPlace(arg_19_0)
	if arg_19_0.blockState ~= RoomBlockEnum.BlockState.Water then
		return false
	end

	if not RoomEnum.IsBlockNeedConnInit then
		return true
	end

	local var_19_0 = arg_19_0.hexPoint:getNeighbors()

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		local var_19_1 = RoomMapBlockModel.instance:getBlockMO(iter_19_1.x, iter_19_1.y)

		if var_19_1 and var_19_1.blockState == RoomBlockEnum.BlockState.Map then
			return true
		end
	end

	return false
end

function var_0_0.resetOpState(arg_20_0)
	arg_20_0._opState = RoomBlockEnum.OpState.Normal
end

function var_0_0.getOpState(arg_21_0)
	return arg_21_0._opState or RoomBlockEnum.OpState.Normal
end

function var_0_0.getOpStateParam(arg_22_0)
	return arg_22_0._opStateParamDic and arg_22_0._opStateParamDic[arg_22_0._opState]
end

function var_0_0.setOpState(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._opState = arg_23_1
	arg_23_0._opStateParamDic = arg_23_0._opStateParamDic or {}
	arg_23_0._opStateParamDic[arg_23_1] = arg_23_2
end

function var_0_0.setUseState(arg_24_0, arg_24_1)
	arg_24_0.useState = arg_24_1
end

function var_0_0.getUseState(arg_25_0)
	return arg_25_0.useState or RoomBlockEnum.UseState.Normal
end

function var_0_0.setCleanType(arg_26_0, arg_26_1)
	arg_26_0.blockCleanType = arg_26_1 or RoomBlockEnum.CleanType.Normal
end

function var_0_0.getCleanType(arg_27_0)
	return arg_27_0.blockCleanType or RoomBlockEnum.CleanType.Normal
end

function var_0_0.setWaterType(arg_28_0, arg_28_1)
	arg_28_0.waterType = arg_28_1
end

function var_0_0.setTempWaterType(arg_29_0, arg_29_1)
	arg_29_0.tempWaterType = arg_29_1
end

function var_0_0.isWaterGradient(arg_30_0)
	local var_30_0 = true
	local var_30_1 = arg_30_0:getWaterType()
	local var_30_2 = arg_30_0:getTempWaterType()

	if var_30_1 and var_30_1 ~= -1 or var_30_2 and var_30_2 ~= -1 then
		var_30_0 = false
	end

	return var_30_0
end

function var_0_0.getResourceId(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_0.blockState == RoomBlockEnum.BlockState.Water then
		return RoomResourceEnum.ResourceId.Empty
	end

	if arg_31_0.blockState == RoomBlockEnum.BlockState.Fake then
		return RoomResourceEnum.ResourceId.None
	end

	local var_31_0 = RoomResourceEnum.ResourceId.None

	if arg_31_1 == 0 then
		var_31_0 = arg_31_0:getResourceCenter()
	else
		arg_31_1 = arg_31_2 and arg_31_1 or RoomRotateHelper.rotateDirection(arg_31_1, -arg_31_0:getRotate())
		var_31_0 = arg_31_0:getResourceList()[arg_31_1]
	end

	return var_31_0
end

function var_0_0.getResourceTypeRiver(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0.blockState == RoomBlockEnum.BlockState.Water or arg_32_0.blockState == RoomBlockEnum.BlockState.Fake then
		return nil
	end

	if arg_32_1 == 0 then
		return nil
	end

	if not arg_32_0._riverTypeDict then
		arg_32_0:refreshRiver()
	end

	arg_32_1 = arg_32_2 and RoomRotateHelper.rotateDirection(arg_32_1, arg_32_0:getRotate()) or arg_32_1

	local var_32_0 = arg_32_0._riverTypeDict[arg_32_1]
	local var_32_1 = arg_32_0._neighborBlockTypeDict and arg_32_0._neighborBlockTypeDict[arg_32_1]
	local var_32_2 = arg_32_0._neighborBlockBTypeDict and arg_32_0._neighborBlockBTypeDict[arg_32_1]

	return var_32_0, var_32_1, var_32_2
end

function var_0_0.refreshRiver(arg_33_0)
	if arg_33_0:getRiverCount() < 1 then
		return
	end

	local var_33_0 = arg_33_0:isFullWater()
	local var_33_1 = arg_33_0.replaceDefineId or arg_33_0.defineId

	if not var_33_0 and arg_33_0._lastRefreshRiverDefineId == var_33_1 then
		return
	end

	arg_33_0._lastRefreshRiverDefineId = var_33_1
	arg_33_0._riverTypeDict, arg_33_0._neighborBlockTypeDict, arg_33_0._neighborBlockBTypeDict = RoomRiverHelper.getRiverTypeDictByMO(arg_33_0)
end

function var_0_0.hasRiver(arg_34_0, arg_34_1)
	return arg_34_0:getResourceCenter(arg_34_1) == RoomResourceEnum.ResourceId.River or arg_34_0:getRiverCount(arg_34_1) > 0
end

function var_0_0.getRiverCount(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getResourceList(arg_35_1)
	local var_35_1 = 0

	for iter_35_0, iter_35_1 in ipairs(var_35_0) do
		if iter_35_1 == RoomResourceEnum.ResourceId.River then
			var_35_1 = var_35_1 + 1
		end
	end

	return var_35_1
end

function var_0_0.getNeighborBlockLinkResourceId(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_1 or arg_36_1 == 0 or arg_36_1 > 6 then
		return nil
	end

	if arg_36_0:isInMap() then
		if arg_36_2 then
			arg_36_1 = RoomRotateHelper.rotateDirection(arg_36_1, arg_36_0:getRotate())
		end

		local var_36_0 = arg_36_0.hexPoint:getNeighbor(arg_36_1)
		local var_36_1 = RoomMapBlockModel.instance:getBlockMO(var_36_0.x, var_36_0.y)

		if var_36_1 then
			local var_36_2 = (arg_36_1 - 1 + 3) % 6 + 1
			local var_36_3 = RoomRotateHelper.rotateDirection(var_36_2, var_36_1:getRotate())

			return var_36_1:getResourceId(var_36_3, true, true), var_36_1
		end
	end

	return nil
end

function var_0_0.hasNeighborSameBlockType(arg_37_0)
	if arg_37_0:isInMap() then
		local var_37_0 = RoomMapBlockModel.instance
		local var_37_1 = arg_37_0:getDefineBlockType()

		for iter_37_0 = 1, 6 do
			local var_37_2 = HexPoint.directions[iter_37_0]
			local var_37_3 = var_37_0:getBlockMO(arg_37_0.hexPoint.x + var_37_2.x, arg_37_0.hexPoint.y + var_37_2.y)

			if var_37_3 and var_37_1 == var_37_3:getDefineBlockType() then
				return true
			end
		end
	end

	return false
end

return var_0_0
