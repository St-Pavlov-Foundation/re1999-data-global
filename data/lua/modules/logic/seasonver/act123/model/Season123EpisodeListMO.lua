module("modules.logic.seasonver.act123.model.Season123EpisodeListMO", package.seeall)

slot0 = pureTable("Season123EpisodeListMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot2.layer
	slot0.cfg = slot2

	if slot1 then
		slot0.isFinished = slot1:isFinished()
		slot0.round = slot1.round
	else
		slot0.isFinished = false
		slot0.round = 0
	end
end

return slot0
