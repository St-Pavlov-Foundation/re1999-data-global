module("modules.logic.equip.model.EquipTeamAttrListModel", package.seeall)

slot0 = class("EquipTeamAttrListModel", ListScrollModel)

function slot0.init(slot0)
end

function slot0.SetAttrList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(EquipTeamListModel.instance:getTeamEquip()) do
		if EquipModel.instance:getEquip(slot7) then
			slot9, slot10, slot11, slot12, slot13 = EquipConfig.instance:getEquipStrengthenAttr(slot8)

			slot0:setAttr(slot1, 101, 0, slot9)
			slot0:setAttr(slot1, 102, 0, slot10)
			slot0:setAttr(slot1, 103, 0, slot11)

			slot17 = slot1
			slot18 = 104

			slot0:setAttr(slot17, slot18, 0, slot12)

			for slot17, slot18 in pairs(lua_character_attribute.configDict) do
				if slot18.type == 2 or slot18.type == 3 then
					slot0:setAttr(slot1, slot17, slot18.showType, slot13[slot18.attrType])
				end
			end
		end
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		for slot12, slot13 in pairs(slot8) do
			table.insert(slot3, {
				attrId = slot7,
				showType = slot12,
				value = slot13
			})
		end
	end

	table.sort(slot3, uv0._sort)
	slot0:setList(slot3)
end

function slot0._sort(slot0, slot1)
	return slot0.attrId < slot1.attrId
end

function slot0.setAttr(slot0, slot1, slot2, slot3, slot4)
	if slot4 <= -1 then
		return
	end

	slot5 = slot1[slot2] or {}
	slot1[slot2] = slot5
	slot5[slot3] = (slot5[slot3] or 0) + slot4
end

slot0.instance = slot0.New()

return slot0
