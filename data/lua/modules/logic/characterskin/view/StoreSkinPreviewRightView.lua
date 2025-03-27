module("modules.logic.characterskin.view.StoreSkinPreviewRightView", package.seeall)

slot0 = class("StoreSkinPreviewRightView", BaseView)
slot1 = true

function slot0.onInitView(slot0)
	slot0._simageshowbg = gohelper.findChildSingleImage(slot0.viewGO, "container/#simage_skinSwitchBg")
	slot0._goskincontainer = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer")
	slot0._scrollskinSwitch = gohelper.findChildScrollRect(slot0.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	slot0._gopreEmpty = gohelper.findChild(slot0.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	slot0._goskinItem = gohelper.findChild(slot0.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy")
	slot0._gotxtbuy = gohelper.findChild(slot0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy")
	slot0._goCost = gohelper.findChild(slot0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#image_icon")
	slot0._txtprice = gohelper.findChildText(slot0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#txt_price")
	slot0._goCharge = gohelper.findChild(slot0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge")
	slot0._txtCharge = gohelper.findChildText(slot0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge/txt_chargeNum")
	slot0._txtOriginalCharge = gohelper.findChildText(slot0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge/txt_originalChargeNum")
	slot0._goChargeItem = gohelper.findChild(slot0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_pay/#go_chargeItem")
	slot0._goCostItem = gohelper.findChild(slot0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_pay/#go_costItem")
	slot0._gohas = gohelper.findChild(slot0.viewGO, "container/skinStore/skinSwitch/dressState/#go_has")
	slot0._goskinCard = gohelper.findChild(slot0.viewGO, "container/skinStore/skinSwitch/#go_skinCard")
	slot0._goSkinTips = gohelper.findChild(slot0.viewGO, "container/#go_SkinTips")
	slot0._imgProp = gohelper.findChildImage(slot0.viewGO, "container/#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	slot0._txtPropNum = gohelper.findChildTextMesh(slot0.viewGO, "container/#go_SkinTips/image/#txt_Tips/#txt_Num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy:RemoveClickListener()
end

function slot0._btnbuyOnClick(slot0)
	if slot0._allSkinList[slot0._currentSelectSkinIndex] and StoreModel.instance:getGoodsMO(slot1.goodsId) then
		if StoreModel.instance:isSkinCanShowMessageBox(slot0.skinCo and slot0.skinCo.id) then
			GameFacade.showMessageBox(MessageBoxIdDefine.SkinGoodsJumpTips, MsgBoxEnum.BoxType.Yes_No, function ()
				StoreController.instance:openStoreView(StoreEnum.StoreId.VersionPackage, uv0)
				uv1:closeThis()
			end, nil, , , , , StoreModel.instance:getGoodsMO(slot0.skinCo.skinStoreId).config.name)

			return
		end

		if slot0._isChargeBuy then
			slot2 = nil

			if slot0.skinCo then
				slot2 = slot0.skinCo.id
			end

			if StoreConfig.instance:getSkinChargeGoodsId(slot2) then
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
				PayController.instance:startPay(slot3)
			else
				GameFacade.showToast(ToastEnum.CanNotBuy)
			end
		else
			ViewMgr.instance:openView(ViewName.StoreSkinGoodsView, {
				goodsMO = slot1
			})
		end
	else
		GameFacade.showToast(ToastEnum.StoreSkinPreview)
	end
end

function slot0._btnnotgetOnClick(slot0)
end

function slot0._setIsChargeBuy(slot0, slot1)
	slot0._isChargeBuy = slot1

	slot0:_refreshPrice()
	slot0:refreshPayItemSelectedStatus()
end

function slot0._refreshPrice(slot0)
	gohelper.setActive(slot0._goCost, not slot0._isChargeBuy)
	gohelper.setActive(slot0._goCharge, slot0._isChargeBuy)

	if slot0._isChargeBuy then
		slot1, slot2 = slot0:_setChargePrice()

		gohelper.setActive(slot0._goCharge, slot1)
	else
		slot1, slot2 = slot0:_getCostIconStrAndName()

		if slot1 then
			UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageicon, slot1)
		end
	end
end

function slot0._setChargePrice(slot0, slot1)
	slot2, slot3 = nil

	if slot1 then
		slot2 = slot0._chargeItem._txtCharge
		slot3 = slot0._chargeItem._txtOriginalCharge
	else
		slot2 = slot0._txtCharge
		slot3 = slot0._txtOriginalCharge
	end

	slot4, slot5 = nil

	if slot0.skinCo and StoreModel.instance:isStoreSkinChargePackageValid(slot0.skinCo.id) then
		slot4, slot5 = StoreConfig.instance:getSkinChargePrice(slot6)
	end

	if slot4 then
		if slot2 then
			slot2.text = string.format("%s%s", StoreModel.instance:getCostStr(slot4))
		end

		if slot3 then
			if slot5 then
				slot3.text = slot5
			end

			gohelper.setActive(slot3.gameObject, slot5)
		end
	end

	return slot4, slot5
end

function slot0.refreshPayItemSelectedStatus(slot0)
	gohelper.setActive(slot0._costItem._goselectbg, not slot0._isChargeBuy)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._costItem._txtdesc, not slot0._isChargeBuy and "#FFFFFF" or "#4C4341")
	gohelper.setActive(slot0._chargeItem._goselectbg, slot0._isChargeBuy)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._chargeItem._txtCharge, slot0._isChargeBuy and "#FFFFFF" or "#4C4341")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._chargeItem._txtOriginalCharge, slot0._isChargeBuy and "#FFFFFF80" or "#4C434180")
end

function slot0.refreshRightContainer(slot0)
	slot0.goSkinNormalContainer = gohelper.findChild(slot0.viewGO, "container/normal")
	slot0.goSkinTipContainer = gohelper.findChild(slot0.viewGO, "container/skinTip")
	slot0.goSkinStoreContainer = gohelper.findChild(slot0.viewGO, "container/skinStore")

	gohelper.setActive(slot0.goSkinNormalContainer, false)
	gohelper.setActive(slot0.goSkinTipContainer, false)
	gohelper.setActive(slot0.goSkinStoreContainer, true)
end

function slot0._editableInitView(slot0)
	slot0:refreshRightContainer()

	slot1 = gohelper.findChild(slot0.viewGO, "drag")

	gohelper.setActive(slot1, true)

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot1)

	slot0._drag:AddDragBeginListener(slot0._onViewDragBegin, slot0)
	slot0._drag:AddDragListener(slot0._onViewDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onViewDragEnd, slot0)
	slot0._simageshowbg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))

	slot0.cardImage = gohelper.findChildSingleImage(slot0._goskinCard, "skinmask/skinicon")
	slot0._skincontainerCanvasGroup = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer"):GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._chargeItem = slot0:_createPayItemUserDataTb(slot0._goChargeItem, true)
	slot0._costItem = slot0:_createPayItemUserDataTb(slot0._goCostItem, false)
end

function slot0._createPayItemUserDataTb(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3._go = slot1
	slot3._gonormalbg = gohelper.findChild(slot1, "go_normalbg")
	slot3._goselectbg = gohelper.findChild(slot1, "go_selectbg")

	if slot2 then
		slot3._txtCharge = gohelper.findChildText(slot1, "go_chargeDesc/txt_chargeNum")
		slot3._txtOriginalCharge = gohelper.findChildText(slot1, "go_chargeDesc/txt_originalChargeNum")
	else
		slot3._txtdesc = gohelper.findChildText(slot1, "txt_desc")
		slot3._imageicon = gohelper.findChildImage(slot1, "txt_desc/simage_icon")
		slot3._godeduction = gohelper.findChild(slot1, "#go_deduction")
		slot3._txtdeduction = gohelper.findChildTextMesh(slot1, "#go_deduction/txt_materialNum")
	end

	slot3._btnpay = gohelper.findChildButtonWithAudio(slot1, "btn_pay")

	slot3._btnpay:AddClickListener(function (slot0)
		slot0:_setIsChargeBuy(uv0)
	end, slot0)

	return slot3
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshView()
end

function slot0.onOpenFinish(slot0)
end

function slot0.refreshView(slot0)
	slot0.goodsMO = slot0.viewParam.goodsMO
	slot0.skinCo = SkinConfig.instance:getSkinCo(string.splitToNumber(slot0.goodsMO.config.product, "#")[2])

	slot0:_refreshSkinList()
	slot0:refreshUI(slot0.skinCo)
end

function slot0.refreshUI(slot0, slot1)
	recthelper.setAnchor(slot0._goskincontainer.transform, 0, 0)

	slot0.skinCo = slot1

	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkin, slot1, slot0.viewName)
	StoreController.instance:dispatchEvent(StoreEvent.OnSwitchSpine, slot0.skinCo.id)
	slot0.cardImage:LoadImage(ResUrl.getHeadSkinSmall(slot0.skinCo.id))
	slot0:_refreshStatus()

	if slot0:getDeductionPrice() > 0 then
		slot0:_setIsChargeBuy(false)
	else
		slot0:_setIsChargeBuy(uv0)
	end

	slot0:_refreshStatus()
end

function slot0._onViewDragBegin(slot0, slot1, slot2)
	slot0._startPos = slot2.position.x

	slot0._animator:Play(UIAnimationName.SwitchClose, 0, 0)
	slot0:setShaderKeyWord(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
end

function slot0._onViewDrag(slot0, slot1, slot2)
	recthelper.setAnchorX(slot0._goskincontainer.transform, recthelper.getAnchorX(slot0._goskincontainer.transform) + slot2.delta.x * 1)

	slot0._skincontainerCanvasGroup.alpha = 1 - Mathf.Abs(slot0._startPos - slot2.position.x) * 0.007
end

function slot0._onViewDragEnd(slot0, slot1, slot2)
	slot4 = nil

	if slot0._startPos < slot2.position.x and slot3 - slot0._startPos >= 100 then
		if slot0._currentSelectSkinIndex - 1 == 0 then
			slot4 = #slot0._allSkinList
		end
	elseif slot3 < slot0._startPos and slot0._startPos - slot3 >= 100 and slot0._currentSelectSkinIndex + 1 > #slot0._allSkinList then
		slot4 = 1
	end

	slot0._skincontainerCanvasGroup.alpha = 1

	slot0._animator:Play(UIAnimationName.SwitchOpen, 0, 0)
	slot0:setShaderKeyWord(true)
	TaskDispatcher.runDelay(slot0.disAbleShader, slot0, 0.33)

	if slot4 then
		slot0._currentSelectSkinIndex = slot4
		slot9 = SkinConfig.instance:getSkinCo(string.splitToNumber(slot0._allSkinList[slot0._currentSelectSkinIndex].config.product, "#")[2])

		if PlayerModel.instance:getMyUserId() % 2 == 0 and true or false then
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, true, slot0.viewName)
		else
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, slot0.viewName)
		end

		slot0:refreshUI(slot9)
	else
		recthelper.setAnchor(slot0._goskincontainer.transform, 0, 0)
	end
end

function slot0._refreshStatus(slot0)
	slot2 = slot0._allSkinList[slot0._currentSelectSkinIndex]:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(slot1)

	gohelper.setActive(slot0._btnbuy.gameObject, slot2 == false)
	gohelper.setActive(slot0._gohas, slot2)

	if slot2 == false then
		slot3 = string.splitToNumber(slot1.config.cost, "#")
		slot0._costType = slot3[1]
		slot0._costId = slot3[2]
		slot0._costQuantity = slot3[3]

		if slot0:getDeductionPrice() <= 0 then
			slot0._txtprice.text = slot0._costQuantity
		else
			slot0._txtprice.text = string.format("%d <color=#22222280><s>%d", math.max(slot0._costQuantity - slot4, 0), slot0._costQuantity)
		end

		slot0:refreshPayItem()
	end

	slot0:refreshSkinTips(slot1)
end

function slot0.getDeductionPrice(slot0)
	slot1 = 0

	if not string.nilorempty(slot0.goodsMO.config.deductionItem) and ItemModel.instance:getItemCount(GameUtil.splitString2(slot0.goodsMO.config.deductionItem, true)[1][2]) > 0 then
		slot1 = slot2[2][1]
	end

	return slot1
end

function slot0.refreshPayItem(slot0)
	slot1 = 0

	if not string.nilorempty(slot0.goodsMO.config.deductionItem) then
		slot2 = GameUtil.splitString2(slot0.goodsMO.config.deductionItem, true)
		slot1 = ItemModel.instance:getItemCount(slot2[1][2])
		slot0._costItem._txtdeduction.text = -slot2[2][1]
	end

	gohelper.setActive(slot0._costItem._godeduction, slot1 > 0)

	slot2, slot0._costItem._txtdesc.text = slot0:_getCostIconStrAndName()

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._costItem._imageicon, slot2)

	slot4, slot5 = slot0:_setChargePrice(true)

	if not slot4 then
		slot0:_setIsChargeBuy(false)
	end

	gohelper.setActive(slot0._goChargeItem, slot4)
	gohelper.setActive(slot0._goCostItem, slot4)
end

function slot0._getCostIconStrAndName(slot0)
	if not slot0._costType then
		return
	end

	slot1, slot2 = nil
	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot0._costType, slot0._costId)

	if slot3 then
		slot1 = string.format("%s_1", slot3.icon)
		slot2 = slot3.name
	end

	return slot1, slot2
end

function slot0._refreshSkinList(slot0)
	slot0._allSkinList = StoreClothesGoodsItemListModel.instance:getList()

	for slot4, slot5 in ipairs(slot0._allSkinList) do
		if slot0.goodsMO.goodsId == slot5.goodsId then
			slot0._currentSelectSkinIndex = slot4
		end
	end
end

function slot0.setShaderKeyWord(slot0, slot1)
	if slot1 then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function slot0.disAbleShader(slot0)
	slot0:setShaderKeyWord(false)
end

function slot0.refreshSkinTips(slot0, slot1)
	if StoreModel.instance:isSkinGoodsCanRepeatBuy(slot1) then
		gohelper.setActive(slot0._goSkinTips, true)

		slot2 = string.splitToNumber(slot0.skinCo.compensate, "#")

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imgProp, string.format("%s_1", CurrencyConfig.instance:getCurrencyCo(slot2[2]).icon))

		slot0._txtPropNum.text = tostring(slot2[3])
	else
		gohelper.setActive(slot0._goSkinTips, false)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.disAbleShader, slot0)
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._drag:RemoveDragListener()
	slot0._costItem._btnpay:RemoveClickListener()
	slot0._chargeItem._btnpay:RemoveClickListener()
end

function slot0.onCloseFinish(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageshowbg:UnLoadImage()
	slot0.cardImage:UnLoadImage()
end

return slot0
