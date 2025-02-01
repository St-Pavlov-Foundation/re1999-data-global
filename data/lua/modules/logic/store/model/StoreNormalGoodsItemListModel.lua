module("modules.logic.store.model.StoreNormalGoodsItemListModel", package.seeall)

slot0 = class("StoreNormalGoodsItemListModel", ListScrollModel)

function slot0.setMOList(slot0, slot1, slot2)
	slot0._moList = {}

	if slot2 then
		for slot7, slot8 in ipairs(FurnaceTreasureModel.instance:getGoodsListByStoreId(slot2)) do
			if FurnaceTreasureModel.instance:getGoodsRemainCount(slot2, slot8) and slot9 > 0 then
				slot11 = StoreGoodsMO.New()

				slot11:intiActGoods(slot2, slot8, FurnaceTreasureModel.instance:getGoodsPoolId(slot2, slot8))

				slot0._moList[#slot0._moList + 1] = slot11
			end
		end
	end

	if slot1 then
		for slot6, slot7 in pairs(slot1) do
			table.insert(slot0._moList, slot7)
		end
	end

	if #slot0._moList > 1 then
		table.sort(slot0._moList, slot0._sortFunction)
	end

	slot0:setList(slot0._moList)
end

function slot0._sortFunction(slot0, slot1)
	if slot0:getIsActGoods() ~= slot1:getIsActGoods() then
		return slot2
	end

	if slot2 then
		return slot0:getActGoodsId() < slot1:getActGoodsId()
	end

	slot4 = StoreConfig.instance:getGoodsConfig(slot0.goodsId)
	slot5 = StoreConfig.instance:getGoodsConfig(slot1.goodsId)

	if uv0._isStoreItemCountLimit(slot0) and not uv0._isStoreItemCountLimit(slot1) then
		return false
	elseif not slot6 and slot7 then
		return true
	end

	slot10 = uv0._isStoreItemUnlock(slot0.goodsId)
	slot11 = uv0._isStoreItemUnlock(slot1.goodsId)

	if not uv0._isStoreItemSoldOut(slot0.goodsId) and uv0._isStoreItemSoldOut(slot1.goodsId) then
		return true
	elseif slot8 and not slot9 then
		return false
	end

	if slot0:alreadyHas() ~= slot1:alreadyHas() then
		return slot13
	end

	if slot10 and not slot11 then
		return true
	elseif not slot10 and slot11 then
		return false
	end

	if uv0.needWeekWalkLayerUnlock(slot0.goodsId) ~= uv0.needWeekWalkLayerUnlock(slot1.goodsId) then
		if slot14 then
			return false
		end

		return true
	end

	if slot4.order < slot5.order then
		return true
	elseif slot5.order < slot4.order then
		return false
	end

	if slot4.id < slot5.id then
		return true
	elseif slot5.id < slot4.id then
		return false
	end
end

function slot0._isStoreItemUnlock(slot0)
	if not StoreConfig.instance:getGoodsConfig(slot0).needEpisodeId or slot1 == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(slot1)
end

function slot0.needWeekWalkLayerUnlock(slot0)
	if StoreConfig.instance:getGoodsConfig(slot0).needWeekwalkLayer <= 0 then
		return false
	end

	if not WeekWalkModel.instance:getInfo() then
		return true
	end

	return WeekWalkModel.instance:getMaxLayerId() < slot1
end

function slot0._isStoreItemSoldOut(slot0)
	return StoreModel.instance:getGoodsMO(slot0):isSoldOut()
end

function slot0._isStoreItemCountLimit(slot0)
	if not slot0:getLimitSoldNum() or slot1 == 0 then
		return false
	end

	slot3 = GameUtil.splitString2(slot0.config.product, true)

	if slot3[1][1] == MaterialEnum.MaterialType.Equip then
		return slot1 <= EquipModel.instance:getEquipQuantity(slot3[1][2])
	end
end

slot0.instance = slot0.New()

return slot0
