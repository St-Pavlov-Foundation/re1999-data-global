module("modules.logic.meilanni.model.EventHistoryMO", package.seeall)

slot0 = pureTable("EventHistoryMO")

function slot0.init(slot0, slot1)
	slot0.index = slot1.index
	slot0.history = slot1.history
end

return slot0
