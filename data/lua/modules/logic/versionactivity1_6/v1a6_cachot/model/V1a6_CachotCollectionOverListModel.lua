module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionOverListModel", package.seeall)

slot0 = class("V1a6_CachotCollectionOverListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._collectionList = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.onInitData(slot0)
	slot0._collectionList = {}

	if V1a6_CachotModel.instance:getRogueInfo() and slot1.collections then
		for slot6, slot7 in ipairs(slot2) do
			table.insert(slot0._collectionList, slot7)
		end
	end

	table.sort(slot0._collectionList, slot0.sortFunc)
	slot0:setList(slot0._collectionList)
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

slot0.instance = slot0.New()

return slot0
