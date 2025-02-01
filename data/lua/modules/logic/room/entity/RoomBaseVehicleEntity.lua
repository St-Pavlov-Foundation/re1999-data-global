module("modules.logic.room.entity.RoomBaseVehicleEntity", package.seeall)

slot0 = class("RoomBaseVehicleEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.id = slot1
	slot0.entityId = slot0.id
	slot0._pathfindingEnabled = false
end

return slot0
