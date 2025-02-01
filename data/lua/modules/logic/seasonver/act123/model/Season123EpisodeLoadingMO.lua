module("modules.logic.seasonver.act123.model.Season123EpisodeLoadingMO", package.seeall)

slot0 = pureTable("Season123EpisodeLoadingMO")

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.id = slot1
	slot0.cfg = slot3
	slot0.emptyIndex = slot4

	if slot2 then
		slot0.isFinished = slot2:isFinished()
		slot0.round = slot2.round
	else
		slot0.isFinished = false
		slot0.round = 0
	end
end

return slot0
