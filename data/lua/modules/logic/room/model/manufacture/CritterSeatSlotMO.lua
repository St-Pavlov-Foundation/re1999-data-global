module("modules.logic.room.model.manufacture.CritterSeatSlotMO", package.seeall)

slot0 = pureTable("CritterSeatSlotMO")

function slot0.init(slot0, slot1)
	slot0._id = slot1.critterSlotId
	slot0._critterUid = slot1.critterUid
end

function slot0.getSeatSlotId(slot0)
	return slot0._id
end

function slot0.getRestingCritter(slot0)
	if not slot0:isEmpty() then
		return slot0._critterUid
	end
end

function slot0.isEmpty(slot0)
	slot1 = true

	if slot0._critterUid and slot0._critterUid ~= CritterEnum.InvalidCritterUid and slot0._critterUid ~= tonumber(CritterEnum.InvalidCritterUid) then
		slot1 = false
	end

	return slot1
end

function slot0.removeCritter(slot0)
	slot0._critterUid = CritterEnum.InvalidCritterUid
end

return slot0
