module("modules.logic.room.model.common.RoomStoreItemMO", package.seeall)

slot0 = pureTable("RoomStoreItemMO")

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.id = slot1
	slot0.itemId = slot1
	slot0.itemNum = slot3 or 0
	slot0.materialType = slot2
	slot0._costId = slot4
	slot0.belongStoreId = slot5.belongStoreId
	slot0.storeGoodsMO = slot5
	slot0.themeId = RoomConfig.instance:getThemeIdByItem(slot1, slot2)
end

function slot0.getNeedNum(slot0)
	if slot0.materialType == MaterialEnum.MaterialType.BlockPackage or slot0.materialType == MaterialEnum.MaterialType.SpecialBlock then
		return 1
	end

	if slot0:getItemConfig() and slot1.numLimit and slot1.numLimit > 0 then
		return slot1.numLimit
	end

	return 9999
end

function slot0.getItemQuantity(slot0)
	return ItemModel.instance:getItemQuantity(slot0.materialType, slot0.id) or 0
end

function slot0.getItemConfig(slot0)
	return ItemModel.instance:getItemConfig(slot0.materialType, slot0.id)
end

function slot0.getTotalPriceByCostId(slot0, slot1)
	if not slot0:getCostById(slot1) then
		logNormal(string.format("RoomStoreItemMO costId:%s itemId:%s", slot1, slot0.id))

		return 0
	end

	return slot0:getCanBuyNum() * slot2.price
end

function slot0.getCanBuyNum(slot0)
	if slot0:getNeedNum() <= slot0:getItemQuantity() then
		return 0
	end

	return math.min(slot1 - slot2, slot0.itemNum)
end

function slot0.addCost(slot0, slot1, slot2, slot3, slot4)
	slot0._costs = slot0._costs or {}
	slot0._costs[slot1] = {
		costId = slot1,
		itemId = slot2,
		itemType = slot3,
		price = slot4
	}
end

function slot0.getCostById(slot0, slot1)
	return slot0._costs and slot0._costs[slot1]
end

function slot0.getStoreGoodsMO(slot0)
	return slot0.storeGoodsMO
end

function slot0.checkShowTicket(slot0)
	if slot0.storeGoodsMO.belongStoreId == StoreEnum.SubRoomOld or slot0.storeGoodsMO.belongStoreId == StoreEnum.SubRoomNew then
		if slot0.materialType ~= MaterialEnum.MaterialType.BlockPackage and slot0.materialType ~= MaterialEnum.MaterialType.Building then
			return false
		end

		if not string.nilorempty(slot0.storeGoodsMO.config.nameEn) then
			return
		end

		if slot0:getItemConfig().rare <= 3 then
			if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 or ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
				return true
			end
		elseif slot0:getItemConfig().rare <= 5 and ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
			return true
		end
	end

	return false
end

function slot0.getTicketId(slot0)
	if slot0:getItemConfig().rare <= 3 then
		if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 then
			return StoreEnum.NormalRoomTicket
		elseif ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
			return StoreEnum.TopRoomTicket
		end
	elseif slot0:getItemConfig().rare <= 5 and ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
		return StoreEnum.TopRoomTicket
	end
end

return slot0
