module("modules.logic.room.model.manufacture.ManufactureSlotMO", package.seeall)

slot0 = pureTable("ManufactureSlotMO")

function slot0.init(slot0, slot1)
	slot0._id = slot1.slotId
	slot0._priority = slot1.priority
	slot0._manufactureItemId = slot1.productionId
	slot0._slotStatus = slot1.slotStatus
	slot0._inventoryCount = slot1.inventoryCount
	slot0._beginTime = slot1.beginTime
	slot0._finishTime = slot1.nextFinishTime
	slot0._pauseTime = slot1.pauseTime
end

function slot0.getSlotId(slot0)
	return slot0._id
end

function slot0.getSlotPriority(slot0)
	return slot0._priority
end

function slot0.getFinishCount(slot0)
	slot1 = 0

	if slot0:getSlotState() == RoomManufactureEnum.SlotState.Complete then
		slot1 = slot0._inventoryCount
	elseif slot2 == RoomManufactureEnum.SlotState.Running or slot2 == RoomManufactureEnum.SlotState.Wait or slot2 == RoomManufactureEnum.SlotState.Stop then
		slot1 = ManufactureConfig.instance:getUnitCount(slot0:getSlotManufactureItemId())
	end

	return slot1
end

function slot0.getSlotManufactureItemId(slot0)
	return slot0._manufactureItemId
end

function slot0.getSlotState(slot0, slot1)
	if not slot1 and slot0._priority == RoomManufactureEnum.FirstSlotPriority and slot0._slotStatus == RoomManufactureEnum.SlotState.Wait then
		return RoomManufactureEnum.SlotState.Stop
	end

	return slot0._slotStatus or RoomManufactureEnum.SlotState.Locked
end

function slot0.getTotalNeedTime(slot0)
	slot1 = 0

	if slot0:getSlotState(true) == RoomManufactureEnum.SlotState.Running or slot2 == RoomManufactureEnum.SlotState.Stop then
		slot1 = slot0._finishTime - slot0._beginTime
	elseif slot2 == RoomManufactureEnum.SlotState.Wait and slot0:getSlotManufactureItemId() and slot3 ~= 0 then
		slot1 = ManufactureConfig.instance:getNeedTime(slot3)
	end

	return math.max(0, slot1)
end

function slot0.getElapsedTime(slot0)
	slot1 = 0

	if slot0:getSlotState() == RoomManufactureEnum.SlotState.Running then
		slot1 = ServerTime.now() - slot0._beginTime
	elseif slot2 == RoomManufactureEnum.SlotState.Stop then
		slot1 = slot0._pauseTime - slot0._beginTime
	end

	return math.max(0, slot1)
end

function slot0.getSlotProgress(slot0)
	slot1 = 0

	if slot0:getTotalNeedTime() and slot3 > 0 then
		slot1 = slot0:getElapsedTime() / slot3
	end

	return Mathf.Clamp(slot1, 0, 1)
end

function slot0.getSlotRemainSecTime(slot0)
	slot1 = 0
	slot3 = slot0:getTotalNeedTime()

	return Mathf.Clamp(slot3 - slot0:getElapsedTime(), 0, slot3)
end

function slot0.getSlotRemainStrTime(slot0, slot1)
	return ManufactureController.instance:getFormatTime(slot0:getSlotRemainSecTime(), slot1)
end

function slot0.getSlotAccelerateEff(slot0, slot1)
	if slot0:getSlotState(true) ~= RoomManufactureEnum.SlotState.Running then
		return 0
	end

	if ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, slot1) then
		slot2 = (slot0._finishTime - slot0._beginTime) * tonumber(slot4.effect) / ManufactureConfig.instance:getNeedTime(slot0:getSlotManufactureItemId())
	end

	return slot2
end

return slot0
