module("modules.logic.backpack.model.BackpackModel", package.seeall)

slot0 = class("BackpackModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._curCategoryId = 1
	slot0._categoryList = {}
	slot0._itemList = {}
	slot0._itemAniHasShown = false
end

function slot0.getItemAniHasShown(slot0)
	return slot0._itemAniHasShown
end

function slot0.setItemAniHasShown(slot0, slot1)
	slot0._itemAniHasShown = slot1
end

function slot0.getCurCategoryId(slot0)
	return slot0._curCategoryId
end

function slot0.setCurCategoryId(slot0, slot1)
	slot0._curCategoryId = slot1
end

function slot0.setBackpackCategoryList(slot0, slot1)
	slot0._categoryList = slot1
end

function slot0.setBackpackItemList(slot0, slot1, slot2)
	slot0._itemList = {}

	for slot6, slot7 in pairs(slot1) do
		slot8, slot9 = nil
		slot10 = true

		if slot7.uid then
			if slot7.insightId then
				if ItemInsightModel.instance:getInsightItem(slot7.uid) ~= nil and slot11.quantity > 0 then
					slot8 = slot0:_convertItemData(slot7.uid, MaterialEnum.MaterialType.NewInsight)
				end
			elseif ItemPowerModel.instance:getPowerItem(slot7.uid) ~= nil and slot11.quantity > 0 then
				slot8 = slot0:_convertItemData(slot7.uid, MaterialEnum.MaterialType.PowerPotion)
			end
		elseif slot7.id then
			if slot2 and slot7.quantity > 0 or ItemModel.instance:getItemCount(slot7.id) > 0 then
				slot8 = slot0:_convertItemData(slot7.id, MaterialEnum.MaterialType.Item, slot2 and slot7.quantity)
			end
		elseif slot7.currencyId then
			slot8 = slot0:_convertItemData(slot7.currencyId, MaterialEnum.MaterialType.Currency)
		end

		if slot10 and slot8 then
			slot11 = BackpackMo.New()

			slot11:init(slot8)
			table.insert(slot0._itemList, slot11)
		end
	end
end

function slot0.getBackpackItemList(slot0)
	return slot0._itemList
end

function slot0.getBackpackList(slot0)
	for slot5, slot6 in pairs(ItemModel.instance:getList()) do
		table.insert({}, slot6)
	end

	for slot5, slot6 in pairs(CurrencyModel.instance:getCurrencyList()) do
		if slot6.quantity > 0 then
			table.insert(slot1, slot6)
		end
	end

	for slot5, slot6 in pairs(ItemPowerModel.instance:getPowerItemList()) do
		if slot6.quantity > 0 then
			table.insert(slot1, slot6)
		end
	end

	for slot5, slot6 in pairs(ItemInsightModel.instance:getInsightItemList()) do
		if slot6.quantity > 0 then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0._convertItemData(slot0, slot1, slot2, slot3)
	slot5, slot6 = nil

	if ({
		type = slot2
	}).type == MaterialEnum.MaterialType.PowerPotion then
		slot4.uid = slot1
		slot4.id = ItemPowerModel.instance:getPowerItem(slot1).id
		slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot4.type, slot4.id)
	elseif slot4.type == MaterialEnum.MaterialType.NewInsight then
		slot4.uid = slot1
		slot4.id = ItemInsightModel.instance:getInsightItem(slot1).insightId
		slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot4.type, slot4.id)
	else
		slot4.id = slot1
		slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot4.type, slot1)
	end

	if not slot5 then
		logError(string.format("convertItemData no config, type: %s, id: %s", slot2, slot1))

		return nil
	end

	slot4.quantity = slot3 or ItemModel.instance:getItemQuantity(slot4.type, slot4.id, slot4.uid)
	slot4.icon = slot6
	slot4.rare = slot5.rare

	if slot4.type == MaterialEnum.MaterialType.Item then
		slot4.isStackable = slot5.isStackable
		slot4.isShow = slot5.isShow
		slot4.subType = slot5.subType
		slot4.isTimeShow = slot5.isTimeShow
		slot4.expireTime = slot5.expireTime or -1
	elseif slot4.type == MaterialEnum.MaterialType.PowerPotion then
		slot4.isStackable = 1
		slot4.isShow = 1
		slot4.subType = 0
		slot4.isTimeShow = slot5.expireType == 0 and 0 or 1

		if slot5.expireType == 0 then
			slot4.expireTime = -1
		else
			slot4.expireTime = ItemPowerModel.instance:getPowerItemDeadline(slot1)
		end
	elseif slot4.type == MaterialEnum.MaterialType.NewInsight then
		slot4.isStackable = 1
		slot4.isShow = 1
		slot4.subType = 0
		slot4.expireTime = ItemInsightModel.instance:getInsightItemDeadline(slot1)
		slot4.isTimeShow = ItemConfig.instance:getInsightItemCo(slot4.id) and slot7.expireType ~= 0 and slot7.expireHours ~= ItemEnum.NoExpiredNum and 1 or 0
	elseif slot4.type == MaterialEnum.MaterialType.Currency then
		slot4.isStackable = 1
		slot4.isShow = 1
		slot4.subType = 0
		slot4.isTimeShow = 0
	end

	return slot4
end

function slot0.getCategoryItemlist(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._itemList) do
		slot8 = slot0:_getItemBelong(slot7.type, slot7.id)

		if slot7.type == MaterialEnum.MaterialType.PowerPotion then
			if slot1 == ItemEnum.CategoryType.All or slot1 == ItemEnum.CategoryType.UseType then
				table.insert(slot2, slot7)
			end
		elseif slot7.type == MaterialEnum.MaterialType.NewInsight then
			if slot1 == ItemEnum.CategoryType.All or slot1 == ItemEnum.CategoryType.UseType then
				table.insert(slot2, slot7)
			end
		else
			for slot12, slot13 in pairs(slot8) do
				if slot13 == slot1 then
					table.insert(slot2, slot7)
				end
			end
		end
	end

	return slot2
end

function slot0._getItemBelong(slot0, slot1, slot2)
	table.insert({}, ItemEnum.CategoryType.All)

	for slot7, slot8 in pairs(slot0._categoryList) do
		slot9, slot10 = nil

		if tonumber(slot1) == MaterialEnum.MaterialType.Item then
			slot9 = slot8.includeitem
			slot10 = ItemConfig.instance:getItemCo(tonumber(slot2)).subType
		elseif slot1 == MaterialEnum.MaterialType.Currency then
			slot9 = slot8.includecurrency
			slot10 = slot2
		end

		if slot0:_isItemBelongCate(slot9, slot10) and not LuaUtil.tableContains(slot3, tonumber(slot8.id)) then
			table.insert(slot3, tonumber(slot8.id))
		end
	end

	return slot3
end

function slot0._isItemBelongCate(slot0, slot1, slot2)
	if not string.split(slot1, "#") then
		return false
	end

	for slot7, slot8 in pairs(slot3) do
		if tonumber(slot8) == slot2 then
			return true
		end
	end

	return false
end

function slot0.getCategoryItemsDeadline(slot0, slot1)
	for slot7, slot8 in pairs(slot0:getCategoryItemlist(slot1)) do
		if slot8.isShow == 1 and slot8.isTimeShow == 1 and slot8:itemExpireTime() ~= -1 then
			if -1 == -1 then
				slot3 = slot9
			elseif slot9 < slot3 then
				slot3 = slot9 or slot3
			end
		end
	end

	return slot3
end

function slot0.getItemDeadline(slot0)
	slot2 = nil

	for slot6, slot7 in pairs(ItemModel.instance:getItemList() or {}) do
		if ItemConfig.instance:getItemCo(slot7.id) then
			if slot8.isShow == 1 and slot8.expireTime and slot8.expireTime ~= "" then
				if type(slot8.expireTime) == "string" then
					slot9 = TimeUtil.stringToTimestamp(slot9)
				end

				if not slot2 or slot9 < slot2 then
					slot2 = slot9
				end
			end
		else
			logError("找不到道具配置, id: " .. slot7.id)
		end
	end

	for slot7, slot8 in pairs(ItemPowerModel.instance:getPowerItemList() or {}) do
		if ItemConfig.instance:getPowerItemCo(slot8.id).expireType ~= 0 and ItemPowerModel.instance:getPowerItemCount(slot8.uid) > 0 then
			slot10 = ItemPowerModel.instance:getPowerItemDeadline(slot8.uid)

			if not slot2 or slot10 < slot2 then
				slot2 = slot10
			end
		end
	end

	for slot8, slot9 in pairs(ItemInsightModel.instance:getInsightItemList() or {}) do
		if ItemConfig.instance:getInsightItemCo(slot9.insightId).expireType ~= 0 and slot10.expireHours ~= ItemEnum.NoExpiredNum and ItemInsightModel.instance:getInsightItemCount(slot9.uid) > 0 then
			slot11 = ItemInsightModel.instance:getInsightItemDeadline(slot9.uid)

			if not slot2 or slot11 < slot2 then
				slot2 = slot11
			end
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
