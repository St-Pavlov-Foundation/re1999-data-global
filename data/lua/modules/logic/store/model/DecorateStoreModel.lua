module("modules.logic.store.model.DecorateStoreModel", package.seeall)

slot0 = class("DecorateStoreModel", BaseModel)

function slot0.onInit(slot0)
	slot0._curGoodId = 0
	slot0._curViewType = 0
	slot0._curDecorateType = 0
	slot0._curCostIndex = 1
	slot0._readGoodList = {}
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.setCurGood(slot0, slot1)
	slot0._curGoodId = slot1
end

function slot0.getCurGood(slot0, slot1)
	if slot0._curGoodId == 0 then
		slot0._curGoodId = slot0:getDecorateGoodList(slot1)[1].goodsId
	elseif tonumber(StoreConfig.instance:getGoodsConfig(slot0._curGoodId).storeId) ~= slot1 then
		slot0._curGoodId = slot0:getDecorateGoodList(slot1)[1].goodsId
	end

	return slot0._curGoodId
end

function slot0.getDecorateGoodList(slot0, slot1)
	slot2 = {}

	if StoreModel.instance:getStoreMO(slot1) then
		for slot8, slot9 in pairs(slot3:getGoodsList()) do
			table.insert(slot2, slot9)
		end
	end

	table.sort(slot2, function (slot0, slot1)
		slot3 = uv0:isDecorateGoodItemHas(slot1.goodsId)
		slot4 = slot0.config.maxBuyCount > 0 and slot0.config.maxBuyCount <= slot0.buyCount and 1 or 0

		if uv0:isDecorateGoodItemHas(slot0.goodsId) then
			slot4 = 1
		end

		slot5 = slot1.config.maxBuyCount > 0 and slot1.config.maxBuyCount <= slot1.buyCount and 1 or 0

		if slot3 then
			slot5 = 1
		end

		if slot4 ~= slot5 then
			return slot4 < slot5
		else
			return slot0.config.order < slot1.config.order
		end
	end)

	return slot2
end

function slot0.getDecorateGoodIndex(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0:getDecorateGoodList(slot1)) do
		if slot8.goodsId == slot2 then
			return slot7
		end
	end

	return 0
end

function slot0.setCurViewType(slot0, slot1)
	slot0._curViewType = slot1
end

function slot0.getCurViewType(slot0)
	if slot0._curViewType == 0 then
		slot0._curViewType = DecorateStoreEnum.DecorateViewType.Fold
	end

	return slot0._curViewType
end

function slot0.setCurDecorateType(slot0, slot1)
	slot0._curDecorateType = slot1
end

function slot0.getCurDecorateType(slot0)
	if slot0._curDecorateType == 0 then
		slot0._curDecorateType = DecorateStoreEnum.DecorateType.New
	end

	return slot0._curDecorateType
end

function slot0.isGoodRead(slot0, slot1)
	return slot0._readGoodList[slot1]
end

function slot0.initDecorateReadState(slot0)
	for slot6, slot7 in pairs(string.splitToNumber(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DecorateStoreReadGoods), ""), "#")) do
		slot0._readGoodList[slot7] = true
	end
end

function slot0.setGoodRead(slot0, slot1)
	slot0._readGoodList[slot1] = true
	slot2 = ""

	for slot6, slot7 in pairs(slot0._readGoodList) do
		slot2 = slot2 == "" and slot6 or string.format("%s#%s", slot2, slot6)
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DecorateStoreReadGoods), slot2)
end

function slot0.getItemType(slot0)
	if DecorateStoreConfig.instance:getDecorateConfig(uv0.instance:getCurGood(slot0)).productType == MaterialEnum.MaterialType.Item then
		if slot2.subType == MaterialEnum.ItemSubType.Icon then
			return DecorateStoreEnum.DecorateItemType.Icon
		elseif slot2.subType == MaterialEnum.ItemSubType.SelfCard then
			return DecorateStoreEnum.DecorateItemType.SelfCard
		elseif slot2.subType == MaterialEnum.ItemSubType.MainScene then
			return DecorateStoreEnum.DecorateItemType.MainScene
		end
	elseif slot2.productType == MaterialEnum.MaterialType.HeroSkin then
		return DecorateStoreEnum.DecorateItemType.Skin
	elseif slot2.productType == MaterialEnum.MaterialType.Building and slot2.subType == 7 then
		return DecorateStoreEnum.DecorateItemType.BuildingVideo
	end

	return DecorateStoreEnum.DecorateItemType.Default
end

function slot0.setCurCostIndex(slot0, slot1)
	slot0._curCostIndex = slot1
end

function slot0.getCurCostIndex(slot0)
	return slot0._curCostIndex
end

function slot0.getGoodDiscount(slot0, slot1)
	if StoreConfig.instance:getGoodsConfig(slot1).discountItem == "" then
		return 0
	end

	if #string.split(slot2.discountItem, "|") ~= 2 then
		return 0
	end

	slot4 = string.splitToNumber(slot3[1], "#")

	if ItemModel.instance:getItemCount(slot4[2]) < slot4[3] then
		return 0
	end

	if math.floor(TimeUtil.stringToTimestamp(ItemModel.instance:getItemConfig(slot4[1], slot4[2]).expireTime) - ServerTime.now()) <= 0 then
		return 0
	end

	return math.floor(tonumber(slot3[2]) / 10)
end

function slot0.getGoodItemLimitTime(slot0, slot1)
	if slot0:getGoodDiscount(slot1) > 0 and slot2 < 100 then
		if StoreConfig.instance:getGoodsConfig(slot1).discountItem == "" then
			return 0
		end

		if #string.split(slot3.discountItem, "|") ~= 2 then
			return 0
		end

		slot5 = string.splitToNumber(slot4[1], "#")

		if ItemModel.instance:getItemCount(slot5[2]) < slot5[3] then
			return 0
		end

		return math.floor(TimeUtil.stringToTimestamp(ItemModel.instance:getItemConfig(slot5[1], slot5[2]).expireTime) - ServerTime.now())
	end

	return 0
end

function slot0.isDecorateGoodItemHas(slot0, slot1)
	if DecorateStoreConfig.instance:getDecorateConfig(slot1).maxbuycountType ~= DecorateStoreEnum.MaxBuyTipType.Owned then
		return false
	end

	slot4 = string.splitToNumber(StoreConfig.instance:getGoodsConfig(slot1).product, "#")

	return ItemModel.instance:getItemQuantity(slot4[1], slot4[2]) > 0
end

slot0.instance = slot0.New()

return slot0
