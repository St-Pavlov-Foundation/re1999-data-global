module("modules.logic.room.model.layout.RoomLayoutBgResMO", package.seeall)

slot0 = pureTable("RoomLayoutBgResMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.config = slot2
end

function slot0.getName(slot0)
	return slot0.config and slot0.config.name
end

function slot0.getResPath(slot0)
	return slot0.config and slot0.config.coverResPath
end

return slot0
