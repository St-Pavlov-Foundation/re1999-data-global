module("modules.logic.critter.model.info.CritterWorkInfoMO", package.seeall)

slot0 = pureTable("CritterWorkInfoMO")

function slot0.init(slot0, slot1)
	slot0.workBuildingUid = slot1 and slot1.buildingUid
	slot0.critterSlotId = slot1 and slot1.critterSlotId
end

function slot0.getBuildingInfo(slot0)
	return slot0.workBuildingUid, slot0.critterSlotId
end

return slot0
