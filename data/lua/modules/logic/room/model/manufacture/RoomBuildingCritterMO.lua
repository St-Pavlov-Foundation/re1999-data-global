module("modules.logic.room.model.manufacture.RoomBuildingCritterMO", package.seeall)

local var_0_0 = pureTable("RoomBuildingCritterMO")

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0 and arg_1_0:getSeatSlotId()
	local var_1_1 = arg_1_1 and arg_1_1:getSeatSlotId()

	if not var_1_0 or not var_1_1 then
		return false
	end

	return var_1_0 < var_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.buildingUid
	arg_2_0.uid = arg_2_0.id

	arg_2_0:setSeatSlotInfos(arg_2_1.unlockSlotInfos)
end

function var_0_0.setSeatSlotInfos(arg_3_0, arg_3_1)
	arg_3_0.seatSlotMODict = {}
	arg_3_0.seatSlotMOList = {}

	if arg_3_1 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			local var_3_0 = CritterSeatSlotMO.New()

			var_3_0:init(iter_3_1)

			arg_3_0.seatSlotMODict[iter_3_1.critterSlotId] = var_3_0
			arg_3_0.seatSlotMOList[#arg_3_0.seatSlotMOList + 1] = var_3_0
		end

		table.sort(arg_3_0.seatSlotMOList, var_0_1)
	end
end

function var_0_0.unlockSeatSlot(arg_4_0, arg_4_1)
	if arg_4_0.seatSlotMODict[arg_4_1] then
		return
	end

	local var_4_0 = CritterSeatSlotMO.New()
	local var_4_1 = {
		critterSlotId = arg_4_1
	}

	var_4_0:init(var_4_1)

	arg_4_0.seatSlotMODict[var_4_1.critterSlotId] = var_4_0
	arg_4_0.seatSlotMOList[#arg_4_0.seatSlotMOList + 1] = var_4_0

	table.sort(arg_4_0.seatSlotMOList, var_0_1)
end

function var_0_0.getBuildingUid(arg_5_0)
	return arg_5_0.uid
end

function var_0_0.getSeatSlotMO(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.seatSlotMODict[arg_6_1]

	if not var_6_0 and arg_6_2 then
		logError(string.format("RoomBuildingCritterMO:getSeatSlotMO error, slotId:%s", arg_6_1))
	end

	return var_6_0
end

function var_0_0.getSeatSlot2CritterDict(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0.seatSlotMODict) do
		if not iter_7_1:isEmpty() then
			var_7_0[iter_7_0] = iter_7_1:getRestingCritter()
		end
	end

	return var_7_0
end

function var_0_0.isCritterInSeatSlot(arg_8_0, arg_8_1)
	local var_8_0

	for iter_8_0, iter_8_1 in pairs(arg_8_0.seatSlotMODict) do
		local var_8_1 = iter_8_1:getRestingCritter()

		if var_8_1 and var_8_1 == arg_8_1 then
			var_8_0 = iter_8_0

			break
		end
	end

	return var_8_0
end

function var_0_0.getNextEmptyCritterSeatSlot(arg_9_0)
	local var_9_0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.seatSlotMOList) do
		if iter_9_1:isEmpty() then
			var_9_0 = iter_9_1:getSeatSlotId()

			break
		end
	end

	return var_9_0
end

function var_0_0.removeRestingCritter(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:isCritterInSeatSlot(arg_10_1)
	local var_10_1 = arg_10_0:getSeatSlotMO(var_10_0)

	if var_10_1 then
		var_10_1:removeCritter()
	end
end

return var_0_0
