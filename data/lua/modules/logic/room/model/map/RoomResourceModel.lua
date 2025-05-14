module("modules.logic.room.model.map.RoomResourceModel", package.seeall)

local var_0_0 = class("RoomResourceModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._allResourcePointDic = {}
	arg_1_0._allResourcePointList = {}
	arg_1_0._blockPointDic = {}
	arg_1_0._mapMaxRadius = 400
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0.clear(arg_4_0)
	var_0_0.super.clear(arg_4_0)
	arg_4_0:_clearData()
end

function var_0_0._clearData(arg_5_0)
	arg_5_0._resourceAreaList = nil
	arg_5_0._resourcePointToAreaIndex = nil
	arg_5_0._lightResourcePointDict = nil
	arg_5_0._blockPointDic = {}

	if arg_5_0._resourcePointAreaModel then
		arg_5_0._resourcePointAreaModel:clear()
	end
end

function var_0_0.init(arg_6_0)
	arg_6_0:clear()

	if not arg_6_0._resourcePointAreaModel then
		arg_6_0._resourcePointAreaModel = BaseModel.New()
	end

	local var_6_0 = CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius)

	if var_6_0 then
		arg_6_0._mapMaxRadius = math.max(var_6_0, arg_6_0._mapMaxRadius)
	end

	arg_6_0:_initLigheResourcePoint()
end

function var_0_0._initLigheResourcePoint(arg_7_0)
	local var_7_0 = RoomMapBlockModel.instance:getBlockMODict()
	local var_7_1 = RoomMapBuildingModel.instance:getTempBuildingMO()
	local var_7_2 = var_7_1 and var_7_1.id or nil
	local var_7_3 = RoomConfig.instance

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			if var_7_2 ~= iter_7_3.id then
				arg_7_0:_addBlockMO(iter_7_3)
			end
		end
	end
end

function var_0_0._addBlockMO(arg_8_0, arg_8_1)
	local var_8_0 = RoomConfig.instance

	for iter_8_0 = 0, 6 do
		local var_8_1 = arg_8_1:getResourceId(iter_8_0)

		if var_8_0:isLightByResourceId(var_8_1) then
			local var_8_2 = arg_8_0._resourcePointAreaModel:getById(var_8_1)

			if not var_8_2 then
				var_8_2 = RoomMapResorcePointAreaMO.New()

				var_8_2:init(var_8_1, var_8_1)
				arg_8_0._resourcePointAreaModel:addAtLast(var_8_2)
			end

			local var_8_3 = arg_8_0:getResourcePoint(arg_8_1.hexPoint.x, arg_8_1.hexPoint.y, iter_8_0)

			var_8_2:addResPoint(var_8_3)

			if not arg_8_0._blockPointDic[arg_8_1.id] then
				arg_8_0._blockPointDic[arg_8_1.id] = var_8_3
			end
		end
	end
end

function var_0_0._removeBlockMO(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._blockPointDic[arg_9_1.id]

	if var_9_0 then
		arg_9_0._blockPointDic[arg_9_1.id] = nil

		local var_9_1 = arg_9_0._resourcePointAreaModel:getList()

		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			iter_9_1:removeByXY(var_9_0.x, var_9_0.y)
		end
	end
end

function var_0_0.unUseBlockList(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		arg_10_0:_removeBlockMO(iter_10_1)
	end
end

function var_0_0.useBlock(arg_11_0, arg_11_1)
	arg_11_0:_removeBlockMO(arg_11_1)
	arg_11_0:_addBlockMO(arg_11_1)
end

function var_0_0.getIndexByXYD(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0._mapMaxRadius + 1

	return ((arg_12_1 + var_12_0) * 2 * var_12_0 + arg_12_2 + var_12_0) * 100 + arg_12_3
end

function var_0_0.getIndexByXY(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0:getIndexByXYD(arg_13_1, arg_13_2, 0)
end

function var_0_0.getResourcePoint(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:getIndexByXYD(arg_14_1, arg_14_2, arg_14_3)
	local var_14_1 = arg_14_0._allResourcePointDic[var_14_0]

	if not var_14_1 then
		var_14_1 = ResourcePoint(HexPoint(arg_14_1, arg_14_2), arg_14_3)
		arg_14_0._allResourcePointDic[var_14_0] = var_14_1

		table.insert(arg_14_0._allResourcePointList, var_14_1)
	end

	return var_14_1
end

function var_0_0._refreshResourceAreaList(arg_15_0)
	arg_15_0._resourceAreaList = {}
	arg_15_0._resourcePointToAreaIndex = {}
end

function var_0_0.getResourceAreaList(arg_16_0)
	if not arg_16_0._resourceAreaList or not arg_16_0._resourcePointToAreaIndex then
		arg_16_0:_refreshResourceAreaList()
	end

	return arg_16_0._resourceAreaList
end

function var_0_0.getResourceAreaById(arg_17_0, arg_17_1)
	if not arg_17_0._resourceAreaList or not arg_17_0._resourcePointToAreaIndex then
		arg_17_0:_refreshResourceAreaList()
	end

	return arg_17_0._resourceAreaList[arg_17_1]
end

function var_0_0.getResourceArea(arg_18_0, arg_18_1)
	if not arg_18_0._resourceAreaList or not arg_18_0._resourcePointToAreaIndex then
		arg_18_0:_refreshResourceAreaList()
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._resourceAreaList) do
		if iter_18_1.resourcePointDict[arg_18_1.x] and iter_18_1.resourcePointDict[arg_18_1.x][arg_18_1.y] and iter_18_1.resourcePointDict[arg_18_1.x][arg_18_1.y][arg_18_1.direction] then
			return iter_18_1
		end
	end

	return nil
end

function var_0_0.getResourcePointToAreaIndex(arg_19_0, arg_19_1)
	if not arg_19_0._resourceAreaList or not arg_19_0._resourcePointToAreaIndex then
		arg_19_0:_refreshResourceAreaList()
	end

	return arg_19_0._resourcePointToAreaIndex[tostring(arg_19_1)]
end

function var_0_0.clearResourceAreaList(arg_20_0)
	arg_20_0._resourceAreaList = nil
end

function var_0_0._refreshBuildingLightResourcePoint(arg_21_0)
	arg_21_0._lightResourcePointDict = {}

	local var_21_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not var_21_0 then
		return
	end

	local var_21_1 = RoomBuildingHelper.getOccupyDict(var_21_0.buildingId, var_21_0.hexPoint, var_21_0.rotate, var_21_0.buildingUid)

	for iter_21_0, iter_21_1 in pairs(var_21_1) do
		for iter_21_2, iter_21_3 in pairs(iter_21_1) do
			local var_21_2 = RoomMapBlockModel.instance:getBlockMO(iter_21_0, iter_21_2)
			local var_21_3 = var_21_2 and RoomBuildingHelper.isJudge(var_21_2.hexPoint, var_21_2.id)

			if var_21_2 and var_21_3 then
				local var_21_4 = var_21_2.replaceDefineId
				local var_21_5 = var_21_2.replaceRotate

				var_21_2.replaceDefineId = iter_21_3.blockDefineId
				var_21_2.replaceRotate = iter_21_3.blockDefineId and iter_21_3.blockRotate

				local var_21_6 = RoomBuildingHelper.getCostResource(var_21_0.buildingId)
				local var_21_7 = var_21_2:getRotate()

				for iter_21_4 = 1, 6 do
					local var_21_8 = var_21_2:getResourceId(iter_21_4)

					if var_21_8 ~= RoomResourceEnum.ResourceId.None and var_21_8 ~= RoomResourceEnum.ResourceId.Empty and RoomBuildingHelper.checkCostResource(var_21_6, var_21_8) then
						local var_21_9 = RoomRotateHelper.rotateDirection(iter_21_4, var_21_7)
						local var_21_10 = arg_21_0:getIndexByXYD(var_21_2.hexPoint.x, var_21_2.hexPoint.y, var_21_9)

						arg_21_0._lightResourcePointDict[var_21_10] = true
					end
				end

				var_21_2.replaceDefineId = var_21_4
				var_21_2.replaceRotate = var_21_5
			end
		end
	end
end

function var_0_0._refreshLightResourcePoint(arg_22_0)
	arg_22_0._lightResourcePointDict = {}

	local var_22_0 = RoomMapBlockModel.instance:getTempBlockMO()

	if not var_22_0 or not var_22_0:isHasLight() then
		return
	end

	local var_22_1 = RoomConfig.instance
	local var_22_2 = var_22_0
	local var_22_3 = var_22_2.hexPoint
	local var_22_4 = {}
	local var_22_5 = {}
	local var_22_6 = {}

	for iter_22_0 = 1, 6 do
		local var_22_7 = var_22_2:getResourceId(iter_22_0)
		local var_22_8 = arg_22_0._resourcePointAreaModel:getById(var_22_7)

		if var_22_1:isLightByResourceId(var_22_7) and var_22_8 then
			var_22_4[var_22_7] = var_22_4[var_22_7] or {}

			local var_22_9 = arg_22_0:getResourcePoint(var_22_3.x, var_22_3.y, iter_22_0)
			local var_22_10 = var_22_8:getConnectsAll(iter_22_0)
			local var_22_11 = false

			for iter_22_1, iter_22_2 in ipairs(var_22_10) do
				if iter_22_2.x ~= 0 or iter_22_2.y ~= 0 then
					local var_22_12 = iter_22_2.x + var_22_9.x
					local var_22_13 = iter_22_2.y + var_22_9.y
					local var_22_14 = var_22_8:getAreaIdByXYD(var_22_12, var_22_13, iter_22_2.direction)

					if var_22_14 then
						var_22_11 = true
					end

					if var_22_14 and not var_22_4[var_22_7][var_22_14] then
						var_22_4[var_22_7][var_22_14] = true

						local var_22_15 = var_22_8:getResorcePiontListByXYD(var_22_12, var_22_13, iter_22_2.direction)

						for iter_22_3, iter_22_4 in ipairs(var_22_15) do
							local var_22_16 = arg_22_0:getIndexByXYD(iter_22_4.x, iter_22_4.y, iter_22_4.direction)

							arg_22_0._lightResourcePointDict[var_22_16] = var_22_7
						end
					end
				end
			end

			if var_22_11 then
				local var_22_17 = arg_22_0:getIndexByXYD(var_22_9.x, var_22_9.y, var_22_9.direction)

				arg_22_0._lightResourcePointDict[var_22_17] = var_22_7

				for iter_22_5, iter_22_6 in ipairs(var_22_10) do
					if (iter_22_6.x == 0 or iter_22_6.y == 0) and var_22_7 == var_22_2:getResourceId(iter_22_6.direction) then
						local var_22_18 = iter_22_6.x + var_22_9.x
						local var_22_19 = iter_22_6.y + var_22_9.y
						local var_22_20 = arg_22_0:getIndexByXYD(var_22_18, var_22_19, iter_22_6.direction)

						arg_22_0._lightResourcePointDict[var_22_20] = var_22_7
					end
				end
			end
		end
	end
end

function var_0_0._refreshWaterReformLightResourcePoint(arg_23_0)
	local var_23_0 = RoomResourceEnum.ResourceId.River

	arg_23_0._lightResourcePointDict = {}

	local var_23_1 = arg_23_0._resourcePointAreaModel:getById(var_23_0)

	if not var_23_1 then
		return
	end

	local var_23_2 = RoomWaterReformModel.instance:getSelectAreaId()
	local var_23_3 = var_23_1:findeArea()

	for iter_23_0, iter_23_1 in ipairs(var_23_3) do
		if iter_23_0 ~= var_23_2 then
			for iter_23_2, iter_23_3 in ipairs(iter_23_1) do
				local var_23_4 = arg_23_0:getIndexByXYD(iter_23_3.x, iter_23_3.y, iter_23_3.direction)

				arg_23_0._lightResourcePointDict[var_23_4] = var_23_0
			end
		end
	end
end

function var_0_0.isLightResourcePoint(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = RoomWaterReformModel.instance:isWaterReform()

	if not arg_24_0._lightResourcePointDict then
		if RoomBuildingController.instance:isBuildingListShow() then
			return false
		elseif var_24_0 then
			return false
		else
			arg_24_0:_refreshLightResourcePoint()
		end
	end

	local var_24_1 = arg_24_0:getIndexByXYD(arg_24_1, arg_24_2, arg_24_3)

	return arg_24_0._lightResourcePointDict[var_24_1]
end

function var_0_0.clearLightResourcePoint(arg_25_0)
	arg_25_0._lightResourcePointDict = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
