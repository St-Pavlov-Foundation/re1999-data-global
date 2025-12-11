module("modules.logic.survival.model.map.SurvivalShopItemMo", package.seeall)

local var_0_0 = pureTable("SurvivalShopItemMo", SurvivalBagItemMo)

function var_0_0.ctor(arg_1_0)
	SurvivalBagItemMo.ctor(arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.shopId = arg_2_2
	arg_2_0.shopCfg = lua_survival_shop.configDict[arg_2_2]
	arg_2_0.shopType = SurvivalConfig.instance:getShopType(arg_2_2)

	if arg_2_0.shopId == nil then
		logError("shopId为nil")
	end

	if arg_2_0.shopType ~= SurvivalEnum.ShopType.Reputation and arg_2_1.count == 0 then
		arg_2_1.itemId = 0
	end

	SurvivalBagItemMo.init(arg_2_0, {
		id = arg_2_1.itemId,
		count = arg_2_1.count,
		uid = arg_2_1.uid
	})

	arg_2_0.shopItemId = arg_2_1.id
	arg_2_0.shopItemCo = lua_survival_shop_item.configDict[arg_2_0.shopItemId]
	arg_2_0.buyPrice = 0

	if arg_2_0.co and not string.nilorempty(arg_2_0.co.cost) then
		local var_2_0 = string.match(arg_2_0.co.cost, "^item#1:(.+)$")

		if var_2_0 then
			arg_2_0.buyPrice = tonumber(var_2_0) or 0
		end
	end

	arg_2_0.fixRate = 0

	if arg_2_0.shopItemCo then
		arg_2_0.fixRate = arg_2_0.shopItemCo.worthFix
	end

	arg_2_0.source = SurvivalEnum.ItemSource.ShopItem
end

function var_0_0.isEmpty(arg_3_0)
	if arg_3_0.shopType == SurvivalEnum.ShopType.Reputation then
		return false
	else
		return SurvivalBagItemMo.isEmpty(arg_3_0)
	end
end

function var_0_0.getBuyPrice(arg_4_0)
	local var_4_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_4_1 = 0

	if arg_4_0.shopType == SurvivalEnum.ShopType.Normal then
		var_4_1 = var_4_0:getAttrRaw(SurvivalEnum.AttrType.ShopBuyPriceFix)
	else
		var_4_1 = var_4_0:getAttrRaw(SurvivalEnum.AttrType.BuildBuyPriceFix)
	end

	local var_4_2 = var_4_0:getAttrRaw(SurvivalEnum.AttrType.BuyPriceFix)

	return (math.floor(arg_4_0.buyPrice * (1 + arg_4_0.fixRate / 1000) * (1000 + var_4_1 + var_4_2) / 1000))
end

function var_0_0.getTabId(arg_5_0)
	return arg_5_0.shopItemCo.type
end

return var_0_0
