module("modules.logic.rouge.dlc.102.config.RougeDLCConfig102", package.seeall)

slot0 = class("RougeDLCConfig102", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"rouge_spcollection_desc",
		"rouge_collection_trammels"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "rouge_spcollection_desc" then
		slot0:onSpCollectionDescConfigLoaded(slot2)
	elseif slot1 == "rouge_collection_trammels" then
		slot0._trammelConfigTab = slot2
	end
end

function slot0.onSpCollectionDescConfigLoaded(slot0, slot1)
	slot0._descTab = slot1
	slot0._descMap = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		if not (slot0._descMap and slot0._descMap[slot6.id]) then
			slot0._descMap[slot7] = {}
		end

		table.insert(slot8, slot6)
	end

	for slot5, slot6 in pairs(slot0._descMap) do
		table.sort(slot6, slot0._spCollectionDescSortFunc)
	end
end

function slot0._spCollectionDescSortFunc(slot0, slot1)
	if slot0.effectId ~= slot1.effectId then
		return slot0.effectId < slot1.effectId
	end
end

function slot0.getSpCollectionDescCos(slot0, slot1)
	return slot0._descMap and slot0._descMap[slot1]
end

function slot0.getCollectionLevelUpCo(slot0, slot1)
	return slot0._levelConfigTab and slot0._levelConfigTab.configDict[slot1]
end

function slot0.getCollectionLevelUpConditions(slot0, slot1)
	return {
		{
			index = 1,
			id = 8110021,
			content = "测试1"
		},
		{
			index = 2,
			id = 8110021,
			content = "测试2"
		}
	}
end

function slot0.getAllCollectionTrammelCo(slot0)
	return slot0._trammelConfigTab and slot0._trammelConfigTab.configList
end

function slot0.getCollectionOwnerCo(slot0, slot1)
	if not RougeCollectionConfig.instance:getCollectionCfg(slot1) then
		return
	end

	if slot2.ownerId and slot3 ~= 0 then
		return HeroConfig.instance:getHeroCO(slot3)
	end
end

slot0.instance = slot0.New()

return slot0
