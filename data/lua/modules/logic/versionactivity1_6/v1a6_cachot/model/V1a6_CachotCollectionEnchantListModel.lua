module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionEnchantListModel", package.seeall)

slot0 = class("V1a6_CachotCollectionEnchantListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._enchantList = nil
	slot0._curSelectEnchantId = nil
	slot0._enchantIndexMap = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
	slot0:clear()
end

function slot0.onInitData(slot0, slot1)
	slot0._enchantList = slot0:buildEnchantDataTab(slot1)

	slot0:setList(slot0._enchantList)
end

function slot0.buildEnchantDataTab(slot0, slot1)
	slot3 = V1a6_CachotModel.instance:getRogueInfo() and slot2.enchants
	slot5 = slot3 and #slot3 or 0

	for slot10, slot11 in ipairs(slot0:getList()) do
		table.insert({}, slot3 and slot3[slot0:getEnchantIndexById(slot11.id) or slot10])
	end

	for slot10 = #slot6 + 1, slot5 do
		table.insert(slot4, slot3[slot10])
	end

	if slot1 then
		table.sort(slot4, slot0.sortFunc)
	end

	return slot4
end

function slot0.getEnchantIndexById(slot0, slot1)
	if not slot0._enchantIndexMap then
		slot0._enchantIndexMap = {}

		for slot7, slot8 in ipairs(V1a6_CachotModel.instance:getRogueInfo() and slot2.enchants) do
			slot0._enchantIndexMap[slot8.id] = slot7
		end
	end

	return slot0._enchantIndexMap and slot0._enchantIndexMap[slot1]
end

function slot0.sortFunc(slot0, slot1)
	if slot0:isEnchant() ~= slot1:isEnchant() then
		return not slot2
	end

	return slot1.id < slot0.id
end

function slot0.isEnchantEmpty(slot0)
	return slot0:getCount() <= 0
end

function slot0.selectCell(slot0, slot1, slot2)
	slot3 = slot0._curSelectEnchantId

	if slot1 and slot1 > 0 and slot2 then
		slot0:selectCellInternal(slot1, slot2)
	else
		slot0:selectCellInternal(slot3, false)
	end
end

function slot0.selectCellInternal(slot0, slot1, slot2)
	slot4 = nil

	if slot0:getById(slot1) then
		uv0.super.selectCell(slot0, slot0:getIndex(slot3), slot2)

		slot4 = slot2 and slot3.id
	end

	slot0._curSelectEnchantId = slot4
end

function slot0.getCurSelectEnchantId(slot0)
	return slot0._curSelectEnchantId
end

slot0.instance = slot0.New()

return slot0
