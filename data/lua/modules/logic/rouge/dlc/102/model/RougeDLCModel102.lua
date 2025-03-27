module("modules.logic.rouge.dlc.102.model.RougeDLCModel102", package.seeall)

slot0 = class("RougeDLCModel102", BaseModel)

function slot0.clear(slot0)
end

function slot0.getCanLevelUpSpCollectionsInSlotArea(slot0)
	slot1 = {}

	if RougeCollectionModel.instance:getSlotAreaCollection() then
		for slot6, slot7 in ipairs(slot2) do
			if slot0:_checkIsSpCollection(slot7) and not slot0:_checkIsCollectionMaxLevelUp(slot7) then
				table.insert(slot1, slot7)
			end
		end
	end

	return slot1
end

function slot0._checkIsCollectionMaxLevelUp(slot0, slot1)
	if slot1:getAttrValueMap() then
		for slot6, slot7 in pairs(slot2) do
			if slot6 == RougeEnum.MaxLevelSpAttrId then
				return true
			end
		end
	end

	return false
end

function slot0._checkIsCollectionAllEffectActive(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		for slot10, slot11 in pairs(slot6) do
			if not slot11.isActive then
				return false
			end
		end
	end

	return true
end

function slot0._checkIsSpCollection(slot0, slot1)
	if slot1 then
		return RougeCollectionConfig.instance:getCollectionCfg(slot1:getCollectionCfgId()) and slot3.type == RougeEnum.CollectionType.Special
	end
end

function slot0.getAllSpCollectionsInSlotArea(slot0)
	slot1 = {}

	if RougeCollectionModel.instance:getSlotAreaCollection() then
		for slot6, slot7 in ipairs(slot2) do
			if slot0:_checkIsSpCollection(slot7) then
				table.insert(slot1, slot7)
			end
		end
	end

	return slot1
end

function slot0.getAllSpCollections(slot0)
	slot1 = {}

	if RougeCollectionModel.instance:getAllCollections() then
		for slot6, slot7 in ipairs(slot2) do
			if slot0:_checkIsSpCollection(slot7) then
				table.insert(slot1, slot7)
			end
		end
	end

	return slot1
end

function slot0.getAllSpCollectionCount(slot0)
	return slot0:getAllSpCollections() and #slot1 or 0
end

function slot0.getAllCanLevelUpSpCollection(slot0)
	slot1 = {}

	if RougeCollectionModel.instance:getAllCollections() then
		for slot6, slot7 in ipairs(slot2) do
			if slot0:_checkIsSpCollection(slot7) and not slot0:_checkIsCollectionMaxLevelUp(slot7) then
				table.insert(slot1, slot7)
			end
		end
	end

	return slot1
end

function slot0.getAllCanLevelUpSpCollectionCount(slot0)
	return slot0:getAllCanLevelUpSpCollection() and #slot1 or 0
end

slot0.instance = slot0.New()

return slot0
