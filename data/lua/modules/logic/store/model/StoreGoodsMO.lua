module("modules.logic.store.model.StoreGoodsMO", package.seeall)

slot0 = pureTable("StoreGoodsMO")

function slot0.init(slot0, slot1, slot2)
	slot0.belongStoreId = slot1
	slot0.goodsId = slot2.goodsId
	slot0.buyCount = slot2.buyCount
	slot0.offlineTime = tonumber(slot2.offlineTime) / 1000
	slot0.config = StoreConfig.instance:getGoodsConfig(slot0.goodsId)

	if string.nilorempty(slot0.config.reduction) == false then
		slot0.reductionInfo = string.splitToNumber(slot0.config.reduction, "#")
	end

	slot0:initRedDotTime()
end

function slot0.initRedDotTime(slot0)
	if string.nilorempty(slot0.config.newStartTime) then
		slot0.newStartTime = 0
	else
		slot0.newStartTime = TimeUtil.stringToTimestamp(slot0.config.newStartTime) - ServerTime.clientToServerOffset()
	end

	if string.nilorempty(slot0.config.newEndTime) then
		slot0.newEndTime = 0
	else
		slot0.newEndTime = TimeUtil.stringToTimestamp(slot0.config.newEndTime) - ServerTime.clientToServerOffset()
	end
end

function slot0.getOffTab(slot0)
	return slot0.config.offTag
end

function slot0.getOfflineTime(slot0)
	if slot0.config.activityId > 0 then
		return ActivityModel.instance:getActEndTime(slot0.config.activityId) / 1000
	else
		return slot0.offlineTime
	end
end

function slot0.getCost(slot0, slot1)
	if slot1 <= 0 then
		return 0
	end

	if string.nilorempty(slot0.config.cost) then
		return 0
	end

	slot4 = string.split(slot2, "|")

	for slot8 = slot0.buyCount + 1, slot0.buyCount + slot1 do
		if slot8 >= #slot4 then
			slot3 = 0 + string.splitToNumber(slot4[slot8] or slot4[#slot4], "#")[3] * (slot0.buyCount + slot1 - slot8 + 1)

			break
		else
			slot3 = slot3 + slot11
		end
	end

	return slot3
end

function slot0.getAllCostInfo(slot0)
	return GameUtil.splitString2(slot0.config.cost, true), GameUtil.splitString2(slot0.config.cost2, true)
end

function slot0.getBuyMaxQuantity(slot0)
	slot1 = -1
	slot2 = StoreEnum.LimitType.Default
	slot3 = 0
	slot3 = (slot0.config.maxBuyCount <= 0 or math.max(slot0.config.maxBuyCount - slot0.buyCount, 0)) and -1
	slot4 = false
	slot5 = 0

	if slot0.config.cost and slot0.config.cost ~= "" then
		slot6 = {}

		if #string.split(slot0.config.cost, "|") > 1 then
			slot4 = true
		end

		while slot5 < CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount) do
			slot10 = string.splitToNumber(slot7[slot0.buyCount + slot5 + 1] or slot7[#slot7], "#")
			slot11 = slot10[1]
			slot12 = slot10[2]
			slot13 = slot10[3]

			if slot0.buyCount + slot5 + 1 >= #slot7 then
				if slot13 == 0 then
					slot5 = -1

					break
				end

				for slot18, slot19 in pairs(slot6) do
					if slot19.type == slot11 and slot19.id == slot12 then
						slot14 = ItemModel.instance:getItemQuantity(slot11, slot12) - slot19.quantity
					end
				end

				slot5 = slot5 + math.floor(slot14 / slot13)

				break
			else
				table.insert(slot6, {
					type = slot11,
					id = slot12,
					quantity = slot13
				})

				slot14, slot15, slot16 = ItemModel.instance:hasEnoughItems(slot6)

				if not slot15 then
					break
				end

				slot5 = slot5 + 1
			end
		end
	else
		slot5 = -1
	end

	if slot4 then
		slot1 = math.min(math.min(slot3, 1), slot5)
		slot2 = StoreEnum.LimitType.CurrencyChanged

		if slot3 < 1 and slot3 >= 0 then
			slot2 = StoreEnum.LimitType.BuyLimit
		elseif slot5 < 1 and slot5 >= 0 then
			slot2 = StoreEnum.LimitType.Currency
		end
	elseif slot3 < 0 and slot5 < 0 then
		logError("商品购买数量计算错误: " .. slot0.goodsId)

		slot1 = -1
		slot2 = StoreEnum.LimitType.Default
	elseif slot3 < 0 then
		slot1 = slot5
		slot2 = StoreEnum.LimitType.Currency
	elseif slot5 < 0 then
		slot1 = slot3
		slot2 = StoreEnum.LimitType.BuyLimit
	else
		slot1 = math.min(slot3, slot5)
		slot2 = slot3 <= slot5 and StoreEnum.LimitType.BuyLimit or StoreEnum.LimitType.Currency
	end

	return slot1, slot2
end

function slot0.canAffordQuantity(slot0)
	if not string.nilorempty(slot0.config.cost) then
		slot1 = 0
		slot2 = {}
		slot3 = string.split(slot0.config.cost, "|")

		while slot1 < CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount) do
			slot6 = string.splitToNumber(slot3[slot0.buyCount + slot1 + 1] or slot3[#slot3], "#")
			slot7 = slot6[1]
			slot8 = slot6[2]
			slot9 = slot6[3]

			if slot0.buyCount + slot1 + 1 >= #slot3 then
				if slot9 == 0 then
					return -1
				end

				for slot14, slot15 in pairs(slot2) do
					if slot15.type == slot7 and slot15.id == slot8 then
						slot10 = ItemModel.instance:getItemQuantity(slot7, slot8) - slot15.quantity
					end
				end

				slot1 = slot1 + math.floor(slot10 / slot9)

				break
			else
				table.insert(slot2, {
					type = slot7,
					id = slot8,
					quantity = slot9
				})

				slot10, slot11, slot12 = ItemModel.instance:hasEnoughItems(slot2)

				if not slot11 then
					break
				end

				slot1 = slot1 + 1
			end
		end

		return slot1
	else
		return -1
	end
end

function slot0.getLimitSoldNum(slot0)
	slot2 = GameUtil.splitString2(slot0.config.product, true)

	if slot2[1][1] == MaterialEnum.MaterialType.Equip then
		return ItemModel.instance:getItemConfig(slot3, slot2[1][2]).upperLimit
	end
end

function slot0.alreadyHas(slot0)
	slot2 = GameUtil.splitString2(slot0.config.product, true)
	slot3 = slot2[1][1]
	slot4 = slot2[1][2]
	slot5 = false

	if slot0.belongStoreId == StoreEnum.SubRoomNew or slot0.belongStoreId == StoreEnum.SubRoomOld then
		slot5 = true

		for slot9, slot10 in ipairs(slot2) do
			slot3 = slot10[1]
			slot4 = slot10[2]

			if (ItemModel.instance:getItemConfig(slot3, slot4) and slot12.numLimit or 1) == 0 or ItemModel.instance:getItemQuantity(slot3, slot4) < slot13 then
				slot5 = false

				break
			end
		end
	elseif slot3 == MaterialEnum.MaterialType.PlayerCloth then
		slot5 = PlayerClothModel.instance:hasCloth(slot4)
	elseif slot3 == MaterialEnum.MaterialType.HeroSkin then
		slot5 = HeroModel.instance:checkHasSkin(slot4)
	end

	return slot5
end

function slot0.buyGoodsReply(slot0, slot1)
	slot0.buyCount = slot0.buyCount + slot1
end

function slot0.hasProduct(slot0, slot1, slot2)
	slot3 = false

	if slot1 and slot2 then
		for slot9, slot10 in ipairs(GameUtil.splitString2(slot0.config.product, true)) do
			if slot1 == slot10[1] and slot2 == slot10[2] then
				slot3 = true

				break
			end
		end
	end

	return slot3
end

function slot0.intiActGoods(slot0, slot1, slot2, slot3)
	slot0.belongStoreId = slot1
	slot0.goodsId = nil
	slot0.actGoodsId = slot2
	slot0.actPoolId = slot3
	slot0.isActGoods = true
end

function slot0.isSoldOut(slot0)
	if slot0:getIsActGoods() then
		return false
	end

	if slot0.config.maxBuyCount > 0 and slot0.config.maxBuyCount <= slot0.buyCount then
		return true
	end

	return false
end

function slot0.needShowNew(slot0)
	if slot0:getIsActGoods() then
		return false
	end

	if slot0:isSoldOut() then
		return false
	else
		return slot0.newStartTime <= ServerTime.now() and slot1 <= slot0.newEndTime
	end
end

function slot0.getBelongStoreId(slot0)
	return slot0.belongStoreId
end

function slot0.getActGoodsId(slot0)
	return slot0.actGoodsId
end

function slot0.getIsGreatActGoods(slot0)
	slot1 = false

	if slot0:getIsActGoods() then
		slot1 = slot0.actPoolId == FurnaceTreasureEnum.ActGoodsPool.Great
	end

	return slot1
end

function slot0.getIsActGoods(slot0)
	return slot0.isActGoods or false
end

function slot0.getIsJumpGoods(slot0)
	return slot0.config.jumpId ~= 0
end

function slot0.getIsPackageGoods(slot0)
	return slot0.config.bindgoodid ~= 0
end

function slot0.getIsActivityGoods(slot0)
	return slot0.config.activityId ~= 0
end

function slot0.checkJumpGoodCanOpen(slot0)
	if not slot0:getIsJumpGoods() then
		return true
	elseif slot0:getIsPackageGoods() then
		if StoreModel.instance:getGoodsMO(slot0.config.bindgoodid) then
			return TimeUtil.stringToTimestamp(slot1.config.onlineTime) <= ServerTime.now() and slot2 <= TimeUtil.stringToTimestamp(slot1.config.offlineTime)
		else
			return false
		end
	elseif slot0:getIsActivityGoods() and ActivityHelper.getActivityStatus(slot0.config.activityId) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	return true
end

function slot0.setNewRedDotKey(slot0)
	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.StoreRoomTreeItemShowNew .. slot0.goodsId, slot0.goodsId)
end

function slot0.checkShowNewRedDot(slot0)
	slot2 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.StoreRoomTreeItemShowNew .. slot0.goodsId, nil)

	if slot0.belongStoreId ~= StoreEnum.SubRoomNew then
		return false
	end

	if slot2 then
		return false
	end

	return true
end

return slot0
