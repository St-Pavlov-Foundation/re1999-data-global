-- chunkname: @modules/logic/characterskin/view/StoreSkinPreviewRightView.lua

module("modules.logic.characterskin.view.StoreSkinPreviewRightView", package.seeall)

local StoreSkinPreviewRightView = class("StoreSkinPreviewRightView", BaseView)

function StoreSkinPreviewRightView:_onOpenViewFinish(viewName)
	if viewName == ViewName.CharacterSkinGainView then
		self:closeThis()
	end
end

local DEFAULT_IS_CHARGE_PAY = true

function StoreSkinPreviewRightView:onInitView()
	self._simageshowbg = gohelper.findChildSingleImage(self.viewGO, "container/#simage_skinSwitchBg")
	self._goskincontainer = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer")
	self._scrollskinSwitch = gohelper.findChildScrollRect(self.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch")
	self._goContent = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	self._gopreEmpty = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	self._goskinItem = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy")
	self._gotxtbuy = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy")
	self._goCost = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price")
	self._imageicon = gohelper.findChildImage(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#image_icon")
	self._txtprice = gohelper.findChildText(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#txt_price")
	self._goCharge = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge")
	self._txtCharge = gohelper.findChildText(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge/txt_chargeNum")
	self._txtOriginalCharge = gohelper.findChildText(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge/txt_originalChargeNum")
	self._goChargeItem = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_pay/#go_chargeItem")
	self._goCostItem = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_pay/#go_costItem")
	self._gohas = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#go_has")
	self._goskinCard = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/#go_skinCard")
	self._goSkinTips = gohelper.findChild(self.viewGO, "container/#go_SkinTips")
	self._imgProp = gohelper.findChildImage(self.viewGO, "container/#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	self._txtPropNum = gohelper.findChildTextMesh(self.viewGO, "container/#go_SkinTips/image/#txt_Tips/#txt_Num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinPreviewRightView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function StoreSkinPreviewRightView:removeEvents()
	self._btnbuy:RemoveClickListener()
end

function StoreSkinPreviewRightView:_btnbuyOnClick()
	local mo = self._allSkinList[self._currentSelectSkinIndex]

	if mo and StoreModel.instance:getGoodsMO(mo.goodsId) then
		if StoreModel.instance:isSkinCanShowMessageBox(self.skinCo and self.skinCo.id) then
			local skinStoreId = self.skinCo.skinStoreId
			local skinGoodsMo = StoreModel.instance:getGoodsMO(skinStoreId)

			local function func()
				StoreController.instance:openStoreView(StoreEnum.StoreId.VersionPackage, skinStoreId)
				self:closeThis()
			end

			GameFacade.showMessageBox(MessageBoxIdDefine.SkinGoodsJumpTips, MsgBoxEnum.BoxType.Yes_No, func, nil, nil, nil, nil, nil, skinGoodsMo.config.name)
		elseif self._isChargeBuy then
			local skinId

			if self.skinCo then
				skinId = self.skinCo.id
			end

			local goodsId = StoreConfig.instance:getSkinChargeGoodsId(skinId)

			if goodsId then
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
				ViewMgr.instance:openView(ViewName.StoreSkinGoodsView2, {
					index = 1,
					goodsMO = mo
				})
			else
				GameFacade.showToast(ToastEnum.CanNotBuy)
			end
		else
			ViewMgr.instance:openView(ViewName.StoreSkinGoodsView2, {
				index = 2,
				goodsMO = mo
			})
		end
	else
		GameFacade.showToast(ToastEnum.StoreSkinPreview)
	end
end

function StoreSkinPreviewRightView:_btnnotgetOnClick()
	return
end

function StoreSkinPreviewRightView:_setIsChargeBuy(isChargeBuy)
	self._isChargeBuy = isChargeBuy

	self:_refreshPrice()
	self:refreshPayItemSelectedStatus()
end

function StoreSkinPreviewRightView:_refreshPrice()
	gohelper.setActive(self._goCost, not self._isChargeBuy)
	gohelper.setActive(self._goCharge, self._isChargeBuy)

	if self._isChargeBuy then
		local price, _ = self:_setChargePrice()

		gohelper.setActive(self._goCharge, price)
	else
		local str, _ = self:_getCostIconStrAndName()

		if str then
			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageicon, str)
		end
	end
end

function StoreSkinPreviewRightView:_setChargePrice(isPayModeChangeItem)
	local chargeTxtComp, originalTxtComp

	if isPayModeChangeItem then
		chargeTxtComp = self._chargeItem._txtCharge
		originalTxtComp = self._chargeItem._txtOriginalCharge
	else
		chargeTxtComp = self._txtCharge
		originalTxtComp = self._txtOriginalCharge
	end

	local price, originalPrice

	if self.skinCo then
		local skinId = self.skinCo.id
		local isChargePackageValid = StoreModel.instance:isStoreSkinChargePackageValid(skinId)

		if isChargePackageValid then
			price, originalPrice = StoreConfig.instance:getSkinChargePrice(skinId)
		end
	end

	if price then
		local priceStr = string.format("%s%s", StoreModel.instance:getCostStr(price))

		if chargeTxtComp then
			chargeTxtComp.text = priceStr
		end

		if originalTxtComp then
			if originalPrice then
				originalTxtComp.text = originalPrice
			end

			gohelper.setActive(originalTxtComp.gameObject, originalPrice)
		end
	end

	return price, originalPrice
end

function StoreSkinPreviewRightView:refreshPayItemSelectedStatus()
	gohelper.setActive(self._costItem._goselectbg, not self._isChargeBuy)
	SLFramework.UGUI.GuiHelper.SetColor(self._costItem._txtdesc, not self._isChargeBuy and "#FFFFFF" or "#4C4341")
	gohelper.setActive(self._chargeItem._goselectbg, self._isChargeBuy)
	SLFramework.UGUI.GuiHelper.SetColor(self._chargeItem._txtCharge, self._isChargeBuy and "#FFFFFF" or "#4C4341")
	SLFramework.UGUI.GuiHelper.SetColor(self._chargeItem._txtOriginalCharge, self._isChargeBuy and "#FFFFFF80" or "#4C434180")
end

function StoreSkinPreviewRightView:refreshRightContainer()
	self.goSkinNormalContainer = gohelper.findChild(self.viewGO, "container/normal")
	self.goSkinTipContainer = gohelper.findChild(self.viewGO, "container/skinTip")
	self.goSkinStoreContainer = gohelper.findChild(self.viewGO, "container/skinStore")

	gohelper.setActive(self.goSkinNormalContainer, false)
	gohelper.setActive(self.goSkinTipContainer, false)
	gohelper.setActive(self.goSkinStoreContainer, true)
end

function StoreSkinPreviewRightView:_editableInitView()
	self:refreshRightContainer()

	local goDrag = gohelper.findChild(self.viewGO, "drag")

	gohelper.setActive(goDrag, true)

	self._drag = SLFramework.UGUI.UIDragListener.Get(goDrag)

	self._drag:AddDragBeginListener(self._onViewDragBegin, self)
	self._drag:AddDragListener(self._onViewDrag, self)
	self._drag:AddDragEndListener(self._onViewDragEnd, self)
	self._simageshowbg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))

	self.cardImage = gohelper.findChildSingleImage(self._goskinCard, "skinmask/skinicon")
	self._skincontainerCanvasGroup = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer"):GetComponent(typeof(UnityEngine.CanvasGroup))
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._chargeItem = self:_createPayItemUserDataTb(self._goChargeItem, true)
	self._costItem = self:_createPayItemUserDataTb(self._goCostItem, false)
end

function StoreSkinPreviewRightView:_createPayItemUserDataTb(goItem, isChargeBuy)
	local tb = self:getUserDataTb_()

	tb._go = goItem
	tb._gonormalbg = gohelper.findChild(goItem, "go_normalbg")
	tb._goselectbg = gohelper.findChild(goItem, "go_selectbg")

	if isChargeBuy then
		tb._txtCharge = gohelper.findChildText(goItem, "go_chargeDesc/txt_chargeNum")
		tb._txtOriginalCharge = gohelper.findChildText(goItem, "go_chargeDesc/txt_originalChargeNum")
	else
		tb._txtdesc = gohelper.findChildText(goItem, "txt_desc")
		tb._imageicon = gohelper.findChildImage(goItem, "txt_desc/simage_icon")
		tb._godeduction = gohelper.findChild(goItem, "#go_deduction")
		tb._txtdeduction = gohelper.findChildTextMesh(goItem, "#go_deduction/txt_materialNum")
	end

	tb._btnpay = gohelper.findChildButtonWithAudio(goItem, "btn_pay")

	tb._btnpay:AddClickListener(function(obj)
		obj:_setIsChargeBuy(isChargeBuy)
	end, self)

	return tb
end

function StoreSkinPreviewRightView:onUpdateParam()
	self:refreshView()
end

function StoreSkinPreviewRightView:onOpen()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self:refreshView()
end

function StoreSkinPreviewRightView:onOpenFinish()
	return
end

function StoreSkinPreviewRightView:refreshView()
	self.goodsMO = self.viewParam.goodsMO

	local product = self.goodsMO.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]

	self.skinCo = SkinConfig.instance:getSkinCo(skinId)

	self:_refreshSkinList()
	self:refreshUI(self.skinCo)
end

function StoreSkinPreviewRightView:refreshUI(skinCo)
	recthelper.setAnchor(self._goskincontainer.transform, 0, 0)

	self.skinCo = skinCo

	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkin, skinCo, self.viewName)
	StoreController.instance:dispatchEvent(StoreEvent.OnSwitchSpine, self.skinCo.id)
	self.cardImage:LoadImage(ResUrl.getHeadSkinSmall(self.skinCo.id), function()
		ZProj.UGUIHelper.SetImageSize(self.cardImage.gameObject)
	end)
	self:_refreshStatus()

	if self:getDeductionPrice() > 0 then
		self:_setIsChargeBuy(false)
	else
		self:_setIsChargeBuy(DEFAULT_IS_CHARGE_PAY)
	end

	self:_refreshStatus()
end

function StoreSkinPreviewRightView:_onViewDragBegin(param, pointerEventData)
	self._startPos = pointerEventData.position.x

	self._animator:Play(UIAnimationName.SwitchClose, 0, 0)
	self:setShaderKeyWord(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
end

function StoreSkinPreviewRightView:_onViewDrag(param, pointerEventData)
	local curPos = pointerEventData.position.x
	local moveSmooth = 1
	local curSpineRootPosX = recthelper.getAnchorX(self._goskincontainer.transform)

	curSpineRootPosX = curSpineRootPosX + pointerEventData.delta.x * moveSmooth

	recthelper.setAnchorX(self._goskincontainer.transform, curSpineRootPosX)

	local alphaSmooth = 0.007

	self._skincontainerCanvasGroup.alpha = 1 - Mathf.Abs(self._startPos - curPos) * alphaSmooth
end

function StoreSkinPreviewRightView:_onViewDragEnd(param, pointerEventData)
	local endPos = pointerEventData.position.x
	local newSelectSkinIndex

	if endPos > self._startPos and endPos - self._startPos >= 100 then
		newSelectSkinIndex = self._currentSelectSkinIndex - 1

		if newSelectSkinIndex == 0 then
			newSelectSkinIndex = #self._allSkinList
		end
	elseif endPos < self._startPos and self._startPos - endPos >= 100 then
		newSelectSkinIndex = self._currentSelectSkinIndex + 1

		if newSelectSkinIndex > #self._allSkinList then
			newSelectSkinIndex = 1
		end
	end

	self._skincontainerCanvasGroup.alpha = 1

	self._animator:Play(UIAnimationName.SwitchOpen, 0, 0)
	self:setShaderKeyWord(true)
	TaskDispatcher.runDelay(self.disAbleShader, self, 0.33)

	if newSelectSkinIndex then
		self._currentSelectSkinIndex = newSelectSkinIndex

		local goodsMO = self._allSkinList[self._currentSelectSkinIndex]
		local product = goodsMO.config.product
		local productInfo = string.splitToNumber(product, "#")
		local skinId = productInfo[2]
		local skinCo = SkinConfig.instance:getSkinCo(skinId)
		local showDynamicVertical = PlayerModel.instance:getMyUserId() % 2 == 0 and true or false

		if showDynamicVertical then
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, true, self.viewName)
		else
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, self.viewName)
		end

		self:refreshUI(skinCo)
	else
		recthelper.setAnchor(self._goskincontainer.transform, 0, 0)
	end
end

function StoreSkinPreviewRightView:_refreshStatus()
	local goodsMO = self._allSkinList[self._currentSelectSkinIndex]
	local alreadyHas = goodsMO:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(goodsMO)

	gohelper.setActive(self._btnbuy.gameObject, alreadyHas == false)
	gohelper.setActive(self._gohas, alreadyHas)

	if alreadyHas == false then
		local costInfo = string.splitToNumber(goodsMO.config.cost, "#")

		self._costType = costInfo[1]
		self._costId = costInfo[2]
		self._costQuantity = costInfo[3]

		local deductionPrice = self:getDeductionPrice()

		if deductionPrice <= 0 then
			self._txtprice.text = self._costQuantity
		else
			local nowPrice = math.max(self._costQuantity - deductionPrice, 0)

			self._txtprice.text = string.format("%d <color=#22222280><s>%d", nowPrice, self._costQuantity)
		end

		self:refreshPayItem()
	end

	self:refreshSkinTips(goodsMO)
end

function StoreSkinPreviewRightView:getDeductionPrice()
	local deductionPrice = 0

	if not string.nilorempty(self.goodsMO.config.deductionItem) then
		local info = GameUtil.splitString2(self.goodsMO.config.deductionItem, true)
		local itemCount = ItemModel.instance:getItemCount(info[1][2])

		if itemCount > 0 then
			deductionPrice = info[2][1]
		end
	end

	return deductionPrice
end

function StoreSkinPreviewRightView:refreshPayItem()
	local deductionItemCount = 0

	if not string.nilorempty(self.goodsMO.config.deductionItem) then
		local info = GameUtil.splitString2(self.goodsMO.config.deductionItem, true)

		deductionItemCount = ItemModel.instance:getItemCount(info[1][2])
		self._costItem._txtdeduction.text = -info[2][1]
	end

	gohelper.setActive(self._costItem._godeduction, deductionItemCount > 0)

	local str, costName = self:_getCostIconStrAndName()

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._costItem._imageicon, str)

	self._costItem._txtdesc.text = costName

	local price, _ = self:_setChargePrice(true)

	if not price then
		self:_setIsChargeBuy(false)
	end

	gohelper.setActive(self._goChargeItem, price)
	gohelper.setActive(self._goCostItem, price)
end

function StoreSkinPreviewRightView:_getCostIconStrAndName()
	if not self._costType then
		return
	end

	local costIconStr, costName
	local costConfig, _ = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)

	if costConfig then
		costIconStr = string.format("%s_1", costConfig.icon)
		costName = costConfig.name
	end

	return costIconStr, costName
end

function StoreSkinPreviewRightView:_refreshSkinList()
	self._allSkinList = StoreClothesGoodsItemListModel.instance:getList()

	for index, goodsMO in ipairs(self._allSkinList) do
		if self.goodsMO.goodsId == goodsMO.goodsId then
			self._currentSelectSkinIndex = index
		end
	end
end

function StoreSkinPreviewRightView:setShaderKeyWord(enable)
	if enable then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function StoreSkinPreviewRightView:disAbleShader()
	self:setShaderKeyWord(false)
end

function StoreSkinPreviewRightView:refreshSkinTips(goodsMO)
	if StoreModel.instance:isSkinGoodsCanRepeatBuy(goodsMO) then
		gohelper.setActive(self._goSkinTips, true)

		local compensate = string.splitToNumber(self.skinCo.compensate, "#")
		local currencyId = compensate[2]
		local currencyNum = compensate[3]
		local currencyCo = CurrencyConfig.instance:getCurrencyCo(currencyId)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imgProp, string.format("%s_1", currencyCo.icon))

		self._txtPropNum.text = tostring(currencyNum)
	else
		gohelper.setActive(self._goSkinTips, false)
	end
end

function StoreSkinPreviewRightView:onClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	TaskDispatcher.cancelTask(self.disAbleShader, self)
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._drag:RemoveDragListener()
	self._costItem._btnpay:RemoveClickListener()
	self._chargeItem._btnpay:RemoveClickListener()
end

function StoreSkinPreviewRightView:onCloseFinish()
	return
end

function StoreSkinPreviewRightView:onDestroyView()
	self._simageshowbg:UnLoadImage()
	self.cardImage:UnLoadImage()
end

return StoreSkinPreviewRightView
