module("modules.logic.room.model.manufacture.ManufactureSlotMO", package.seeall)

local var_0_0 = pureTable("ManufactureSlotMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._id = arg_1_1.slotId
	arg_1_0._priority = arg_1_1.priority
	arg_1_0._manufactureItemId = arg_1_1.productionId
	arg_1_0._slotStatus = arg_1_1.slotStatus
	arg_1_0._inventoryCount = arg_1_1.inventoryCount
	arg_1_0._beginTime = arg_1_1.beginTime
	arg_1_0._finishTime = arg_1_1.nextFinishTime
	arg_1_0._pauseTime = arg_1_1.pauseTime
end

function var_0_0.getSlotId(arg_2_0)
	return arg_2_0._id
end

function var_0_0.getSlotPriority(arg_3_0)
	return arg_3_0._priority
end

function var_0_0.getFinishCount(arg_4_0)
	local var_4_0 = 0
	local var_4_1 = arg_4_0:getSlotState()

	if var_4_1 == RoomManufactureEnum.SlotState.Complete then
		var_4_0 = arg_4_0._inventoryCount
	elseif var_4_1 == RoomManufactureEnum.SlotState.Running or var_4_1 == RoomManufactureEnum.SlotState.Wait or var_4_1 == RoomManufactureEnum.SlotState.Stop then
		local var_4_2 = arg_4_0:getSlotManufactureItemId()

		var_4_0 = ManufactureConfig.instance:getUnitCount(var_4_2)
	end

	return var_4_0
end

function var_0_0.getSlotManufactureItemId(arg_5_0)
	return arg_5_0._manufactureItemId
end

function var_0_0.getSlotState(arg_6_0, arg_6_1)
	if not arg_6_1 and arg_6_0._priority == RoomManufactureEnum.FirstSlotPriority and arg_6_0._slotStatus == RoomManufactureEnum.SlotState.Wait then
		return RoomManufactureEnum.SlotState.Stop
	end

	return arg_6_0._slotStatus or RoomManufactureEnum.SlotState.Locked
end

function var_0_0.getTotalNeedTime(arg_7_0)
	local var_7_0 = 0
	local var_7_1 = arg_7_0:getSlotState(true)

	if var_7_1 == RoomManufactureEnum.SlotState.Running or var_7_1 == RoomManufactureEnum.SlotState.Stop then
		var_7_0 = arg_7_0._finishTime - arg_7_0._beginTime
	elseif var_7_1 == RoomManufactureEnum.SlotState.Wait then
		local var_7_2 = arg_7_0:getSlotManufactureItemId()

		if var_7_2 and var_7_2 ~= 0 then
			var_7_0 = ManufactureConfig.instance:getNeedTime(var_7_2)
		end
	end

	return math.max(0, var_7_0)
end

function var_0_0.getElapsedTime(arg_8_0)
	local var_8_0 = 0
	local var_8_1 = arg_8_0:getSlotState()

	if var_8_1 == RoomManufactureEnum.SlotState.Running then
		var_8_0 = ServerTime.now() - arg_8_0._beginTime
	elseif var_8_1 == RoomManufactureEnum.SlotState.Stop then
		var_8_0 = arg_8_0._pauseTime - arg_8_0._beginTime
	end

	return math.max(0, var_8_0)
end

function var_0_0.getSlotProgress(arg_9_0)
	local var_9_0 = 0
	local var_9_1 = arg_9_0:getElapsedTime()
	local var_9_2 = arg_9_0:getTotalNeedTime()

	if var_9_2 and var_9_2 > 0 then
		var_9_0 = var_9_1 / var_9_2
	end

	return Mathf.Clamp(var_9_0, 0, 1)
end

function var_0_0.getSlotRemainSecTime(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = arg_10_0:getElapsedTime()
	local var_10_2 = arg_10_0:getTotalNeedTime()
	local var_10_3 = var_10_2 - var_10_1

	return Mathf.Clamp(var_10_3, 0, var_10_2)
end

function var_0_0.getSlotRemainStrTime(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getSlotRemainSecTime()

	return (ManufactureController.instance:getFormatTime(var_11_0, arg_11_1))
end

function var_0_0.getSlotAccelerateEff(arg_12_0, arg_12_1)
	local var_12_0 = 0

	if arg_12_0:getSlotState(true) ~= RoomManufactureEnum.SlotState.Running then
		return var_12_0
	end

	local var_12_1 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, arg_12_1)

	if var_12_1 then
		local var_12_2 = arg_12_0:getSlotManufactureItemId()
		local var_12_3 = ManufactureConfig.instance:getNeedTime(var_12_2)
		local var_12_4 = tonumber(var_12_1.effect)

		var_12_0 = (arg_12_0._finishTime - arg_12_0._beginTime) * (var_12_4 / var_12_3)
	end

	return var_12_0
end

return var_0_0
