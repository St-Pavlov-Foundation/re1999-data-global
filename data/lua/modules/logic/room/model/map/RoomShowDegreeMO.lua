module("modules.logic.room.model.map.RoomShowDegreeMO", package.seeall)

slot0 = pureTable("RoomShowDegreeMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.degreeType = slot2 or 1
	slot0.degree = 0
	slot0.count = 0
	slot0.name = slot3 or ""
end

function slot0.getCount(slot0)
	return slot0.count
end

return slot0
