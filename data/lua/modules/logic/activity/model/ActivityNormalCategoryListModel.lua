module("modules.logic.activity.model.ActivityNormalCategoryListModel", package.seeall)

slot0 = class("ActivityNormalCategoryListModel", ListScrollModel)

function slot0.setCategoryList(slot0, slot1)
	slot0._moList = slot1 and slot1 or {}

	table.sort(slot0._moList, function (slot0, slot1)
		return slot0.co.displayPriority < slot1.co.displayPriority
	end)
	slot0:setList(slot0._moList)
end

slot0.instance = slot0.New()

return slot0
