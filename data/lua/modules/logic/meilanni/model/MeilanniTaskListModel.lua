module("modules.logic.meilanni.model.MeilanniTaskListModel", package.seeall)

slot0 = class("MeilanniTaskListModel", ListScrollModel)

function slot0.setTaskRewardList(slot0, slot1)
	slot0._rewardList = slot1
end

function slot0.getTaskRewardList(slot0)
	return slot0._rewardList
end

function slot0.showTaskList(slot0)
	slot1 = {}
	slot2 = false

	for slot6, slot7 in ipairs(lua_activity108_grade.configList) do
		slot8, slot9 = uv0._getTaskStatus(slot7)

		if slot8 == 0 and slot9 == 0 then
			slot2 = true
		end

		table.insert(slot1, slot7)
	end

	table.sort(slot1, uv0._sort)

	if slot2 then
		table.insert(slot1, 1, {
			id = 0,
			isGetAll = true
		})
	end

	slot0:setList(slot1)
end

function slot0._sort(slot0, slot1)
	slot2, slot3 = uv0._getTaskStatus(slot0)
	slot4, slot5 = uv0._getTaskStatus(slot1)

	if slot2 ~= slot4 then
		return slot2 < slot4
	end

	if slot3 ~= slot5 then
		return slot3 < slot5
	end

	return slot0.id < slot1.id
end

function slot0._getTaskStatus(slot0)
	slot1, slot2 = uv0.getTaskStatus(slot0)

	return slot1 and 1 or 0, slot2 and 0 or 1
end

function slot0.getTaskStatus(slot0)
	return slot1 and slot1:isGetReward(slot0.id), slot0.score <= (MeilanniModel.instance:getMapInfo(slot0.mapId) and slot1:getMaxScore() or 0)
end

slot0.instance = slot0.New()

return slot0
