module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueInfoMO", package.seeall)

slot0 = pureTable("RogueInfoMO")

function slot0.init(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.difficulty = slot1.difficulty
	slot0.layer = slot1.layer
	slot0.room = slot1.room
	slot0.coin = slot1.coin
	slot0.currency = slot1.currency
	slot0.heart = slot1.heart
	slot0.isFinish = slot1.isFinish
	slot0.score = slot1.score
	slot0.sceneId = slot1.sceneId
	slot0.currencyTotal = slot1.currencyTotal

	slot0:updateTeamInfo(slot1.teamInfo)

	slot0.currentEvents = {}

	for slot5, slot6 in ipairs(slot1.currentEvents) do
		slot7 = RogueEventMO.New()

		slot7:init(slot6)
		table.insert(slot0.currentEvents, slot7)
	end

	slot0.nextEvents = {}

	for slot5, slot6 in ipairs(slot1.nextEvents) do
		slot7 = RogueEventMO.New()

		slot7:init(slot6)
		table.insert(slot0.nextEvents, slot7)
	end

	slot0:updateCollections(slot1.collections)

	slot0.selectedEvents = {}

	for slot5, slot6 in ipairs(slot1.selectedEvents) do
		if slot6.status ~= V1a6_CachotEnum.EventStatus.Finish then
			slot7 = RogueEventMO.New()

			slot7:init(slot6)
			table.insert(slot0.selectedEvents, slot7)
		end
	end
end

function slot0.updateTeamInfo(slot0, slot1)
	slot0.teamInfo = RogueTeamInfoMO.New()

	slot0.teamInfo:init(slot1)
end

function slot0.updateCoin(slot0, slot1)
	slot0.coin = slot1
end

function slot0.updateCurrency(slot0, slot1)
	slot0.currency = slot1
end

function slot0.updateCurrencyTotal(slot0, slot1)
	slot0.currencyTotal = slot1
end

function slot0.updateHeart(slot0, slot1)
	slot0.heart = slot1
end

function slot0.updateCollections(slot0, slot1)
	slot0.collections = {}
	slot0.collectionCfgMap = {}
	slot0.collectionBaseMap = {}
	slot0.enchants = {}
	slot0.collectionMap = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = RogueCollectionMO.New()

			slot7:init(slot6)

			if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot7.cfgId) and slot8.type == V1a6_CachotEnum.CollectionType.Enchant then
				table.insert(slot0.enchants, slot7)
			end

			if not slot7:isEnchant() then
				table.insert(slot0.collections, slot7)
			end

			slot0.collectionMap[slot7.id] = slot7
			slot0.collectionCfgMap[slot7.cfgId] = slot0.collectionCfgMap[slot7.cfgId] or {}

			table.insert(slot0.collectionCfgMap[slot7.cfgId], slot7)

			if slot7 and slot7.baseId and slot7.baseId ~= 0 then
				slot0.collectionBaseMap[slot7.baseId] = slot0.collectionBaseMap[slot7.baseId] or {}

				table.insert(slot0.collectionBaseMap[slot7.baseId], slot7)
			end
		end
	end
end

function slot0.getCollectionByUid(slot0, slot1)
	return slot0.collectionMap and slot0.collectionMap[slot1]
end

function slot0.getSelectEvents(slot0)
	return slot0.selectedEvents
end

return slot0
