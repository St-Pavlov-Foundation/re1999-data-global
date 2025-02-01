module("modules.logic.room.model.debug.RoomDebugThemeMO", package.seeall)

slot0 = pureTable("RoomDebugThemeMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.config = slot2 or RoomConfig.instance:getThemeConfig(slot1)
end

return slot0
