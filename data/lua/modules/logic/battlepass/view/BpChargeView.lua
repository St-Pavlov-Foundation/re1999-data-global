module("modules.logic.battlepass.view.BpChargeView", package.seeall)

local var_0_0 = class("BpChargeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnBuyNormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/left/#btnBuy")
	arg_1_0._goBuyedNormal = gohelper.findChild(arg_1_0.viewGO, "Root/left/#go_hasBuy")
	arg_1_0._btnBuy2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/right/#btnBuy")
	arg_1_0._txtPayStatus = gohelper.findChildText(arg_1_0.viewGO, "Root/left/#btnBuy/txt")
	arg_1_0._txtPayStatus2 = gohelper.findChildText(arg_1_0.viewGO, "Root/right/#btnBuy/price_layout/txt")
	arg_1_0._txtPayStatus3 = gohelper.findChildText(arg_1_0.viewGO, "Root/right/#btnBuy/price_layout/txt_discount")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/center/#simage_signature")
	arg_1_0._goBuyed2 = gohelper.findChild(arg_1_0.viewGO, "Root/right/#go_hasBuy")
	arg_1_0._goleftitem = gohelper.findChild(arg_1_0.viewGO, "Root/left/#scroll_new/viewport/content/Normal/Items/#go_Items")
	arg_1_0._goleftitemup = gohelper.findChild(arg_1_0.viewGO, "Root/left/#scroll_new/viewport/content/LvUp/#go_Items")
	arg_1_0._gorightitem = gohelper.findChild(arg_1_0.viewGO, "Root/right/#scroll_new/viewport/content/Normal/Items/#go_Items")
	arg_1_0._gorightitemup = gohelper.findChild(arg_1_0.viewGO, "Root/right/#scroll_new/viewport/content/LvUp/#go_Items")
	arg_1_0._btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/center/#txt_centerDesc/#btn_faj", AudioEnum.UI.play_artificial_ui_carddisappear)
	arg_1_0._gobtnjapan = gohelper.findChild(arg_1_0.viewGO, "#go_btnjapan")
	arg_1_0._btnJp1 = gohelper.findChildButtonWithAudio(arg_1_0._gobtnjapan, "#btn_btn1")
	arg_1_0._btnJp2 = gohelper.findChildButtonWithAudio(arg_1_0._gobtnjapan, "#btn_btn2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBuyNormal:AddClickListener(arg_2_0._onClickbuyNormal, arg_2_0)
	arg_2_0._btnBuy2:AddClickListener(arg_2_0._onClickbuy2, arg_2_0)
	arg_2_0._btnDetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_2_0._onUpdatePayStatus, arg_2_0)
	arg_2_0._btnJp1:AddClickListener(arg_2_0._onJpBtn1Click, arg_2_0)
	arg_2_0._btnJp2:AddClickListener(arg_2_0._onJpBtn2Click, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBuyNormal:RemoveClickListener()
	arg_3_0._btnBuy2:RemoveClickListener()
	arg_3_0._btnDetail:RemoveClickListener()
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_3_0._onUpdatePayStatus, arg_3_0)
	arg_3_0._btnJp1:RemoveClickListener()
	arg_3_0._btnJp2:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	local var_4_0 = BpConfig.instance:getCurSkinId(BpModel.instance.id)
	local var_4_1 = lua_skin.configDict[var_4_0].characterId
	local var_4_2 = lua_character.configDict[var_4_1]

	arg_4_0._simagesignature:LoadImage(ResUrl.getSignature(var_4_2.signature))

	local var_4_3 = BpConfig.instance:getBpCO(BpModel.instance.id)

	if var_4_3 then
		local var_4_4 = gohelper.findChildTextMesh(arg_4_0.viewGO, "Root/center/#txt_centerDesc")
		local var_4_5 = gohelper.findChildTextMesh(arg_4_0.viewGO, "Root/center/#txt_centerDesc/#txt_name")
		local var_4_6 = gohelper.findChildTextMesh(arg_4_0.viewGO, "Root/center/#txt_centerDesc/#txt_name/#txt_nameEn")

		var_4_4.text = var_4_3.bpSkinDesc
		var_4_5.text = var_4_3.bpSkinNametxt
		var_4_6.text = var_4_3.bpSkinEnNametxt
	end

	gohelper.setActive(arg_4_0._gobtnjapan, SettingsModel.instance:isJpRegion())

	local var_4_7 = BpConfig.instance:getDesConfig(BpModel.instance.id, 1)
	local var_4_8 = BpConfig.instance:getDesConfig(BpModel.instance.id, 2)
	local var_4_9 = BpConfig.instance:getDesConfig(BpModel.instance.id, 3)
	local var_4_10 = (tonumber(PlayerModel.instance:getMyUserId()) or 0) % 2 == 0

	arg_4_0._itemGetTags = {
		arg_4_0:getUserDataTb_(),
		arg_4_0:getUserDataTb_()
	}

	arg_4_0:createItems(arg_4_0._goleftitem, var_4_7, 1)
	arg_4_0:createItems(arg_4_0._goleftitemup, var_4_9, nil, var_4_10)
	arg_4_0:createItems(arg_4_0._gorightitem, var_4_7, 1)
	arg_4_0:createItems(arg_4_0._gorightitem, var_4_8, 2)
	arg_4_0:createItems(arg_4_0._gorightitemup, var_4_9, nil, var_4_10)
end

function var_0_0._btndetailOnClick(arg_5_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function var_0_0.createItems(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if not arg_6_2 then
		return
	end

	gohelper.setActive(arg_6_1, false)

	for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
		local var_6_0 = GameUtil.splitString2(iter_6_1.items, true) or {}

		for iter_6_2, iter_6_3 in ipairs(var_6_0) do
			local var_6_1 = gohelper.cloneInPlace(arg_6_1, "item" .. iter_6_2)

			gohelper.setActive(var_6_1, true)

			local var_6_2 = gohelper.findChild(var_6_1, "#go_Limit")
			local var_6_3 = gohelper.findChild(var_6_1, "#go_item")
			local var_6_4 = gohelper.findChild(var_6_1, "#goHasGet")
			local var_6_5 = gohelper.findChild(var_6_1, "#go_new")
			local var_6_6 = IconMgr.instance:getCommonPropItemIcon(var_6_3)

			var_6_6:setMOValue(iter_6_3[1], iter_6_3[2], iter_6_3[3], nil, true)

			local var_6_7 = not arg_6_4 and iter_6_3[3] and iter_6_3[3] ~= 0

			if iter_6_3[1] == MaterialEnum.MaterialType.HeroSkin then
				var_6_7 = false
			end

			var_6_6:isShowEquipAndItemCount(var_6_7)

			if var_6_7 then
				var_6_6:setCountText(GameUtil.numberDisplay(iter_6_3[3]))
			end

			var_6_6:setCountFontSize(43)
			gohelper.setActive(var_6_2, iter_6_3[4] == 1)
			gohelper.setActive(var_6_5, iter_6_3[5] == 1)

			if arg_6_3 then
				table.insert(arg_6_0._itemGetTags[arg_6_3], var_6_4)
			end
		end
	end
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagesignature:UnLoadImage()
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_pieces_open)
	arg_8_0:_onUpdatePayStatus()
end

function var_0_0._onClickbuyNormal(arg_9_0)
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId1)
	end
end

function var_0_0._onClickbuy2(arg_10_0)
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId2)
	else
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId1to2)
	end
end

function var_0_0._onUpdatePayStatus(arg_11_0)
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		local var_11_0 = StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId1)
		local var_11_1 = StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId2)
		local var_11_2 = PayModel.instance:getProductPrice(var_11_0.id)
		local var_11_3 = PayModel.instance:getProductPrice(var_11_1.id)

		arg_11_0._txtPayStatus.text = string.format("%s", var_11_2)
		arg_11_0._txtPayStatus2.text = string.format("%s", var_11_3)

		local var_11_4 = PayModel.instance:getProductPrice(var_11_1.originalCostGoodsId)

		arg_11_0._txtPayStatus3.text = string.format("<s>%s</s>", var_11_4)

		gohelper.setActive(arg_11_0._btnBuyNormal.gameObject, true)
		gohelper.setActive(arg_11_0._btnBuy2.gameObject, true)
		gohelper.setActive(arg_11_0._goBuyedNormal, false)
		gohelper.setActive(arg_11_0._goBuyed2, false)
	elseif BpModel.instance.payStatus == BpEnum.PayStatus.Pay1 then
		local var_11_5 = StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId1to2)
		local var_11_6 = PayModel.instance:getProductPrice(var_11_5.id)

		gohelper.setActive(arg_11_0._btnBuyNormal.gameObject, false)
		gohelper.setActive(arg_11_0._btnBuy2.gameObject, true)
		gohelper.setActive(arg_11_0._goBuyedNormal, true)
		gohelper.setActive(arg_11_0._goBuyed2, false)

		arg_11_0._txtPayStatus2.text = string.format("%s", var_11_6)
		arg_11_0._txtPayStatus3.text = ""
	else
		gohelper.setActive(arg_11_0._btnBuyNormal.gameObject, false)
		gohelper.setActive(arg_11_0._btnBuy2.gameObject, false)
		gohelper.setActive(arg_11_0._goBuyedNormal, true)
		gohelper.setActive(arg_11_0._goBuyed2, true)
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0._itemGetTags[1]) do
		gohelper.setActive(iter_11_1, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay)
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0._itemGetTags[2]) do
		gohelper.setActive(iter_11_3, BpModel.instance.payStatus == BpEnum.PayStatus.Pay2)
	end
end

function var_0_0._onJpBtn1Click(arg_12_0)
	ViewMgr.instance:openView(ViewName.LawDescriptionView, {
		id = 19001
	})
end

function var_0_0._onJpBtn2Click(arg_13_0)
	ViewMgr.instance:openView(ViewName.LawDescriptionView, {
		id = 19002
	})
end

return var_0_0
