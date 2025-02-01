module("modules.logic.room.model.debug.RoomDebugPlaceMO", package.seeall)

slot0 = pureTable("RoomDebugPlaceMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.defineId = slot1.id
	slot0.blockId = slot1.blockId
	slot0.config = RoomConfig.instance:getBlockDefineConfig(slot0.defineId)
end

return slot0
