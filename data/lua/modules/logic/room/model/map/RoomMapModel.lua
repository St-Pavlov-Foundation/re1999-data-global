module("modules.logic.room.model.map.RoomMapModel", package.seeall)

local var_0_0 = class("RoomMapModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	arg_4_0._revertCameraParam = nil
	arg_4_0._buildingConfigParamDict = nil
	arg_4_0._otherLineLevelDict = nil
	arg_4_0._roomLevel = 1
	arg_4_0._roomLeveling = false
end

function var_0_0.init(arg_5_0)
	arg_5_0:clear()
end

function var_0_0.updateRoomLevel(arg_6_0, arg_6_1)
	arg_6_0._roomLevel = arg_6_1
end

function var_0_0.getRoomLevel(arg_7_0)
	return arg_7_0._roomLevel
end

function var_0_0.saveCameraParam(arg_8_0, arg_8_1)
	arg_8_0._revertCameraParam = LuaUtil.deepCopy(arg_8_1)
end

function var_0_0.getCameraParam(arg_9_0)
	return arg_9_0._revertCameraParam
end

function var_0_0.clearCameraParam(arg_10_0)
	arg_10_0._revertCameraParam = nil
end

function var_0_0.getBuildingConfigParam(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return nil
	end

	arg_11_0._buildingConfigParamDict = arg_11_0._buildingConfigParamDict or {}

	local var_11_0 = arg_11_0._buildingConfigParamDict[arg_11_1]

	if not var_11_0 then
		local var_11_1 = RoomConfig.instance:getBuildingConfig(arg_11_1)

		if not var_11_1 then
			return nil
		end

		var_11_0 = {}

		local var_11_2 = var_11_1.center

		if not string.nilorempty(var_11_2) then
			var_11_0.onlyDirection = string.splitToNumber(var_11_2, "#")[3]
		end

		local var_11_3 = var_11_1.costResource

		if not string.nilorempty(var_11_3) then
			var_11_0.costResource = string.splitToNumber(var_11_3, "#")
		else
			var_11_0.costResource = {}
		end

		local var_11_4 = var_11_1.center

		if string.nilorempty(var_11_4) then
			var_11_0.centerPoint = HexPoint(0, 0)
		else
			local var_11_5 = string.splitToNumber(var_11_4, "#")

			var_11_0.centerPoint = HexPoint(var_11_5[1], var_11_5[2])
		end

		var_11_0.pointList = {}

		local var_11_6 = RoomConfig.instance:getBuildingAreaConfig(var_11_1.areaId)

		if not string.nilorempty(var_11_6.area) then
			local var_11_7 = GameUtil.splitString2(var_11_6.area, true)

			for iter_11_0, iter_11_1 in ipairs(var_11_7) do
				local var_11_8 = HexPoint(iter_11_1[1], iter_11_1[2])

				table.insert(var_11_0.pointList, var_11_8)
			end
		end

		local var_11_9 = {}
		local var_11_10 = {}

		var_11_0.crossloadResPointDic = var_11_10
		var_11_0.crossloadResIdList = var_11_9

		if var_11_1.crossload and var_11_1.crossload ~= 0 and RoomBuildingEnum.Crossload[arg_11_1] then
			local var_11_11 = RoomBuildingEnum.Crossload[arg_11_1]

			for iter_11_2, iter_11_3 in ipairs(var_11_11.AnimStatus) do
				table.insert(var_11_9, iter_11_3.resId)

				for iter_11_4, iter_11_5 in ipairs(iter_11_3.replaceBlockRes) do
					if not var_11_10[iter_11_5.x] then
						var_11_10[iter_11_5.x] = {}
					end

					if not var_11_10[iter_11_5.x][iter_11_5.y] then
						var_11_10[iter_11_5.x][iter_11_5.y] = {}
					end

					var_11_10[iter_11_5.x][iter_11_5.y][iter_11_3.resId] = iter_11_5.resPionts
				end
			end
		end

		local var_11_12 = {}

		var_11_0.replaceBlockDic = var_11_12
		var_11_0.replaceBlockCount = 0

		if not string.nilorempty(var_11_1.replaceBlock) then
			local var_11_13 = GameUtil.splitString2(var_11_1.replaceBlock, true)

			for iter_11_6, iter_11_7 in ipairs(var_11_13) do
				if #iter_11_7 >= 3 then
					if not var_11_12[iter_11_7[1]] then
						var_11_12[iter_11_7[1]] = {}
					end

					var_11_12[iter_11_7[1]][iter_11_7[2]] = iter_11_7[3]
					var_11_0.replaceBlockCount = var_11_0.replaceBlockCount + 1
				else
					logError(string.format("【小屋】建筑表中id:%s的[replaceBlack]字段配置有误", arg_11_1))
				end
			end
		end

		local var_11_14 = {}

		var_11_0.canPlaceBlockDic = var_11_14

		if not string.nilorempty(var_11_1.canPlaceBlock) then
			local var_11_15 = GameUtil.splitString2(var_11_1.canPlaceBlock, true)

			for iter_11_8, iter_11_9 in ipairs(var_11_15) do
				if #iter_11_9 >= 2 then
					if not var_11_14[iter_11_9[1]] then
						var_11_14[iter_11_9[1]] = {}
					end

					var_11_14[iter_11_9[1]][iter_11_9[2]] = true
				else
					logError(string.format("【小屋】建筑表中id:%s的[canPlaceBlock]字段配置有误", arg_11_1))
				end
			end
		end

		local var_11_16 = var_11_1.levelGroups

		if string.nilorempty(var_11_16) then
			var_11_16 = {}
		else
			var_11_16 = string.splitToNumber(var_11_16, "#")
		end

		var_11_0.levelGroups = var_11_16

		local var_11_17 = Vector3.zero

		if not string.nilorempty(var_11_1.offset) then
			local var_11_18 = string.splitToNumber(var_11_1.offset, "#")

			var_11_17 = Vector3(var_11_18[1] or 0, var_11_18[2] or 0, var_11_18[3] or 0)
		end

		var_11_0.offset = var_11_17

		if #var_11_0.pointList > 1 and var_11_0.onlyDirection then
			logError("占多格的建筑配置了指定方向 约定没有这种情况")
		end

		arg_11_0._buildingConfigParamDict[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.getBuildingPointList(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._buildingRotatePointsDict = arg_12_0._buildingRotatePointsDict or {}

	local var_12_0 = arg_12_0._buildingRotatePointsDict[arg_12_1]

	if not var_12_0 then
		local var_12_1 = arg_12_0:getBuildingConfigParam(arg_12_1)

		if not var_12_1 then
			return nil
		end

		var_12_0 = {}
		arg_12_0._buildingRotatePointsDict[arg_12_1] = var_12_0

		for iter_12_0 = 0, 5 do
			var_12_0[iter_12_0] = arg_12_0:_rotatePointList(var_12_1.pointList, var_12_1.centerPoint, iter_12_0)
		end
	end

	return var_12_0[RoomRotateHelper.getMod(arg_12_2, 6)]
end

function var_0_0._rotatePointList(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}

	if arg_13_3 == 0 then
		tabletool.addValues(var_13_0, arg_13_1)
	else
		for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
			local var_13_1 = (iter_13_1 - arg_13_2):Rotate(HexPoint.Zero, arg_13_3, true)

			table.insert(var_13_0, var_13_1)
		end
	end

	return var_13_0
end

function var_0_0.setOtherLineLevelDict(arg_14_0, arg_14_1)
	arg_14_0._otherLineLevelDict = {}

	if arg_14_1 then
		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			arg_14_0._otherLineLevelDict[iter_14_1.id] = iter_14_1.level
		end
	end
end

function var_0_0.getOtherLineLevelDict(arg_15_0)
	return arg_15_0._otherLineLevelDict
end

function var_0_0.getAllBuildDegree(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1 = 0
	local var_16_2 = {
		count = 0,
		degree = 0
	}
	local var_16_3 = var_16_1 + RoomBlockEnum.InitBlockDegreeValue
	local var_16_4 = 0
	local var_16_5 = RoomMapBlockModel.instance:getFullBlockMOList()

	for iter_16_0, iter_16_1 in ipairs(var_16_5) do
		if iter_16_1.blockState == RoomBlockEnum.BlockState.Map or iter_16_1.blockState == RoomBlockEnum.BlockState.Revert or arg_16_1 and iter_16_1.blockState == RoomBlockEnum.BlockState.Temp then
			local var_16_6 = iter_16_1.blockId
			local var_16_7 = RoomConfig.instance:getPackageConfigByBlockId(var_16_6)
			local var_16_8 = var_16_7 and var_16_7.blockBuildDegree or 0

			var_16_3 = var_16_3 + var_16_8
			var_16_2.count = var_16_2.count + (var_16_7 and 1 or 0)
			var_16_2.degree = var_16_2.degree + var_16_8
		end
	end

	local var_16_9 = RoomMapBuildingModel.instance:getList()

	for iter_16_2, iter_16_3 in ipairs(var_16_9) do
		if iter_16_3.buildingState == RoomBuildingEnum.BuildingState.Map or iter_16_3.buildingState == RoomBuildingEnum.BuildingState.Revert or arg_16_1 and iter_16_3.buildingState == RoomBuildingEnum.BuildingState.Temp then
			var_16_3 = var_16_3 + iter_16_3.config.buildDegree
			var_16_0[iter_16_3.buildingId] = var_16_0[iter_16_3.buildingId] or {
				count = 0,
				config = iter_16_3.config
			}
			var_16_0[iter_16_3.buildingId].count = var_16_0[iter_16_3.buildingId].count + 1
		end
	end

	local var_16_10 = {}

	for iter_16_4, iter_16_5 in pairs(var_16_0) do
		table.insert(var_16_10, iter_16_5)
	end

	return var_16_3, var_16_2, var_16_10
end

function var_0_0.setRoomLeveling(arg_17_0, arg_17_1)
	arg_17_0._roomLeveling = arg_17_1
end

function var_0_0.isRoomLeveling(arg_18_0)
	return arg_18_0._roomLeveling
end

var_0_0.instance = var_0_0.New()

return var_0_0
