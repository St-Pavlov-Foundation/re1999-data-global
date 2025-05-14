module("modules.logic.backpack.model.BackpackModel", package.seeall)

local var_0_0 = class("BackpackModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curCategoryId = 1
	arg_2_0._categoryList = {}
	arg_2_0._itemList = {}
	arg_2_0._itemAniHasShown = false
end

function var_0_0.getItemAniHasShown(arg_3_0)
	return arg_3_0._itemAniHasShown
end

function var_0_0.setItemAniHasShown(arg_4_0, arg_4_1)
	arg_4_0._itemAniHasShown = arg_4_1
end

function var_0_0.getCurCategoryId(arg_5_0)
	return arg_5_0._curCategoryId
end

function var_0_0.setCurCategoryId(arg_6_0, arg_6_1)
	arg_6_0._curCategoryId = arg_6_1
end

function var_0_0.setBackpackCategoryList(arg_7_0, arg_7_1)
	arg_7_0._categoryList = arg_7_1
end

function var_0_0.setBackpackItemList(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._itemList = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		local var_8_0
		local var_8_1
		local var_8_2 = true

		if iter_8_1.uid then
			if iter_8_1.insightId then
				local var_8_3 = MaterialEnum.MaterialType.NewInsight
				local var_8_4 = ItemInsightModel.instance:getInsightItem(iter_8_1.uid)

				var_8_2 = var_8_4 ~= nil and var_8_4.quantity > 0

				if var_8_2 then
					var_8_0 = arg_8_0:_convertItemData(iter_8_1.uid, var_8_3)
				end
			else
				local var_8_5 = MaterialEnum.MaterialType.PowerPotion
				local var_8_6 = ItemPowerModel.instance:getPowerItem(iter_8_1.uid)

				var_8_2 = var_8_6 ~= nil and var_8_6.quantity > 0

				if var_8_2 then
					var_8_0 = arg_8_0:_convertItemData(iter_8_1.uid, var_8_5)
				end
			end
		elseif iter_8_1.id then
			local var_8_7 = MaterialEnum.MaterialType.Item

			var_8_2 = arg_8_2 and iter_8_1.quantity > 0 or ItemModel.instance:getItemCount(iter_8_1.id) > 0

			if var_8_2 then
				var_8_0 = arg_8_0:_convertItemData(iter_8_1.id, var_8_7, arg_8_2 and iter_8_1.quantity)
			end
		elseif iter_8_1.currencyId then
			local var_8_8 = MaterialEnum.MaterialType.Currency

			var_8_0 = arg_8_0:_convertItemData(iter_8_1.currencyId, var_8_8)
		end

		if var_8_2 and var_8_0 then
			local var_8_9 = BackpackMo.New()

			var_8_9:init(var_8_0)
			table.insert(arg_8_0._itemList, var_8_9)
		end
	end
end

function var_0_0.getBackpackItemList(arg_9_0)
	return arg_9_0._itemList
end

function var_0_0.getBackpackList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(ItemModel.instance:getList()) do
		table.insert(var_10_0, iter_10_1)
	end

	for iter_10_2, iter_10_3 in pairs(CurrencyModel.instance:getCurrencyList()) do
		if iter_10_3.quantity > 0 then
			table.insert(var_10_0, iter_10_3)
		end
	end

	for iter_10_4, iter_10_5 in pairs(ItemPowerModel.instance:getPowerItemList()) do
		if iter_10_5.quantity > 0 then
			table.insert(var_10_0, iter_10_5)
		end
	end

	for iter_10_6, iter_10_7 in pairs(ItemInsightModel.instance:getInsightItemList()) do
		if iter_10_7.quantity > 0 then
			table.insert(var_10_0, iter_10_7)
		end
	end

	return var_10_0
end

function var_0_0._convertItemData(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {
		type = arg_11_2
	}
	local var_11_1
	local var_11_2

	if var_11_0.type == MaterialEnum.MaterialType.PowerPotion then
		var_11_0.uid = arg_11_1
		var_11_0.id = ItemPowerModel.instance:getPowerItem(arg_11_1).id
		var_11_1, var_11_2 = ItemModel.instance:getItemConfigAndIcon(var_11_0.type, var_11_0.id)
	elseif var_11_0.type == MaterialEnum.MaterialType.NewInsight then
		var_11_0.uid = arg_11_1
		var_11_0.id = ItemInsightModel.instance:getInsightItem(arg_11_1).insightId
		var_11_1, var_11_2 = ItemModel.instance:getItemConfigAndIcon(var_11_0.type, var_11_0.id)
	else
		var_11_0.id = arg_11_1
		var_11_1, var_11_2 = ItemModel.instance:getItemConfigAndIcon(var_11_0.type, arg_11_1)
	end

	if not var_11_1 then
		logError(string.format("convertItemData no config, type: %s, id: %s", arg_11_2, arg_11_1))

		return nil
	end

	var_11_0.quantity = arg_11_3 or ItemModel.instance:getItemQuantity(var_11_0.type, var_11_0.id, var_11_0.uid)
	var_11_0.icon = var_11_2
	var_11_0.rare = var_11_1.rare

	if var_11_0.type == MaterialEnum.MaterialType.Item then
		var_11_0.isStackable = var_11_1.isStackable
		var_11_0.isShow = var_11_1.isShow
		var_11_0.subType = var_11_1.subType
		var_11_0.isTimeShow = var_11_1.isTimeShow
		var_11_0.expireTime = var_11_1.expireTime or -1
	elseif var_11_0.type == MaterialEnum.MaterialType.PowerPotion then
		var_11_0.isStackable = 1
		var_11_0.isShow = 1
		var_11_0.subType = 0
		var_11_0.isTimeShow = var_11_1.expireType == 0 and 0 or 1

		if var_11_1.expireType == 0 then
			var_11_0.expireTime = -1
		else
			var_11_0.expireTime = ItemPowerModel.instance:getPowerItemDeadline(arg_11_1)
		end
	elseif var_11_0.type == MaterialEnum.MaterialType.NewInsight then
		var_11_0.isStackable = 1
		var_11_0.isShow = 1
		var_11_0.subType = 0
		var_11_0.expireTime = ItemInsightModel.instance:getInsightItemDeadline(arg_11_1)

		local var_11_3 = ItemConfig.instance:getInsightItemCo(var_11_0.id)

		var_11_0.isTimeShow = var_11_3 and var_11_3.expireType ~= 0 and var_11_3.expireHours ~= ItemEnum.NoExpiredNum and 1 or 0
	elseif var_11_0.type == MaterialEnum.MaterialType.Currency then
		var_11_0.isStackable = 1
		var_11_0.isShow = 1
		var_11_0.subType = 0
		var_11_0.isTimeShow = 0
	end

	return var_11_0
end

function var_0_0.getCategoryItemlist(arg_12_0, arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0._itemList) do
		local var_12_1 = arg_12_0:_getItemBelong(iter_12_1.type, iter_12_1.id)

		if iter_12_1.type == MaterialEnum.MaterialType.PowerPotion then
			if arg_12_1 == ItemEnum.CategoryType.All or arg_12_1 == ItemEnum.CategoryType.UseType then
				table.insert(var_12_0, iter_12_1)
			end
		elseif iter_12_1.type == MaterialEnum.MaterialType.NewInsight then
			if arg_12_1 == ItemEnum.CategoryType.All or arg_12_1 == ItemEnum.CategoryType.UseType then
				table.insert(var_12_0, iter_12_1)
			end
		else
			for iter_12_2, iter_12_3 in pairs(var_12_1) do
				if iter_12_3 == arg_12_1 then
					table.insert(var_12_0, iter_12_1)
				end
			end
		end
	end

	return var_12_0
end

function var_0_0._getItemBelong(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1 = tonumber(arg_13_1)
	arg_13_2 = tonumber(arg_13_2)

	local var_13_0 = {}

	table.insert(var_13_0, ItemEnum.CategoryType.All)

	for iter_13_0, iter_13_1 in pairs(arg_13_0._categoryList) do
		local var_13_1
		local var_13_2

		if arg_13_1 == MaterialEnum.MaterialType.Item then
			var_13_1 = iter_13_1.includeitem
			var_13_2 = ItemConfig.instance:getItemCo(arg_13_2).subType
		elseif arg_13_1 == MaterialEnum.MaterialType.Currency then
			var_13_1 = iter_13_1.includecurrency
			var_13_2 = arg_13_2
		end

		if arg_13_0:_isItemBelongCate(var_13_1, var_13_2) and not LuaUtil.tableContains(var_13_0, tonumber(iter_13_1.id)) then
			table.insert(var_13_0, tonumber(iter_13_1.id))
		end
	end

	return var_13_0
end

function var_0_0._isItemBelongCate(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = string.split(arg_14_1, "#")

	if not var_14_0 then
		return false
	end

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if tonumber(iter_14_1) == arg_14_2 then
			return true
		end
	end

	return false
end

function var_0_0.getCategoryItemsDeadline(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getCategoryItemlist(arg_15_1)
	local var_15_1 = -1

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		if iter_15_1.isShow == 1 and iter_15_1.isTimeShow == 1 then
			local var_15_2 = iter_15_1:itemExpireTime()

			if var_15_2 ~= -1 then
				if var_15_1 == -1 then
					var_15_1 = var_15_2
				else
					var_15_1 = var_15_2 < var_15_1 and var_15_2 or var_15_1
				end
			end
		end
	end

	return var_15_1
end

function var_0_0.getItemDeadline(arg_16_0)
	local var_16_0 = ItemModel.instance:getItemList() or {}
	local var_16_1

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_2 = ItemConfig.instance:getItemCo(iter_16_1.id)

		if var_16_2 then
			if var_16_2.isShow == 1 and var_16_2.expireTime and var_16_2.expireTime ~= "" then
				local var_16_3 = var_16_2.expireTime

				if type(var_16_3) == "string" then
					var_16_3 = TimeUtil.stringToTimestamp(var_16_3)
				end

				if not var_16_1 or var_16_3 < var_16_1 then
					var_16_1 = var_16_3
				end
			end
		else
			logError("找不到道具配置, id: " .. iter_16_1.id)
		end
	end

	local var_16_4 = ItemPowerModel.instance:getPowerItemList() or {}

	for iter_16_2, iter_16_3 in pairs(var_16_4) do
		if ItemConfig.instance:getPowerItemCo(iter_16_3.id).expireType ~= 0 and ItemPowerModel.instance:getPowerItemCount(iter_16_3.uid) > 0 then
			local var_16_5 = ItemPowerModel.instance:getPowerItemDeadline(iter_16_3.uid)

			if not var_16_1 or var_16_5 < var_16_1 then
				var_16_1 = var_16_5
			end
		end
	end

	local var_16_6 = ItemInsightModel.instance:getInsightItemList() or {}

	for iter_16_4, iter_16_5 in pairs(var_16_6) do
		local var_16_7 = ItemConfig.instance:getInsightItemCo(iter_16_5.insightId)

		if var_16_7.expireType ~= 0 and var_16_7.expireHours ~= ItemEnum.NoExpiredNum and ItemInsightModel.instance:getInsightItemCount(iter_16_5.uid) > 0 then
			local var_16_8 = ItemInsightModel.instance:getInsightItemDeadline(iter_16_5.uid)

			if not var_16_1 or var_16_8 < var_16_1 then
				var_16_1 = var_16_8
			end
		end
	end

	return var_16_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
