module("modules.logic.equip.model.EquipSelectedListModel", package.seeall)

slot0 = class("EquipSelectedListModel", ListScrollModel)

function slot0.initList(slot0)
	slot0:updateList()
end

function slot0.updateList(slot0, slot1)
	slot2 = {}

	for slot6 = 1, EquipEnum.StrengthenMaxCount do
		table.insert(slot2, slot1 and slot1[slot6] or {})
	end

	slot0:setList(slot2)
end

function slot0.clearList(slot0)
	slot0:clear()
end

slot0.instance = slot0.New()

return slot0
