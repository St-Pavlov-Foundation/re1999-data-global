module("modules.versionactivitybase.enterview.controller.VersionActivityEnterHelper", package.seeall)

slot0 = class("VersionActivityEnterHelper")

function slot0.getTabIndex(slot0, slot1)
	if slot1 and slot1 > 0 then
		for slot5, slot6 in ipairs(slot0) do
			if uv0.checkIsSameAct(slot6, slot1) then
				return slot5
			end
		end
	end

	return 1
end

function slot0.checkIsSameAct(slot0, slot1)
	if slot0.actType == VersionActivityEnterViewEnum.ActType.Single then
		return slot0.actId == slot1
	end

	for slot5, slot6 in ipairs(slot0.actId) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.getActId(slot0)
	if slot0.actType == VersionActivityEnterViewEnum.ActType.Single then
		return slot0.actId
	end

	for slot4, slot5 in ipairs(slot0.actId) do
		if ActivityHelper.getActivityStatus(slot5) ~= ActivityEnum.ActivityStatus.Expired and slot6 ~= ActivityEnum.ActivityStatus.NotOnLine then
			return slot5
		end
	end

	return slot0.actId[1]
end

function slot0.getActIdList(slot0)
	slot1 = {}

	if slot0 then
		for slot5, slot6 in ipairs(slot0) do
			if uv0.getActId(slot6) then
				slot1[#slot1 + 1] = slot7
			end
		end
	end

	return slot1
end

function slot0.isActTabCanRemove(slot0)
	if not slot0 then
		return true
	end

	if slot0.actType == VersionActivityEnterViewEnum.ActType.Single then
		slot1 = slot0.storeId and ActivityHelper.getActivityStatus(slot0.storeId) or ActivityHelper.getActivityStatus(slot0.actId)

		return slot1 == ActivityEnum.ActivityStatus.Expired or slot1 == ActivityEnum.ActivityStatus.NotOnLine
	end

	for slot4, slot5 in ipairs(slot0.actId) do
		if ActivityHelper.getActivityStatus(slot5) ~= ActivityEnum.ActivityStatus.Expired and slot6 ~= ActivityEnum.ActivityStatus.NotOnLine then
			return false
		end
	end

	return true
end

function slot0.checkCanOpen(slot0)
	slot1 = true
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(slot0)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		if slot3 then
			GameFacade.showToastWithTableParam(slot3, slot4)
		end

		slot1 = false
	end

	return slot1
end

return slot0
