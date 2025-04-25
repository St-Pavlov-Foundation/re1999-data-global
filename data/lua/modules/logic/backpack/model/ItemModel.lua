module("modules.logic.backpack.model.ItemModel", package.seeall)

slot0 = class("ItemModel", BaseModel)

function slot0.onInit(slot0)
	slot0._itemList = {}
	slot0._localQuantityChanged = {}
end

function slot0.reInit(slot0)
	slot0._itemList = {}
	slot0._localQuantityChanged = {}
end

function slot0.convertMaterialData(slot0, slot1)
	if not slot1 then
		return nil
	end

	if slot0:materialIsItem(slot1) then
		slot2 = ItemMo.New()

		slot2:initFromMaterialData(slot1)

		return slot2
	end
end

function slot0.materialIsItem(slot0, slot1)
	if not slot1 then
		return false
	end

	if slot1.materilType == MaterialEnum.MaterialType.Item then
		return true
	end

	if slot1.materilType == MaterialEnum.MaterialType.PowerPotion then
		return true
	end

	if slot1.materilType == MaterialEnum.MaterialType.NewInsight then
		return true
	end

	return false
end

slot1 = {
	[MaterialEnum.MaterialType.Item] = function (slot0)
		return uv0.instance:getItemCount(slot0)
	end,
	[MaterialEnum.MaterialType.Exp] = function (slot0)
		return 1
	end,
	[MaterialEnum.MaterialType.Bp] = function (slot0)
		if BpModel.instance:isEnd() then
			return 0
		end

		return BpModel.instance.score % BpConfig.instance:getLevelScore(BpModel.instance.id)
	end,
	[MaterialEnum.MaterialType.HeroSkin] = function (slot0)
		if HeroModel.instance:checkHasSkin(slot0) then
			return 1
		end

		if HeroModel.instance:getByHeroId(SkinConfig.instance:getSkinCo(slot0) and slot1.characterId) and slot3.skinInfoList and #slot4 > 0 then
			for slot8, slot9 in ipairs(slot4) do
				if slot9.skin == slot0 then
					return 1
				end
			end
		end

		return 0
	end,
	[MaterialEnum.MaterialType.Hero] = function (slot0)
		return HeroModel.instance:getByHeroId(slot0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.Currency] = function (slot0)
		if not CurrencyModel.instance:getCurrency(slot0) then
			logError("获取不到货币数量, CurrencyId: " .. tostring(slot0))

			return 0
		else
			return slot1.quantity
		end
	end,
	[MaterialEnum.MaterialType.PowerPotion] = function (slot0, slot1)
		if slot1 then
			return ItemPowerModel.instance:getPowerItemCount(slot1)
		end

		if not uv0.instance:getItemConfig(MaterialEnum.MaterialType.PowerPotion, slot0) then
			return 0
		end

		for slot9, slot10 in ipairs(lua_power_item.configList) do
			if slot2.effect == slot10.effect then
				slot3 = 0 + ItemPowerModel.instance:getPowerItemCountById(slot10.id)
			end
		end

		return slot3
	end,
	[MaterialEnum.MaterialType.Equip] = function (slot0)
		return EquipModel.instance:getEquipQuantity(slot0)
	end,
	[MaterialEnum.MaterialType.PlayerCloth] = function (slot0)
		return PlayerClothModel.instance:hasCloth(slot0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.Building] = function (slot0)
		return RoomModel.instance:getBuildingCount(slot0)
	end,
	[MaterialEnum.MaterialType.Formula] = function (slot0)
		return RoomModel.instance:getFormulaCount(slot0)
	end,
	[MaterialEnum.MaterialType.BlockPackage] = function (slot0)
		return RoomModel.instance:isHasBlockPackageById(slot0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.SpecialBlock] = function (slot0)
		return RoomModel.instance:isHasBlockById(slot0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.RoomTheme] = function (slot0)
		return RoomModel.instance:isHasRoomThemeById(slot0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.Explore] = function (slot0)
		return ExploreBackpackModel.instance:getItem(slot0) and slot1.quantity or 0
	end,
	[MaterialEnum.MaterialType.EquipCard] = function (slot0)
		return SeasonEquipMetaUtils.getCurSeasonEquipCount(slot0)
	end,
	[MaterialEnum.MaterialType.Antique] = function (slot0)
		return AntiqueModel.instance:getAntique(slot0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.V1a5AiZiLa] = function (slot0)
		return AiZiLaModel.instance:getItemQuantity(slot0)
	end,
	[MaterialEnum.MaterialType.Season123EquipCard] = function (slot0)
		return Season123EquipMetaUtils.getCurSeasonEquipCount(slot0)
	end,
	[MaterialEnum.MaterialType.NewInsight] = function (slot0, slot1)
		if slot1 then
			return ItemInsightModel.instance:getInsightItemCount(slot1)
		end

		if not uv0.instance:getItemConfig(MaterialEnum.MaterialType.NewInsight, slot0) then
			return 0
		end

		for slot8, slot9 in ipairs(lua_insight_item.configList) do
			if slot9.id == slot0 then
				slot3 = 0 + ItemInsightModel.instance:getInsightItemCountById(slot9.id)
			end
		end

		return slot3
	end,
	[MaterialEnum.MaterialType.Critter] = function (slot0)
		return CritterModel.instance:getCritterCntById(slot0)
	end
}

function slot0.getItemConfig(slot0, slot1, slot2)
	return ItemConfig.instance:getItemConfig(slot1, slot2)
end

function slot0.getItemConfigAndIcon(slot0, slot1, slot2, slot3)
	if not slot0:getItemConfig(tonumber(slot1), tonumber(slot2)) then
		logError(string.format("getItemConfigAndIcon no config type:%s,id:%s", slot1, slot2))

		return
	end

	slot5, slot6 = nil

	if ItemIconGetDefine.instance:getItemIconFunc(slot1) then
		slot5, slot9 = slot7(slot4)

		if not string.nilorempty(slot9) and slot3 then
			slot5 = slot6
		end
	else
		slot5 = ResUrl.getSpecialPropItemIcon(slot4.icon)
	end

	return slot4, slot5
end

function slot0.getItemSmallIcon(slot0, slot1)
	return slot0:getItemConfig(MaterialEnum.MaterialType.Item, slot1) and ResUrl.getPropItemIconSmall(slot2.icon)
end

function slot0.getItemQuantity(slot0, slot1, slot2, slot3, slot4)
	slot5 = nil

	if uv0[tonumber(slot1)] then
		slot5 = slot6(tonumber(slot2), slot3)
	else
		logError("获取道具数量失败")

		slot5 = 0
	end

	if slot4 then
		slot5 = slot5 + slot0:getLocalQuantityChanged(slot1, slot2, slot3)
	end

	return slot5
end

function slot0.setLocalQuantityChanged(slot0, slot1, slot2)
	slot0._localQuantityChanged[slot1] = slot2
end

function slot0.hasLocalQuantityChanged(slot0, slot1)
	return slot0._localQuantityChanged[slot1]
end

function slot0.getLocalQuantityChanged(slot0, slot1, slot2, slot3)
	slot4 = 0

	for slot8, slot9 in pairs(slot0._localQuantityChanged) do
		for slot13, slot14 in ipairs(slot9) do
			if slot14.type == slot1 and slot14.id == slot2 and slot14.uid == slot3 then
				slot4 = slot4 + slot14.quantity
			end
		end
	end

	return slot4
end

function slot0.getItemRare(slot0, slot1)
	return slot1 and slot1.rare or 1
end

function slot0.setItemList(slot0, slot1)
	slot0._itemList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = ItemMo.New()

		slot7:init(slot6)
		SDKChannelEventModel.instance:consumeItem(slot6.itemId, slot6.totalGainCount - slot6.quantity)
		table.insert(slot0._itemList, slot7)
	end

	slot0:setList(slot0._itemList)
end

function slot0.changeItemList(slot0, slot1)
	slot0._itemList = slot0:getList()

	for slot5, slot6 in ipairs(slot1) do
		if not slot0:getById(slot6.itemId) then
			slot8 = ItemMo.New()

			slot8:init(slot6)

			slot8.quantity = slot6.quantity

			table.insert(slot0._itemList, slot8)
		elseif slot6.quantity == 0 then
			slot0:remove(slot7)
		else
			slot7.quantity = slot6.quantity
		end

		SDKChannelEventModel.instance:consumeItem(slot6.itemId, slot6.totalGainCount - slot6.quantity)
	end

	slot0:setList(slot0._itemList)
end

function slot0.getItemCount(slot0, slot1)
	return slot0:getById(slot1) and slot2.quantity or 0
end

function slot0.getItemList(slot0)
	return slot0._itemList
end

function slot0.getItemsBySubType(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._itemList) do
		if lua_item.configDict[slot7.id] and slot8.subType == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.hasEnoughItems(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #slot1 do
		slot7 = slot1[slot6]
		slot2[slot7.type] = slot2[slot7.type] or {}
		slot2[slot7.type][slot7.id] = (slot2[slot7.type][slot7.id] or 0) + slot7.quantity
	end

	for slot6 = 1, #slot1 do
		slot7 = slot1[slot6]

		if slot0:getItemQuantity(slot7.type, slot7.id) < slot2[slot7.type][slot7.id] then
			slot9, slot10 = slot0:getItemConfigAndIcon(slot7.type, slot7.id)
			slot11 = ""

			if slot9 then
				slot11 = slot9.name
			end

			return slot11, false, slot10
		end
	end

	return "", true
end

function slot0.getItemDataListByConfigStr(slot0, slot1, slot2, slot3)
	slot5 = {}
	slot6 = nil

	if GameUtil.splitString2(slot1, true) and #slot4 > 0 then
		for slot10, slot11 in ipairs(slot4) do
			slot14 = slot11[3]

			if slot2 then
				slot6 = slot6 or {}

				if not slot3 and not ItemConfig.instance:isItemStackable(slot11[1], slot11[2]) then
					for slot18 = 1, slot14 do
						table.insert(slot5, {
							quantity = 1,
							isIcon = true,
							materilType = slot12,
							materilId = slot13
						})
					end
				else
					if not slot6[slot12] then
						slot6[slot12] = {}
					end

					if not slot6[slot12][slot13] then
						slot6[slot12][slot13] = {}
					end

					slot6[slot12][slot13].materilType = slot12
					slot6[slot12][slot13].materilId = slot13
					slot6[slot12][slot13].quantity = slot14
					slot6[slot12][slot13].isIcon = true
				end
			else
				table.insert(slot5, {
					isIcon = true,
					materilType = slot12,
					materilId = slot13,
					quantity = slot14
				})
			end
		end
	end

	if slot2 and slot6 then
		for slot10, slot11 in pairs(slot6) do
			for slot15, slot16 in pairs(slot11) do
				table.insert(slot5, slot16)
			end
		end
	end

	return slot5
end

function slot0.goodsIsEnough(slot0, slot1, slot2, slot3)
	return slot3 <= slot0:getItemQuantity(slot1, slot2), slot4
end

function slot0.getItemIsEnoughText(slot0, slot1)
	if slot1.quantity <= uv0.instance:getItemQuantity(slot1.materilType, slot1.materilId) then
		if slot1.materilType == MaterialEnum.MaterialType.Currency then
			return tostring(GameUtil.numberDisplay(slot1.quantity))
		else
			return tostring(GameUtil.numberDisplay(slot2)) .. "/" .. tostring(GameUtil.numberDisplay(slot1.quantity))
		end
	elseif slot1.materilType == MaterialEnum.MaterialType.Currency then
		return "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(slot1.quantity)) .. "</color>"
	else
		return "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(slot2)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(slot1.quantity))
	end
end

function slot0.hasEnoughItemsByCellData(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #slot1 do
		slot7 = slot1[slot6]
		slot2[slot7.materilType] = slot2[slot7.materilType] or {}
		slot2[slot7.materilType][slot7.materilId] = (slot2[slot7.materilType][slot7.materilId] or 0) + slot7.quantity
	end

	for slot6 = 1, #slot1 do
		slot7 = slot1[slot6]

		if slot0:getItemQuantity(slot7.materilType, slot7.materilId) < slot2[slot7.materilType][slot7.materilId] then
			slot9, slot10 = slot0:getItemConfigAndIcon(slot7.materilType, slot7.materilId)
			slot11 = ""

			if slot9 then
				slot11 = slot9.name
			end

			return slot11, false, slot10
		end
	end

	return "", true
end

function slot0.processRPCItemList(slot0, slot1)
	if not slot1 then
		return {}
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if ItemConfig.instance:isItemStackable(slot7.materilType, slot7.materilId) then
			table.insert(slot2, slot7)
		else
			for slot11 = 1, slot7.quantity do
				table.insert(slot2, {
					quantity = 1,
					bonusTag = slot7.bonusTag,
					materilType = slot7.materilType,
					materilId = slot7.materilId,
					uid = slot7.uid
				})
			end
		end
	end

	return slot2
end

function slot0.canShowVfx(slot0, slot1, slot2)
	if tonumber(slot0) == MaterialEnum.MaterialType.PlayerCloth then
		slot2 = slot2 or 5
	end

	if ItemConfig.instance:getItemCategroyShow(slot0) and slot3.highQuality == 1 then
		if slot1.highQuality ~= nil then
			if slot2 ~= nil then
				return slot2 >= 4 and slot1.highQuality == 1
			else
				return slot1.highQuality == 1
			end
		elseif slot2 ~= nil then
			return slot2 >= 5
		else
			return true
		end
	else
		return false
	end
end

function slot0.setOptionalGift(slot0)
	slot0.optionalGiftData = {}

	if ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.OptionalGift) then
		for slot5, slot6 in pairs(slot1) do
			if not string.nilorempty(slot6.effect) then
				slot8 = string.split(slot6.effect, "|")

				if ItemConfig.instance:getItemListBySubType(({
					subType = slot9[1],
					rare = string.splitToNumber(slot8[1], "#")[2] or slot6.rare,
					ignore = string.splitToNumber(slot8[2], "#"),
					co = slot6,
					id = slot6.id,
					materials = {}
				}).subType) then
					for slot15, slot16 in pairs(slot11) do
						if slot16.rare == slot7.rare and not LuaUtil.tableContains(slot7.ignore, slot16.id) then
							table.insert(slot7.materials, slot16.id)
						end
					end

					slot0.optionalGiftData[slot6.id] = slot7
				end
			end
		end
	end
end

function slot0.getOptionalGiftMaterialSubTypeList(slot0, slot1)
	slot2 = slot0.optionalGiftData and slot0.optionalGiftData[slot1]

	return slot2 and slot2.materials
end

function slot0.getOptionalGiftBySubTypeAndRare(slot0, slot1, slot2, slot3)
	slot4 = {}

	if slot0.optionalGiftData then
		for slot8, slot9 in pairs(slot0.optionalGiftData) do
			if slot9.subType == slot1 and slot9.rare == slot2 and LuaUtil.tableContains(slot9.materials, slot3) then
				table.insert(slot4, slot9)
			end
		end
	end

	return slot4
end

slot0.instance = slot0.New()

return slot0
