module("modules.logic.critter.model.info.CritterRestInfoMO", package.seeall)

slot0 = pureTable("CritterRestInfoMO")

function slot0.init(slot0, slot1)
	slot0.restBuildingUid = slot1 and slot1.buildingUid
	slot0.seatSlotId = slot1 and slot1.restSlotId
end

return slot0
