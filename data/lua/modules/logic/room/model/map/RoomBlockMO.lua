module("modules.logic.room.model.map.RoomBlockMO", package.seeall)

local var_0_0 = pureTable("RoomBlockMO")

function var_0_0.init(arg_1_0, arg_1_1)
	if arg_1_1.fishingBlockId then
		arg_1_0.id = arg_1_1.fishingBlockId
		arg_1_0.blockId = arg_1_1.fishingBlockId
		arg_1_0.isFishingBlock = true
	else
		arg_1_0.id = arg_1_1.blockId
		arg_1_0.blockId = arg_1_1.blockId
		arg_1_0.isFishingBlock = false
	end

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

	arg_1_0:setWaterType(arg_1_1.waterType or RoomWaterReformModel.InitWaterType)
	arg_1_0:setTempWaterType()

	arg_1_0._defineWaterType = arg_1_1.defineWaterType

	arg_1_0:setBlockColorType(arg_1_1.blockColor or RoomWaterReformModel.InitBlockColor)
	arg_1_0:setTempBlockColorType()

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
	if arg_4_0:isInMapBlock() then
		local var_4_0 = arg_4_0:getTempBlockColorType()

		if var_4_0 and var_4_0 ~= RoomWaterReformModel.InitBlockColor then
			return var_4_0
		elseif var_4_0 == RoomWaterReformModel.InitBlockColor then
			local var_4_1 = arg_4_0:getBlockDefineCfg(arg_4_1)

			return var_4_1 and var_4_1.blockType or 0
		end
	end

	return (arg_4_0:getOriginalBlockType(arg_4_1))
end

function var_0_0.getOriginalBlockType(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getBlockColorType()

	if var_5_0 then
		return var_5_0
	end

	local var_5_1 = arg_5_0:getBlockDefineCfg(arg_5_1)

	return var_5_1 and var_5_1.blockType or 0
end

function var_0_0.getTempBlockColorType(arg_6_0)
	return arg_6_0.tempBlockColor
end

function var_0_0.getBlockColorType(arg_7_0)
	if arg_7_0.blockState == RoomBlockEnum.BlockState.Inventory or arg_7_0.blockState == RoomBlockEnum.BlockState.Temp then
		local var_7_0 = RoomWaterReformModel.instance:getBlockPermanentInfo(arg_7_0.blockId)

		if var_7_0 and var_7_0 ~= RoomWaterReformModel.InitBlockColor then
			return var_7_0
		end
	end

	if arg_7_0.blockColor == RoomWaterReformModel.InitBlockColor then
		return
	end

	return arg_7_0.blockColor
end

function var_0_0.getDefineId(arg_8_0, arg_8_1)
	return arg_8_1 and arg_8_0.defineId or arg_8_0.replaceDefineId or arg_8_0.defineId
end

function var_0_0.getRotate(arg_9_0, arg_9_1)
	return arg_9_1 and arg_9_0.rotate or arg_9_0.replaceDefineId and arg_9_0.replaceRotate or arg_9_0.rotate
end

function var_0_0.getDefineWaterType(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 and not arg_10_2 and arg_10_0:isInMapBlock() then
		local var_10_0 = arg_10_0:getTempWaterType()

		if var_10_0 and var_10_0 ~= RoomWaterReformModel.InitWaterType then
			return var_10_0
		end
	end

	return (arg_10_0:getOriginalWaterType(arg_10_2))
end

function var_0_0.getOriginalWaterType(arg_11_0, arg_11_1)
	if not arg_11_1 and arg_11_0:isInMapBlock() then
		local var_11_0 = arg_11_0:getWaterType()

		if var_11_0 and var_11_0 ~= RoomWaterReformModel.InitWaterType then
			return var_11_0
		end
	end

	local var_11_1 = arg_11_0._defineWaterType

	if not var_11_1 then
		local var_11_2 = arg_11_0:getBlockDefineCfg(arg_11_1)

		var_11_1 = var_11_2 and var_11_2.waterType or 0
	end

	return var_11_1
end

function var_0_0.getTempWaterType(arg_12_0)
	return arg_12_0.tempWaterType
end

function var_0_0.getWaterType(arg_13_0)
	return arg_13_0.waterType
end

function var_0_0.getDefineWaterAreaType(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getBlockDefineCfg(arg_14_1)

	return var_14_0 and var_14_0.waterAreaType or 0
end

function var_0_0.isFullWater(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getRiverCount(arg_15_1)

	if var_15_0 < 1 and arg_15_0:getResourceCenter(arg_15_1) ~= RoomResourceEnum.ResourceId.River then
		return false
	end

	if var_15_0 >= 6 then
		return true
	end

	return arg_15_0:isHalfLakeWater(arg_15_1)
end

function var_0_0.isHalfLakeWater(arg_16_0, arg_16_1)
	return arg_16_0:getDefineWaterAreaType(arg_16_1) == 1
end

function var_0_0.getResourceList(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getBlockDefineCfg(arg_17_1)

	if not var_17_0 then
		local var_17_1 = -1000

		arg_17_0._isHasLightDic[var_17_1] = false

		return RoomResourceEnum.Block.NoneList
	end

	if not arg_17_0._resourceListDic[arg_17_0._blockDefineCfg.defineId] then
		local var_17_2 = {}
		local var_17_3 = false

		for iter_17_0 = 1, 6 do
			local var_17_4 = var_17_0.resourceIds[iter_17_0 + 1]

			table.insert(var_17_2, var_17_4)

			if not var_17_3 and RoomConfig.instance:isLightByResourceId(var_17_4) then
				var_17_3 = true
			end
		end

		arg_17_0._isHasLightDic[arg_17_0._blockDefineCfg.defineId] = var_17_3
		arg_17_0._resourceListDic[arg_17_0._blockDefineCfg.defineId] = var_17_2
	end

	if arg_17_0:getUseState() == RoomBlockEnum.UseState.TransportPath then
		if var_17_0.resIdCountDict[RoomResourceEnum.ResourceId.River] then
			return RoomResourceEnum.Block.RiverList
		end

		return RoomResourceEnum.Block.NoneList
	end

	return arg_17_0._resourceListDic[arg_17_0._blockDefineCfg.defineId]
end

function var_0_0.isHasLight(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._isHasLightDic[arg_18_0:getDefineId(arg_18_1)]

	if var_18_0 == nil then
		arg_18_0:getResourceList(arg_18_1)

		return arg_18_0._isHasLightDic[arg_18_0:getDefineId(arg_18_1)]
	end

	return var_18_0
end

function var_0_0.getResourceCenter(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getBlockDefineCfg(arg_19_1)

	if not var_19_0 then
		return RoomResourceEnum.ResourceId.None
	end

	if arg_19_0:getUseState() == RoomBlockEnum.UseState.TransportPath then
		if var_19_0.resIdCountDict[RoomResourceEnum.ResourceId.River] then
			return RoomResourceEnum.ResourceId.River
		end

		return RoomResourceEnum.ResourceId.None
	end

	return var_19_0.resourceIds[1]
end

function var_0_0.isInMap(arg_20_0)
	return arg_20_0.blockState == RoomBlockEnum.BlockState.Map or arg_20_0.blockState == RoomBlockEnum.BlockState.Water or arg_20_0.blockState == RoomBlockEnum.BlockState.Temp
end

function var_0_0.isInMapBlock(arg_21_0)
	return arg_21_0.blockState == RoomBlockEnum.BlockState.Map or arg_21_0.blockState == RoomBlockEnum.BlockState.Temp
end

function var_0_0.canPlace(arg_22_0)
	if arg_22_0.blockState ~= RoomBlockEnum.BlockState.Water then
		return false
	end

	if not RoomEnum.IsBlockNeedConnInit then
		return true
	end

	local var_22_0 = arg_22_0.hexPoint:getNeighbors()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_1 = RoomMapBlockModel.instance:getBlockMO(iter_22_1.x, iter_22_1.y)

		if var_22_1 and var_22_1.blockState == RoomBlockEnum.BlockState.Map then
			return true
		end
	end

	return false
end

function var_0_0.resetOpState(arg_23_0)
	arg_23_0._opState = RoomBlockEnum.OpState.Normal
end

function var_0_0.getOpState(arg_24_0)
	return arg_24_0._opState or RoomBlockEnum.OpState.Normal
end

function var_0_0.getOpStateParam(arg_25_0)
	return arg_25_0._opStateParamDic and arg_25_0._opStateParamDic[arg_25_0._opState]
end

function var_0_0.setOpState(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._opState = arg_26_1
	arg_26_0._opStateParamDic = arg_26_0._opStateParamDic or {}
	arg_26_0._opStateParamDic[arg_26_1] = arg_26_2
end

function var_0_0.setUseState(arg_27_0, arg_27_1)
	arg_27_0.useState = arg_27_1
end

function var_0_0.getUseState(arg_28_0)
	return arg_28_0.useState or RoomBlockEnum.UseState.Normal
end

function var_0_0.setCleanType(arg_29_0, arg_29_1)
	arg_29_0.blockCleanType = arg_29_1 or RoomBlockEnum.CleanType.Normal
end

function var_0_0.getCleanType(arg_30_0)
	return arg_30_0.blockCleanType or RoomBlockEnum.CleanType.Normal
end

function var_0_0.setWaterType(arg_31_0, arg_31_1)
	arg_31_0.waterType = arg_31_1
end

function var_0_0.setTempWaterType(arg_32_0, arg_32_1)
	arg_32_0.tempWaterType = arg_32_1
end

function var_0_0.setBlockColorType(arg_33_0, arg_33_1)
	arg_33_0.blockColor = arg_33_1
end

function var_0_0.setTempBlockColorType(arg_34_0, arg_34_1)
	arg_34_0.tempBlockColor = arg_34_1
end

function var_0_0.isWaterGradient(arg_35_0)
	local var_35_0 = true
	local var_35_1 = arg_35_0:getWaterType()
	local var_35_2 = arg_35_0:getTempWaterType()

	if var_35_1 and var_35_1 ~= RoomWaterReformModel.InitWaterType or var_35_2 and var_35_2 ~= RoomWaterReformModel.InitWaterType then
		var_35_0 = false
	end

	return var_35_0
end

function var_0_0.getResourceId(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if arg_36_0.blockState == RoomBlockEnum.BlockState.Water then
		return RoomResourceEnum.ResourceId.Empty
	end

	if arg_36_0.blockState == RoomBlockEnum.BlockState.Fake then
		return RoomResourceEnum.ResourceId.None
	end

	local var_36_0 = RoomResourceEnum.ResourceId.None

	if arg_36_1 == 0 then
		var_36_0 = arg_36_0:getResourceCenter()
	else
		arg_36_1 = arg_36_2 and arg_36_1 or RoomRotateHelper.rotateDirection(arg_36_1, -arg_36_0:getRotate())
		var_36_0 = arg_36_0:getResourceList()[arg_36_1]
	end

	return var_36_0
end

function var_0_0.getResourceTypeRiver(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0.blockState == RoomBlockEnum.BlockState.Water or arg_37_0.blockState == RoomBlockEnum.BlockState.Fake then
		return nil
	end

	if arg_37_1 == 0 then
		return nil
	end

	if not arg_37_0._riverTypeDict then
		arg_37_0:refreshRiver()
	end

	arg_37_1 = arg_37_2 and RoomRotateHelper.rotateDirection(arg_37_1, arg_37_0:getRotate()) or arg_37_1

	local var_37_0 = arg_37_0._riverTypeDict and arg_37_0._riverTypeDict[arg_37_1]
	local var_37_1 = arg_37_0._neighborBlockTypeDict and arg_37_0._neighborBlockTypeDict[arg_37_1]
	local var_37_2 = arg_37_0._neighborBlockBTypeDict and arg_37_0._neighborBlockBTypeDict[arg_37_1]

	return var_37_0, var_37_1, var_37_2
end

function var_0_0.refreshRiver(arg_38_0)
	if arg_38_0:getRiverCount() < 1 then
		return
	end

	local var_38_0 = arg_38_0:isFullWater()
	local var_38_1 = arg_38_0.replaceDefineId or arg_38_0.defineId

	if not var_38_0 and arg_38_0._lastRefreshRiverDefineId == var_38_1 then
		return
	end

	arg_38_0._lastRefreshRiverDefineId = var_38_1
	arg_38_0._riverTypeDict, arg_38_0._neighborBlockTypeDict, arg_38_0._neighborBlockBTypeDict = RoomRiverHelper.getRiverTypeDictByMO(arg_38_0)
end

function var_0_0.hasRiver(arg_39_0, arg_39_1)
	return arg_39_0:getResourceCenter(arg_39_1) == RoomResourceEnum.ResourceId.River or arg_39_0:getRiverCount(arg_39_1) > 0
end

function var_0_0.getRiverCount(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getResourceList(arg_40_1)
	local var_40_1 = 0

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		if iter_40_1 == RoomResourceEnum.ResourceId.River then
			var_40_1 = var_40_1 + 1
		end
	end

	return var_40_1
end

function var_0_0.getNeighborBlockLinkResourceId(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_1 or arg_41_1 == 0 or arg_41_1 > 6 then
		return nil
	end

	if arg_41_0:isInMap() then
		if arg_41_2 then
			arg_41_1 = RoomRotateHelper.rotateDirection(arg_41_1, arg_41_0:getRotate())
		end

		local var_41_0 = arg_41_0.hexPoint:getNeighbor(arg_41_1)
		local var_41_1 = RoomMapBlockModel.instance:getBlockMO(var_41_0.x, var_41_0.y)

		if var_41_1 then
			local var_41_2 = (arg_41_1 - 1 + 3) % 6 + 1
			local var_41_3 = RoomRotateHelper.rotateDirection(var_41_2, var_41_1:getRotate())

			return var_41_1:getResourceId(var_41_3, true, true), var_41_1
		end
	end

	return nil
end

function var_0_0.hasNeighborSameBlockType(arg_42_0)
	if arg_42_0:isInMap() then
		local var_42_0 = RoomMapBlockModel.instance
		local var_42_1 = arg_42_0:getDefineBlockType()

		for iter_42_0 = 1, 6 do
			local var_42_2 = HexPoint.directions[iter_42_0]
			local var_42_3 = var_42_0:getBlockMO(arg_42_0.hexPoint.x + var_42_2.x, arg_42_0.hexPoint.y + var_42_2.y)

			if var_42_3 and var_42_1 == var_42_3:getDefineBlockType() then
				return true
			end
		end
	end

	return false
end

return var_0_0
