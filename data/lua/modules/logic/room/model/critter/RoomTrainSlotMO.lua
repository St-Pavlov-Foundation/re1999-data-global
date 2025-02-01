module("modules.logic.room.model.critter.RoomTrainSlotMO", package.seeall)

slot0 = pureTable("RoomTrainSlotMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.isLock = slot1.isLock
end

function slot0.setCritterMO(slot0, slot1)
	slot0.critterMO = slot1
end

function slot0.setWaitingCritterUid(slot0, slot1)
	slot0.waitingTrainUid = slot1
end

function slot0.isFree(slot0)
	if not slot0.isLock and slot0.critterMO == nil then
		return true
	end
end

return slot0
