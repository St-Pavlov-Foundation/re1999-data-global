module("modules.logic.activitywelfare.model.ActivityWelfareListModel", package.seeall)

slot0 = class("ActivityWelfareListModel", ListScrollModel)

function slot0.setCategoryList(slot0, slot1)
	slot0._moList = slot1 and slot1 or {}

	table.sort(slot0._moList, uv0._sort)
	slot0:setList(slot0._moList)
	slot0.checkTargetCategory(slot0._moList)
end

function slot0.checkTargetCategory(slot0)
	if ActivityModel.instance:getCurTargetActivityCategoryId() > 0 or not slot0 or #slot0 <= 0 then
		return
	end

	table.sort(slot0, uv0._sort)
	ActivityModel.instance:setTargetActivityCategoryId(slot0[1].co.id)
end

function slot0._sort(slot0, slot1)
	if slot0.co.defaultPriority == slot1.co.defaultPriority then
		return slot1.co.id < slot0.co.id
	end

	return slot5 < slot4
end

function slot0.setOpenViewTime(slot0)
	slot0.openViewTime = Time.realtimeSinceStartup
end

slot0.instance = slot0.New()

return slot0
