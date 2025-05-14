module("modules.logic.room.model.manufacture.RoomBuildingManufactureMO", package.seeall)

local var_0_0 = pureTable("RoomBuildingManufactureMO")

local function var_0_1(arg_1_0, arg_1_1)
	return arg_1_0:getSlotPriority() < arg_1_1:getSlotPriority()
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.buildingUid
	arg_2_0.uid = arg_2_0.id

	arg_2_0:setSlotInfos(arg_2_1.slotInfos)
	arg_2_0:setWorkCritterInfoList(arg_2_1.critterInfos, true)
end

function var_0_0.setSlotInfos(arg_3_0, arg_3_1)
	arg_3_0.slotMODict = {}
	arg_3_0.slotMOList = {}

	if arg_3_1 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			local var_3_0 = iter_3_1.slotId
			local var_3_1 = ManufactureSlotMO.New()

			var_3_1:init(iter_3_1)

			arg_3_0.slotMODict[var_3_0] = var_3_1
			arg_3_0.slotMOList[#arg_3_0.slotMOList + 1] = var_3_1
		end

		table.sort(arg_3_0.slotMOList, var_0_1)
	end

	arg_3_0:setNeedMatDict()
end

function var_0_0.setWorkCritterInfoList(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 then
		arg_4_0:clearAllWorkCritterInfo()
	end

	if arg_4_1 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			arg_4_0:setWorkCritterInfo(iter_4_1)
		end
	end
end

function var_0_0.setWorkCritterInfo(arg_5_0, arg_5_1)
	if not arg_5_0._critterWorkInfo then
		arg_5_0:clearAllWorkCritterInfo()
	end

	local var_5_0 = arg_5_1.critterUid
	local var_5_1 = arg_5_1.critterSlotId

	if var_5_0 and var_5_0 ~= CritterEnum.InvalidCritterUid then
		arg_5_0._critterWorkInfo.slotDict[var_5_1] = var_5_0
		arg_5_0._critterWorkInfo.critterDict[var_5_0] = var_5_1
	else
		arg_5_0:removeWorkCritterInfo(var_5_1)
	end
end

function var_0_0.removeWorkCritterInfo(arg_6_0, arg_6_1)
	if not arg_6_0._critterWorkInfo or not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_0._critterWorkInfo.slotDict[arg_6_1]

	arg_6_0._critterWorkInfo.slotDict[arg_6_1] = nil

	if var_6_0 then
		arg_6_0._critterWorkInfo.critterDict[var_6_0] = nil
	end
end

function var_0_0.clearAllWorkCritterInfo(arg_7_0)
	arg_7_0._critterWorkInfo = {
		slotDict = {},
		critterDict = {}
	}
end

function var_0_0.setNeedMatDict(arg_8_0)
	arg_8_0._needMatDict = {}

	local var_8_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_8_0.id)
	local var_8_1 = RoomConfig.instance:getBuildingType(var_8_0 and var_8_0.buildingId)

	if var_8_1 == RoomBuildingEnum.BuildingType.Process or var_8_1 == RoomBuildingEnum.BuildingType.Manufacture then
		for iter_8_0, iter_8_1 in pairs(arg_8_0.slotMODict) do
			local var_8_2 = iter_8_1:getSlotManufactureItemId()

			if var_8_2 and var_8_2 ~= 0 then
				local var_8_3 = ManufactureConfig.instance:getNeedMatItemList(var_8_2)

				for iter_8_2, iter_8_3 in ipairs(var_8_3) do
					local var_8_4 = iter_8_3.id
					local var_8_5 = ManufactureConfig.instance:getItemId(var_8_4)
					local var_8_6 = iter_8_3.quantity

					arg_8_0._needMatDict[var_8_5] = var_8_6 + (arg_8_0._needMatDict[var_8_5] or 0)
				end
			end
		end
	end
end

function var_0_0.getBuildingUid(arg_9_0)
	return arg_9_0.uid
end

function var_0_0.getManufactureState(arg_10_0)
	local var_10_0 = RoomManufactureEnum.ManufactureState.Wait

	for iter_10_0, iter_10_1 in pairs(arg_10_0.slotMODict) do
		local var_10_1 = iter_10_1:getSlotState()

		if var_10_1 == RoomManufactureEnum.SlotState.Running then
			var_10_0 = RoomManufactureEnum.ManufactureState.Running

			break
		end

		if var_10_1 == RoomManufactureEnum.SlotState.Stop then
			var_10_0 = RoomManufactureEnum.ManufactureState.Stop
		end
	end

	return var_10_0
end

function var_0_0.getManufactureProgress(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = 0
	local var_11_2 = 0

	for iter_11_0, iter_11_1 in pairs(arg_11_0.slotMODict) do
		var_11_1 = var_11_1 + iter_11_1:getElapsedTime()

		local var_11_3 = 0
		local var_11_4 = iter_11_1:getSlotManufactureItemId()

		if var_11_4 and var_11_4 ~= 0 then
			var_11_3 = ManufactureConfig.instance:getNeedTime(var_11_4)
		end

		var_11_0 = var_11_0 + var_11_3
		var_11_2 = var_11_2 + iter_11_1:getSlotRemainSecTime()
	end

	local var_11_5 = var_11_1 / var_11_0
	local var_11_6 = TimeUtil.second2TimeString(var_11_2, true)

	return var_11_5, var_11_6
end

function var_0_0.getSlotMO(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.slotMODict[arg_12_1]

	if not var_12_0 and arg_12_2 then
		logError(string.format("RoomBuildingManufactureMO:getSlotMO error, slotId:%s", arg_12_1))
	end

	return var_12_0
end

function var_0_0.getAllUnlockedSlotMOList(arg_13_0)
	return arg_13_0.slotMOList or {}
end

function var_0_0.getAllUnlockedSlotIdList(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = arg_14_0:getAllUnlockedSlotMOList()

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		var_14_0[iter_14_0] = iter_14_1:getSlotId()
	end

	return var_14_0
end

function var_0_0.getOccupySlotCount(arg_15_0, arg_15_1)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0.slotMODict) do
		local var_15_1 = iter_15_1:getSlotManufactureItemId()

		if var_15_1 and var_15_1 ~= 0 then
			if arg_15_1 then
				if not (iter_15_1:getSlotState() == RoomManufactureEnum.SlotState.Complete) then
					var_15_0 = var_15_0 + 1
				end
			else
				var_15_0 = var_15_0 + 1
			end
		end
	end

	return var_15_0
end

function var_0_0.getSlotIdInProgress(arg_16_0)
	local var_16_0

	for iter_16_0, iter_16_1 in pairs(arg_16_0.slotMODict) do
		if iter_16_1:getSlotState() == RoomManufactureEnum.SlotState.Running then
			var_16_0 = iter_16_1:getSlotId()

			break
		end
	end

	return var_16_0
end

function var_0_0.getCanChangeMaxPriority(arg_17_0)
	local var_17_0

	if arg_17_0.slotMODict then
		for iter_17_0, iter_17_1 in pairs(arg_17_0.slotMODict) do
			local var_17_1 = iter_17_1:getSlotState()

			if var_17_1 == RoomManufactureEnum.SlotState.Running or var_17_1 == RoomManufactureEnum.SlotState.Stop or var_17_1 == RoomManufactureEnum.SlotState.Wait then
				local var_17_2 = iter_17_1:getSlotPriority()

				if not var_17_0 or var_17_0 < var_17_2 then
					var_17_0 = var_17_2
				end
			end
		end
	end

	return var_17_0
end

function var_0_0.isHasCompletedProduction(arg_18_0)
	local var_18_0 = false

	for iter_18_0, iter_18_1 in pairs(arg_18_0.slotMODict) do
		if iter_18_1:getSlotState() == RoomManufactureEnum.SlotState.Complete then
			var_18_0 = true

			break
		end
	end

	return var_18_0
end

function var_0_0.getNewerCompleteManufactureItem(arg_19_0)
	local var_19_0
	local var_19_1

	for iter_19_0, iter_19_1 in pairs(arg_19_0.slotMODict) do
		if iter_19_1:getSlotState() == RoomManufactureEnum.SlotState.Complete then
			local var_19_2 = iter_19_1:getSlotPriority()

			if not var_19_1 or var_19_1 < var_19_2 then
				var_19_1 = var_19_2
				var_19_0 = iter_19_1:getSlotManufactureItemId()
			end
		end
	end

	return var_19_0
end

function var_0_0.getManufactureItemFinishCount(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = 0
	local var_20_1 = ManufactureConfig.instance:getItemId(arg_20_1)

	for iter_20_0, iter_20_1 in pairs(arg_20_0.slotMODict) do
		local var_20_2 = false
		local var_20_3 = iter_20_1:getSlotManufactureItemId()

		if arg_20_3 then
			if var_20_3 and var_20_3 ~= 0 then
				var_20_2 = var_20_1 == ManufactureConfig.instance:getItemId(var_20_3)
			end
		else
			var_20_2 = var_20_3 == arg_20_1
		end

		if var_20_2 then
			local var_20_4 = iter_20_1:getSlotState()

			if not arg_20_2 or var_20_4 == RoomManufactureEnum.SlotState.Complete then
				var_20_0 = var_20_0 + iter_20_1:getFinishCount()
			end

			if not arg_20_3 then
				break
			end
		end
	end

	return var_20_0
end

function var_0_0.getWorkingCritter(arg_21_0, arg_21_1)
	local var_21_0

	if arg_21_0._critterWorkInfo and arg_21_0._critterWorkInfo.slotDict then
		var_21_0 = arg_21_0._critterWorkInfo.slotDict[arg_21_1]
	end

	return var_21_0
end

function var_0_0.getCritterWorkSlot(arg_22_0, arg_22_1)
	local var_22_0

	if arg_22_0._critterWorkInfo and arg_22_0._critterWorkInfo.critterDict then
		var_22_0 = arg_22_0._critterWorkInfo.critterDict[arg_22_1]
	end

	return var_22_0
end

function var_0_0.getSlot2CritterDict(arg_23_0)
	local var_23_0

	if arg_23_0._critterWorkInfo and arg_23_0._critterWorkInfo.slotDict then
		var_23_0 = tabletool.copy(arg_23_0._critterWorkInfo.slotDict)
	end

	return var_23_0
end

function var_0_0.getEmptySlotIdList(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = arg_24_0:getAllUnlockedSlotMOList()

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		if (iter_24_1 and iter_24_1:getSlotState()) == RoomManufactureEnum.SlotState.None then
			var_24_0[#var_24_0 + 1] = iter_24_1:getSlotId()
		end
	end

	return var_24_0
end

function var_0_0.getNextEmptySlot(arg_25_0)
	local var_25_0
	local var_25_1 = arg_25_0:getAllUnlockedSlotMOList()

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		if (iter_25_1 and iter_25_1:getSlotState()) == RoomManufactureEnum.SlotState.None then
			var_25_0 = iter_25_1:getSlotId()

			break
		end
	end

	return var_25_0
end

function var_0_0.getNextEmptyCritterSlot(arg_26_0)
	local var_26_0
	local var_26_1 = ManufactureModel.instance:getTradeLevel()
	local var_26_2 = 0
	local var_26_3 = RoomMapBuildingModel.instance:getBuildingMOById(arg_26_0.id)

	if var_26_3 then
		var_26_2 = ManufactureConfig.instance:getBuildingCanPlaceCritterCount(var_26_3.buildingId, var_26_1)
	end

	if var_26_2 > 0 then
		for iter_26_0 = 0, var_26_2 - 1 do
			if not arg_26_0:getWorkingCritter(iter_26_0) then
				var_26_0 = iter_26_0

				break
			end
		end
	end

	return var_26_0
end

function var_0_0.getNeedMatDict(arg_27_0)
	return arg_27_0._needMatDict or {}
end

return var_0_0
