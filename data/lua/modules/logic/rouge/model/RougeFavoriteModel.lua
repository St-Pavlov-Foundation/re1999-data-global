module("modules.logic.rouge.model.RougeFavoriteModel", package.seeall)

slot0 = class("RougeFavoriteModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._reddots = {}
	slot0._reviewInfoList = {}
end

function slot0.initReddots(slot0, slot1)
	slot0._reddots = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = RougeNewReddotNOMO.New()

		slot7:init(slot6)

		slot0._reddots[slot6.type] = slot7
	end
end

function slot0.getReddotNum(slot0, slot1)
	return slot0._reddots[slot1].idNum
end

function slot0.getReddotMap(slot0, slot1)
	return slot0._reddots[slot1].idMap
end

function slot0.getReddot(slot0, slot1, slot2)
	return slot0._reddots[slot1].idMap[slot2]
end

function slot0.deleteReddotId(slot0, slot1, slot2)
	slot0._reddots[slot1]:removeId(slot2)
end

function slot0.getAllReddotNum(slot0)
	for slot5, slot6 in pairs(slot0._reddots) do
		slot1 = 0 + slot6.idNum
	end

	return slot1
end

function slot0.initReviews(slot0, slot1)
	slot0._reviewInfoList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = RougeReviewMO.New()

		slot7:init(slot6)
		table.insert(slot0._reviewInfoList, slot7)
	end
end

function slot0.getReviewInfoList(slot0)
	return slot0._reviewInfoList
end

function slot0.initUnlockCollectionIds(slot0, slot1)
	slot0._collectionMap = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0._collectionMap[slot6] = slot6
	end
end

function slot0.collectionIsUnlock(slot0, slot1)
	return slot0._collectionMap and slot0._collectionMap[slot1] ~= nil
end

slot0.instance = slot0.New()

return slot0
