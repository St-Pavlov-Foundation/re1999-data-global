module("modules.logic.store.model.StoreMO", package.seeall)

slot0 = pureTable("StoreMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.nextRefreshTime = slot1.nextRefreshTime
	slot0.goodsInfos = slot1.goodsInfos
	slot0.offlineTime = slot1.offlineTime

	slot0:_initstoreGoodsMOList()
end

function slot0._initstoreGoodsMOList(slot0)
	slot0._storeGoodsMOList = {}

	if slot0.goodsInfos and #slot0.goodsInfos > 0 then
		for slot4, slot5 in ipairs(slot0.goodsInfos) do
			slot6 = StoreGoodsMO.New()

			slot6:init(slot0.id, slot5)
			table.insert(slot0._storeGoodsMOList, slot6)
		end
	end
end

function slot0.buyGoodsReply(slot0, slot1, slot2)
	if slot0._storeGoodsMOList and #slot0._storeGoodsMOList > 0 then
		for slot6, slot7 in ipairs(slot0._storeGoodsMOList) do
			if slot7.goodsId == slot1 then
				slot7:buyGoodsReply(slot2)

				return
			end
		end
	end
end

function slot0.getBuyCount(slot0, slot1)
	if slot0._storeGoodsMOList and #slot0._storeGoodsMOList > 0 then
		for slot5, slot6 in ipairs(slot0._storeGoodsMOList) do
			if slot6.goodsId == slot1 then
				return slot6.buyCount or 0
			end
		end
	end

	return 0
end

function slot0.getGoodsList(slot0, slot1)
	slot2 = slot0._storeGoodsMOList

	if slot1 and #slot2 > 0 then
		table.sort(slot2, slot0._goodsSortFunction)
	end

	return slot2
end

function slot0.getGoodsCount(slot0)
	return slot0._storeGoodsMOList and #slot0._storeGoodsMOList or 0
end

function slot0.getGoodsMO(slot0, slot1)
	if slot0._storeGoodsMOList and #slot0._storeGoodsMOList > 0 then
		for slot5, slot6 in ipairs(slot0._storeGoodsMOList) do
			if slot6.goodsId == slot1 then
				return slot6
			end
		end
	end
end

function slot0._goodsSortFunction(slot0, slot1)
	slot2 = slot0:isSoldOut()
	slot3 = slot1:isSoldOut()

	if slot0:alreadyHas() and not slot1:alreadyHas() then
		return false
	elseif slot5 and not slot4 then
		return true
	end

	if slot2 and not slot3 then
		return false
	elseif slot3 and not slot2 then
		return true
	end

	if StoreConfig.instance:getGoodsConfig(slot1.goodsId).order < StoreConfig.instance:getGoodsConfig(slot0.goodsId).order then
		return true
	elseif slot6.order < slot7.order then
		return false
	end

	return slot6.id < slot7.id
end

return slot0
