module("modules.logic.characterskin.view.StoreSkinPreviewRightView", package.seeall)

local var_0_0 = class("StoreSkinPreviewRightView", BaseView)

function var_0_0._onOpenViewFinish(arg_1_0, arg_1_1)
	if arg_1_1 == ViewName.CharacterSkinGainView then
		arg_1_0:closeThis()
	end
end

local var_0_1 = true

function var_0_0.onInitView(arg_2_0)
	arg_2_0._simageshowbg = gohelper.findChildSingleImage(arg_2_0.viewGO, "container/#simage_skinSwitchBg")
	arg_2_0._goskincontainer = gohelper.findChild(arg_2_0.viewGO, "characterSpine/#go_skincontainer")
	arg_2_0._scrollskinSwitch = gohelper.findChildScrollRect(arg_2_0.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch")
	arg_2_0._goContent = gohelper.findChild(arg_2_0.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	arg_2_0._gopreEmpty = gohelper.findChild(arg_2_0.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	arg_2_0._goskinItem = gohelper.findChild(arg_2_0.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	arg_2_0._btnbuy = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy")
	arg_2_0._gotxtbuy = gohelper.findChild(arg_2_0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy")
	arg_2_0._goCost = gohelper.findChild(arg_2_0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price")
	arg_2_0._imageicon = gohelper.findChildImage(arg_2_0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#image_icon")
	arg_2_0._txtprice = gohelper.findChildText(arg_2_0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#txt_price")
	arg_2_0._goCharge = gohelper.findChild(arg_2_0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge")
	arg_2_0._txtCharge = gohelper.findChildText(arg_2_0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge/txt_chargeNum")
	arg_2_0._txtOriginalCharge = gohelper.findChildText(arg_2_0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge/txt_originalChargeNum")
	arg_2_0._goChargeItem = gohelper.findChild(arg_2_0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_pay/#go_chargeItem")
	arg_2_0._goCostItem = gohelper.findChild(arg_2_0.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_pay/#go_costItem")
	arg_2_0._gohas = gohelper.findChild(arg_2_0.viewGO, "container/skinStore/skinSwitch/dressState/#go_has")
	arg_2_0._goskinCard = gohelper.findChild(arg_2_0.viewGO, "container/skinStore/skinSwitch/#go_skinCard")
	arg_2_0._goSkinTips = gohelper.findChild(arg_2_0.viewGO, "container/#go_SkinTips")
	arg_2_0._imgProp = gohelper.findChildImage(arg_2_0.viewGO, "container/#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	arg_2_0._txtPropNum = gohelper.findChildTextMesh(arg_2_0.viewGO, "container/#go_SkinTips/image/#txt_Tips/#txt_Num")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnbuy:AddClickListener(arg_3_0._btnbuyOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnbuy:RemoveClickListener()
end

function var_0_0._btnbuyOnClick(arg_5_0)
	local var_5_0 = arg_5_0._allSkinList[arg_5_0._currentSelectSkinIndex]

	if var_5_0 and StoreModel.instance:getGoodsMO(var_5_0.goodsId) then
		if StoreModel.instance:isSkinCanShowMessageBox(arg_5_0.skinCo and arg_5_0.skinCo.id) then
			local var_5_1 = arg_5_0.skinCo.skinStoreId
			local var_5_2 = StoreModel.instance:getGoodsMO(var_5_1)

			local function var_5_3()
				StoreController.instance:openStoreView(StoreEnum.StoreId.VersionPackage, var_5_1)
				arg_5_0:closeThis()
			end

			GameFacade.showMessageBox(MessageBoxIdDefine.SkinGoodsJumpTips, MsgBoxEnum.BoxType.Yes_No, var_5_3, nil, nil, nil, nil, nil, var_5_2.config.name)
		elseif arg_5_0._isChargeBuy then
			local var_5_4

			if arg_5_0.skinCo then
				var_5_4 = arg_5_0.skinCo.id
			end

			local var_5_5 = StoreConfig.instance:getSkinChargeGoodsId(var_5_4)

			if var_5_5 then
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
				PayController.instance:startPay(var_5_5)
			else
				GameFacade.showToast(ToastEnum.CanNotBuy)
			end
		else
			ViewMgr.instance:openView(ViewName.StoreSkinGoodsView, {
				goodsMO = var_5_0
			})
		end
	else
		GameFacade.showToast(ToastEnum.StoreSkinPreview)
	end
end

function var_0_0._btnnotgetOnClick(arg_7_0)
	return
end

function var_0_0._setIsChargeBuy(arg_8_0, arg_8_1)
	arg_8_0._isChargeBuy = arg_8_1

	arg_8_0:_refreshPrice()
	arg_8_0:refreshPayItemSelectedStatus()
end

function var_0_0._refreshPrice(arg_9_0)
	gohelper.setActive(arg_9_0._goCost, not arg_9_0._isChargeBuy)
	gohelper.setActive(arg_9_0._goCharge, arg_9_0._isChargeBuy)

	if arg_9_0._isChargeBuy then
		local var_9_0, var_9_1 = arg_9_0:_setChargePrice()

		gohelper.setActive(arg_9_0._goCharge, var_9_0)
	else
		local var_9_2, var_9_3 = arg_9_0:_getCostIconStrAndName()

		if var_9_2 then
			UISpriteSetMgr.instance:setCurrencyItemSprite(arg_9_0._imageicon, var_9_2)
		end
	end
end

function var_0_0._setChargePrice(arg_10_0, arg_10_1)
	local var_10_0
	local var_10_1

	if arg_10_1 then
		var_10_0 = arg_10_0._chargeItem._txtCharge
		var_10_1 = arg_10_0._chargeItem._txtOriginalCharge
	else
		var_10_0 = arg_10_0._txtCharge
		var_10_1 = arg_10_0._txtOriginalCharge
	end

	local var_10_2
	local var_10_3

	if arg_10_0.skinCo then
		local var_10_4 = arg_10_0.skinCo.id

		if StoreModel.instance:isStoreSkinChargePackageValid(var_10_4) then
			var_10_2, var_10_3 = StoreConfig.instance:getSkinChargePrice(var_10_4)
		end
	end

	if var_10_2 then
		local var_10_5 = string.format("%s%s", StoreModel.instance:getCostStr(var_10_2))

		if var_10_0 then
			var_10_0.text = var_10_5
		end

		if var_10_1 then
			if var_10_3 then
				var_10_1.text = var_10_3
			end

			gohelper.setActive(var_10_1.gameObject, var_10_3)
		end
	end

	return var_10_2, var_10_3
end

function var_0_0.refreshPayItemSelectedStatus(arg_11_0)
	gohelper.setActive(arg_11_0._costItem._goselectbg, not arg_11_0._isChargeBuy)
	SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._costItem._txtdesc, not arg_11_0._isChargeBuy and "#FFFFFF" or "#4C4341")
	gohelper.setActive(arg_11_0._chargeItem._goselectbg, arg_11_0._isChargeBuy)
	SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._chargeItem._txtCharge, arg_11_0._isChargeBuy and "#FFFFFF" or "#4C4341")
	SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._chargeItem._txtOriginalCharge, arg_11_0._isChargeBuy and "#FFFFFF80" or "#4C434180")
end

function var_0_0.refreshRightContainer(arg_12_0)
	arg_12_0.goSkinNormalContainer = gohelper.findChild(arg_12_0.viewGO, "container/normal")
	arg_12_0.goSkinTipContainer = gohelper.findChild(arg_12_0.viewGO, "container/skinTip")
	arg_12_0.goSkinStoreContainer = gohelper.findChild(arg_12_0.viewGO, "container/skinStore")

	gohelper.setActive(arg_12_0.goSkinNormalContainer, false)
	gohelper.setActive(arg_12_0.goSkinTipContainer, false)
	gohelper.setActive(arg_12_0.goSkinStoreContainer, true)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0:refreshRightContainer()

	local var_13_0 = gohelper.findChild(arg_13_0.viewGO, "drag")

	gohelper.setActive(var_13_0, true)

	arg_13_0._drag = SLFramework.UGUI.UIDragListener.Get(var_13_0)

	arg_13_0._drag:AddDragBeginListener(arg_13_0._onViewDragBegin, arg_13_0)
	arg_13_0._drag:AddDragListener(arg_13_0._onViewDrag, arg_13_0)
	arg_13_0._drag:AddDragEndListener(arg_13_0._onViewDragEnd, arg_13_0)
	arg_13_0._simageshowbg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))

	arg_13_0.cardImage = gohelper.findChildSingleImage(arg_13_0._goskinCard, "skinmask/skinicon")
	arg_13_0._skincontainerCanvasGroup = gohelper.findChild(arg_13_0.viewGO, "characterSpine/#go_skincontainer"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_13_0._animator = arg_13_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_13_0._chargeItem = arg_13_0:_createPayItemUserDataTb(arg_13_0._goChargeItem, true)
	arg_13_0._costItem = arg_13_0:_createPayItemUserDataTb(arg_13_0._goCostItem, false)
end

function var_0_0._createPayItemUserDataTb(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0._go = arg_14_1
	var_14_0._gonormalbg = gohelper.findChild(arg_14_1, "go_normalbg")
	var_14_0._goselectbg = gohelper.findChild(arg_14_1, "go_selectbg")

	if arg_14_2 then
		var_14_0._txtCharge = gohelper.findChildText(arg_14_1, "go_chargeDesc/txt_chargeNum")
		var_14_0._txtOriginalCharge = gohelper.findChildText(arg_14_1, "go_chargeDesc/txt_originalChargeNum")
	else
		var_14_0._txtdesc = gohelper.findChildText(arg_14_1, "txt_desc")
		var_14_0._imageicon = gohelper.findChildImage(arg_14_1, "txt_desc/simage_icon")
		var_14_0._godeduction = gohelper.findChild(arg_14_1, "#go_deduction")
		var_14_0._txtdeduction = gohelper.findChildTextMesh(arg_14_1, "#go_deduction/txt_materialNum")
	end

	var_14_0._btnpay = gohelper.findChildButtonWithAudio(arg_14_1, "btn_pay")

	var_14_0._btnpay:AddClickListener(function(arg_15_0)
		arg_15_0:_setIsChargeBuy(arg_14_2)
	end, arg_14_0)

	return var_14_0
end

function var_0_0.onUpdateParam(arg_16_0)
	arg_16_0:refreshView()
end

function var_0_0.onOpen(arg_17_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_17_0._onOpenViewFinish, arg_17_0)
	arg_17_0:refreshView()
end

function var_0_0.onOpenFinish(arg_18_0)
	return
end

function var_0_0.refreshView(arg_19_0)
	arg_19_0.goodsMO = arg_19_0.viewParam.goodsMO

	local var_19_0 = arg_19_0.goodsMO.config.product
	local var_19_1 = string.splitToNumber(var_19_0, "#")[2]

	arg_19_0.skinCo = SkinConfig.instance:getSkinCo(var_19_1)

	arg_19_0:_refreshSkinList()
	arg_19_0:refreshUI(arg_19_0.skinCo)
end

function var_0_0.refreshUI(arg_20_0, arg_20_1)
	recthelper.setAnchor(arg_20_0._goskincontainer.transform, 0, 0)

	arg_20_0.skinCo = arg_20_1

	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkin, arg_20_1, arg_20_0.viewName)
	StoreController.instance:dispatchEvent(StoreEvent.OnSwitchSpine, arg_20_0.skinCo.id)
	arg_20_0.cardImage:LoadImage(ResUrl.getHeadSkinSmall(arg_20_0.skinCo.id))
	arg_20_0:_refreshStatus()

	if arg_20_0:getDeductionPrice() > 0 then
		arg_20_0:_setIsChargeBuy(false)
	else
		arg_20_0:_setIsChargeBuy(var_0_1)
	end

	arg_20_0:_refreshStatus()
end

function var_0_0._onViewDragBegin(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._startPos = arg_21_2.position.x

	arg_21_0._animator:Play(UIAnimationName.SwitchClose, 0, 0)
	arg_21_0:setShaderKeyWord(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
end

function var_0_0._onViewDrag(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_2.position.x
	local var_22_1 = 1
	local var_22_2 = recthelper.getAnchorX(arg_22_0._goskincontainer.transform) + arg_22_2.delta.x * var_22_1

	recthelper.setAnchorX(arg_22_0._goskincontainer.transform, var_22_2)

	local var_22_3 = 0.007

	arg_22_0._skincontainerCanvasGroup.alpha = 1 - Mathf.Abs(arg_22_0._startPos - var_22_0) * var_22_3
end

function var_0_0._onViewDragEnd(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_2.position.x
	local var_23_1

	if var_23_0 > arg_23_0._startPos and var_23_0 - arg_23_0._startPos >= 100 then
		var_23_1 = arg_23_0._currentSelectSkinIndex - 1

		if var_23_1 == 0 then
			var_23_1 = #arg_23_0._allSkinList
		end
	elseif var_23_0 < arg_23_0._startPos and arg_23_0._startPos - var_23_0 >= 100 then
		var_23_1 = arg_23_0._currentSelectSkinIndex + 1

		if var_23_1 > #arg_23_0._allSkinList then
			var_23_1 = 1
		end
	end

	arg_23_0._skincontainerCanvasGroup.alpha = 1

	arg_23_0._animator:Play(UIAnimationName.SwitchOpen, 0, 0)
	arg_23_0:setShaderKeyWord(true)
	TaskDispatcher.runDelay(arg_23_0.disAbleShader, arg_23_0, 0.33)

	if var_23_1 then
		arg_23_0._currentSelectSkinIndex = var_23_1

		local var_23_2 = arg_23_0._allSkinList[arg_23_0._currentSelectSkinIndex].config.product
		local var_23_3 = string.splitToNumber(var_23_2, "#")[2]
		local var_23_4 = SkinConfig.instance:getSkinCo(var_23_3)

		if PlayerModel.instance:getMyUserId() % 2 == 0 and true or false then
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, true, arg_23_0.viewName)
		else
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, arg_23_0.viewName)
		end

		arg_23_0:refreshUI(var_23_4)
	else
		recthelper.setAnchor(arg_23_0._goskincontainer.transform, 0, 0)
	end
end

function var_0_0._refreshStatus(arg_24_0)
	local var_24_0 = arg_24_0._allSkinList[arg_24_0._currentSelectSkinIndex]
	local var_24_1 = var_24_0:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(var_24_0)

	gohelper.setActive(arg_24_0._btnbuy.gameObject, var_24_1 == false)
	gohelper.setActive(arg_24_0._gohas, var_24_1)

	if var_24_1 == false then
		local var_24_2 = string.splitToNumber(var_24_0.config.cost, "#")

		arg_24_0._costType = var_24_2[1]
		arg_24_0._costId = var_24_2[2]
		arg_24_0._costQuantity = var_24_2[3]

		local var_24_3 = arg_24_0:getDeductionPrice()

		if var_24_3 <= 0 then
			arg_24_0._txtprice.text = arg_24_0._costQuantity
		else
			local var_24_4 = math.max(arg_24_0._costQuantity - var_24_3, 0)

			arg_24_0._txtprice.text = string.format("%d <color=#22222280><s>%d", var_24_4, arg_24_0._costQuantity)
		end

		arg_24_0:refreshPayItem()
	end

	arg_24_0:refreshSkinTips(var_24_0)
end

function var_0_0.getDeductionPrice(arg_25_0)
	local var_25_0 = 0

	if not string.nilorempty(arg_25_0.goodsMO.config.deductionItem) then
		local var_25_1 = GameUtil.splitString2(arg_25_0.goodsMO.config.deductionItem, true)

		if ItemModel.instance:getItemCount(var_25_1[1][2]) > 0 then
			var_25_0 = var_25_1[2][1]
		end
	end

	return var_25_0
end

function var_0_0.refreshPayItem(arg_26_0)
	local var_26_0 = 0

	if not string.nilorempty(arg_26_0.goodsMO.config.deductionItem) then
		local var_26_1 = GameUtil.splitString2(arg_26_0.goodsMO.config.deductionItem, true)

		var_26_0 = ItemModel.instance:getItemCount(var_26_1[1][2])
		arg_26_0._costItem._txtdeduction.text = -var_26_1[2][1]
	end

	gohelper.setActive(arg_26_0._costItem._godeduction, var_26_0 > 0)

	local var_26_2, var_26_3 = arg_26_0:_getCostIconStrAndName()

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_26_0._costItem._imageicon, var_26_2)

	arg_26_0._costItem._txtdesc.text = var_26_3

	local var_26_4, var_26_5 = arg_26_0:_setChargePrice(true)

	if not var_26_4 then
		arg_26_0:_setIsChargeBuy(false)
	end

	gohelper.setActive(arg_26_0._goChargeItem, var_26_4)
	gohelper.setActive(arg_26_0._goCostItem, var_26_4)
end

function var_0_0._getCostIconStrAndName(arg_27_0)
	if not arg_27_0._costType then
		return
	end

	local var_27_0
	local var_27_1
	local var_27_2, var_27_3 = ItemModel.instance:getItemConfigAndIcon(arg_27_0._costType, arg_27_0._costId)

	if var_27_2 then
		var_27_0 = string.format("%s_1", var_27_2.icon)
		var_27_1 = var_27_2.name
	end

	return var_27_0, var_27_1
end

function var_0_0._refreshSkinList(arg_28_0)
	arg_28_0._allSkinList = StoreClothesGoodsItemListModel.instance:getList()

	for iter_28_0, iter_28_1 in ipairs(arg_28_0._allSkinList) do
		if arg_28_0.goodsMO.goodsId == iter_28_1.goodsId then
			arg_28_0._currentSelectSkinIndex = iter_28_0
		end
	end
end

function var_0_0.setShaderKeyWord(arg_29_0, arg_29_1)
	if arg_29_1 then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function var_0_0.disAbleShader(arg_30_0)
	arg_30_0:setShaderKeyWord(false)
end

function var_0_0.refreshSkinTips(arg_31_0, arg_31_1)
	if StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_31_1) then
		gohelper.setActive(arg_31_0._goSkinTips, true)

		local var_31_0 = string.splitToNumber(arg_31_0.skinCo.compensate, "#")
		local var_31_1 = var_31_0[2]
		local var_31_2 = var_31_0[3]
		local var_31_3 = CurrencyConfig.instance:getCurrencyCo(var_31_1)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_31_0._imgProp, string.format("%s_1", var_31_3.icon))

		arg_31_0._txtPropNum.text = tostring(var_31_2)
	else
		gohelper.setActive(arg_31_0._goSkinTips, false)
	end
end

function var_0_0.onClose(arg_32_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_32_0._onOpenViewFinish, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0.disAbleShader, arg_32_0)
	arg_32_0._drag:RemoveDragBeginListener()
	arg_32_0._drag:RemoveDragEndListener()
	arg_32_0._drag:RemoveDragListener()
	arg_32_0._costItem._btnpay:RemoveClickListener()
	arg_32_0._chargeItem._btnpay:RemoveClickListener()
end

function var_0_0.onCloseFinish(arg_33_0)
	return
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._simageshowbg:UnLoadImage()
	arg_34_0.cardImage:UnLoadImage()
end

return var_0_0
