module("modules.logic.room.model.map.RoomMapBuildingModel", package.seeall)

local var_0_0 = class("RoomMapBuildingModel", BaseModel)

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
	arg_4_0._mapBuildingMODict = {}
	arg_4_0._type2BuildingDict = {}
	arg_4_0._tempBuildingMO = nil
	arg_4_0._allOccupyDict = nil
	arg_4_0._canConfirmPlaceDict = nil
	arg_4_0._revertHexPoint = nil
	arg_4_0._revertRotate = nil
	arg_4_0._tempOccupyDict = nil
	arg_4_0._lightResourcePointDict = nil
	arg_4_0._isHasCritterDict = nil
end

function var_0_0.initMap(arg_5_0, arg_5_1)
	arg_5_0:clear()

	if not arg_5_1 or #arg_5_1 <= 0 then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if iter_5_1.use then
			local var_5_0 = RoomInfoHelper.serverInfoToBuildingInfo(iter_5_1)
			local var_5_1 = RoomBuildingMO.New()

			var_5_1:init(var_5_0)

			if var_5_1.config then
				arg_5_0:_addBuildingMO(var_5_1)
			end
		end
	end
end

function var_0_0._addBuildingMO(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.hexPoint

	arg_6_0._mapBuildingMODict[var_6_0.x] = arg_6_0._mapBuildingMODict[var_6_0.x] or {}
	arg_6_0._mapBuildingMODict[var_6_0.x][var_6_0.y] = arg_6_1

	local var_6_1 = arg_6_1.config.buildingType

	arg_6_0._type2BuildingDict[var_6_1] = arg_6_0._type2BuildingDict[var_6_1] or {}

	table.insert(arg_6_0._type2BuildingDict[var_6_1], arg_6_1)
	arg_6_0:addAtLast(arg_6_1)
end

function var_0_0._removeBuildingMO(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.hexPoint

	if arg_7_0._mapBuildingMODict[var_7_0.x] then
		arg_7_0._mapBuildingMODict[var_7_0.x][var_7_0.y] = nil
	end

	local var_7_1 = arg_7_1.config.buildingType

	if arg_7_0._type2BuildingDict[var_7_1] then
		tabletool.removeValue(arg_7_0._type2BuildingDict[var_7_1], arg_7_1)
	end

	arg_7_0:remove(arg_7_1)
end

function var_0_0.removeBuildingMO(arg_8_0, arg_8_1)
	arg_8_0:_removeBuildingMO(arg_8_1)
end

function var_0_0.addTempBuildingMO(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._tempBuildingMO then
		logError("暂不支持两个临时建筑")

		return
	end

	local var_9_0 = RoomInfoHelper.buildingMOToBuildingInfo(arg_9_1)

	arg_9_0._tempBuildingMO = RoomBuildingMO.New()
	var_9_0.buildingState = RoomBuildingEnum.BuildingState.Temp
	var_9_0.x = arg_9_2.x
	var_9_0.y = arg_9_2.y

	arg_9_0._tempBuildingMO:init(var_9_0)
	arg_9_0:_addBuildingMO(arg_9_0._tempBuildingMO)
	RoomResourceModel.instance:clearResourceAreaList()
	arg_9_0:clearCanConfirmPlaceDict()
	arg_9_0:clearTempOccupyDict()
	arg_9_0:clearLightResourcePoint()

	return arg_9_0._tempBuildingMO
end

function var_0_0.getTempBuildingMO(arg_10_0)
	return arg_10_0._tempBuildingMO
end

function var_0_0.changeTempBuildingMOUid(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._tempBuildingMO and tonumber(arg_11_0._tempBuildingMO.id) < 1 and arg_11_0._tempBuildingMO.buildingId == arg_11_2 then
		local var_11_0 = arg_11_0._tempBuildingMO.id

		if var_11_0 ~= arg_11_1 then
			arg_11_0:_removeBuildingMO(arg_11_0._tempBuildingMO)
			arg_11_0._tempBuildingMO:setUid(arg_11_1)
			arg_11_0:_addBuildingMO(arg_11_0._tempBuildingMO)
		end

		return true, var_11_0
	end
end

function var_0_0.changeTempBuildingMO(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0._tempBuildingMO then
		return
	end

	arg_12_0._tempBuildingMO.rotate = arg_12_2

	if arg_12_0._tempBuildingMO.hexPoint ~= arg_12_1 then
		arg_12_0:_removeBuildingMO(arg_12_0._tempBuildingMO)

		arg_12_0._tempBuildingMO.hexPoint = arg_12_1

		arg_12_0:_addBuildingMO(arg_12_0._tempBuildingMO)
	end

	RoomResourceModel.instance:clearResourceAreaList()
	arg_12_0:clearTempOccupyDict()
	arg_12_0:clearLightResourcePoint()
end

function var_0_0.removeTempBuildingMO(arg_13_0)
	if not arg_13_0._tempBuildingMO then
		return
	end

	arg_13_0:_removeBuildingMO(arg_13_0._tempBuildingMO)

	arg_13_0._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	arg_13_0:clearCanConfirmPlaceDict()
	arg_13_0:clearTempOccupyDict()
	arg_13_0:clearLightResourcePoint()
end

function var_0_0.placeTempBuildingMO(arg_14_0, arg_14_1)
	if not arg_14_0._tempBuildingMO then
		return
	end

	local var_14_0 = RoomBuildingMO.New()
	local var_14_1 = RoomInfoHelper.serverInfoToBuildingInfo(arg_14_1)

	var_14_0:init(var_14_1)

	arg_14_0._tempBuildingMO.uid = var_14_0.uid
	arg_14_0._tempBuildingMO.buildingId = var_14_0.buildingId
	arg_14_0._tempBuildingMO.rotate = var_14_0.rotate
	arg_14_0._tempBuildingMO.levels = var_14_0.levels
	arg_14_0._tempBuildingMO.resAreaDirection = var_14_0.resAreaDirection
	arg_14_0._tempBuildingMO.buildingState = RoomBuildingEnum.BuildingState.Map
	arg_14_0._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	arg_14_0:clearAllOccupyDict()
	arg_14_0:clearCanConfirmPlaceDict()
	arg_14_0:clearTempOccupyDict()
	arg_14_0:clearLightResourcePoint()
end

function var_0_0.revertTempBuildingMO(arg_15_0, arg_15_1)
	if arg_15_0._tempBuildingMO then
		logError("暂不支持两个临时建筑")

		return
	end

	arg_15_0._tempBuildingMO = arg_15_0:getBuildingMOById(arg_15_1)

	if not arg_15_0._tempBuildingMO then
		return
	end

	arg_15_0._tempBuildingMO.buildingState = RoomBuildingEnum.BuildingState.Revert
	arg_15_0._revertHexPoint = HexPoint(arg_15_0._tempBuildingMO.hexPoint.x, arg_15_0._tempBuildingMO.hexPoint.y)
	arg_15_0._revertRotate = arg_15_0._tempBuildingMO.rotate

	RoomResourceModel.instance:clearResourceAreaList()
	arg_15_0:clearAllOccupyDict()
	arg_15_0:clearCanConfirmPlaceDict()
	arg_15_0:clearTempOccupyDict()
	arg_15_0:clearLightResourcePoint()

	return arg_15_0._tempBuildingMO
end

function var_0_0.removeRevertBuildingMO(arg_16_0)
	if not arg_16_0._tempBuildingMO then
		return
	end

	local var_16_0 = arg_16_0._tempBuildingMO.buildingId

	arg_16_0._tempBuildingMO.hexPoint = arg_16_0._revertHexPoint
	arg_16_0._tempBuildingMO.rotate = arg_16_0._revertRotate
	arg_16_0._tempBuildingMO.buildingState = RoomBuildingEnum.BuildingState.Map
	arg_16_0._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	arg_16_0:clearAllOccupyDict()
	arg_16_0:clearCanConfirmPlaceDict()
	arg_16_0:clearTempOccupyDict()
	arg_16_0:clearLightResourcePoint()

	return var_16_0, arg_16_0._revertHexPoint, arg_16_0._revertRotate
end

function var_0_0.unUseRevertBuildingMO(arg_17_0)
	if not arg_17_0._tempBuildingMO then
		return
	end

	arg_17_0:_removeBuildingMO(arg_17_0._tempBuildingMO)

	arg_17_0._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	arg_17_0:clearCanConfirmPlaceDict()
	arg_17_0:clearTempOccupyDict()
	arg_17_0:clearLightResourcePoint()
end

function var_0_0.updateBuildingLevels(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:getBuildingMOById(arg_18_1):updateBuildingLevels(arg_18_2)
end

function var_0_0.getBuildingMO(arg_19_0, arg_19_1, arg_19_2)
	return arg_19_0._mapBuildingMODict[arg_19_1] and arg_19_0._mapBuildingMODict[arg_19_1][arg_19_2]
end

function var_0_0.getBuildingMOList(arg_20_0)
	return arg_20_0:getList()
end

function var_0_0.getBuildingMODict(arg_21_0)
	return arg_21_0._mapBuildingMODict
end

function var_0_0.getBuildingMOById(arg_22_0, arg_22_1)
	return arg_22_0:getById(arg_22_1)
end

function var_0_0.getCount(arg_23_0)
	local var_23_0 = arg_23_0:getCount()

	if arg_23_0._tempBuildingMO then
		var_23_0 = var_23_0 - 1
	end

	return var_23_0
end

function var_0_0.refreshAllOccupyDict(arg_24_0)
	arg_24_0._allOccupyDict = RoomBuildingHelper.getAllOccupyDict()
end

function var_0_0.getAllOccupyDict(arg_25_0)
	if not arg_25_0._allOccupyDict then
		arg_25_0:refreshAllOccupyDict()
	end

	return arg_25_0._allOccupyDict
end

function var_0_0.clearAllOccupyDict(arg_26_0)
	arg_26_0._allOccupyDict = nil
end

function var_0_0.getBuildingParam(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0._allOccupyDict then
		arg_27_0:refreshAllOccupyDict()
	end

	return arg_27_0._allOccupyDict[arg_27_1] and arg_27_0._allOccupyDict[arg_27_1][arg_27_2]
end

function var_0_0.isHasBuilding(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_0._allOccupyDict then
		arg_28_0:refreshAllOccupyDict()
	end

	if arg_28_0._allOccupyDict[arg_28_1] and arg_28_0._allOccupyDict[arg_28_1][arg_28_2] then
		return true
	end

	return false
end

function var_0_0.refreshCanConfirmPlaceDict(arg_29_0)
	if not arg_29_0._tempBuildingMO then
		arg_29_0._canConfirmPlaceDict = {}
	else
		arg_29_0._canConfirmPlaceDict = RoomBuildingHelper.getCanConfirmPlaceDict(arg_29_0._tempBuildingMO.buildingId, nil, nil, false, arg_29_0._tempBuildingMO.levels)
	end
end

function var_0_0.isCanConfirm(arg_30_0, arg_30_1)
	if not arg_30_0._canConfirmPlaceDict then
		arg_30_0:refreshCanConfirmPlaceDict()
	end

	return arg_30_0._canConfirmPlaceDict[arg_30_1.x] and arg_30_0._canConfirmPlaceDict[arg_30_1.x][arg_30_1.y]
end

function var_0_0.getCanConfirmPlaceDict(arg_31_0)
	if not arg_31_0._canConfirmPlaceDict then
		arg_31_0:refreshCanConfirmPlaceDict()
	end

	return arg_31_0._canConfirmPlaceDict
end

function var_0_0.clearCanConfirmPlaceDict(arg_32_0)
	arg_32_0._canConfirmPlaceDict = nil
end

function var_0_0.refreshTempOccupyDict(arg_33_0)
	if arg_33_0._tempBuildingMO then
		local var_33_0 = arg_33_0._tempBuildingMO.hexPoint
		local var_33_1 = RoomBuildingController.instance:isPressBuilding()

		var_33_0 = var_33_1 and var_33_1 == arg_33_0._tempBuildingMO.id and RoomBuildingController.instance:getPressBuildingHexPoint() or var_33_0
		arg_33_0._tempOccupyIndexDict = {}
		arg_33_0._tempOccupyDict = RoomBuildingHelper.getOccupyDict(arg_33_0._tempBuildingMO.buildingId, var_33_0, arg_33_0._tempBuildingMO.rotate)

		local var_33_2 = RoomBuildingAreaHelper.checkBuildingArea(arg_33_0._tempBuildingMO.buildingId, var_33_0, arg_33_0._tempBuildingMO.rotate)

		for iter_33_0, iter_33_1 in pairs(arg_33_0._tempOccupyDict) do
			for iter_33_2, iter_33_3 in pairs(iter_33_1) do
				arg_33_0._tempOccupyIndexDict[iter_33_3.index] = iter_33_3
				iter_33_3.checkBuildingAreaSuccess = var_33_2
			end
		end
	else
		arg_33_0._tempOccupyDict = {}
		arg_33_0._tempOccupyIndexDict = {}
	end
end

function var_0_0.isTempOccupy(arg_34_0, arg_34_1)
	if arg_34_0:getTempBuildingParam(arg_34_1.x, arg_34_1.y) then
		return true
	end

	return false
end

function var_0_0.getTempBuildingParam(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_0._tempOccupyDict then
		arg_35_0:refreshTempOccupyDict()
	end

	return arg_35_0._tempOccupyDict[arg_35_1] and arg_35_0._tempOccupyDict[arg_35_1][arg_35_2]
end

function var_0_0.getTempBuildingParamByPointIndex(arg_36_0, arg_36_1)
	if not arg_36_0._tempOccupyDict then
		arg_36_0:refreshTempOccupyDict()
	end

	return arg_36_0._tempOccupyIndexDict[arg_36_1]
end

function var_0_0.clearTempOccupyDict(arg_37_0)
	arg_37_0._tempOccupyDict = nil
	arg_37_0._tempOccupyIndexDict = nil
end

function var_0_0._refreshLightResourcePoint(arg_38_0)
	arg_38_0._lightResourcePointDict = {}

	if arg_38_0._tempBuildingMO then
		local var_38_0 = RoomBuildingHelper.getCostResource(arg_38_0._tempBuildingMO.buildingId)
		local var_38_1 = RoomResourceModel.instance:getResourceAreaList()

		for iter_38_0, iter_38_1 in ipairs(var_38_1) do
			if RoomBuildingHelper.checkCostResource(var_38_0, iter_38_1.resourceId) and RoomBuildingHelper.canContain(iter_38_1.hexPointDict, arg_38_0._tempBuildingMO.buildingId) then
				local var_38_2 = iter_38_1.area

				for iter_38_2, iter_38_3 in ipairs(var_38_2) do
					arg_38_0._lightResourcePointDict[tostring(iter_38_3)] = true
				end
			end
		end

		local var_38_3 = RoomBuildingController.instance:isPressBuilding()
		local var_38_4 = var_0_0.instance:getAllOccupyDict()
		local var_38_5 = RoomBuildingHelper.getOccupyDict(arg_38_0._tempBuildingMO.buildingId, arg_38_0._tempBuildingMO.hexPoint, arg_38_0._tempBuildingMO.rotate, arg_38_0._tempBuildingMO.buildingUid)

		for iter_38_4, iter_38_5 in pairs(var_38_5) do
			for iter_38_6, iter_38_7 in pairs(iter_38_5) do
				if iter_38_7.buildingUid ~= var_38_3 then
					for iter_38_8 = 0, 6 do
						local var_38_6 = ResourcePoint(HexPoint(iter_38_4, iter_38_6), iter_38_8)

						arg_38_0._lightResourcePointDict[tostring(var_38_6)] = nil
					end
				end
			end
		end

		for iter_38_9, iter_38_10 in pairs(var_38_4) do
			for iter_38_11, iter_38_12 in pairs(iter_38_10) do
				if iter_38_12.buildingUid ~= var_38_3 then
					for iter_38_13 = 0, 6 do
						local var_38_7 = ResourcePoint(HexPoint(iter_38_9, iter_38_11), iter_38_13)

						arg_38_0._lightResourcePointDict[tostring(var_38_7)] = nil
					end
				end
			end
		end
	end
end

function var_0_0.isLightResourcePoint(arg_39_0, arg_39_1)
	if not arg_39_0._lightResourcePointDict then
		arg_39_0:_refreshLightResourcePoint()
	end

	return arg_39_0._lightResourcePointDict[tostring(arg_39_1)]
end

function var_0_0.clearLightResourcePoint(arg_40_0)
	arg_40_0._lightResourcePointDict = nil
end

function var_0_0.getTotalReserve(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:getBuildingMOById(arg_41_1)

	if not var_41_0 then
		return 0
	end

	return var_41_0.config.reserve
end

function var_0_0.debugPlaceBuilding(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = RoomBuildingMO.New()

	var_42_0:init(arg_42_2)
	arg_42_0:_addBuildingMO(var_42_0)

	return var_42_0
end

function var_0_0.debugRootOutBuilding(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0:getBuildingMO(arg_43_1.x, arg_43_1.y)

	arg_43_0:_removeBuildingMO(var_43_0)

	return var_43_0
end

function var_0_0.getRevertHexPoint(arg_44_0)
	return arg_44_0._revertHexPoint
end

function var_0_0.getRevertRotate(arg_45_0)
	return arg_45_0._revertRotate
end

function var_0_0.getBuildingListByType(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_0._type2BuildingDict[arg_46_1]

	if var_46_0 and arg_46_2 then
		table.sort(var_46_0, RoomHelper.sortBuildingById)
	end

	return var_46_0
end

function var_0_0.isHasCritterByBuid(arg_47_0, arg_47_1)
	if not arg_47_0._isHasCritterDict then
		arg_47_0._isHasCritterDict = {}

		local var_47_0 = CritterModel.instance:getAllCritters()

		for iter_47_0, iter_47_1 in ipairs(var_47_0) do
			if iter_47_1.workInfo.buildingUid and iter_47_1.workInfo.buildingUid ~= 0 then
				arg_47_0._isHasCritterDict[iter_47_1.workInfo.buildingUid] = true
			elseif iter_47_1.restInfo.restBuildingUid and iter_47_1.restInfo.restBuildingUid ~= 0 then
				arg_47_0._isHasCritterDict[iter_47_1.restInfo.restBuildingUid] = true
			end
		end
	end

	return arg_47_0._isHasCritterDict[arg_47_1]
end

function var_0_0.getBuildingMoByBuildingId(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0:getList()

	if var_48_0 then
		for iter_48_0, iter_48_1 in pairs(var_48_0) do
			if iter_48_1.buildingId == arg_48_1 then
				return iter_48_1
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
