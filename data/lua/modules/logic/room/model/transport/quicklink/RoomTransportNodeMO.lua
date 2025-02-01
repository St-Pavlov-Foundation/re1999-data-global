module("modules.logic.room.model.transport.quicklink.RoomTransportNodeMO", package.seeall)

slot0 = pureTable("RoomTransportNodeMO")

function slot0.init(slot0, slot1)
	slot0.hexPoint = slot1

	slot0:resetParam()
end

function slot0.resetParam(slot0)
	slot0.isBuilding = false
	slot0.linkNum = 0
	slot0.searchIndex = -1
	slot0.isBlock = false
	slot0.isSelectPath = false
end

return slot0
