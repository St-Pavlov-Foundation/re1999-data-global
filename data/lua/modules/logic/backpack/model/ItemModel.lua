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
	[MaterialEnum.MaterialType.V1a5AiZiLa] = function(arg_22_0)
		return AiZiLaModel.instance:getItemQuantity(arg_22_0)
	end,
	[MaterialEnum.MaterialType.Season123EquipCard] = function(arg_23_0)
		return Season123EquipMetaUtils.getCurSeasonEquipCount(arg_23_0)
	end,
	[MaterialEnum.MaterialType.NewInsight] = function(arg_24_0, arg_24_1)
		if arg_24_1 then
			return ItemInsightModel.instance:getInsightItemCount(arg_24_1)
		end

		if not var_0_0.instance:getItemConfig(MaterialEnum.MaterialType.NewInsight, arg_24_0) then
			return 0
		end

		local var_24_0 = 0
		local var_24_1 = lua_insight_item.configList

		for iter_24_0, iter_24_1 in ipairs(var_24_1) do
			if iter_24_1.id == arg_24_0 then
				var_24_0 = var_24_0 + ItemInsightModel.instance:getInsightItemCountById(iter_24_1.id)
			end
		end

		return var_24_0
	end,
	[MaterialEnum.MaterialType.Critter] = function(arg_25_0)
		return CritterModel.instance:getCritterCntById(arg_25_0)
	end
}

function var_0_0.getItemConfig(arg_26_0, arg_26_1, arg_26_2)
	return ItemConfig.instance:getItemConfig(arg_26_1, arg_26_2)
end

function var_0_0.getItemConfigAndIcon(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_1 = tonumber(arg_27_1)
	arg_27_2 = tonumber(arg_27_2)

	local var_27_0 = arg_27_0:getItemConfig(arg_27_1, arg_27_2)

	if not var_27_0 then
		logError(string.format("getItemConfigAndIcon no config type:%s,id:%s", arg_27_1, arg_27_2))

		return
	end

	local var_27_1
	local var_27_2
	local var_27_3 = ItemIconGetDefine.instance:getItemIconFunc(arg_27_1)

	if var_27_3 then
		local var_27_4

		var_27_1, var_27_4 = var_27_3(var_27_0)

		if not string.nilorempty(var_27_4) and arg_27_3 then
			var_27_1 = var_27_4
		end
	else
		var_27_1 = ResUrl.getSpecialPropItemIcon(var_27_0.icon)
	end

	return var_27_0, var_27_1
end

function var_0_0.getItemSmallIcon(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:getItemConfig(MaterialEnum.MaterialType.Item, arg_28_1)

	return var_28_0 and ResUrl.getPropItemIconSmall(var_28_0.icon)
end

function var_0_0.getItemQuantity(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	arg_29_1 = tonumber(arg_29_1)
	arg_29_2 = tonumber(arg_29_2)

	local var_29_0
	local var_29_1 = var_0_1[arg_29_1]

	if var_29_1 then
		var_29_0 = var_29_1(arg_29_2, arg_29_3)
	else
		logError("获取道具数量失败")

		var_29_0 = 0
	end

	if arg_29_4 then
		var_29_0 = var_29_0 + arg_29_0:getLocalQuantityChanged(arg_29_1, arg_29_2, arg_29_3)
	end

	return var_29_0
end

function var_0_0.setLocalQuantityChanged(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0._localQuantityChanged[arg_30_1] = arg_30_2
end

function var_0_0.hasLocalQuantityChanged(arg_31_0, arg_31_1)
	return arg_31_0._localQuantityChanged[arg_31_1]
end

function var_0_0.getLocalQuantityChanged(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in pairs(arg_32_0._localQuantityChanged) do
		for iter_32_2, iter_32_3 in ipairs(iter_32_1) do
			if iter_32_3.type == arg_32_1 and iter_32_3.id == arg_32_2 and iter_32_3.uid == arg_32_3 then
				var_32_0 = var_32_0 + iter_32_3.quantity
			end
		end
	end

	return var_32_0
end

function var_0_0.getItemRare(arg_33_0, arg_33_1)
	return arg_33_1 and arg_33_1.rare or 1
end

function var_0_0.setItemList(arg_34_0, arg_34_1)
	arg_34_0._itemList = {}

	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		local var_34_0 = ItemMo.New()

		var_34_0:init(iter_34_1)
		SDKChannelEventModel.instance:consumeItem(iter_34_1.itemId, iter_34_1.totalGainCount - iter_34_1.quantity)
		table.insert(arg_34_0._itemList, var_34_0)
	end

	arg_34_0:setList(arg_34_0._itemList)
end

function var_0_0.changeItemList(arg_35_0, arg_35_1)
	arg_35_0._itemList = arg_35_0:getList()

	for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
		local var_35_0 = arg_35_0:getById(iter_35_1.itemId)

		if not var_35_0 then
			local var_35_1 = ItemMo.New()

			var_35_1:init(iter_35_1)

			var_35_1.quantity = iter_35_1.quantity

			table.insert(arg_35_0._itemList, var_35_1)
		elseif iter_35_1.quantity == 0 then
			arg_35_0:remove(var_35_0)
		else
			var_35_0.quantity = iter_35_1.quantity
		end

		SDKChannelEventModel.instance:consumeItem(iter_35_1.itemId, iter_35_1.totalGainCount - iter_35_1.quantity)
	end

	arg_35_0:setList(arg_35_0._itemList)
end

function var_0_0.getItemCount(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:getById(arg_36_1)

	return var_36_0 and var_36_0.quantity or 0
end

function var_0_0.getItemList(arg_37_0)
	return arg_37_0._itemList
end

function var_0_0.getItemsBySubType(arg_38_0, arg_38_1)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in pairs(arg_38_0._itemList) do
		local var_38_1 = lua_item.configDict[iter_38_1.id]

		if var_38_1 and var_38_1.subType == arg_38_1 then
			table.insert(var_38_0, iter_38_1)
		end
	end

	return var_38_0
end

function var_0_0.hasEnoughItems(arg_39_0, arg_39_1)
	local var_39_0 = {}

	for iter_39_0 = 1, #arg_39_1 do
		local var_39_1 = arg_39_1[iter_39_0]

		var_39_0[var_39_1.type] = var_39_0[var_39_1.type] or {}
		var_39_0[var_39_1.type][var_39_1.id] = (var_39_0[var_39_1.type][var_39_1.id] or 0) + var_39_1.quantity
	end

	for iter_39_1 = 1, #arg_39_1 do
		local var_39_2 = arg_39_1[iter_39_1]

		if arg_39_0:getItemQuantity(var_39_2.type, var_39_2.id) < var_39_0[var_39_2.type][var_39_2.id] then
			local var_39_3, var_39_4 = arg_39_0:getItemConfigAndIcon(var_39_2.type, var_39_2.id)
			local var_39_5 = ""

			if var_39_3 then
				var_39_5 = var_39_3.name
			end

			return var_39_5, false, var_39_4
		end
	end

	return "", true
end

function var_0_0.getItemDataListByConfigStr(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = GameUtil.splitString2(arg_40_1, true)
	local var_40_1 = {}
	local var_40_2

	if var_40_0 and #var_40_0 > 0 then
		for iter_40_0, iter_40_1 in ipairs(var_40_0) do
			local var_40_3 = iter_40_1[1]
			local var_40_4 = iter_40_1[2]
			local var_40_5 = iter_40_1[3]

			if arg_40_2 then
				var_40_2 = var_40_2 or {}

				if not arg_40_3 and not ItemConfig.instance:isItemStackable(var_40_3, var_40_4) then
					for iter_40_2 = 1, var_40_5 do
						table.insert(var_40_1, {
							quantity = 1,
							isIcon = true,
							materilType = var_40_3,
							materilId = var_40_4
						})
					end
				else
					if not var_40_2[var_40_3] then
						var_40_2[var_40_3] = {}
					end

					if not var_40_2[var_40_3][var_40_4] then
						var_40_2[var_40_3][var_40_4] = {}
					end

					var_40_2[var_40_3][var_40_4].materilType = var_40_3
					var_40_2[var_40_3][var_40_4].materilId = var_40_4
					var_40_2[var_40_3][var_40_4].quantity = var_40_5
					var_40_2[var_40_3][var_40_4].isIcon = true
				end
			else
				table.insert(var_40_1, {
					isIcon = true,
					materilType = var_40_3,
					materilId = var_40_4,
					quantity = var_40_5
				})
			end
		end
	end

	if arg_40_2 and var_40_2 then
		for iter_40_3, iter_40_4 in pairs(var_40_2) do
			for iter_40_5, iter_40_6 in pairs(iter_40_4) do
				table.insert(var_40_1, iter_40_6)
			end
		end
	end

	return var_40_1
end

function var_0_0.goodsIsEnough(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = arg_41_0:getItemQuantity(arg_41_1, arg_41_2)

	return arg_41_3 <= var_41_0, var_41_0
end

function var_0_0.getItemIsEnoughText(arg_42_0, arg_42_1)
	local var_42_0 = var_0_0.instance:getItemQuantity(arg_42_1.materilType, arg_42_1.materilId)

	if var_42_0 >= arg_42_1.quantity then
		if arg_42_1.materilType == MaterialEnum.MaterialType.Currency then
			return tostring(GameUtil.numberDisplay(arg_42_1.quantity))
		else
			return tostring(GameUtil.numberDisplay(var_42_0)) .. "/" .. tostring(GameUtil.numberDisplay(arg_42_1.quantity))
		end
	elseif arg_42_1.materilType == MaterialEnum.MaterialType.Currency then
		return "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(arg_42_1.quantity)) .. "</color>"
	else
		return "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(var_42_0)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(arg_42_1.quantity))
	end
end

function var_0_0.hasEnoughItemsByCellData(arg_43_0, arg_43_1)
	local var_43_0 = {}

	for iter_43_0 = 1, #arg_43_1 do
		local var_43_1 = arg_43_1[iter_43_0]

		var_43_0[var_43_1.materilType] = var_43_0[var_43_1.materilType] or {}
		var_43_0[var_43_1.materilType][var_43_1.materilId] = (var_43_0[var_43_1.materilType][var_43_1.materilId] or 0) + var_43_1.quantity
	end

	for iter_43_1 = 1, #arg_43_1 do
		local var_43_2 = arg_43_1[iter_43_1]

		if arg_43_0:getItemQuantity(var_43_2.materilType, var_43_2.materilId) < var_43_0[var_43_2.materilType][var_43_2.materilId] then
			local var_43_3, var_43_4 = arg_43_0:getItemConfigAndIcon(var_43_2.materilType, var_43_2.materilId)
			local var_43_5 = ""

			if var_43_3 then
				var_43_5 = var_43_3.name
			end

			return var_43_5, false, var_43_4
		end
	end

	return "", true
end

function var_0_0.processRPCItemList(arg_44_0, arg_44_1)
	if not arg_44_1 then
		return {}
	end

	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
		if ItemConfig.instance:isItemStackable(iter_44_1.materilType, iter_44_1.materilId) then
			table.insert(var_44_0, iter_44_1)
		else
			for iter_44_2 = 1, iter_44_1.quantity do
				local var_44_1 = {
					quantity = 1,
					bonusTag = iter_44_1.bonusTag,
					materilType = iter_44_1.materilType,
					materilId = iter_44_1.materilId,
					uid = iter_44_1.uid
				}

				table.insert(var_44_0, var_44_1)
			end
		end
	end

	return var_44_0
end

function var_0_0.canShowVfx(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0 = tonumber(arg_45_0)

	if arg_45_0 == MaterialEnum.MaterialType.PlayerCloth then
		arg_45_2 = arg_45_2 or 5
	end

	local var_45_0 = ItemConfig.instance:getItemCategroyShow(arg_45_0)

	if var_45_0 and var_45_0.highQuality == 1 then
		if arg_45_1.highQuality ~= nil then
			if arg_45_2 ~= nil then
				return arg_45_2 >= 4 and arg_45_1.highQuality == 1
			else
				return arg_45_1.highQuality == 1
			end
		elseif arg_45_2 ~= nil then
			return arg_45_2 >= 5
		else
			return true
		end
	else
		return false
	end
end

function var_0_0.setOptionalGift(arg_46_0)
	arg_46_0.optionalGiftData = {}

	local var_46_0 = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.OptionalGift)

	if var_46_0 then
		for iter_46_0, iter_46_1 in pairs(var_46_0) do
			if not string.nilorempty(iter_46_1.effect) then
				local var_46_1 = {}
				local var_46_2 = string.split(iter_46_1.effect, "|")
				local var_46_3 = string.splitToNumber(var_46_2[1], "#")
				local var_46_4 = string.splitToNumber(var_46_2[2], "#")

				var_46_1.subType = var_46_3[1]
				var_46_1.rare = var_46_3[2] or iter_46_1.rare
				var_46_1.ignore = var_46_4
				var_46_1.co = iter_46_1
				var_46_1.id = iter_46_1.id
				var_46_1.materials = {}

				local var_46_5 = ItemConfig.instance:getItemListBySubType(var_46_1.subType)

				if var_46_5 then
					for iter_46_2, iter_46_3 in pairs(var_46_5) do
						if iter_46_3.rare == var_46_1.rare and not LuaUtil.tableContains(var_46_1.ignore, iter_46_3.id) then
							table.insert(var_46_1.materials, iter_46_3.id)
						end
					end

					arg_46_0.optionalGiftData[iter_46_1.id] = var_46_1
				end
			end
		end
	end
end

function var_0_0.getOptionalGiftMaterialSubTypeList(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0.optionalGiftData and arg_47_0.optionalGiftData[arg_47_1]

	return var_47_0 and var_47_0.materials
end

function var_0_0.getOptionalGiftBySubTypeAndRare(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = {}

	if arg_48_0.optionalGiftData then
		for iter_48_0, iter_48_1 in pairs(arg_48_0.optionalGiftData) do
			if iter_48_1.subType == arg_48_1 and iter_48_1.rare == arg_48_2 and LuaUtil.tableContains(iter_48_1.materials, arg_48_3) then
				table.insert(var_48_0, iter_48_1)
			end
		end
	end

	return var_48_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
