module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionBagListModel", package.seeall)

slot0 = class("V1a6_CachotCollectionBagListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._filterCollectionList = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.onInitData(slot0)
	slot0:onCollectionDataUpdate()
end

function slot0.onCollectionDataUpdate(slot0)
	slot0._filterCollectionList = {}

	if V1a6_CachotModel.instance:getRogueInfo() and slot1.collections then
		for slot6, slot7 in ipairs(slot2) do
			table.insert(slot0._filterCollectionList, slot7)
		end
	end

	table.sort(slot0._filterCollectionList, slot0.sortFunc)
	slot0:setList(slot0:insertFakeData())
end

function slot0.insertFakeData(slot0)
	slot0._unEnchantCollectionLineNum = 0
	slot0._enchantCollectionCount = 0
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._filterCollectionList) do
		if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot7 and slot7.cfgId) and slot9.type ~= V1a6_CachotEnum.CollectionType.Enchant then
			slot1 = 0 + 1
		else
			slot0._enchantCollectionCount = slot0._enchantCollectionCount + 1
		end

		table.insert(slot2, slot7)
	end

	slot4 = ViewMgr.instance:getContainer(ViewName.V1a6_CachotCollectionBagView) and slot3:getScrollParam()
	slot0._unEnchantCollectionLineNum = math.ceil(slot1 / (slot4 and slot4.lineCount or 1))

	for slot10 = 1, slot0._unEnchantCollectionLineNum * slot5 - slot1 do
		table.insert(slot2, slot1 + slot10, {
			isFake = true,
			id = -slot10
		})
	end

	return slot2
end

function slot0.sortFunc(slot0, slot1)
	slot3 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot1.cfgId)

	if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot0.cfgId) and slot3 and slot2.type ~= slot3.type then
		return slot2.type < slot3.type
	end

	return slot1.id < slot0.id
end

function slot0.isBagEmpty(slot0)
	return slot0:getCount() <= 0
end

function slot0.moveCollectionWithHole2Top(slot0)
	slot1 = false

	if slot0:getFirstCollectionWithHole() then
		slot0:remove(slot2)
		slot0:addAtFirst(slot2)

		slot1 = true
	else
		logError("cannot find first collection with hole")
	end

	return slot1
end

function slot0.getFirstCollectionWithHole(slot0)
	if slot0:getList() then
		for slot5, slot6 in ipairs(slot1) do
			if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot6.cfgId) and slot7.type ~= V1a6_CachotEnum.CollectionType.Enchant and slot7.holeNum > 0 then
				return slot6
			end
		end
	end
end

function slot0.getUnEnchantCollectionLineNum(slot0)
	return slot0._unEnchantCollectionLineNum or 0
end

function slot0.getEnchantCollectionNum(slot0)
	return slot0._enchantCollectionCount or 0
end

slot0.instance = slot0.New()

return slot0
