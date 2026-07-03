-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/store/VersionActivitySpecialStoreGoodsItem.lua

module("modules.versionactivitybase.fixed.dungeon.view.store.VersionActivitySpecialStoreGoodsItem", package.seeall)

local VersionActivitySpecialStoreGoodsItem = class("VersionActivitySpecialStoreGoodsItem", VersionActivityFixedStoreGoodsItem)

function VersionActivitySpecialStoreGoodsItem:onInitView(go)
	VersionActivitySpecialStoreGoodsItem.super.onInitView(self, go)

	self._txt2 = gohelper.findChildText(go, "node2/#txt2")
	self._imagekeyicon = gohelper.findChildImage(go, "node2/icon")
end

function VersionActivitySpecialStoreGoodsItem:updateInfo(storeGoodsCo)
	VersionActivitySpecialStoreGoodsItem.super.updateInfo(self, storeGoodsCo)

	local itemType, id, quantity = VersionActivityFixedEnterHelper.getItemTypeIdQuantity(storeGoodsCo.product)
	local itemCo, itemIcon = ItemModel.instance:getItemConfigAndIcon(itemType, id)

	if itemCo.subType == ItemEnum.SubType.HeroExpBox then
		local keyCount = HeroExpBoxModel.instance:getKeyCount()
		local needKeyCount = HeroExpBoxModel.instance:getNeedKeyCount(itemCo.id)
		local icon = HeroExpBoxModel.instance:getKeyIcon()

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagekeyicon, icon .. "_1", true)

		local str = ""

		if needKeyCount <= keyCount then
			str = string.format("%d/%d", keyCount, needKeyCount)
		else
			str = string.format("<color=%s>%d</color>/%d", "#FF0000", keyCount, needKeyCount)
		end

		self._txt2.text = str
	end
end

return VersionActivitySpecialStoreGoodsItem
