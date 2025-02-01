module("modules.logic.activity.model.ActivityBeginnerCategoryListModel", package.seeall)

slot0 = class("ActivityBeginnerCategoryListModel", ListScrollModel)

function slot0.setSortInfos(slot0, slot1)
	slot0._sortInfos = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6.co.id
		slot0._sortInfos[slot7] = ActivityBeginnerController.instance:showRedDot(slot7)
	end
end

function slot0.checkTargetCategory(slot0, slot1)
	if ActivityModel.instance:getCurTargetActivityCategoryId() > 0 or not slot1 or #slot1 <= 0 then
		return
	end

	table.sort(slot1, uv0._sort)
	ActivityModel.instance:setTargetActivityCategoryId(slot1[1].co.id)
end

function slot0.setCategoryList(slot0, slot1)
	slot0._moList = slot1 and slot1 or {}

	table.sort(slot0._moList, uv0._sort)
	slot0:setList(slot0._moList)
end

function slot0._sort(slot0, slot1)
	if (uv0.instance._sortInfos[slot0.co.id] and slot0.co.hintPriority or slot0.co.defaultPriority) == (slot2[slot1.co.id] and slot1.co.hintPriority or slot1.co.defaultPriority) then
		return slot4 < slot3
	end

	return slot6 < slot5
end

function slot0.setOpenViewTime(slot0)
	slot0.openViewTime = Time.realtimeSinceStartup
end

slot0.instance = slot0.New()

return slot0
