module("modules.logic.meilanni.model.EpisodeHistoryMO", package.seeall)

slot0 = pureTable("EpisodeHistoryMO")

function slot0.init(slot0, slot1)
	slot0.eventId = slot1.eventId
	slot0.index = slot1.index
end

return slot0
