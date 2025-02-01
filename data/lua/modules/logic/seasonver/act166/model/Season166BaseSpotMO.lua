module("modules.logic.seasonver.act166.model.Season166BaseSpotMO", package.seeall)

slot0 = pureTable("Season166BaseSpotMO")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.isEnter = false
	slot0.maxScore = 0
end

function slot0.setData(slot0, slot1)
	slot0.id = slot1.id
	slot0.isEnter = slot1.isEnter
	slot0.maxScore = slot1.maxScore
end

return slot0
