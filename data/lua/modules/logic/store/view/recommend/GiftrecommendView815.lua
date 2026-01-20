-- chunkname: @modules/logic/store/view/recommend/GiftrecommendView815.lua

module("modules.logic.store.view.recommend.GiftrecommendView815", package.seeall)

local GiftrecommendView815 = class("GiftrecommendView815", StoreRecommendBaseSubView)

function GiftrecommendView815:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")
	self._txtduration = gohelper.findChildText(self.viewGO, "view/txt_tips/#txt_duration")
	self._txtprice3 = gohelper.findChildText(self.viewGO, "view/right/#txt_price3")
	self._btnbuy3 = gohelper.findChildButtonWithAudio(self.viewGO, "view/right/#btn_buy3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GiftrecommendView815:addEvents()
	self._btnbuy3:AddClickListener(self._btnbuy3OnClick, self)
end

function GiftrecommendView815:removeEvents()
	self._btnbuy3:RemoveClickListener()
end

function GiftrecommendView815:_btnbuy3OnClick()
	if self._isBought3 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if self._systemJumpCode3 then
		GameFacade.jumpByAdditionParam(self._systemJumpCode3)
	end
end

function GiftrecommendView815:_getIsBought(relation)
	if not relation then
		return false
	end

	local relationType = relation[1]
	local relationId = relation[2]

	if not relationType or not relationId then
		return false
	end

	local storePackageGoodsMO = StoreModel.instance:getGoodsMO(relationId)

	if storePackageGoodsMO == nil or storePackageGoodsMO:isSoldOut() then
		return true
	end

	return false
end

function GiftrecommendView815:onOpen()
	GiftrecommendView815.super.onOpen(self)
	self:_refreshUI()
	self:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, self._refreshUI, self)
	self:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, self._refreshUI, self)
end

function GiftrecommendView815:_refreshUI()
	self._txtprice3.text = ""

	if self.config == nil then
		return
	end

	self._systemJumpCode3 = self.config.systemJumpCode

	if self._systemJumpCode3 then
		local costStr = self:_getCostSymbolAndPrice(self._systemJumpCode3)

		if costStr then
			self._txtprice3.text = costStr
		end
	end

	if not string.nilorempty(self.config.relations) then
		local relations = GameUtil.splitString2(self.config.relations, true)

		if type(relations) == "table" then
			self._isBought3 = self:_getIsBought(relations[3])
		end
	end

	self._txtduration.text = StoreController.instance:getRecommendStoreTime(self.config)
end

function GiftrecommendView815:_getCostSymbolAndPrice(systemJumpCode)
	if not systemJumpCode or systemJumpCode == "" then
		return
	end

	local paramsList = string.splitToNumber(systemJumpCode, "#")

	if type(paramsList) ~= "table" and #paramsList < 2 then
		return
	end

	local jumpGoodsId = paramsList[2]
	local symbol = PayModel.instance:getProductOriginPriceSymbol(jumpGoodsId)
	local num, numStr = PayModel.instance:getProductOriginPriceNum(jumpGoodsId)
	local symbol2 = ""

	if string.nilorempty(symbol) then
		local reverseStr = string.reverse(numStr)
		local lastIndex = string.find(reverseStr, "%d")

		lastIndex = string.len(reverseStr) - lastIndex + 1
		symbol2 = string.sub(numStr, lastIndex + 1, string.len(numStr))
		numStr = string.sub(numStr, 1, lastIndex)

		return string.format("%s<size=50>%s</size>", numStr, symbol2)
	else
		return string.format("<size=50>%s</size>%s", symbol, numStr)
	end
end

function GiftrecommendView815:onClose()
	GiftrecommendView815.super.onClose(self)
	self:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, self._refreshUI, self)
	self:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, self._refreshUI, self)
end

return GiftrecommendView815
