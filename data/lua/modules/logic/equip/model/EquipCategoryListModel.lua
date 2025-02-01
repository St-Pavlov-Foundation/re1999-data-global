module("modules.logic.equip.model.EquipCategoryListModel", package.seeall)

slot0 = class("EquipCategoryListModel", ListScrollModel)
slot0.ViewIndex = {
	EquipInfoViewIndex = 1,
	EquipRefineViewIndex = 3,
	EquipStrengthenViewIndex = 2,
	EquipStoryViewIndex = 4
}

function slot0.initCategory(slot0, slot1, slot2)
	table.insert({}, slot0:packMo(luaLang("equip_lang_18"), luaLang("p_equip_35"), uv0.ViewIndex.EquipInfoViewIndex))

	if slot1 and slot2.isExpEquip ~= 1 and slot2.id ~= EquipConfig.instance:getEquipUniversalId() and not EquipHelper.isSpRefineEquip(slot2) then
		table.insert(slot3, slot0:packMo(luaLang("equip_lang_19"), luaLang("p_equip_36"), uv0.ViewIndex.EquipStrengthenViewIndex))
		table.insert(slot3, slot0:packMo(luaLang("equip_lang_21"), luaLang("p_equip_39"), uv0.ViewIndex.EquipRefineViewIndex))
	end

	table.insert(slot3, slot0:packMo(luaLang("equip_lang_20"), luaLang("p_equip_38"), uv0.ViewIndex.EquipStoryViewIndex))
	slot0:setList(slot3)
end

function slot0.packMo(slot0, slot1, slot2, slot3)
	slot0._moList = slot0._moList or {}

	if not slot0._moList[slot3] then
		slot4 = {}
		slot0._moList[slot3] = slot4
		slot4.cnName = slot1
		slot4.enName = slot2
		slot4.resIndex = slot3
	end

	if slot4.cnName ~= slot1 or slot4.enName ~= slot2 or slot4.resIndex ~= slot3 then
		slot4 = {}
		slot0._moList[slot3] = slot4
		slot4.cnName = slot1
		slot4.enName = slot2
		slot4.resIndex = slot3
	end

	return slot4
end

slot0.instance = slot0.New()

return slot0
