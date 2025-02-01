module("modules.logic.room.model.manufacture.RoomBuildingCritterMO", package.seeall)

slot0 = pureTable("RoomBuildingCritterMO")

function slot1(slot0, slot1)
	slot3 = slot1 and slot1:getSeatSlotId()

	if not slot0 or not slot0:getSeatSlotId() or not slot3 then
		return false
	end

	return slot2 < slot3
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.buildingUid
	slot0.uid = slot0.id

	slot0:setSeatSlotInfos(slot1.unlockSlotInfos)
end

function slot0.setSeatSlotInfos(slot0, slot1)
	slot0.seatSlotMODict = {}
	slot0.seatSlotMOList = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = CritterSeatSlotMO.New()

			slot7:init(slot6)

			slot0.seatSlotMODict[slot6.critterSlotId] = slot7
			slot0.seatSlotMOList[#slot0.seatSlotMOList + 1] = slot7
		end

		table.sort(slot0.seatSlotMOList, uv0)
	end
end

function slot0.unlockSeatSlot(slot0, slot1)
	if slot0.seatSlotMODict[slot1] then
		return
	end

	slot2 = CritterSeatSlotMO.New()
	slot3 = {
		critterSlotId = slot1
	}

	slot2:init(slot3)

	slot0.seatSlotMODict[slot3.critterSlotId] = slot2
	slot0.seatSlotMOList[#slot0.seatSlotMOList + 1] = slot2

	table.sort(slot0.seatSlotMOList, uv0)
end

function slot0.getBuildingUid(slot0)
	return slot0.uid
end

function slot0.getSeatSlotMO(slot0, slot1, slot2)
	if not slot0.seatSlotMODict[slot1] and slot2 then
		logError(string.format("RoomBuildingCritterMO:getSeatSlotMO error, slotId:%s", slot1))
	end

	return slot3
end

function slot0.getSeatSlot2CritterDict(slot0)
	for slot5, slot6 in pairs(slot0.seatSlotMODict) do
		if not slot6:isEmpty() then
			-- Nothing
		end
	end

	return {
		[slot5] = slot6:getRestingCritter()
	}
end

function slot0.isCritterInSeatSlot(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in pairs(slot0.seatSlotMODict) do
		if slot7:getRestingCritter() and slot8 == slot1 then
			slot2 = slot6

			break
		end
	end

	return slot2
end

function slot0.getNextEmptyCritterSeatSlot(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0.seatSlotMOList) do
		if slot6:isEmpty() then
			slot1 = slot6:getSeatSlotId()

			break
		end
	end

	return slot1
end

function slot0.removeRestingCritter(slot0, slot1)
	if slot0:getSeatSlotMO(slot0:isCritterInSeatSlot(slot1)) then
		slot3:removeCritter()
	end
end

return slot0
