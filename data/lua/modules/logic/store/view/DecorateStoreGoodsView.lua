module("modules.logic.store.view.DecorateStoreGoodsView", package.seeall)

slot0 = class("DecorateStoreGoodsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_blur")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_leftbg")
	slot0._txtgoodsNameCn = gohelper.findChildText(slot0.viewGO, "view/common/title/#txt_goodsNameCn")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/common/#btn_buy")
	slot0._godiscount = gohelper.findChild(slot0.viewGO, "view/common/#btn_buy/#go_discount")
	slot0._txtdiscount = gohelper.findChildText(slot0.viewGO, "view/common/#btn_buy/#go_discount/#txt_discount")
	slot0._godiscount2 = gohelper.findChild(slot0.viewGO, "view/common/#btn_buy/#go_discount2")
	slot0._txtdiscount2 = gohelper.findChildText(slot0.viewGO, "view/common/#btn_buy/#go_discount2/#txt_discount")
	slot0._gocost = gohelper.findChild(slot0.viewGO, "view/common/cost")
	slot0._btncost1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/common/cost/#btn_cost1")
	slot0._gounselect1 = gohelper.findChild(slot0.viewGO, "view/common/cost/#btn_cost1/unselect")
	slot0._imageiconunselect1 = gohelper.findChildImage(slot0.viewGO, "view/common/cost/#btn_cost1/unselect/icon/simage_icon")
	slot0._txtcurpriceunselect1 = gohelper.findChildText(slot0.viewGO, "view/common/cost/#btn_cost1/unselect/txt_Num")
	slot0._txtoriginalpriceunselect1 = gohelper.findChildText(slot0.viewGO, "view/common/cost/#btn_cost1/unselect/#txt_original_price")
	slot0._goselect1 = gohelper.findChild(slot0.viewGO, "view/common/cost/#btn_cost1/select")
	slot0._imageiconselect1 = gohelper.findChildImage(slot0.viewGO, "view/common/cost/#btn_cost1/select/icon/simage_icon")
	slot0._txtcurpriceselect1 = gohelper.findChildText(slot0.viewGO, "view/common/cost/#btn_cost1/select/txt_Num")
	slot0._txtoriginalpriceselect1 = gohelper.findChildText(slot0.viewGO, "view/common/cost/#btn_cost1/select/#txt_original_price")
	slot0._btncost2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/common/cost/#btn_cost2")
	slot0._gounselect2 = gohelper.findChild(slot0.viewGO, "view/common/cost/#btn_cost2/unselect")
	slot0._imageiconunselect2 = gohelper.findChildImage(slot0.viewGO, "view/common/cost/#btn_cost2/unselect/icon/simage_icon")
	slot0._txtcurpriceunselect2 = gohelper.findChildText(slot0.viewGO, "view/common/cost/#btn_cost2/unselect/txt_Num")
	slot0._txtoriginalpriceunselect2 = gohelper.findChildText(slot0.viewGO, "view/common/cost/#btn_cost2/unselect/#txt_original_price")
	slot0._goselect2 = gohelper.findChild(slot0.viewGO, "view/common/cost/#btn_cost2/select")
	slot0._imageiconselect2 = gohelper.findChildImage(slot0.viewGO, "view/common/cost/#btn_cost2/select/icon/simage_icon")
	slot0._txtcurpriceselect2 = gohelper.findChildText(slot0.viewGO, "view/common/cost/#btn_cost2/select/txt_Num")
	slot0._txtoriginalpriceselect2 = gohelper.findChildText(slot0.viewGO, "view/common/cost/#btn_cost2/select/#txt_original_price")
	slot0._gocostsingle = gohelper.findChild(slot0.viewGO, "view/common/cost_single")
	slot0._imageiconsingle = gohelper.findChildImage(slot0.viewGO, "view/common/cost_single/simage_material")
	slot0._txtcurpricesingle = gohelper.findChildText(slot0.viewGO, "view/common/cost_single/#txt_materialNum")
	slot0._txtoriginalpricesingle = gohelper.findChildText(slot0.viewGO, "view/common/cost_single/#txt_price")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "view/normal")
	slot0._gonormalremain = gohelper.findChild(slot0.viewGO, "view/normal/info/remain")
	slot0._gonormalleftbg = gohelper.findChild(slot0.viewGO, "view/normal/info/remain/#go_leftbg")
	slot0._txtnormalleftremain = gohelper.findChildText(slot0.viewGO, "view/normal/info/remain/#go_leftbg/#txt_remain")
	slot0._gonormalrightbg = gohelper.findChild(slot0.viewGO, "view/normal/info/remain/#go_rightbg")
	slot0._txtnormalrightremain = gohelper.findChildText(slot0.viewGO, "view/normal/info/remain/#go_rightbg/#txt_remaintime")
	slot0._txtgoodsUseDesc = gohelper.findChildText(slot0.viewGO, "view/normal/info/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	slot0._txtgoodsDesc = gohelper.findChildText(slot0.viewGO, "view/normal/info/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	slot0._gonormaldetail = gohelper.findChild(slot0.viewGO, "view/normal_detail")
	slot0._godetailremain = gohelper.findChild(slot0.viewGO, "view/normal_detail/remain")
	slot0._godetailleftbg = gohelper.findChild(slot0.viewGO, "view/normal_detail/remain/#go_leftbg")
	slot0._txtdetailleftremain = gohelper.findChildText(slot0.viewGO, "view/normal_detail/remain/#go_leftbg/#txt_remain")
	slot0._godetailrightbg = gohelper.findChild(slot0.viewGO, "view/normal_detail/remain/#go_rightbg")
	slot0._txtdetailrightremain = gohelper.findChildText(slot0.viewGO, "view/normal_detail/remain/#go_rightbg/#txt_remaintime")
	slot0._gonormaldetailinfo = gohelper.findChild(slot0.viewGO, "view/normal_detail/info")
	slot0._txtnormaldetailUseDesc = gohelper.findChildText(slot0.viewGO, "view/normal_detail/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	slot0._txtnormaldetaildesc = gohelper.findChildText(slot0.viewGO, "view/normal_detail/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/#btn_close")
	slot0._simagetype1 = gohelper.findChildSingleImage(slot0.viewGO, "view/right/type1")
	slot0._simagetype2 = gohelper.findChildSingleImage(slot0.viewGO, "view/right/type2")
	slot0._goType3 = gohelper.findChild(slot0.viewGO, "view/right/type3")
	slot0._simagetype3 = gohelper.findChildSingleImage(slot0.viewGO, "view/right/type3/#simage_icon")
	slot0._gohadnumber = gohelper.findChild(slot0.viewGO, "view/right/type3/#go_hadnumber")
	slot0._txttype3num = gohelper.findChildText(slot0.viewGO, "view/right/type3/#go_hadnumber/#txt_hadnumber")
	slot0._btnicon = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/right/#btn_click")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._btncost1:AddClickListener(slot0._btncost1OnClick, slot0)
	slot0._btncost2:AddClickListener(slot0._btncost2OnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnicon:AddClickListener(slot0._btniconOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy:RemoveClickListener()
	slot0._btncost1:RemoveClickListener()
	slot0._btncost2:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnicon:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btniconOnClick(slot0)
	slot1 = string.splitToNumber(slot0._goodConfig.product, "#")

	MaterialTipController.instance:showMaterialInfo(slot1[1], slot1[2])
end

function slot0._btncost1OnClick(slot0)
	if DecorateStoreModel.instance:getCurCostIndex() == 1 then
		return
	end

	DecorateStoreModel.instance:setCurCostIndex(1)
	slot0:_refreshCost()
end

function slot0._btncost2OnClick(slot0)
	if DecorateStoreModel.instance:getCurCostIndex() == 2 then
		return
	end

	DecorateStoreModel.instance:setCurCostIndex(2)
	slot0:_refreshCost()
end

function slot0._btnbuyOnClick(slot0)
	if string.nilorempty(slot0._mo.config.cost) and string.nilorempty(slot0._mo.config.cost2) then
		slot0:_buyGood()

		return
	end

	if (DecorateStoreModel.instance:getGoodItemLimitTime(slot0._mo.goodsId) > 0 and DecorateStoreModel.instance:getGoodDiscount(slot0._mo.goodsId) or 100) == 0 then
		slot3 = 100
	end

	if DecorateStoreModel.instance:getCurCostIndex() == 1 then
		slot5 = string.splitToNumber(slot0._mo.config.cost, "#")
		slot0._costType = slot5[1]
		slot0._costId = slot5[2]
		slot0._costQuantity = 0.01 * slot3 * slot5[3]
	else
		slot5 = string.splitToNumber(slot0._mo.config.cost2, "#")
		slot0._costType = slot5[1]
		slot0._costId = slot5[2]
		slot0._costQuantity = 0.01 * slot3 * slot5[3]
	end

	if slot0._costType == MaterialEnum.MaterialType.Currency and slot0._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(slot0._costQuantity, CurrencyEnum.PayDiamondExchangeSource.Store, nil, slot0._buyGoods, slot0, slot0.closeThis, slot0) then
			slot0:_buyGood(slot4)
		end
	elseif slot0._costType == MaterialEnum.MaterialType.Currency and slot0._costId == CurrencyEnum.CurrencyType.Diamond then
		if CurrencyController.instance:checkDiamondEnough(slot0._costQuantity, slot0.closeThis, slot0) then
			slot0:_buyGood(slot4)
		end
	elseif slot0._costType == MaterialEnum.MaterialType.Currency and slot0._costId == CurrencyEnum.CurrencyType.OldTravelTicket then
		if CurrencyModel.instance:getCurrency(slot0._costId) then
			if slot0._costQuantity <= slot5.quantity then
				slot0:_buyGood(slot4)
			else
				GameFacade.showToast(ToastEnum.CurrencyNotEnough)

				return false
			end
		end
	elseif ItemModel.instance:goodsIsEnough(slot0._costType, slot0._costId, slot0._costQuantity) then
		slot0:_buyGood(slot4)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.DecorateStoreCurrencyNotEnough, MsgBoxEnum.BoxType.Yes_No, slot0._storeCurrencyNotEnoughCallback, nil, , slot0, nil)
	end
end

function slot0._storeCurrencyNotEnoughCallback(slot0)
	GameFacade.jump(JumpEnum.JumpId.GlowCharge)
end

function slot0._buyGood(slot0, slot1)
	StoreController.instance:buyGoods(slot0._mo, 1, slot0._buyCallback, slot0, slot1)
end

function slot0._buyCallback(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)
	DecorateStoreModel.instance:setCurCostIndex(1)
end

function slot0._refreshUI(slot0)
	slot0._goodConfig = StoreConfig.instance:getGoodsConfig(slot0._mo.goodsId)
	slot0._curItemType = DecorateStoreModel.getItemType(tonumber(slot0._goodConfig.storeId))

	slot0:_refreshIcon()
	slot0:_refreshGoodDetail()
	slot0:_refreshCost()
end

function slot0._refreshIcon(slot0)
	gohelper.setActive(slot0._simagetype1.gameObject, false)
	gohelper.setActive(slot0._simagetype2.gameObject, false)
	gohelper.setActive(slot0._goType3, false)

	if not string.nilorempty(DecorateStoreConfig.instance:getDecorateConfig(slot0._mo.goodsId).buylmg) then
		if slot0._curItemType == DecorateStoreEnum.DecorateItemType.Skin then
			slot0._simagetype2:LoadImage(ResUrl.getDecorateStoreImg(slot1.buylmg))
			gohelper.setActive(slot0._simagetype2.gameObject, true)
		else
			slot0._simagetype1:LoadImage(slot2)
			gohelper.setActive(slot0._simagetype1.gameObject, true)
		end
	else
		slot2 = string.splitToNumber(slot0._goodConfig.product, "#")
		slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot2[1], slot2[2], true)

		gohelper.setActive(slot0._goType3, true)
		gohelper.setActive(slot0._gohadnumber, slot1.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.SoldOut)
		slot0._simagetype3:LoadImage(slot4)

		if slot1.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.SoldOut then
			slot0._txttype3num.text = ItemModel.instance:getItemCount(slot2[2])
		end
	end
end

function slot0._refreshGoodDetail(slot0)
	slot1 = string.splitToNumber(slot0._goodConfig.product, "#")
	slot2 = ItemModel.instance:getItemConfig(slot1[1], slot1[2])
	slot0._txtgoodsNameCn.text = slot0._mo.config.name

	gohelper.setActive(slot0._gonormal, slot0._curItemType == DecorateStoreEnum.DecorateItemType.Skin)
	gohelper.setActive(slot0._gonormaldetail, slot0._curItemType ~= DecorateStoreEnum.DecorateItemType.Skin)

	if slot0._curItemType == DecorateStoreEnum.DecorateItemType.Skin then
		if slot0._mo:getOfflineTime() > 0 then
			gohelper.setActive(slot0._gonormalremain, true)

			slot0._txtnormalrightremain.text = string.format("%s%s", TimeUtil.secondToRoughTime(math.floor(slot3 - ServerTime.now())))
		else
			gohelper.setActive(slot0._gonormalremain, false)
		end

		if slot0._goodConfig.maxBuyCount and slot0._goodConfig.maxBuyCount > 0 then
			gohelper.setActive(slot0._gonormalleftbg, true)

			slot0._txtnormalleftremain.text = GameUtil.getSubPlaceholderLuaLang(luaLang("store_buylimit_count"), {
				slot0._goodConfig.maxBuyCount
			})
		else
			gohelper.setActive(slot0._gonormalleftbg, false)
		end

		slot4 = SkinConfig.instance:getSkinCo(slot1[2])
		slot0._txtgoodsUseDesc.text = string.format(CommonConfig.instance:getConstStr(ConstEnum.StoreSkinGood), lua_character.configDict[slot4.characterId].name)
		slot0._txtgoodsDesc.text = slot4.skinDescription
	else
		if slot0._mo:getOfflineTime() > 0 then
			gohelper.setActive(slot0._godetailrightbg, true)

			slot0._txtdetailrightremain.text = string.format("%s%s", TimeUtil.secondToRoughTime(math.floor(slot3 - ServerTime.now())))
		else
			gohelper.setActive(slot0._godetailrightbg, false)
		end

		if slot0._goodConfig.maxBuyCount and slot0._goodConfig.maxBuyCount > 0 then
			gohelper.setActive(slot0._godetailleftbg, true)

			slot0._txtdetailleftremain.text = GameUtil.getSubPlaceholderLuaLang(luaLang("store_buylimit_count"), {
				slot0._goodConfig.maxBuyCount
			})
		else
			gohelper.setActive(slot0._godetailleftbg, false)
		end

		slot0._txtnormaldetailUseDesc.text = slot2.useDesc
		slot0._txtnormaldetaildesc.text = slot2.desc
	end

	gohelper.setActive(slot0._godetailremain, slot0._godetailleftbg.gameObject.activeSelf and slot0._godetailrightbg.gameObject.activeSelf)
end

function slot0._refreshCost(slot0)
	gohelper.setActive(slot0._btncost1, not string.nilorempty(slot0._goodConfig.cost))
	gohelper.setActive(slot0._btncost2, not string.nilorempty(slot0._goodConfig.cost2))

	if string.nilorempty(slot0._goodConfig.cost) then
		gohelper.setActive(slot0._gocost, false)

		return
	end

	gohelper.setActive(slot0._gocost, true)

	slot1 = DecorateStoreModel.instance:getCurCostIndex()

	if (DecorateStoreConfig.instance:getDecorateConfig(slot0._mo.goodsId).offTag > 0 and slot2.offTag or 100) > 0 and slot3 < 100 then
		gohelper.setActive(slot0._godiscount, true)

		slot0._txtdiscount.text = string.format("-%s%%", slot3)
	else
		gohelper.setActive(slot0._godiscount, false)
	end

	if (DecorateStoreModel.instance:getGoodItemLimitTime(slot0._mo.goodsId) > 0 and DecorateStoreModel.instance:getGoodDiscount(slot0._mo.goodsId) or 100) == 0 then
		slot5 = 100
	end

	if slot5 > 0 and slot5 < 100 then
		gohelper.setActive(slot0._godiscount, false)
		gohelper.setActive(slot0._godiscount2, true)

		slot0._txtdiscount2.text = string.format("-%s%%", slot5)
	else
		gohelper.setActive(slot0._godiscount2, false)
	end

	if (DecorateStoreModel.instance:getGoodItemLimitTime(slot0._mo.goodsId) > 0 and DecorateStoreModel.instance:getGoodDiscount(slot0._mo.goodsId) or 100) == 0 then
		slot8 = 100
	end

	slot9 = string.split(slot0._goodConfig.cost, "#")

	if string.nilorempty(slot0._mo.config.cost2) then
		gohelper.setActive(slot0._gocost, false)
		gohelper.setActive(slot0._gocostsingle, true)

		slot10, slot11 = ItemModel.instance:getItemConfigAndIcon(slot9[1], slot9[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageiconsingle, slot10.icon .. "_1", true)

		slot0._txtcurpricesingle.text = 0.01 * slot8 * slot9[3]

		if slot2.originalCost1 > 0 then
			gohelper.setActive(slot0._txtoriginalpricesingle.gameObject, true)

			slot0._txtoriginalpricesingle.text = slot2.originalCost1
		else
			gohelper.setActive(slot0._txtoriginalpricesingle.gameObject, false)
		end
	else
		gohelper.setActive(slot0._gocost, true)
		gohelper.setActive(slot0._gocostsingle, false)

		slot10, slot11 = ItemModel.instance:getItemConfigAndIcon(slot9[1], slot9[2])
		slot0._txtcurpriceunselect1.text = 0.01 * slot8 * slot9[3]
		slot0._txtcurpriceselect1.text = 0.01 * slot8 * slot9[3]

		if slot2.originalCost1 > 0 then
			gohelper.setActive(slot0._txtoriginalpriceselect1.gameObject, true)
			gohelper.setActive(slot0._txtoriginalpriceunselect1.gameObject, true)

			slot0._txtoriginalpriceselect1.text = slot2.originalCost1
			slot0._txtoriginalpriceunselect1.text = slot2.originalCost1
		else
			gohelper.setActive(slot0._txtoriginalpriceselect1.gameObject, false)
			gohelper.setActive(slot0._txtoriginalpriceunselect1.gameObject, false)
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageiconselect1, slot10.icon .. "_1", true)
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageiconunselect1, slot10.icon .. "_1", true)
		gohelper.setActive(slot0._goselect1, slot1 == 1)
		gohelper.setActive(slot0._gounselect1, slot1 ~= 1)

		if string.nilorempty(slot0._goodConfig.cost2) then
			gohelper.setActive(slot0._txtoriginalpriceselect2.gameObject, false)
			gohelper.setActive(slot0._txtoriginalpriceunselect2.gameObject, false)

			return
		end

		slot12 = string.split(slot0._goodConfig.cost2, "#")
		slot13, slot14 = ItemModel.instance:getItemConfigAndIcon(slot12[1], slot12[2])
		slot0._txtcurpriceunselect2.text = 0.01 * slot8 * slot12[3]
		slot0._txtcurpriceselect2.text = 0.01 * slot8 * slot12[3]

		if slot2.originalCost2 > 0 then
			gohelper.setActive(slot0._txtoriginalpriceselect2.gameObject, true)
			gohelper.setActive(slot0._txtoriginalpriceunselect2.gameObject, true)

			slot0._txtoriginalpriceselect2.text = slot2.originalCost2
			slot0._txtoriginalpriceunselect2.text = slot2.originalCost2
		else
			gohelper.setActive(slot0._txtoriginalpriceselect2.gameObject, false)
			gohelper.setActive(slot0._txtoriginalpriceunselect2.gameObject, false)
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageiconselect2, slot13.icon .. "_1", true)
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageiconunselect2, slot13.icon .. "_1", true)
		gohelper.setActive(slot0._goselect2, slot1 == 2)
		gohelper.setActive(slot0._gounselect2, slot1 ~= 2)
	end
end

function slot0.onOpen(slot0)
	slot0._mo = slot0.viewParam

	slot0:_setCurrency()
	slot0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
end

function slot0._setCurrency(slot0)
	if slot0._mo.config.cost ~= "" then
		table.insert({}, string.splitToNumber(slot0._mo.config.cost, "#")[2])
	end

	if slot0._mo.config.cost2 ~= "" then
		table.insert(slot1, string.splitToNumber(slot0._mo.config.cost2, "#")[2])
	end

	for slot5, slot6 in pairs(slot1) do
		if slot6 == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			table.insert(slot1, CurrencyEnum.CurrencyType.Diamond)
		end
	end

	slot0.viewContainer:setCurrencyType(LuaUtil.getReverseArrTab(slot1))
end

function slot0.onClose(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0._mo = slot0.viewParam

	slot0:_refreshUI()
end

function slot0.onDestroyView(slot0)
	slot0._simagetype1:UnLoadImage()
	slot0._simagetype2:UnLoadImage()
end

return slot0
