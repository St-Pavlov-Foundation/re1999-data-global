module("modules.logic.room.model.manufacture.RoomBuildingManufactureMO", package.seeall)

slot0 = pureTable("RoomBuildingManufactureMO")

function slot1(slot0, slot1)
	return slot0:getSlotPriority() < slot1:getSlotPriority()
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.buildingUid
	slot0.uid = slot0.id

	slot0:setSlotInfos(slot1.slotInfos)
	slot0:setWorkCritterInfoList(slot1.critterInfos, true)
end

function slot0.setSlotInfos(slot0, slot1)
	slot0.slotMODict = {}
	slot0.slotMOList = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot8 = ManufactureSlotMO.New()

			slot8:init(slot6)

			slot0.slotMODict[slot6.slotId] = slot8
			slot0.slotMOList[#slot0.slotMOList + 1] = slot8
		end

		table.sort(slot0.slotMOList, uv0)
	end

	slot0:setNeedMatDict()
end

function slot0.setWorkCritterInfoList(slot0, slot1, slot2)
	if slot2 then
		slot0:clearAllWorkCritterInfo()
	end

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot0:setWorkCritterInfo(slot7)
		end
	end
end

function slot0.setWorkCritterInfo(slot0, slot1)
	if not slot0._critterWorkInfo then
		slot0:clearAllWorkCritterInfo()
	end

	slot3 = slot1.critterSlotId

	if slot1.critterUid and slot2 ~= CritterEnum.InvalidCritterUid then
		slot0._critterWorkInfo.slotDict[slot3] = slot2
		slot0._critterWorkInfo.critterDict[slot2] = slot3
	else
		slot0:removeWorkCritterInfo(slot3)
	end
end

function slot0.removeWorkCritterInfo(slot0, slot1)
	if not slot0._critterWorkInfo or not slot1 then
		return
	end

	slot0._critterWorkInfo.slotDict[slot1] = nil

	if slot0._critterWorkInfo.slotDict[slot1] then
		slot0._critterWorkInfo.critterDict[slot2] = nil
	end
end

function slot0.clearAllWorkCritterInfo(slot0)
	slot0._critterWorkInfo = {
		slotDict = {},
		critterDict = {}
	}
end

function slot0.setNeedMatDict(slot0)
	slot0._needMatDict = {}

	if RoomConfig.instance:getBuildingType(RoomMapBuildingModel.instance:getBuildingMOById(slot0.id) and slot1.buildingId) == RoomBuildingEnum.BuildingType.Process or slot2 == RoomBuildingEnum.BuildingType.Manufacture then
		for slot6, slot7 in pairs(slot0.slotMODict) do
			if slot7:getSlotManufactureItemId() and slot8 ~= 0 then
				for slot13, slot14 in ipairs(ManufactureConfig.instance:getNeedMatItemList(slot8)) do
					slot0._needMatDict[slot16] = slot14.quantity + (slot0._needMatDict[ManufactureConfig.instance:getItemId(slot14.id)] or 0)
				end
			end
		end
	end
end

function slot0.getBuildingUid(slot0)
	return slot0.uid
end

function slot0.getManufactureState(slot0)
	slot1 = RoomManufactureEnum.ManufactureState.Wait

	for slot5, slot6 in pairs(slot0.slotMODict) do
		if slot6:getSlotState() == RoomManufactureEnum.SlotState.Running then
			slot1 = RoomManufactureEnum.ManufactureState.Running

			break
		end

		if slot7 == RoomManufactureEnum.SlotState.Stop then
			slot1 = RoomManufactureEnum.ManufactureState.Stop
		end
	end

	return slot1
end

function slot0.getManufactureProgress(slot0)
	slot1 = 0
	slot3 = 0

	for slot7, slot8 in pairs(slot0.slotMODict) do
		slot2 = 0 + slot8:getElapsedTime()
		slot10 = 0

		if slot8:getSlotManufactureItemId() and slot11 ~= 0 then
			slot10 = ManufactureConfig.instance:getNeedTime(slot11)
		end

		slot1 = slot1 + slot10
		slot3 = slot3 + slot8:getSlotRemainSecTime()
	end

	return slot2 / slot1, TimeUtil.second2TimeString(slot3, true)
end

function slot0.getSlotMO(slot0, slot1, slot2)
	if not slot0.slotMODict[slot1] and slot2 then
		logError(string.format("RoomBuildingManufactureMO:getSlotMO error, slotId:%s", slot1))
	end

	return slot3
end

function slot0.getAllUnlockedSlotMOList(slot0)
	return slot0.slotMOList or {}
end

function slot0.getAllUnlockedSlotIdList(slot0)
	for slot6, slot7 in ipairs(slot0:getAllUnlockedSlotMOList()) do
		-- Nothing
	end

	return {
		[slot6] = slot7:getSlotId()
	}
end

function slot0.getOccupySlotCount(slot0, slot1)
	for slot6, slot7 in pairs(slot0.slotMODict) do
		if slot7:getSlotManufactureItemId() and slot8 ~= 0 then
			if slot1 then
				if not (slot7:getSlotState() == RoomManufactureEnum.SlotState.Complete) then
					slot2 = 0 + 1
				end
			else
				slot2 = slot2 + 1
			end
		end
	end

	return slot2
end

function slot0.getSlotIdInProgress(slot0)
	slot1 = nil

	for slot5, slot6 in pairs(slot0.slotMODict) do
		if slot6:getSlotState() == RoomManufactureEnum.SlotState.Running then
			slot1 = slot6:getSlotId()

			break
		end
	end

	return slot1
end

function slot0.getCanChangeMaxPriority(slot0)
	slot1 = nil

	if slot0.slotMODict then
		for slot5, slot6 in pairs(slot0.slotMODict) do
			if slot6:getSlotState() == RoomManufactureEnum.SlotState.Running or slot7 == RoomManufactureEnum.SlotState.Stop or slot7 == RoomManufactureEnum.SlotState.Wait then
				slot8 = slot6:getSlotPriority()

				if not slot1 or slot1 < slot8 then
					slot1 = slot8
				end
			end
		end
	end

	return slot1
end

function slot0.isHasCompletedProduction(slot0)
	slot1 = false

	for slot5, slot6 in pairs(slot0.slotMODict) do
		if slot6:getSlotState() == RoomManufactureEnum.SlotState.Complete then
			slot1 = true

			break
		end
	end

	return slot1
end

function slot0.getNewerCompleteManufactureItem(slot0)
	slot1, slot2 = nil

	for slot6, slot7 in pairs(slot0.slotMODict) do
		if slot7:getSlotState() == RoomManufactureEnum.SlotState.Complete then
			slot9 = slot7:getSlotPriority()

			if not slot2 or slot2 < slot9 then
				slot2 = slot9
				slot1 = slot7:getSlotManufactureItemId()
			end
		end
	end

	return slot1
end

function slot0.getManufactureItemFinishCount(slot0, slot1, slot2, slot3)
	slot4 = 0

	for slot9, slot10 in pairs(slot0.slotMODict) do
		slot11 = false
		slot12 = slot10:getSlotManufactureItemId()

		if slot3 then
			if slot12 and slot12 ~= 0 then
				slot11 = ManufactureConfig.instance:getItemId(slot1) == ManufactureConfig.instance:getItemId(slot12)
			end
		else
			slot11 = slot12 == slot1
		end

		if slot11 then
			if not slot2 or slot10:getSlotState() == RoomManufactureEnum.SlotState.Complete then
				slot4 = slot4 + slot10:getFinishCount()
			end

			if not slot3 then
				break
			end
		end
	end

	return slot4
end

function slot0.getWorkingCritter(slot0, slot1)
	slot2 = nil

	if slot0._critterWorkInfo and slot0._critterWorkInfo.slotDict then
		slot2 = slot0._critterWorkInfo.slotDict[slot1]
	end

	return slot2
end

function slot0.getCritterWorkSlot(slot0, slot1)
	slot2 = nil

	if slot0._critterWorkInfo and slot0._critterWorkInfo.critterDict then
		slot2 = slot0._critterWorkInfo.critterDict[slot1]
	end

	return slot2
end

function slot0.getSlot2CritterDict(slot0)
	slot1 = nil

	if slot0._critterWorkInfo and slot0._critterWorkInfo.slotDict then
		slot1 = tabletool.copy(slot0._critterWorkInfo.slotDict)
	end

	return slot1
end

function slot0.getEmptySlotIdList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getAllUnlockedSlotMOList()) do
		if (slot7 and slot7:getSlotState()) == RoomManufactureEnum.SlotState.None then
			slot1[#slot1 + 1] = slot7:getSlotId()
		end
	end

	return slot1
end

function slot0.getNextEmptySlot(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(slot0:getAllUnlockedSlotMOList()) do
		if (slot7 and slot7:getSlotState()) == RoomManufactureEnum.SlotState.None then
			slot1 = slot7:getSlotId()

			break
		end
	end

	return slot1
end

function slot0.getNextEmptyCritterSlot(slot0)
	slot1 = nil
	slot3 = 0

	if RoomMapBuildingModel.instance:getBuildingMOById(slot0.id) then
		slot3 = ManufactureConfig.instance:getBuildingCanPlaceCritterCount(slot4.buildingId, ManufactureModel.instance:getTradeLevel())
	end

	if slot3 > 0 then
		for slot8 = 0, slot3 - 1 do
			if not slot0:getWorkingCritter(slot8) then
				slot1 = slot8

				break
			end
		end
	end

	return slot1
end

function slot0.getNeedMatDict(slot0)
	return slot0._needMatDict or {}
end

return slot0
