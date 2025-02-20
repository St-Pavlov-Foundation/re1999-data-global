module("modules.logic.battlepass.view.BpChargeView", package.seeall)

slot0 = class("BpChargeView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnBuyNormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/left/#btnBuy")
	slot0._goBuyedNormal = gohelper.findChild(slot0.viewGO, "Root/left/#go_hasBuy")
	slot0._btnBuy2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/right/#btnBuy")
	slot0._txtPayStatus = gohelper.findChildText(slot0.viewGO, "Root/left/#btnBuy/txt")
	slot0._txtPayStatus2 = gohelper.findChildText(slot0.viewGO, "Root/right/#btnBuy/price_layout/txt")
	slot0._txtPayStatus3 = gohelper.findChildText(slot0.viewGO, "Root/right/#btnBuy/price_layout/txt_discount")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "Root/center/#simage_signature")
	slot0._goBuyed2 = gohelper.findChild(slot0.viewGO, "Root/right/#go_hasBuy")
	slot0._goleftitem = gohelper.findChild(slot0.viewGO, "Root/left/#scroll_new/viewport/content/Normal/Items/#go_Items")
	slot0._goleftitemup = gohelper.findChild(slot0.viewGO, "Root/left/#scroll_new/viewport/content/LvUp/#go_Items")
	slot0._gorightitem = gohelper.findChild(slot0.viewGO, "Root/right/#scroll_new/viewport/content/Normal/Items/#go_Items")
	slot0._gorightitemup = gohelper.findChild(slot0.viewGO, "Root/right/#scroll_new/viewport/content/LvUp/#go_Items")
	slot0._btnDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/center/#txt_centerDesc/#btn_faj", AudioEnum.UI.play_artificial_ui_carddisappear)
	slot0._gobtnjapan = gohelper.findChild(slot0.viewGO, "#go_btnjapan")
	slot0._btnJp1 = gohelper.findChildButtonWithAudio(slot0._gobtnjapan, "#btn_btn1")
	slot0._btnJp2 = gohelper.findChildButtonWithAudio(slot0._gobtnjapan, "#btn_btn2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnBuyNormal:AddClickListener(slot0._onClickbuyNormal, slot0)
	slot0._btnBuy2:AddClickListener(slot0._onClickbuy2, slot0)
	slot0._btnDetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0._onUpdatePayStatus, slot0)
	slot0._btnJp1:AddClickListener(slot0._onJpBtn1Click, slot0)
	slot0._btnJp2:AddClickListener(slot0._onJpBtn2Click, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnBuyNormal:RemoveClickListener()
	slot0._btnBuy2:RemoveClickListener()
	slot0._btnDetail:RemoveClickListener()
	slot0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0._onUpdatePayStatus, slot0)
	slot0._btnJp1:RemoveClickListener()
	slot0._btnJp2:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._simagesignature:LoadImage(ResUrl.getSignature(lua_character.configDict[lua_skin.configDict[BpConfig.instance:getCurSkinId(BpModel.instance.id)].characterId].signature))

	if BpConfig.instance:getBpCO(BpModel.instance.id) then
		gohelper.findChildTextMesh(slot0.viewGO, "Root/center/#txt_centerDesc").text = slot4.bpSkinDesc
		gohelper.findChildTextMesh(slot0.viewGO, "Root/center/#txt_centerDesc/#txt_name").text = slot4.bpSkinNametxt
		gohelper.findChildTextMesh(slot0.viewGO, "Root/center/#txt_centerDesc/#txt_name/#txt_nameEn").text = slot4.bpSkinEnNametxt
	end

	gohelper.setActive(slot0._gobtnjapan, SettingsModel.instance:isJpRegion())

	slot5 = BpConfig.instance:getDesConfig(BpModel.instance.id, 1)
	slot7 = BpConfig.instance:getDesConfig(BpModel.instance.id, 3)
	slot8 = (tonumber(PlayerModel.instance:getMyUserId()) or 0) % 2 == 0
	slot0._itemGetTags = {
		slot0:getUserDataTb_(),
		slot0:getUserDataTb_()
	}

	slot0:createItems(slot0._goleftitem, slot5, 1)
	slot0:createItems(slot0._goleftitemup, slot7, nil, slot8)
	slot0:createItems(slot0._gorightitem, slot5, 1)
	slot0:createItems(slot0._gorightitem, BpConfig.instance:getDesConfig(BpModel.instance.id, 2), 2)
	slot0:createItems(slot0._gorightitemup, slot7, nil, slot8)
end

function slot0._btndetailOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function slot0.createItems(slot0, slot1, slot2, slot3, slot4)
	if not slot2 then
		return
	end

	slot8 = false

	gohelper.setActive(slot1, slot8)

	for slot8, slot9 in ipairs(slot2) do
		for slot14, slot15 in ipairs(GameUtil.splitString2(slot9.items, true) or {}) do
			slot16 = gohelper.cloneInPlace(slot1, "item" .. slot14)

			gohelper.setActive(slot16, true)

			slot17 = gohelper.findChild(slot16, "#go_Limit")
			slot19 = gohelper.findChild(slot16, "#goHasGet")
			slot20 = gohelper.findChild(slot16, "#go_new")

			IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot16, "#go_item")):setMOValue(slot15[1], slot15[2], slot15[3], nil, true)

			slot22 = not slot4 and slot15[3] and slot15[3] ~= 0

			slot21:isShowEquipAndItemCount(slot22)

			if slot22 then
				slot21:setCountText(GameUtil.numberDisplay(slot15[3]))
			end

			slot21:setCountFontSize(43)
			gohelper.setActive(slot17, slot15[4] == 1)
			gohelper.setActive(slot20, slot15[5] == 1)

			if slot3 then
				table.insert(slot0._itemGetTags[slot3], slot19)
			end
		end
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagesignature:UnLoadImage()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_pieces_open)
	slot0:_onUpdatePayStatus()
end

function slot0._onClickbuyNormal(slot0)
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId1)
	end
end

function slot0._onClickbuy2(slot0)
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId2)
	else
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId1to2)
	end
end

function slot0._onUpdatePayStatus(slot0)
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		slot2 = StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId2)
		slot0._txtPayStatus.text = string.format("%s", PayModel.instance:getProductPrice(StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId1).id))
		slot0._txtPayStatus2.text = string.format("%s", PayModel.instance:getProductPrice(slot2.id))
		slot0._txtPayStatus3.text = string.format("<s>%s</s>", PayModel.instance:getProductPrice(slot2.originalCostGoodsId))

		gohelper.setActive(slot0._btnBuyNormal.gameObject, true)
		gohelper.setActive(slot0._btnBuy2.gameObject, true)
		gohelper.setActive(slot0._goBuyedNormal, false)
		gohelper.setActive(slot0._goBuyed2, false)
	elseif BpModel.instance.payStatus == BpEnum.PayStatus.Pay1 then
		gohelper.setActive(slot0._btnBuyNormal.gameObject, false)
		gohelper.setActive(slot0._btnBuy2.gameObject, true)
		gohelper.setActive(slot0._goBuyedNormal, true)
		gohelper.setActive(slot0._goBuyed2, false)

		slot0._txtPayStatus2.text = string.format("%s", PayModel.instance:getProductPrice(StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId1to2).id))
		slot0._txtPayStatus3.text = ""
	else
		gohelper.setActive(slot0._btnBuyNormal.gameObject, false)
		gohelper.setActive(slot0._btnBuy2.gameObject, false)
		gohelper.setActive(slot0._goBuyedNormal, true)
		gohelper.setActive(slot0._goBuyed2, true)
	end

	for slot4, slot5 in pairs(slot0._itemGetTags[1]) do
		gohelper.setActive(slot5, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay)
	end

	for slot4, slot5 in pairs(slot0._itemGetTags[2]) do
		gohelper.setActive(slot5, BpModel.instance.payStatus == BpEnum.PayStatus.Pay2)
	end
end

function slot0._onJpBtn1Click(slot0)
	ViewMgr.instance:openView(ViewName.LawDescriptionView, {
		id = 19001
	})
end

function slot0._onJpBtn2Click(slot0)
	ViewMgr.instance:openView(ViewName.LawDescriptionView, {
		id = 19002
	})
end

return slot0
