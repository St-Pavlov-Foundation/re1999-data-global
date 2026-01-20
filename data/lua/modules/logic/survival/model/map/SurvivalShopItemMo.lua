-- chunkname: @modules/logic/survival/model/map/SurvivalShopItemMo.lua

module("modules.logic.survival.model.map.SurvivalShopItemMo", package.seeall)

local SurvivalShopItemMo = pureTable("SurvivalShopItemMo", SurvivalBagItemMo)

function SurvivalShopItemMo:ctor()
	SurvivalBagItemMo.ctor(self)
end

function SurvivalShopItemMo:init(data, shopId)
	self.shopId = shopId
	self.shopCfg = lua_survival_shop.configDict[shopId]
	self.shopType = SurvivalConfig.instance:getShopType(shopId)

	if self.shopId == nil then
		logError("shopId为nil")
	end

	if self.shopType ~= SurvivalEnum.ShopType.Reputation and data.count == 0 then
		data.itemId = 0
	end

	SurvivalBagItemMo.init(self, {
		id = data.itemId,
		count = data.count,
		uid = data.uid
	})

	self.shopItemId = data.id
	self.shopItemCo = lua_survival_shop_item.configDict[self.shopItemId]
	self.buyPrice = 0

	if self.co and not string.nilorempty(self.co.cost) then
		local price = string.match(self.co.cost, "^item#1:(.+)$")

		if price then
			self.buyPrice = tonumber(price) or 0
		end
	end

	self.fixRate = 0

	if self.shopItemCo then
		self.fixRate = self.shopItemCo.worthFix
	end

	self.source = SurvivalEnum.ItemSource.ShopItem
end

function SurvivalShopItemMo:isEmpty()
	if self.shopType == SurvivalEnum.ShopType.Reputation then
		return false
	else
		return SurvivalBagItemMo.isEmpty(self)
	end
end

function SurvivalShopItemMo:getBuyPrice()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()
	local attrRate = 0

	if self.shopType == SurvivalEnum.ShopType.Normal then
		attrRate = weekMo:getAttrRaw(SurvivalEnum.AttrType.ShopBuyPriceFix)
	else
		attrRate = weekMo:getAttrRaw(SurvivalEnum.AttrType.BuildBuyPriceFix)
	end

	local attrRate2 = weekMo:getAttrRaw(SurvivalEnum.AttrType.BuyPriceFix)
	local price = math.floor(self.buyPrice * (1 + self.fixRate / 1000) * (1000 + attrRate + attrRate2) / 1000)

	return price
end

function SurvivalShopItemMo:getTabId()
	return self.shopItemCo.type
end

return SurvivalShopItemMo
