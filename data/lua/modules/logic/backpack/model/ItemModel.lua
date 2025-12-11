module("modules.logic.backpack.model.ItemModel", package.seeall)

local var_0_0 = class("ItemModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._itemList = {}
	arg_1_0._localQuantityChanged = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._itemList = {}
	arg_2_0._localQuantityChanged = {}
end

function var_0_0.convertMaterialData(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return nil
	end

	if arg_3_0:materialIsItem(arg_3_1) then
		local var_3_0 = ItemMo.New()

		var_3_0:initFromMaterialData(arg_3_1)

		return var_3_0
	end
end

function var_0_0.materialIsItem(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return false
	end

	if arg_4_1.materilType == MaterialEnum.MaterialType.Item then
		return true
	end

	if arg_4_1.materilType == MaterialEnum.MaterialType.PowerPotion then
		return true
	end

	if arg_4_1.materilType == MaterialEnum.MaterialType.NewInsight then
		return true
	end

	return false
end

local var_0_1 = {
	[MaterialEnum.MaterialType.Item] = function(arg_5_0)
		return var_0_0.instance:getItemCount(arg_5_0)
	end,
	[MaterialEnum.MaterialType.Exp] = function(arg_6_0)
		return 1
	end,
	[MaterialEnum.MaterialType.Bp] = function(arg_7_0)
		if BpModel.instance:isEnd() then
			return 0
		end

		local var_7_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)

		return BpModel.instance.score % var_7_0
	end,
	[MaterialEnum.MaterialType.HeroSkin] = function(arg_8_0)
		if HeroModel.instance:checkHasSkin(arg_8_0) then
			return 1
		end

		local var_8_0 = SkinConfig.instance:getSkinCo(arg_8_0)
		local var_8_1 = var_8_0 and var_8_0.characterId
		local var_8_2 = HeroModel.instance:getByHeroId(var_8_1)
		local var_8_3 = var_8_2 and var_8_2.skinInfoList

		if var_8_3 and #var_8_3 > 0 then
			for iter_8_0, iter_8_1 in ipairs(var_8_3) do
				if iter_8_1.skin == arg_8_0 then
					return 1
				end
			end
		end

		return 0
	end,
	[MaterialEnum.MaterialType.Hero] = function(arg_9_0)
		return HeroModel.instance:getByHeroId(arg_9_0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.Currency] = function(arg_10_0)
		local var_10_0 = CurrencyModel.instance:getCurrency(arg_10_0)

		if not var_10_0 then
			logError("获取不到货币数量, CurrencyId: " .. tostring(arg_10_0))

			return 0
		else
			return var_10_0.quantity
		end
	end,
	[MaterialEnum.MaterialType.PowerPotion] = function(arg_11_0, arg_11_1)
		if arg_11_1 then
			return ItemPowerModel.instance:getPowerItemCount(arg_11_1)
		end

		local var_11_0 = var_0_0.instance:getItemConfig(MaterialEnum.MaterialType.PowerPotion, arg_11_0)

		if not var_11_0 then
			return 0
		end

		local var_11_1 = 0
		local var_11_2 = var_11_0.effect
		local var_11_3 = lua_power_item.configList

		for iter_11_0, iter_11_1 in ipairs(var_11_3) do
			if var_11_2 == iter_11_1.effect then
				var_11_1 = var_11_1 + ItemPowerModel.instance:getPowerItemCountById(iter_11_1.id)
			end
		end

		return var_11_1
	end,
	[MaterialEnum.MaterialType.Equip] = function(arg_12_0)
		return EquipModel.instance:getEquipQuantity(arg_12_0)
	end,
	[MaterialEnum.MaterialType.PlayerCloth] = function(arg_13_0)
		return PlayerClothModel.instance:hasCloth(arg_13_0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.Building] = function(arg_14_0)
		return RoomModel.instance:getBuildingCount(arg_14_0)
	end,
	[MaterialEnum.MaterialType.Formula] = function(arg_15_0)
		return RoomModel.instance:getFormulaCount(arg_15_0)
	end,
	[MaterialEnum.MaterialType.BlockPackage] = function(arg_16_0)
		return RoomModel.instance:isHasBlockPackageById(arg_16_0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.SpecialBlock] = function(arg_17_0)
		return RoomModel.instance:isHasBlockById(arg_17_0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.RoomTheme] = function(arg_18_0)
		return RoomModel.instance:isHasRoomThemeById(arg_18_0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.Explore] = function(arg_19_0)
		local var_19_0 = ExploreBackpackModel.instance:getItem(arg_19_0)

		return var_19_0 and var_19_0.quantity or 0
	end,
	[MaterialEnum.MaterialType.EquipCard] = function(arg_20_0)
		return SeasonEquipMetaUtils.getCurSeasonEquipCount(arg_20_0)
	end,
	[MaterialEnum.MaterialType.Antique] = function(arg_21_0)
		return AntiqueModel.instance:getAntique(arg_21_0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.UnlockVoucher] = function(arg_22_0)
		return UnlockVoucherModel.instance:getVoucher(arg_22_0) and 1 or 0
	end,
	[MaterialEnum.MaterialType.V1a5AiZiLa] = function(arg_23_0)
		return AiZiLaModel.instance:getItemQuantity(arg_23_0)
	end,
	[MaterialEnum.MaterialType.Season123EquipCard] = function(arg_24_0)
		return Season123EquipMetaUtils.getCurSeasonEquipCount(arg_24_0)
	end,
	[MaterialEnum.MaterialType.NewInsight] = function(arg_25_0, arg_25_1)
		if arg_25_1 then
			return ItemInsightModel.instance:getInsightItemCount(arg_25_1)
		end

		if not var_0_0.instance:getItemConfig(MaterialEnum.MaterialType.NewInsight, arg_25_0) then
			return 0
		end

		local var_25_0 = 0
		local var_25_1 = lua_insight_item.configList

		for iter_25_0, iter_25_1 in ipairs(var_25_1) do
			if iter_25_1.id == arg_25_0 then
				var_25_0 = var_25_0 + ItemInsightModel.instance:getInsightItemCountById(iter_25_1.id)
			end
		end

		return var_25_0
	end,
	[MaterialEnum.MaterialType.Critter] = function(arg_26_0)
		return CritterModel.instance:getCritterCntById(arg_26_0)
	end
}

function var_0_0.getItemConfig(arg_27_0, arg_27_1, arg_27_2)
	return ItemConfig.instance:getItemConfig(arg_27_1, arg_27_2)
end

function var_0_0.getItemConfigAndIcon(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_1 = tonumber(arg_28_1)
	arg_28_2 = tonumber(arg_28_2)

	local var_28_0 = arg_28_0:getItemConfig(arg_28_1, arg_28_2)

	if not var_28_0 then
		logError(string.format("getItemConfigAndIcon no config type:%s,id:%s", arg_28_1, arg_28_2))

		return
	end

	local var_28_1
	local var_28_2
	local var_28_3 = ItemIconGetDefine.instance:getItemIconFunc(arg_28_1)

	if var_28_3 then
		local var_28_4

		var_28_1, var_28_4 = var_28_3(var_28_0)

		if not string.nilorempty(var_28_4) and arg_28_3 then
			var_28_1 = var_28_4
		end
	else
		var_28_1 = ResUrl.getSpecialPropItemIcon(var_28_0.icon)
	end

	return var_28_0, var_28_1
end

function var_0_0.getItemSmallIcon(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getItemConfig(MaterialEnum.MaterialType.Item, arg_29_1)

	return var_29_0 and ResUrl.getPropItemIconSmall(var_29_0.icon)
end

function var_0_0.getItemQuantity(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	arg_30_1 = tonumber(arg_30_1)
	arg_30_2 = tonumber(arg_30_2)

	local var_30_0
	local var_30_1 = var_0_1[arg_30_1]

	if var_30_1 then
		var_30_0 = var_30_1(arg_30_2, arg_30_3)
	else
		logError("获取道具数量失败")

		var_30_0 = 0
	end

	if arg_30_4 then
		var_30_0 = var_30_0 + arg_30_0:getLocalQuantityChanged(arg_30_1, arg_30_2, arg_30_3)
	end

	return var_30_0
end

function var_0_0.setLocalQuantityChanged(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0._localQuantityChanged[arg_31_1] = arg_31_2
end

function var_0_0.hasLocalQuantityChanged(arg_32_0, arg_32_1)
	return arg_32_0._localQuantityChanged[arg_32_1]
end

function var_0_0.getLocalQuantityChanged(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in pairs(arg_33_0._localQuantityChanged) do
		for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
			if iter_33_3.type == arg_33_1 and iter_33_3.id == arg_33_2 and iter_33_3.uid == arg_33_3 then
				var_33_0 = var_33_0 + iter_33_3.quantity
			end
		end
	end

	return var_33_0
end

function var_0_0.getItemRare(arg_34_0, arg_34_1)
	return arg_34_1 and arg_34_1.rare or 1
end

function var_0_0.setItemList(arg_35_0, arg_35_1)
	arg_35_0._itemList = {}

	for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
		local var_35_0 = ItemMo.New()

		var_35_0:init(iter_35_1)
		SDKChannelEventModel.instance:consumeItem(iter_35_1.itemId, iter_35_1.totalGainCount - iter_35_1.quantity)
		table.insert(arg_35_0._itemList, var_35_0)
	end

	arg_35_0:setList(arg_35_0._itemList)
end

function var_0_0.changeItemList(arg_36_0, arg_36_1)
	arg_36_0._itemList = arg_36_0:getList()

	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		local var_36_0 = arg_36_0:getById(iter_36_1.itemId)

		if not var_36_0 then
			local var_36_1 = ItemMo.New()

			var_36_1:init(iter_36_1)

			var_36_1.quantity = iter_36_1.quantity

			table.insert(arg_36_0._itemList, var_36_1)
		elseif iter_36_1.quantity == 0 then
			arg_36_0:remove(var_36_0)
		else
			var_36_0.quantity = iter_36_1.quantity
		end

		SDKChannelEventModel.instance:consumeItem(iter_36_1.itemId, iter_36_1.totalGainCount - iter_36_1.quantity)
	end

	arg_36_0:setList(arg_36_0._itemList)
end

function var_0_0.getItemCount(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:getById(arg_37_1)

	return var_37_0 and var_37_0.quantity or 0
end

function var_0_0.getItemList(arg_38_0)
	return arg_38_0._itemList
end

function var_0_0.getItemsBySubType(arg_39_0, arg_39_1)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(arg_39_0._itemList) do
		local var_39_1 = lua_item.configDict[iter_39_1.id]

		if var_39_1 and var_39_1.subType == arg_39_1 then
			table.insert(var_39_0, iter_39_1)
		end
	end

	return var_39_0
end

function var_0_0.hasEnoughItems(arg_40_0, arg_40_1)
	local var_40_0 = {}

	for iter_40_0 = 1, #arg_40_1 do
		local var_40_1 = arg_40_1[iter_40_0]

		var_40_0[var_40_1.type] = var_40_0[var_40_1.type] or {}
		var_40_0[var_40_1.type][var_40_1.id] = (var_40_0[var_40_1.type][var_40_1.id] or 0) + var_40_1.quantity
	end

	for iter_40_1 = 1, #arg_40_1 do
		local var_40_2 = arg_40_1[iter_40_1]

		if arg_40_0:getItemQuantity(var_40_2.type, var_40_2.id) < var_40_0[var_40_2.type][var_40_2.id] then
			local var_40_3, var_40_4 = arg_40_0:getItemConfigAndIcon(var_40_2.type, var_40_2.id)
			local var_40_5 = ""

			if var_40_3 then
				var_40_5 = var_40_3.name
			end

			return var_40_5, false, var_40_4
		end
	end

	return "", true
end

function var_0_0.getItemDataListByConfigStr(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = GameUtil.splitString2(arg_41_1, true)
	local var_41_1 = {}
	local var_41_2

	if var_41_0 and #var_41_0 > 0 then
		for iter_41_0, iter_41_1 in ipairs(var_41_0) do
			local var_41_3 = iter_41_1[1]
			local var_41_4 = iter_41_1[2]
			local var_41_5 = iter_41_1[3]

			if arg_41_2 then
				var_41_2 = var_41_2 or {}

				if not arg_41_3 and not ItemConfig.instance:isItemStackable(var_41_3, var_41_4) then
					for iter_41_2 = 1, var_41_5 do
						table.insert(var_41_1, {
							quantity = 1,
							isIcon = true,
							materilType = var_41_3,
							materilId = var_41_4
						})
					end
				else
					if not var_41_2[var_41_3] then
						var_41_2[var_41_3] = {}
					end

					if not var_41_2[var_41_3][var_41_4] then
						var_41_2[var_41_3][var_41_4] = {}
					end

					var_41_2[var_41_3][var_41_4].materilType = var_41_3
					var_41_2[var_41_3][var_41_4].materilId = var_41_4
					var_41_2[var_41_3][var_41_4].quantity = var_41_5
					var_41_2[var_41_3][var_41_4].isIcon = true
				end
			else
				table.insert(var_41_1, {
					isIcon = true,
					materilType = var_41_3,
					materilId = var_41_4,
					quantity = var_41_5
				})
			end
		end
	end

	if arg_41_2 and var_41_2 then
		for iter_41_3, iter_41_4 in pairs(var_41_2) do
			for iter_41_5, iter_41_6 in pairs(iter_41_4) do
				table.insert(var_41_1, iter_41_6)
			end
		end
	end

	return var_41_1
end

function var_0_0.goodsIsEnough(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = arg_42_0:getItemQuantity(arg_42_1, arg_42_2)

	return arg_42_3 <= var_42_0, var_42_0
end

function var_0_0.getItemIsEnoughText(arg_43_0, arg_43_1)
	local var_43_0 = var_0_0.instance:getItemQuantity(arg_43_1.materilType, arg_43_1.materilId)

	if var_43_0 >= arg_43_1.quantity then
		if arg_43_1.materilType == MaterialEnum.MaterialType.Currency then
			return tostring(GameUtil.numberDisplay(arg_43_1.quantity))
		else
			return tostring(GameUtil.numberDisplay(var_43_0)) .. "/" .. tostring(GameUtil.numberDisplay(arg_43_1.quantity))
		end
	else
		local var_43_1 = arg_43_1.quantity - var_43_0

		if arg_43_1.materilType == MaterialEnum.MaterialType.Currency then
			return "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(arg_43_1.quantity)) .. "</color>", var_43_1
		else
			return "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(var_43_0)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(arg_43_1.quantity)), var_43_1
		end
	end
end

function var_0_0.hasEnoughItemsByCellData(arg_44_0, arg_44_1)
	local var_44_0 = {}

	for iter_44_0 = 1, #arg_44_1 do
		local var_44_1 = arg_44_1[iter_44_0]

		var_44_0[var_44_1.materilType] = var_44_0[var_44_1.materilType] or {}
		var_44_0[var_44_1.materilType][var_44_1.materilId] = (var_44_0[var_44_1.materilType][var_44_1.materilId] or 0) + var_44_1.quantity
	end

	for iter_44_1 = 1, #arg_44_1 do
		local var_44_2 = arg_44_1[iter_44_1]

		if arg_44_0:getItemQuantity(var_44_2.materilType, var_44_2.materilId) < var_44_0[var_44_2.materilType][var_44_2.materilId] then
			local var_44_3, var_44_4 = arg_44_0:getItemConfigAndIcon(var_44_2.materilType, var_44_2.materilId)
			local var_44_5 = ""

			if var_44_3 then
				var_44_5 = var_44_3.name
			end

			return var_44_5, false, var_44_4
		end
	end

	return "", true
end

function var_0_0.processRPCItemList(arg_45_0, arg_45_1)
	if not arg_45_1 then
		return {}
	end

	local var_45_0 = {}

	for iter_45_0, iter_45_1 in ipairs(arg_45_1) do
		if ItemConfig.instance:isItemStackable(iter_45_1.materilType, iter_45_1.materilId) then
			table.insert(var_45_0, iter_45_1)
		else
			for iter_45_2 = 1, iter_45_1.quantity do
				local var_45_1 = {
					quantity = 1,
					bonusTag = iter_45_1.bonusTag,
					materilType = iter_45_1.materilType,
					materilId = iter_45_1.materilId,
					uid = iter_45_1.uid
				}

				table.insert(var_45_0, var_45_1)
			end
		end
	end

	return var_45_0
end

function var_0_0.canShowVfx(arg_46_0, arg_46_1, arg_46_2)
	arg_46_0 = tonumber(arg_46_0)

	if arg_46_0 == MaterialEnum.MaterialType.PlayerCloth then
		arg_46_2 = arg_46_2 or 5
	end

	local var_46_0 = ItemConfig.instance:getItemCategroyShow(arg_46_0)

	if var_46_0 and var_46_0.highQuality == 1 then
		if arg_46_1.highQuality ~= nil then
			if arg_46_2 ~= nil then
				return arg_46_2 >= 4 and arg_46_1.highQuality == 1
			else
				return arg_46_1.highQuality == 1
			end
		elseif arg_46_2 ~= nil then
			return arg_46_2 >= 5
		else
			return true
		end
	else
		return false
	end
end

function var_0_0.setOptionalGift(arg_47_0)
	arg_47_0.optionalGiftData = {}

	local var_47_0 = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.OptionalGift)

	if var_47_0 then
		for iter_47_0, iter_47_1 in pairs(var_47_0) do
			if not string.nilorempty(iter_47_1.effect) then
				local var_47_1 = {}
				local var_47_2 = string.split(iter_47_1.effect, "|")
				local var_47_3 = string.splitToNumber(var_47_2[1], "#")
				local var_47_4 = string.splitToNumber(var_47_2[2], "#")

				var_47_1.subType = var_47_3[1]
				var_47_1.rare = var_47_3[2] or iter_47_1.rare
				var_47_1.ignore = var_47_4
				var_47_1.co = iter_47_1
				var_47_1.id = iter_47_1.id
				var_47_1.materials = {}

				local var_47_5 = ItemConfig.instance:getItemListBySubType(var_47_1.subType)

				if var_47_5 then
					for iter_47_2, iter_47_3 in pairs(var_47_5) do
						if iter_47_3.rare == var_47_1.rare and not LuaUtil.tableContains(var_47_1.ignore, iter_47_3.id) then
							table.insert(var_47_1.materials, iter_47_3.id)
						end
					end

					arg_47_0.optionalGiftData[iter_47_1.id] = var_47_1
				end
			end
		end
	end
end

function var_0_0.getOptionalGiftMaterialSubTypeList(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0.optionalGiftData and arg_48_0.optionalGiftData[arg_48_1]

	return var_48_0 and var_48_0.materials
end

function var_0_0.getOptionalGiftBySubTypeAndRare(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = {}

	if arg_49_0.optionalGiftData then
		for iter_49_0, iter_49_1 in pairs(arg_49_0.optionalGiftData) do
			if iter_49_1.subType == arg_49_1 and iter_49_1.rare == arg_49_2 and LuaUtil.tableContains(iter_49_1.materials, arg_49_3) then
				table.insert(var_49_0, iter_49_1)
			end
		end
	end

	return var_49_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
