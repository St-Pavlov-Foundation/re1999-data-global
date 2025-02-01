module("modules.logic.turnback.model.TurnbackBeginnerCategoryListModel", package.seeall)

slot0 = class("TurnbackBeginnerCategoryListModel", ListScrollModel)

function slot0.setCategoryList(slot0, slot1)
	slot0._moList = slot1 and slot1 or {}

	table.sort(slot0._moList, function (slot0, slot1)
		return slot0.order < slot1.order
	end)
	slot0:setList(slot0._moList)
end

function slot0.setOpenViewTime(slot0)
	slot0.openViewTime = Time.realtimeSinceStartup
end

slot0.instance = slot0.New()

return slot0
