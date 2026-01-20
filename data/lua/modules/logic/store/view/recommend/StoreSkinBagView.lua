-- chunkname: @modules/logic/store/view/recommend/StoreSkinBagView.lua

module("modules.logic.store.view.recommend.StoreSkinBagView", package.seeall)

local StoreSkinBagView = class("StoreSkinBagView", GiftrecommendViewBase)

function StoreSkinBagView:_getCostSymbolAndPrice(systemJumpCode)
	if not systemJumpCode or systemJumpCode == "" then
		return
	end

	local paramsList = string.splitToNumber(systemJumpCode, "#")

	if type(paramsList) ~= "table" and #paramsList < 2 then
		return
	end

	local jumpGoodsId = paramsList[2]
	local symbol = PayModel.instance:getProductOriginPriceSymbol(jumpGoodsId)
	local num, numStr, isNoDecimalsCurrency = PayModel.instance:getProductOriginPriceNum(jumpGoodsId)

	return symbol, numStr
end

function StoreSkinBagView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")
	self._txtdurationTime = gohelper.findChildText(self.viewGO, "view/time/#txt_durationTime")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/#btn_buy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinBagView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function StoreSkinBagView:removeEvents()
	self._btnbuy:RemoveClickListener()
end

function StoreSkinBagView:_btnbuyOnClick()
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(self.config and self.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = self.config and self.config.name or "StoreSkinBagView",
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()
	})
	GameFacade.jumpByAdditionParam(self.config.systemJumpCode)
end

function StoreSkinBagView:_editableInitView()
	StoreSkinBagView.super._editableInitView(self)

	self._pricetxtnum = gohelper.findChildText(self.viewGO, "view/pricetxt/pricetxtnum")
	self._pricetxticon = gohelper.findChildText(self.viewGO, "view/pricetxt/pricetxtnum/pricetxticon")

	local symbol, price = self:_getCostSymbolAndPrice(self.config.systemJumpCode)

	self._pricetxtnum.text = ""
	self._pricetxticon.text = ""

	if not string.nilorempty(symbol) then
		self._pricetxticon.text = symbol
	end

	if not string.nilorempty(price) then
		self._pricetxtnum.text = price
	end
end

function StoreSkinBagView:onOpen()
	self.config = self.config or StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreSkinBagView)

	StoreSkinBagView.super.onOpen(self)
end

function StoreSkinBagView:onClose()
	StoreSkinBagView.super.onClose(self)
end

function StoreSkinBagView:refreshUI()
	self._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(self.config)
end

function StoreSkinBagView:onDestroyView()
	StoreSkinBagView.super.onDestroyView(self)
end

return StoreSkinBagView
