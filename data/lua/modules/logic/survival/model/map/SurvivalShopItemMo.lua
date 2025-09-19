module("modules.logic.survival.model.map.SurvivalShopItemMo", package.seeall)

local var_0_0 = pureTable("SurvivalShopItemMo", SurvivalBagItemMo)

function var_0_0.ctor(arg_1_0)
	SurvivalBagItemMo.ctor(arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	if arg_2_1.count == 0 then
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

function var_0_0.getBuyPrice(arg_3_0)
	return SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.BuyPriceFix, arg_3_0.buyPrice, arg_3_0.fixRate)
end

return var_0_0
