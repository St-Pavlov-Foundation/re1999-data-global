-- chunkname: @modules/logic/store/view/recommend/StoreNew6StarsChooseView.lua

module("modules.logic.store.view.recommend.StoreNew6StarsChooseView", package.seeall)

local StoreNew6StarsChooseView = class("StoreNew6StarsChooseView", StoreRecommendBaseSubView)

function StoreNew6StarsChooseView:_getCostSymbolAndPrice(systemJumpCode)
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

function StoreNew6StarsChooseView:ctor(...)
	StoreNew6StarsChooseView.super.ctor(self, ...)

	self.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.New6StarsChoose)
end

function StoreNew6StarsChooseView:onInitView()
	self._txtduration = gohelper.findChildText(self.viewGO, "recommend/txt_tips/#txt_duration")
	self._imageAttr1 = gohelper.findChildImage(self.viewGO, "recommend/Name1/#image_Attr")
	self._txtName1 = gohelper.findChildText(self.viewGO, "recommend/Name1/#txt_Name")
	self._imageAttr2 = gohelper.findChildImage(self.viewGO, "recommend/Name2/#image_Attr")
	self._txtName2 = gohelper.findChildText(self.viewGO, "recommend/Name2/#txt_Name")
	self._imageAttr3 = gohelper.findChildImage(self.viewGO, "recommend/Name3/#image_Attr")
	self._txtName3 = gohelper.findChildText(self.viewGO, "recommend/Name3/#txt_Name")
	self._txtChar = gohelper.findChildText(self.viewGO, "recommend/image_Char/#txt_Char")
	self._txtProp = gohelper.findChildText(self.viewGO, "recommend/image_Prop/#txt_Prop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreNew6StarsChooseView:addEvents()
	return
end

function StoreNew6StarsChooseView:removeEvents()
	if self._clickBuy then
		self._clickBuy:RemoveClickListener()
	end
end

function StoreNew6StarsChooseView:_btnbuyOnClick()
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(self.config and self.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = self.config and self.config.name or self.__cname,
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()
	})

	local jumpParams = string.splitToNumber(self.config.systemJumpCode, "#")

	if jumpParams[2] then
		local goodId = jumpParams[2]
		local packageMo = StoreModel.instance:getGoodsMO(goodId)

		StoreController.instance:openPackageStoreGoodsView(packageMo)
	else
		GameFacade.jumpByAdditionParam(self.config.systemJumpCode)
	end
end

function StoreNew6StarsChooseView:_editableInitView()
	StoreNew6StarsChooseView.super._editableInitView(self)

	self._txtNum = gohelper.findChildText(self.viewGO, "recommend/Buy/txt_Num")

	local costStr = self:_getCostSymbolAndPrice(self.config.systemJumpCode)

	self._txtNum.text = costStr or ""

	local goBuyClick = gohelper.findChild(self.viewGO, "recommend/Buy")

	self._clickBuy = SLFramework.UGUI.UIClickListener.Get(goBuyClick)

	self._clickBuy:AddClickListener(self._btnbuyOnClick, self)
end

function StoreNew6StarsChooseView:onOpen()
	StoreNew6StarsChooseView.super.onOpen(self)
	self:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, self.refreshUI, self)
	self:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, self.refreshUI, self)
	self:refreshUI()
end

function StoreNew6StarsChooseView:onClose()
	self:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, self.refreshUI, self)
	self:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, self.refreshUI, self)
end

function StoreNew6StarsChooseView:refreshUI()
	self._txtduration.text = StoreController.instance:getRecommendStoreTime(self.config)
end

return StoreNew6StarsChooseView
