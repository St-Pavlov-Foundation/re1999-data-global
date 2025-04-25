module("modules.logic.versionactivity2_5.challenge.model.Act183ReportListModel", package.seeall)

slot0 = class("Act183ReportListModel", MixScrollModel)

function slot0.init(slot0, slot1, slot2)
	slot0._activityId = slot1

	table.sort(slot2, slot0._recordSortFunc)
	slot0:setList(slot2)
end

function slot0._recordSortFunc(slot0, slot1)
	if slot0:getFinishedTime() ~= slot1:getFinishedTime() then
		return slot3 < slot2
	end

	return slot0:getGroupId() < slot1:getGroupId()
end

function slot0.getActivityId(slot0)
	return slot0._activityId
end

slot0.instance = slot0.New()

return slot0
