module("modules.logic.seasonver.act166.model.Season166InfoMO", package.seeall)

slot0 = pureTable("Season166InfoMO")

function slot0.init(slot0, slot1)
	slot0.id = 0
	slot0.stage = 0
	slot0.bonusStage = 0
	slot0.activityId = slot1
end

function slot0.setData(slot0, slot1)
	slot0.id = slot1.id
	slot0.stage = slot1.stage
	slot0.bonusStage = slot1.bonusStage
end

function slot0.hasAnaly(slot0)
	return (Season166Config.instance:getSeasonInfoAnalys(slot0.activityId, slot0.id) or {})[slot0.stage + 1] == nil
end

return slot0
