module("modules.logic.store.model.StorePackageGoodsMO", package.seeall)

slot0 = pureTable("StorePackageGoodsMO")

function slot0.initCharge(slot0, slot1, slot2)
	slot0.isChargeGoods = true
	slot0.belongStoreId = slot1
	slot0.goodsId = slot2.id
	slot0.id = slot0.goodsId
	slot0.buyCount = slot2.buyCount
	slot0.config = StoreConfig.instance:getChargeGoodsConfig(slot0.goodsId)
	slot0.buyLevel = 0

	if slot0.id == StoreEnum.LittleMonthCardGoodsId then
		slot0.refreshTime = StoreEnum.ChargeRefreshTime.None
		slot0.maxBuyCount = StoreConfig.instance:getMonthCardAddConfig(slot0.id).limit
	else
		slot4 = GameUtil.splitString2(slot0.config.limit, true)[1]
		slot0.refreshTime = slot4[1]

		if slot4[1] == StoreEnum.ChargeRefreshTime.None then
			slot0.maxBuyCount = 0
		else
			slot0.maxBuyCount = slot4[2]
		end

		for slot8, slot9 in ipairs(slot3) do
			if slot9[1] == StoreEnum.ChargeRefreshTime.Level then
				slot0.buyLevel = slot9[2]
			end
		end
	end

	slot0.cost = StoreConfig.instance:getChargeGoodsPrice(slot0.id)

	if string.nilorempty(slot0.config.offlineTime) then
		slot0.offlineTime = 0
	else
		slot0.offlineTime = TimeUtil.stringToTimestamp(slot0.config.offlineTime)
	end

	slot0._offInfos = string.split(slot0.config.offTag, "#")

	slot0:initRedDotTime()
end

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.isChargeGoods = false
	slot0.belongStoreId = slot1
	slot0.goodsId = slot2
	slot0.id = slot0.goodsId
	slot0.buyCount = slot3
	slot0.offlineTime = slot4
	slot0.config = StoreConfig.instance:getGoodsConfig(slot0.goodsId)
	slot0.maxBuyCount = slot0.config.maxBuyCount
	slot0.refreshTime = slot0.config.refreshTime
	slot0.cost = slot0.config.cost
	slot0.buyLevel = slot0.config.buyLevel
	slot0._offInfos = string.split(slot0.config.offTag, "#")

	if slot4 == nil then
		slot0.offlineTime = TimeUtil.stringToTimestamp(slot0.config.offlineTime)
	end

	slot0:initRedDotTime()
end

function slot0.initRedDotTime(slot0)
	if string.nilorempty(slot0.config.newStartTime) then
		slot0.newStartTime = 0
	else
		slot0.newStartTime = TimeUtil.stringToTimestamp(slot0.config.newStartTime)
	end

	if string.nilorempty(slot0.config.newEndTime) then
		slot0.newEndTime = 0
	else
		slot0.newEndTime = TimeUtil.stringToTimestamp(slot0.config.newEndTime)
	end
end

function slot0.alreadyHas(slot0)
	slot2 = string.split(slot0.config.product, "#")

	if tonumber(slot2[1]) == MaterialEnum.MaterialType.PlayerCloth then
		return PlayerClothModel.instance:hasCloth(tonumber(slot2[2]))
	else
		return false
	end
end

function slot0.isSoldOut(slot0)
	if slot0.maxBuyCount > 0 and slot0.maxBuyCount <= slot0.buyCount then
		return true
	end

	return false
end

function slot0.isLevelOpen(slot0)
	return slot0.buyLevel <= PlayerModel.instance:getPlayerLevel()
end

function slot0.checkPreGoodsSoldOut(slot0)
	if slot0.config.preGoodsId == 0 then
		return true
	end

	return (StoreModel.instance:getGoodsMO(slot0.config.preGoodsId) and slot1:isSoldOut()) == true
end

function slot0.getDiscount(slot0)
	if slot0._offInfos[1] == StoreEnum.Discount.Discount then
		return slot0._offInfos[2] or 0
	end

	return 0
end

function slot0.needShowNew(slot0)
	if slot0:isSoldOut() then
		return false
	else
		return slot0.newStartTime <= ServerTime.now() and slot1 <= slot0.newEndTime
	end
end

return slot0
