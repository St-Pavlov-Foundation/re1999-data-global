module("modules.logic.room.model.map.RoomShowBlockPackageMO", package.seeall)

slot0 = pureTable("RoomShowBlockPackageMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.packageId = slot1
	slot0.num = slot2 or 0
	slot0.rare = slot3 or 0
end

return slot0
