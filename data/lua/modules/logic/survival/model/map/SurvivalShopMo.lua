module("modules.logic.survival.model.map.SurvivalShopMo", package.seeall)

local var_0_0 = pureTable("SurvivalShopMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1.id

	if arg_1_0.id and arg_1_0.id ~= 0 then
		arg_1_0.shopCfg = lua_survival_shop.configDict[arg_1_0.id]
		arg_1_0.shopType = arg_1_0.shopCfg.type
	end

	arg_1_0.reputationId = arg_1_2
	arg_1_0.reputationLevel = arg_1_3
	arg_1_0.items = {}
	arg_1_0.tabItems = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.items) do
		local var_1_0 = SurvivalShopItemMo.New()

		var_1_0:init(iter_1_1, arg_1_0.id)
		table.insert(arg_1_0.items, var_1_0)

		local var_1_1 = var_1_0.shopItemCo.type

		if var_1_1 > 0 then
			if arg_1_0.tabItems[var_1_1] == nil then
				arg_1_0.tabItems[var_1_1] = {}
			end

			table.insert(arg_1_0.tabItems[var_1_1], var_1_0)
		end
	end

	if arg_1_0.shopType and arg_1_0.shopType == SurvivalEnum.ShopType.Reputation then
		arg_1_0.cfgLevelItems = {}
		arg_1_0.levelItems = {}

		for iter_1_2, iter_1_3 in ipairs(arg_1_0.items) do
			local var_1_2 = SurvivalConfig.instance:getShopItemUnlock(iter_1_3.shopItemId)

			if var_1_2 then
				local var_1_3 = var_1_2.level

				if arg_1_0.levelItems[var_1_3] == nil then
					arg_1_0.levelItems[var_1_3] = {}
				end

				table.insert(arg_1_0.levelItems[var_1_3], iter_1_3)
			end
		end
	end
end

function var_0_0.isPreExploreShop(arg_2_0)
	return arg_2_0.shopType == SurvivalEnum.ShopType.PreExplore
end

function var_0_0.isGeneralShop(arg_3_0)
	return arg_3_0.shopType == SurvivalEnum.ShopType.GeneralShop
end

function var_0_0.reduceItem(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.items) do
		if iter_4_1.uid == arg_4_1 then
			iter_4_1.count = iter_4_1.count - arg_4_2

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShopItemUpdate, iter_4_0, iter_4_1, arg_4_1)

			break
		end
	end
end

function var_0_0.removeItem(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.items) do
		if iter_5_1.uid == arg_5_1 then
			iter_5_1.count = iter_5_1.count - arg_5_2

			if iter_5_1.count <= 0 then
				iter_5_1:ctor()
			end

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShopItemUpdate, iter_5_0, iter_5_1, arg_5_1)

			break
		end
	end
end

function var_0_0.getItemByUid(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.items) do
		if iter_6_1.uid == arg_6_1 then
			return iter_6_1
		end
	end
end

function var_0_0.getItemsByTabId(arg_7_0, arg_7_1)
	return arg_7_0.tabItems[arg_7_1] or {}
end

function var_0_0.haveTab(arg_8_0)
	return tabletool.len(arg_8_0.tabItems) > 0
end

function var_0_0.isReputationShopLevelLock(arg_9_0, arg_9_1)
	return arg_9_1 > arg_9_0.reputationLevel
end

function var_0_0.getReputationShopItemByGroupId(arg_10_0, arg_10_1)
	if not arg_10_0:isReputationShopLevelLock(arg_10_1) then
		return arg_10_0.levelItems[arg_10_1] or {}
	else
		if arg_10_0.cfgLevelItems[arg_10_1] == nil then
			arg_10_0.cfgLevelItems[arg_10_1] = {}

			local var_10_0 = SurvivalConfig.instance:getShopItemsByLevel(arg_10_0.reputationId, arg_10_1)

			for iter_10_0, iter_10_1 in ipairs(var_10_0) do
				local var_10_1 = SurvivalShopItemMo.New()

				var_10_1:init({
					uid = 0,
					id = iter_10_1.id,
					itemId = iter_10_1.item,
					count = iter_10_1.maxNum
				}, arg_10_0.id)
				table.insert(arg_10_0.cfgLevelItems[arg_10_1], var_10_1)
			end
		end

		return arg_10_0.cfgLevelItems[arg_10_1]
	end
end

function var_0_0.getReputationItemMaxLevel(arg_11_0)
	return SurvivalConfig.instance:getReputationItemMaxLevel(arg_11_0.reputationId)
end

return var_0_0
