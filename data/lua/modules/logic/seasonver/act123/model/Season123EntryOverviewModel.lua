module("modules.logic.seasonver.act123.model.Season123EntryOverviewModel", package.seeall)

slot0 = class("Season123EntryOverviewModel", BaseModel)

function slot0.release(slot0)
end

function slot0.init(slot0, slot1)
	slot0.activityId = slot1
end

function slot0.getActId(slot0)
	return slot0.activityId
end

function slot0.getStageMO(slot0, slot1)
	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return nil
	end

	return slot2:getStageMO(slot1)
end

function slot0.stageIsPassed(slot0, slot1)
	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return false
	end

	return slot2.stageMap[slot1] and slot3.isPass
end

slot0.instance = slot0.New()

return slot0
