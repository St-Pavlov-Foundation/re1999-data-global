module("modules.logic.room.model.debug.RoomDebugPackageMO", package.seeall)

slot0 = pureTable("RoomDebugPackageMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.blockId = slot1.id
	slot0.packageId = slot1.packageId
	slot0.packageOrder = slot1.packageOrder
	slot0.defineId = slot1.defineId
	slot0.config = RoomConfig.instance:getBlockDefineConfig(slot0.defineId)
end

return slot0
