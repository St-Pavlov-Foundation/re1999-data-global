module("modules.logic.equip.model.EquipBreakCostListModel", package.seeall)

slot0 = class("EquipBreakCostListModel", ListScrollModel)

function slot0.initList(slot0, slot1)
	slot0:setList(slot1)
end

function slot0.clearList(slot0)
	slot0:clear()
end

slot0.instance = slot0.New()

return slot0
