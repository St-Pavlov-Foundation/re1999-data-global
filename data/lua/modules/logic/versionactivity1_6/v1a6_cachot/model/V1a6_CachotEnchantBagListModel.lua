module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotEnchantBagListModel", package.seeall)

slot0 = class("V1a6_CachotEnchantBagListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._collectionDataDic = nil
	slot0._curSelectCollectionId = nil
	slot0._curSelectHoleIndex = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.onInitData(slot0, slot1)
	slot0._collectionDataDic = slot0:getAllCollectionDataByType()

	slot0:switchCategory(slot1)
end

function slot0.getAllCollectionDataByType(slot0)
	slot1 = {
		[V1a6_CachotCollectionEnchantView.AllFilterType] = {},
		[slot9] = {}
	}
	slot3 = V1a6_CachotModel.instance:getRogueInfo().collections

	for slot8, slot9 in pairs(V1a6_CachotEnum.CollectionType) do
		-- Nothing
	end

	if slot3 then
		for slot8, slot9 in ipairs(slot3) do
			if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot9.cfgId) and slot10.type and slot11 ~= V1a6_CachotEnum.CollectionType.Enchant then
				table.insert(slot1[slot4], slot9)

				if slot1[slot11] then
					table.insert(slot12, slot9)
				else
					logError(string.format("collectionType match error, collectionId = %s, collectionType = %s", slot10.id, slot11))
				end
			end
		end
	end

	for slot8, slot9 in pairs(slot1) do
		table.sort(slot9, slot0.sortFunc)
	end

	return slot1
end

function slot0.sortFunc(slot0, slot1)
	slot3 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot1.cfgId)

	if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot0.cfgId) and slot3 and slot2.holeNum ~= slot3.holeNum and (slot2.holeNum == 0 or slot3.holeNum == 0) then
		return slot2.holeNum ~= 0
	end

	if slot2 and slot3 and slot2.type ~= slot3.type then
		return slot2.type < slot3.type
	end

	return slot1.id < slot0.id
end

function slot0.isBagEmpty(slot0)
	return slot0:getCount() <= 0
end

function slot0.selectCell(slot0, slot1, slot2)
	slot3 = slot0._curSelectCollectionId

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

	slot0._curSelectCollectionId = slot4
end

function slot0.getCurSelectCollectionId(slot0)
	return slot0._curSelectCollectionId
end

function slot0.getCurSelectHoleIndex(slot0)
	return slot0._curSelectHoleIndex or V1a6_CachotEnum.CollectionHole.Left
end

function slot0.markCurSelectHoleIndex(slot0, slot1)
	slot0._curSelectHoleIndex = slot1
end

function slot0.getCurSelectCategory(slot0)
	return slot0._curSelectCategory
end

function slot0.switchCategory(slot0, slot1)
	slot0._curSelectCategory = slot1 or V1a6_CachotCollectionEnchantView.AllFilterType

	if slot0._collectionDataDic[slot0._curSelectCategory] then
		slot0:setList(slot2)
	end
end

slot0.instance = slot0.New()

return slot0
