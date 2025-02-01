module("modules.logic.backpack.model.BackpackCategoryListModel", package.seeall)

slot0 = class("BackpackCategoryListModel", ListScrollModel)

function slot0.setCategoryList(slot0, slot1)
	slot2 = slot1 and slot1 or {}

	table.sort(slot2, function (slot0, slot1)
		return slot0.id < slot1.id
	end)
	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
