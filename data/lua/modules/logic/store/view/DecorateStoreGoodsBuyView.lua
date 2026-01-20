-- chunkname: @modules/logic/store/view/DecorateStoreGoodsBuyView.lua

module("modules.logic.store.view.DecorateStoreGoodsBuyView", package.seeall)

local DecorateStoreGoodsBuyView = class("DecorateStoreGoodsBuyView", BaseView)

function DecorateStoreGoodsBuyView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._btntheme = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_theme")
	self._txttheme = gohelper.findChildText(self.viewGO, "left/#btn_theme/txt")
	self._gocobrand = gohelper.findChild(self.viewGO, "left/#go_cobrand")
	self._gobuyContent = gohelper.findChild(self.viewGO, "right/#go_buyContent")
	self._goblockInfoItem = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_blockInfoItem")
	self._gochange = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_change")
	self._txtchange = gohelper.findChildText(self.viewGO, "right/#go_buyContent/#go_change/#txt_desc")
	self._imagechangeicon = gohelper.findChildImage(self.viewGO, "right/#go_buyContent/#go_change/#txt_desc/simage_icon")
	self._gopaynoraml = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_change/go_normalbg")
	self._gopayselect = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_change/go_selectbg")
	self._btnticket = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_buyContent/#go_change/btn_pay")
	self._gopay = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_pay")
	self._gopayitem = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	self._btninsight = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_buyContent/buy/#btn_insight")
	self._txtcostnum = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	self._imagecosticon = gohelper.findChildImage(self.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	self._gosource = gohelper.findChild(self.viewGO, "right/#go_source")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateStoreGoodsBuyView:addEvents()
	self._btntheme:AddClickListener(self._btnthemeOnClick, self)
	self._btninsight:AddClickListener(self._btninsightOnClick, self)
	self._btnticket:AddClickListener(self._btnClickUseTicket, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function DecorateStoreGoodsBuyView:removeEvents()
	self._btntheme:RemoveClickListener()
	self._btninsight:RemoveClickListener()
	self._btnticket:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function DecorateStoreGoodsBuyView:_btnthemeOnClick()
	return
end

function DecorateStoreGoodsBuyView:_btninsightOnClick()
	local curIndex = DecorateStoreModel.instance:getCurCostIndex()
	local costParam = self._currencyParam[curIndex]

	if costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(costParam[3], CurrencyEnum.PayDiamondExchangeSource.Store, nil, self._buyGood, self, self.closeThis, self) then
			self:_buyGood(curIndex)
		end
	elseif costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.Diamond then
		if CurrencyController.instance:checkDiamondEnough(costParam[3], self.closeThis, self) then
			self:_buyGood(curIndex)
		end
	elseif costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.OldTravelTicket then
		local currencyMo = CurrencyModel.instance:getCurrency(costParam[2])

		if currencyMo then
			if currencyMo.quantity >= costParam[3] then
				self:_buyGood(curIndex)
			else
				GameFacade.showToast(ToastEnum.CurrencyNotEnough)

				return false
			end
		end
	elseif ItemModel.instance:goodsIsEnough(costParam[1], costParam[2], costParam[3]) then
		self:_buyGood(curIndex)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.DecorateStoreCurrencyNotEnough, MsgBoxEnum.BoxType.Yes_No, self._storeCurrencyNotEnoughCallback, nil, nil, self, nil)
	end
end

function DecorateStoreGoodsBuyView:_storeCurrencyNotEnoughCallback()
	GameFacade.jump(JumpEnum.JumpId.GlowCharge)
end

function DecorateStoreGoodsBuyView:_buyGood(index)
	StoreController.instance:buyGoods(self._mo, 1, self._buyCallback, self, index)
end

function DecorateStoreGoodsBuyView:_buyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
	end
end

function DecorateStoreGoodsBuyView:_btnClickUseTicket()
	return
end

function DecorateStoreGoodsBuyView:_btncloseOnClick()
	self:closeThis()
end

function DecorateStoreGoodsBuyView:_editableInitView()
	self._simagetheme = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/iconmask/simage_theme")
	self._goitemContent = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/go_itemContent")
	self._simageinfobg = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/simage_infobg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/txt_desc")
	self._txtname = gohelper.findChildText(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/txt_desc/txt_name")
	self._goslider = gohelper.findChild(self.viewGO, "left/banner/#go_slider")
	self._payItemTbList = {}
	self._infoItemTbList = {}

	gohelper.setActive(self._goblockInfoItem, false)
	gohelper.setActive(self._btntheme.gameObject, false)
	gohelper.setActive(self._goitemContent.gameObject, false)
	gohelper.setActive(self._goslider.gameObject, false)
	gohelper.setActive(self._gobuyContent, true)
	gohelper.setActive(self._gosource, false)
	self:_createPayItemUserDataTb_(self._gopayitem, 1)
	self:_createInfoItemUserDataTb_(self._goblockInfoItem, 1)
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
	gohelper.removeUIClickAudio(self._btnclose.gameObject)
	gohelper.addUIClickAudio(self._btninsight.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
	self._simageinfobg:LoadImage(ResUrl.getRoomImage("bg_zhezhao_yinying"))
end

function DecorateStoreGoodsBuyView:onOpen()
	self._mo = self.viewParam.goodsMo

	DecorateStoreModel.instance:setCurCostIndex(1)
	self:_setCurrency()
	self:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
	StoreController.instance:statOpenChargeGoods(self._mo.belongStoreId, self._mo.config)
end

function DecorateStoreGoodsBuyView:_setCurrency()
	local currencyParam = {}

	self._currencyParam = {}

	if self._mo.config.cost ~= "" then
		local costs = string.splitToNumber(self._mo.config.cost, "#")

		table.insert(currencyParam, costs[2])
		table.insert(self._currencyParam, costs)
	end

	if self._mo.config.cost2 ~= "" then
		local cost2s = string.splitToNumber(self._mo.config.cost2, "#")

		table.insert(currencyParam, cost2s[2])
		table.insert(self._currencyParam, cost2s)
	end

	for _, v in pairs(currencyParam) do
		if v == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			table.insert(currencyParam, CurrencyEnum.CurrencyType.Diamond)
		end
	end

	local result = LuaUtil.getReverseArrTab(currencyParam)

	self.viewContainer:setCurrencyType(result)
end

function DecorateStoreGoodsBuyView:_refreshUI()
	self._goodConfig = StoreConfig.instance:getGoodsConfig(self._mo.goodsId)
	self._curItemType = DecorateStoreModel.getItemType(tonumber(self._goodConfig.storeId))
	self._products = string.splitToNumber(self._goodConfig.product, "#")
	self._itemCo = ItemModel.instance:getItemConfig(self._products[1], self._products[2])

	self:_refreshIcon()
	self:_refreshCost()
	self._simagetheme:LoadImage(ResUrl.getDecorateStoreBuyBannerFullPath(self._itemCo.id), function()
		ZProj.UGUIHelper.SetImageSize(self._simagetheme.gameObject)
	end, self)

	self._txtdesc.text = self._itemCo.desc
	self._txtname.text = self._itemCo.name
end

function DecorateStoreGoodsBuyView:_createPayItemUserDataTb_(goItem, index)
	local item = self:getUserDataTb_()

	item._go = goItem
	item._index = index
	item._gonormalbg = gohelper.findChild(goItem, "go_normalbg")
	item._goselectbg = gohelper.findChild(goItem, "go_selectbg")
	item._imageicon = gohelper.findChildImage(goItem, "txt_desc/simage_icon")
	item._txtdesc = gohelper.findChildText(goItem, "txt_desc")
	item._btnpay = gohelper.findChildButtonWithAudio(goItem, "btn_pay")

	item._btnpay:AddClickListener(self._onClickPlay, self, index)
	table.insert(self._payItemTbList, item)

	return item
end

function DecorateStoreGoodsBuyView:_onClickPlay(index)
	for _, item in ipairs(self._payItemTbList) do
		self:_onSelectPayItemUI(item, item._index == index)
	end

	DecorateStoreModel.instance:setCurCostIndex(index)
	self:_refreshCost()
end

function DecorateStoreGoodsBuyView:_createInfoItemUserDataTb_(goItem, index)
	local item = self:getUserDataTb_()

	item._go = goItem
	item._index = index
	item._goeprice = gohelper.findChild(goItem, "go_price")
	item._gofinish = gohelper.findChild(goItem, "go_finish")
	item._txtgold = gohelper.findChildText(goItem, "go_price/txt_gold")
	item._imagegold = gohelper.findChildImage(goItem, "go_price/image_gold")
	item._txtname = gohelper.findChildText(goItem, "txt_name")
	item._txtnum = gohelper.findChildText(goItem, "txt_num")
	item._gobg = gohelper.findChild(goItem, "go_bg")
	item._txtowner = gohelper.findChildText(goItem, "go_finish/txt_owner")

	table.insert(self._infoItemTbList, item)

	return item
end

function DecorateStoreGoodsBuyView:_refreshPayItemUI(item, costId, itemType, itemId)
	item.costId = costId

	local str = self:_getCurrencyIconStr(itemType, itemId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(item._imageicon, str)

	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(itemType, itemId, true)

	item._txtdesc.text = itemCfg and itemCfg.name or nil
end

function DecorateStoreGoodsBuyView:_getCurrencyIconStr(itemType, itemId)
	local id = 0

	if string.len(itemId) == 1 then
		id = itemType .. "0" .. itemId
	else
		id = itemType .. itemId
	end

	return string.format("%s_1", id)
end

function DecorateStoreGoodsBuyView:_onSelectPayItemUI(item, isSelect)
	gohelper.setActive(item._goselectbg, isSelect)
	gohelper.setActive(item._gonormalbg, not isSelect)
	SLFramework.UGUI.GuiHelper.SetColor(item._txtdesc, isSelect and "#FFFFFF" or "#4C4341")
end

function DecorateStoreGoodsBuyView:_refreshIcon()
	local curIndex = DecorateStoreModel.instance:getCurCostIndex()

	for index, currency in ipairs(self._currencyParam) do
		local item = self._payItemTbList[index]

		if not item then
			local goItem = gohelper.cloneInPlace(self._gopayitem, "go_payitem" .. index)

			item = self:_createPayItemUserDataTb_(goItem, index)
		end

		self:_onSelectPayItemUI(item, item._index == curIndex)
		gohelper.setActive(item._go, true)
		self:_refreshPayItemUI(item, index, currency[1], currency[2])
	end
end

function DecorateStoreGoodsBuyView:_refreshCost()
	local curIndex = DecorateStoreModel.instance:getCurCostIndex()
	local costParam = self._currencyParam[curIndex]

	if costParam then
		local str = self:_getCurrencyIconStr(costParam[1], costParam[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecosticon, str)

		local quantity = ItemModel.instance:getItemQuantity(costParam[1], costParam[2])

		SLFramework.UGUI.GuiHelper.SetColor(self._txtcostnum, quantity and quantity >= costParam[3] and "#595959" or "#BF2E11")

		self._txtcostnum.text = costParam[3]

		local item = self._infoItemTbList[1]

		if not item then
			local goItem = gohelper.cloneInPlace(self._goblockInfoItem, "go_payitem" .. curIndex)

			item = self:_createInfoItemUserDataTb_(goItem, curIndex)
		end

		item._txtname.text = self._goodConfig.name

		local count = ItemModel.instance:getItemQuantity(self._products[1], self._products[2])

		item._txtnum.text = string.format("%s/%s", count, self._products[3])
		item._txtgold.text = costParam[3]

		UISpriteSetMgr.instance:setCurrencyItemSprite(item._imagegold, str)
		gohelper.setActive(item._go, true)
	else
		logError("消耗货币数据出错")
	end
end

function DecorateStoreGoodsBuyView:onClickModalMask()
	self:closeThis()
end

function DecorateStoreGoodsBuyView:onClose()
	for _, item in ipairs(self._payItemTbList) do
		item._btnpay:RemoveClickListener()
	end
end

function DecorateStoreGoodsBuyView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._simagetheme:UnLoadImage()
	self._simageinfobg:UnLoadImage()
end

return DecorateStoreGoodsBuyView
