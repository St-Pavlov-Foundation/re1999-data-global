module("modules.logic.rouge.model.RougeCollectionMO", package.seeall)

slot0 = class("RougeCollectionMO")

function slot0.init(slot0, slot1)
	slot0:initBaseInfo(slot1)
	slot0:updateAttrValues(slot1.attr)
end

function slot0.initBaseInfo(slot0, slot1)
	slot0.id = tonumber(slot1.id)
	slot0.cfgId = tonumber(slot1.itemId)
	slot0.enchantIds = {}

	if slot1.holdIds then
		for slot5, slot6 in ipairs(slot1.holdIds) do
			table.insert(slot0.enchantIds, tonumber(slot6))
		end
	end

	slot0.enchantCfgIds = {}

	if slot1.holdItems then
		for slot5, slot6 in ipairs(slot1.holdItems) do
			table.insert(slot0.enchantCfgIds, tonumber(slot6))
		end
	end
end

function slot0.getCollectionCfgId(slot0)
	return slot0.cfgId
end

function slot0.getCollectionId(slot0)
	return slot0.id
end

function slot0.isEnchant(slot0, slot1)
	return slot0.enchantIds and slot0.enchantIds[slot1] and slot0.enchantIds[slot1] > 0
end

function slot0.getEnchantIdAndCfgId(slot0, slot1)
	return slot0.enchantIds and slot0.enchantIds[slot1], slot0.enchantCfgIds and slot0.enchantCfgIds[slot1]
end

function slot0.getAllEnchantId(slot0)
	return slot0.enchantIds
end

function slot0.getEnchantCount(slot0)
	for slot5, slot6 in pairs(slot0.enchantIds) do
		if slot6 and slot6 > 0 then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getAllEnchantCfgId(slot0)
	return slot0.enchantCfgIds
end

function slot0.updateEnchant(slot0, slot1, slot2)
	slot0.enchantIds = slot0.enchantIds or {}
	slot0.enchantIds[slot2] = slot1
end

function slot0.updateEnchantTargetId(slot0, slot1)
	slot0.enchantUid = slot1
end

function slot0.getEnchantTargetId(slot0)
	return slot0.enchantUid or 0
end

function slot0.isEnchant2Collection(slot0)
	return slot0.enchantUid and slot0.enchantUid > 0
end

function slot0.getRotation(slot0)
	return RougeEnum.CollectionRotation.Rotation_0
end

function slot0.updateInfo(slot0, slot1)
	slot0:init(slot1)
end

function slot0.copyOtherCollectionMO(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.id = slot1.id
	slot0.cfgId = slot1.cfgId
	slot0.enchantIds = {}

	if slot1.enchantIds then
		for slot5, slot6 in ipairs(slot1.enchantIds) do
			table.insert(slot0.enchantIds, tonumber(slot6))
		end
	end

	slot0.enchantCfgIds = {}

	if slot1.enchantCfgIds then
		for slot5, slot6 in ipairs(slot1.enchantCfgIds) do
			table.insert(slot0.enchantCfgIds, tonumber(slot6))
		end
	end
end

function slot0.updateAttrValues(slot0, slot1)
	slot0.attrValueMap = {}

	if slot1 then
		for slot7, slot8 in ipairs(slot1.attrIds) do
			slot0.attrValueMap[slot8] = tonumber(slot1.attrVals[slot7])
		end
	end
end

function slot0.isAttrExist(slot0, slot1)
	return slot0.attrValueMap and slot0.attrValueMap[slot1] ~= nil
end

function slot0.getAttrValueMap(slot0)
	return slot0.attrValueMap
end

function slot0.getLeftTopPos(slot0)
	return Vector2(1000, 1000)
end

return slot0
