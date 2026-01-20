-- chunkname: @modules/logic/battlepass/view/BpChargeView.lua

module("modules.logic.battlepass.view.BpChargeView", package.seeall)

local BpChargeView = class("BpChargeView", BaseView)

function BpChargeView:onInitView()
	self._btnBuyNormal = gohelper.findChildButtonWithAudio(self.viewGO, "Root/left/#btnBuy")
	self._goBuyedNormal = gohelper.findChild(self.viewGO, "Root/left/#go_hasBuy")
	self._btnBuy2 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/right/#btnBuy")
	self._txtPayStatus = gohelper.findChildText(self.viewGO, "Root/left/#btnBuy/txt")
	self._txtPayStatus2 = gohelper.findChildText(self.viewGO, "Root/right/#btnBuy/price_layout/txt")
	self._txtPayStatus3 = gohelper.findChildText(self.viewGO, "Root/right/#btnBuy/price_layout/txt_discount")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "Root/center/#simage_signature")
	self._goBuyed2 = gohelper.findChild(self.viewGO, "Root/right/#go_hasBuy")
	self._goleftitem = gohelper.findChild(self.viewGO, "Root/left/#scroll_new/viewport/content/Normal/Items/#go_Items")
	self._goleftitemup = gohelper.findChild(self.viewGO, "Root/left/#scroll_new/viewport/content/LvUp/#go_Items")
	self._gorightitem = gohelper.findChild(self.viewGO, "Root/right/#scroll_new/viewport/content/Normal/Items/#go_Items")
	self._gorightitemup = gohelper.findChild(self.viewGO, "Root/right/#scroll_new/viewport/content/LvUp/#go_Items")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "Root/center/#txt_centerDesc/#btn_faj", AudioEnum.UI.play_artificial_ui_carddisappear)
	self._gobtnjapan = gohelper.findChild(self.viewGO, "#go_btnjapan")
	self._btnJp1 = gohelper.findChildButtonWithAudio(self._gobtnjapan, "#btn_btn1")
	self._btnJp2 = gohelper.findChildButtonWithAudio(self._gobtnjapan, "#btn_btn2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BpChargeView:addEvents()
	self._btnBuyNormal:AddClickListener(self._onClickbuyNormal, self)
	self._btnBuy2:AddClickListener(self._onClickbuy2, self)
	self._btnDetail:AddClickListener(self._btndetailOnClick, self)
	self:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, self._onUpdatePayStatus, self)
	self._btnJp1:AddClickListener(self._onJpBtn1Click, self)
	self._btnJp2:AddClickListener(self._onJpBtn2Click, self)
end

function BpChargeView:removeEvents()
	self._btnBuyNormal:RemoveClickListener()
	self._btnBuy2:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, self._onUpdatePayStatus, self)
	self._btnJp1:RemoveClickListener()
	self._btnJp2:RemoveClickListener()
end

function BpChargeView:_editableInitView()
	local skinId = BpConfig.instance:getCurSkinId(BpModel.instance.id)
	local heroId = lua_skin.configDict[skinId].characterId
	local heroCo = lua_character.configDict[heroId]

	self._simagesignature:LoadImage(ResUrl.getSignature(heroCo.signature))

	local co = BpConfig.instance:getBpCO(BpModel.instance.id)

	if co then
		local skinname = gohelper.findChildTextMesh(self.viewGO, "Root/center/#txt_centerDesc")
		local name = gohelper.findChildTextMesh(self.viewGO, "Root/center/#txt_centerDesc/#txt_name")
		local nameEn = gohelper.findChildTextMesh(self.viewGO, "Root/center/#txt_centerDesc/#txt_name/#txt_nameEn")

		skinname.text = co.bpSkinDesc
		name.text = co.bpSkinNametxt
		nameEn.text = co.bpSkinEnNametxt
	end

	gohelper.setActive(self._gobtnjapan, SettingsModel.instance:isJpRegion())

	local normalCo = BpConfig.instance:getDesConfig(BpModel.instance.id, 1)
	local payCo = BpConfig.instance:getDesConfig(BpModel.instance.id, 2)
	local upLvCo = BpConfig.instance:getDesConfig(BpModel.instance.id, 3)
	local noShowNum = (tonumber(PlayerModel.instance:getMyUserId()) or 0) % 2 == 0

	self._itemGetTags = {
		self:getUserDataTb_(),
		self:getUserDataTb_()
	}

	self:createItems(self._goleftitem, normalCo, 1)
	self:createItems(self._goleftitemup, upLvCo, nil, noShowNum)
	self:createItems(self._gorightitem, normalCo, 1)
	self:createItems(self._gorightitem, payCo, 2)
	self:createItems(self._gorightitemup, upLvCo, nil, noShowNum)
end

function BpChargeView:_btndetailOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function BpChargeView:createItems(go, colist, type, noShowNum)
	if not colist then
		return
	end

	gohelper.setActive(go, false)

	for _, co in ipairs(colist) do
		local dict = GameUtil.splitString2(co.items, true) or {}

		for index, arr in ipairs(dict) do
			local cloneGo = gohelper.cloneInPlace(go, "item" .. index)

			gohelper.setActive(cloneGo, true)

			local limit = gohelper.findChild(cloneGo, "#go_Limit")
			local itemGo = gohelper.findChild(cloneGo, "#go_item")
			local isGet = gohelper.findChild(cloneGo, "#goHasGet")
			local isNew = gohelper.findChild(cloneGo, "#go_new")
			local go_cruise = gohelper.findChild(cloneGo, "#go_cruise")
			local itemIcon = IconMgr.instance:getCommonPropItemIcon(itemGo)

			itemIcon:setMOValue(arr[1], arr[2], arr[3], nil, true)

			local showNum = not noShowNum and arr[3] and arr[3] ~= 0

			if arr[1] == MaterialEnum.MaterialType.HeroSkin then
				showNum = false
			end

			itemIcon:isShowEquipAndItemCount(showNum)

			if showNum then
				itemIcon:setCountText(GameUtil.numberDisplay(arr[3]))
			end

			itemIcon:setCountFontSize(43)
			gohelper.setActive(limit, arr[4] == 1)
			gohelper.setActive(isNew, arr[5] == 1)

			if type then
				table.insert(self._itemGetTags[type], isGet)
			end

			local isSpecialBonus = BpModel.instance:isSpecialBonus(arr[2])

			gohelper.setActive(go_cruise, isSpecialBonus)
			itemIcon:setCanShowDeadLine(not isSpecialBonus)
		end
	end
end

function BpChargeView:onDestroyView()
	self._simagesignature:UnLoadImage()
end

function BpChargeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_pieces_open)
	self:_onUpdatePayStatus()
end

function BpChargeView:_onClickbuyNormal()
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId1)
	end
end

function BpChargeView:_onClickbuy2()
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId2)
	else
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId1to2)
	end
end

function BpChargeView:_onUpdatePayStatus()
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		local shopCo1 = StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId1)
		local shopCo2 = StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId2)
		local price1 = PayModel.instance:getProductPrice(shopCo1.id)
		local price2 = PayModel.instance:getProductPrice(shopCo2.id)

		self._txtPayStatus.text = string.format("%s", price1)
		self._txtPayStatus2.text = string.format("%s", price2)

		local originalPrice3 = PayModel.instance:getProductPrice(shopCo2.originalCostGoodsId)

		self._txtPayStatus3.text = string.format("<s>%s</s>", originalPrice3)

		gohelper.setActive(self._btnBuyNormal.gameObject, true)
		gohelper.setActive(self._btnBuy2.gameObject, true)
		gohelper.setActive(self._goBuyedNormal, false)
		gohelper.setActive(self._goBuyed2, false)
	elseif BpModel.instance.payStatus == BpEnum.PayStatus.Pay1 then
		local shopCo = StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId1to2)
		local price1 = PayModel.instance:getProductPrice(shopCo.id)

		gohelper.setActive(self._btnBuyNormal.gameObject, false)
		gohelper.setActive(self._btnBuy2.gameObject, true)
		gohelper.setActive(self._goBuyedNormal, true)
		gohelper.setActive(self._goBuyed2, false)

		self._txtPayStatus2.text = string.format("%s", price1)
		self._txtPayStatus3.text = ""
	else
		gohelper.setActive(self._btnBuyNormal.gameObject, false)
		gohelper.setActive(self._btnBuy2.gameObject, false)
		gohelper.setActive(self._goBuyedNormal, true)
		gohelper.setActive(self._goBuyed2, true)
	end

	for _, go in pairs(self._itemGetTags[1]) do
		gohelper.setActive(go, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay)
	end

	for _, go in pairs(self._itemGetTags[2]) do
		gohelper.setActive(go, BpModel.instance.payStatus == BpEnum.PayStatus.Pay2)
	end
end

function BpChargeView:_onJpBtn1Click()
	ViewMgr.instance:openView(ViewName.LawDescriptionView, {
		id = 19001
	})
end

function BpChargeView:_onJpBtn2Click()
	ViewMgr.instance:openView(ViewName.LawDescriptionView, {
		id = 19002
	})
end

return BpChargeView
