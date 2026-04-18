-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/store/VersionActivitySpecialStoreGoodsItem.lua

module("modules.versionactivitybase.fixed.dungeon.view.store.VersionActivitySpecialStoreGoodsItem", package.seeall)

local VersionActivitySpecialStoreGoodsItem = class("VersionActivitySpecialStoreGoodsItem", LuaCompBase)

function VersionActivitySpecialStoreGoodsItem:init(go)
	self.viewGO = go
	self._gosold = gohelper.findChild(self.viewGO, "go_sold")
	self._txt1 = gohelper.findChildText(self.viewGO, "go_sold/node1/#txt1")
	self._txt2 = gohelper.findChildText(self.viewGO, "go_sold/node2/#txt2")
	self._imagekeyicon = gohelper.findChildImage(self.viewGO, "go_sold/node2/icon")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "go_sold/Icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "go_sold/Icon/txt_icon")
	self._simagecosticon = gohelper.findChildSingleImage(self.viewGO, "go_sold/txt_bg/#txt3/icon")
	self._txt3 = gohelper.findChildText(self.viewGO, "go_sold/txt_bg/#txt3")
	self._txt4 = gohelper.findChildText(self.viewGO, "go_sold/txt_bg/#txt4")
	self._gosoldout = gohelper.findChild(self.viewGO, "go_soldout")
	self.goClick = gohelper.getClick(go)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivitySpecialStoreGoodsItem:addEventListeners()
	self.goClick:AddClickListener(self.onClick, self)
end

function VersionActivitySpecialStoreGoodsItem:removeEventListeners()
	self.goClick:RemoveClickListener()
end

function VersionActivitySpecialStoreGoodsItem:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local remainBuyCount = self:_getRemainBuyCount(self._goodsCo)

	if remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6NormalStoreGoodsView, self._goodsCo)
end

function VersionActivitySpecialStoreGoodsItem:_editableInitView()
	return
end

function VersionActivitySpecialStoreGoodsItem:onUpdateMO(actId)
	self._actId = actId
	self._spGoodsCoList = VersionActivityFixedStoreListModel.instance:getSpecialGoodsList()
	self._goodsCo = self:_getShowGoods()

	local remainBuyCount = self:_getRemainBuyCount(self._goodsCo)

	gohelper.setActive(self._gosoldout, remainBuyCount <= 0)

	local itemType, id, quantity = VersionActivityFixedEnterHelper.getItemTypeIdQuantity(self._goodsCo.product)

	self._txtnum.text = quantity > 1 and luaLang("multiple") .. quantity or ""

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

	self._simageicon:LoadImage(itemIcon)

	local costs = string.splitToNumber(self._goodsCo.cost, "#")

	self._txt1.text = tonumber(self._goodsCo.offTag) * 100 .. "%"
	self._txt3.text = costs[3]
	self._txt4.text = self._goodsCo.originalCost

	local _, costIcon = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])
end

function VersionActivitySpecialStoreGoodsItem:_getShowGoods()
	for _, goodsCo in ipairs(self._spGoodsCoList) do
		local remainBuyCount = self:_getRemainBuyCount(goodsCo)

		if remainBuyCount > 0 then
			return goodsCo
		end
	end

	return self._spGoodsCoList[1]
end

function VersionActivitySpecialStoreGoodsItem:_getRemainBuyCount(goodsCo)
	if goodsCo and goodsCo.maxBuyCount > 0 then
		local count = ActivityStoreModel.instance:getActivityGoodsBuyCount(self._actId, goodsCo.id)

		return goodsCo.maxBuyCount - count
	end

	return 0
end

function VersionActivitySpecialStoreGoodsItem:onDestroy()
	self._simageicon:UnLoadImage()
end

return VersionActivitySpecialStoreGoodsItem
