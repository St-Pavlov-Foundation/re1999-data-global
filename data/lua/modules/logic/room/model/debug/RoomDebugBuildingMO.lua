module("modules.logic.room.model.debug.RoomDebugBuildingMO", package.seeall)

slot0 = pureTable("RoomDebugBuildingMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.buildingId = slot1.id
	slot0.config = RoomConfig.instance:getBuildingConfig(slot0.buildingId)
end

return slot0
