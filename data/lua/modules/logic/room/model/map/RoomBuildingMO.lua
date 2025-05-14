module("modules.logic.room.model.map.RoomBuildingMO", package.seeall)

local var_0_0 = pureTable("RoomBuildingMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:setUid(arg_1_1.uid)

	arg_1_0.buildingId = arg_1_1.buildingId or arg_1_1.defineId
	arg_1_0.rotate = arg_1_1.rotate or 0
	arg_1_0.buildingState = arg_1_1.buildingState
	arg_1_0.use = arg_1_1.use
	arg_1_0.level = arg_1_1.level or 0

	if arg_1_0:isInMap() then
		arg_1_0.hexPoint = HexPoint(arg_1_1.x, arg_1_1.y)
		arg_1_0.resAreaDirection = arg_1_1.resAreaDirection
	end

	arg_1_0:refreshCfg()

	arg_1_0._currentInteractionId = nil
end

function var_0_0.setUid(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.uid = arg_2_1
	arg_2_0.buildingUid = arg_2_1
end

function var_0_0.refreshCfg(arg_3_0)
	arg_3_0.config = RoomConfig.instance:getBuildingConfig(arg_3_0.buildingId)

	if not arg_3_0.config then
		logError("找不到建筑id: " .. tostring(arg_3_0.buildingId))
	elseif arg_3_0.config.canLevelUp then
		local var_3_0 = RoomConfig.instance:getLevelGroupConfig(arg_3_0.buildingId, arg_3_0.level)

		if var_3_0 then
			arg_3_0.config = RoomHelper.mergeCfg(arg_3_0.config, var_3_0)
		end
	end
end

function var_0_0.isInMap(arg_4_0)
	return arg_4_0.buildingState == RoomBuildingEnum.BuildingState.Map or arg_4_0.buildingState == RoomBuildingEnum.BuildingState.Temp or arg_4_0.buildingState == RoomBuildingEnum.BuildingState.Revert
end

function var_0_0.updateBuildingLevels(arg_5_0)
	return
end

function var_0_0.setCurrentInteractionId(arg_6_0, arg_6_1)
	arg_6_0._currentInteractionId = arg_6_1
end

function var_0_0.getCurrentInteractionId(arg_7_0)
	return arg_7_0._currentInteractionId
end

function var_0_0.getInteractMO(arg_8_0)
	if arg_8_0:checkSameType(RoomBuildingEnum.BuildingType.Interact) then
		if not arg_8_0._interactMO then
			arg_8_0._interactMO = RoomInteractBuildingMO.New()

			arg_8_0._interactMO:init(arg_8_0)
		end

		return arg_8_0._interactMO
	end

	return nil
end

function var_0_0.getPlaceAudioId(arg_9_0, arg_9_1)
	if arg_9_0.config and arg_9_0.config.placeAudio and arg_9_0.config.placeAudio ~= 0 then
		return arg_9_0.config.placeAudio
	end

	if arg_9_1 then
		return 0
	end

	return AudioEnum.Room.play_ui_home_board_lay
end

function var_0_0.getLevel(arg_10_0)
	return arg_10_0.level
end

function var_0_0.getIcon(arg_11_0)
	if arg_11_0.config then
		if arg_11_0.config.canLevelUp and arg_11_0.levelConfig and not string.nilorempty(arg_11_0.levelConfig.icon) then
			return arg_11_0.levelConfig.icon
		end

		return arg_11_0.config.icon
	end
end

function var_0_0.getLevelUpIcon(arg_12_0)
	local var_12_0

	if arg_12_0.config and arg_12_0.config.canLevelUp then
		var_12_0 = arg_12_0.config.levelUpIcon
	end

	return var_12_0
end

function var_0_0._getCfgParam(arg_13_0)
	return
end

function var_0_0.getCanPlaceCritterCount(arg_14_0)
	local var_14_0 = ManufactureModel.instance:getTradeLevel()

	return (ManufactureConfig.instance:getBuildingCanPlaceCritterCount(arg_14_0.buildingId, var_14_0))
end

function var_0_0.getWorkingCritter(arg_15_0, arg_15_1)
	local var_15_0
	local var_15_1 = ManufactureModel.instance:getManufactureMOById(arg_15_0.id)

	if var_15_1 then
		var_15_0 = var_15_1:getWorkingCritter(arg_15_1)
	end

	return var_15_0
end

function var_0_0.getCritterWorkSlot(arg_16_0, arg_16_1)
	local var_16_0
	local var_16_1 = ManufactureModel.instance:getManufactureMOById(arg_16_0.id)

	if var_16_1 then
		var_16_0 = var_16_1:getCritterWorkSlot(arg_16_1)
	end

	return var_16_0
end

function var_0_0.getSeatSlotMO(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0
	local var_17_1 = ManufactureModel.instance:getCritterBuildingMOById(arg_17_0.id)

	if var_17_1 then
		var_17_0 = var_17_1:getSeatSlotMO(arg_17_1, arg_17_2)
	end

	return var_17_0
end

function var_0_0.getRestingCritter(arg_18_0, arg_18_1)
	local var_18_0
	local var_18_1 = arg_18_0:getSeatSlotMO(arg_18_1)

	if var_18_1 then
		var_18_0 = var_18_1:getRestingCritter()
	end

	return var_18_0
end

function var_0_0.isSeatSlotEmpty(arg_19_0, arg_19_1)
	local var_19_0 = true
	local var_19_1 = arg_19_0:getSeatSlotMO(arg_19_1)

	if var_19_1 then
		var_19_0 = var_19_1:isEmpty()
	end

	return var_19_0
end

function var_0_0.isCritterInSeatSlot(arg_20_0, arg_20_1)
	local var_20_0
	local var_20_1 = ManufactureModel.instance:getCritterBuildingMOById(arg_20_0.id)

	if var_20_1 then
		var_20_0 = var_20_1:isCritterInSeatSlot(arg_20_1)
	end

	return var_20_0
end

function var_0_0.getNextEmptyCritterSeatSlot(arg_21_0)
	local var_21_0
	local var_21_1 = ManufactureModel.instance:getCritterBuildingMOById(arg_21_0.id)

	if var_21_1 then
		var_21_0 = var_21_1:getNextEmptyCritterSeatSlot()
	end

	return var_21_0
end

function var_0_0.isCanClaimProduction(arg_22_0)
	local var_22_0 = false
	local var_22_1 = ManufactureModel.instance:getManufactureMOById(arg_22_0.id)

	if var_22_1 then
		var_22_0 = var_22_1:isHasCompletedProduction()
	end

	return var_22_0
end

function var_0_0.getNewerCompleteManufactureItem(arg_23_0)
	local var_23_0
	local var_23_1 = ManufactureModel.instance:getManufactureMOById(arg_23_0.id)

	if var_23_1 then
		var_23_0 = var_23_1:getNewerCompleteManufactureItem()
	end

	return var_23_0
end

function var_0_0.getAllUnlockedSlotIdList(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = ManufactureModel.instance:getManufactureMOById(arg_24_0.id)

	if var_24_1 then
		var_24_0 = var_24_1:getAllUnlockedSlotIdList()
	end

	return var_24_0
end

function var_0_0.getManufactureState(arg_25_0)
	local var_25_0
	local var_25_1 = ManufactureModel.instance:getManufactureMOById(arg_25_0.id)

	if var_25_1 then
		var_25_0 = var_25_1:getManufactureState()
	end

	return var_25_0
end

function var_0_0.getManufactureProgress(arg_26_0)
	local var_26_0 = 0
	local var_26_1 = ""
	local var_26_2 = ManufactureModel.instance:getManufactureMOById(arg_26_0.id)

	if var_26_2 then
		var_26_0, var_26_1 = var_26_2:getManufactureProgress()
	end

	return var_26_0, var_26_1
end

function var_0_0.getOccupySlotCount(arg_27_0, arg_27_1)
	local var_27_0 = 0
	local var_27_1 = ManufactureModel.instance:getManufactureMOById(arg_27_0.id)

	if var_27_1 then
		var_27_0 = var_27_1:getOccupySlotCount(arg_27_1)
	end

	return var_27_0
end

function var_0_0.getEmptySlotIdList(arg_28_0)
	local var_28_0 = {}
	local var_28_1 = ManufactureModel.instance:getManufactureMOById(arg_28_0.id)

	if var_28_1 then
		var_28_0 = var_28_1:getEmptySlotIdList()
	end

	return var_28_0
end

function var_0_0.getSlotIdInProgress(arg_29_0)
	local var_29_0
	local var_29_1 = ManufactureModel.instance:getManufactureMOById(arg_29_0.id)

	if var_29_1 then
		var_29_0 = var_29_1:getSlotIdInProgress()
	end

	return var_29_0
end

function var_0_0.getCanChangeMaxPriority(arg_30_0)
	local var_30_0
	local var_30_1 = ManufactureModel.instance:getManufactureMOById(arg_30_0.id)

	if var_30_1 then
		var_30_0 = var_30_1:getCanChangeMaxPriority()
	end

	return var_30_0
end

function var_0_0.getSlotMO(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0
	local var_31_1 = ManufactureModel.instance:getManufactureMOById(arg_31_0.id)

	if var_31_1 then
		var_31_0 = var_31_1:getSlotMO(arg_31_1, arg_31_2)
	end

	return var_31_0
end

function var_0_0.getSlotState(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = RoomManufactureEnum.SlotState.Locked
	local var_32_1 = arg_32_0:getSlotMO(arg_32_1)

	if var_32_1 then
		var_32_0 = var_32_1:getSlotState(arg_32_2)
	end

	return var_32_0
end

function var_0_0.getSlotProgress(arg_33_0, arg_33_1)
	local var_33_0 = 0
	local var_33_1 = arg_33_0:getSlotMO(arg_33_1)

	if var_33_1 then
		var_33_0 = var_33_1:getSlotProgress()
	end

	return var_33_0
end

function var_0_0.getSlotRemainStrTime(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = ""
	local var_34_1 = arg_34_0:getSlotMO(arg_34_1)

	if var_34_1 then
		var_34_0 = var_34_1:getSlotRemainStrTime(arg_34_2)
	end

	return var_34_0
end

function var_0_0.getSlotRemainSecTime(arg_35_0, arg_35_1)
	local var_35_0 = 0
	local var_35_1 = arg_35_0:getSlotMO(arg_35_1)

	if var_35_1 then
		var_35_0 = var_35_1:getSlotRemainSecTime()
	end

	return var_35_0
end

function var_0_0.getAccelerateEff(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = 0
	local var_36_1 = arg_36_0:getSlotMO(arg_36_1)

	if var_36_1 then
		var_36_0 = var_36_1:getSlotAccelerateEff(arg_36_2)
	end

	return var_36_0
end

function var_0_0.getSlotManufactureItemId(arg_37_0, arg_37_1)
	local var_37_0
	local var_37_1 = arg_37_0:getSlotMO(arg_37_1)

	if var_37_1 then
		var_37_0 = var_37_1:getSlotManufactureItemId()
	end

	return var_37_0
end

function var_0_0.getSlotFinishCount(arg_38_0, arg_38_1)
	local var_38_0 = 0
	local var_38_1 = arg_38_0:getSlotMO(arg_38_1)

	if var_38_1 then
		var_38_0 = var_38_1:getFinishCount()
	end

	return var_38_0
end

function var_0_0.getSlotPriority(arg_39_0, arg_39_1)
	local var_39_0
	local var_39_1 = arg_39_0:getSlotMO(arg_39_1)

	if var_39_1 then
		var_39_0 = var_39_1:getSlotPriority()
	end

	return var_39_0
end

function var_0_0.checkSameType(arg_40_0, arg_40_1)
	if arg_40_0.config and arg_40_0.config.buildingType == arg_40_1 then
		return true
	end

	return false
end

function var_0_0.getSlot2CritterDict(arg_41_0)
	local var_41_0 = {}
	local var_41_1 = ManufactureModel.instance:getManufactureMOById(arg_41_0.id)

	if var_41_1 then
		var_41_0 = var_41_1:getSlot2CritterDict()
	end

	return var_41_0
end

function var_0_0.isBuildingArea(arg_42_0)
	if arg_42_0.config and RoomBuildingEnum.BuildingArea[arg_42_0.config.buildingType] then
		return true
	end

	return false
end

function var_0_0.isAreaMainBuilding(arg_43_0)
	if arg_43_0.config and arg_43_0.config.isAreaMainBuilding then
		return true
	end

	return false
end

return var_0_0
