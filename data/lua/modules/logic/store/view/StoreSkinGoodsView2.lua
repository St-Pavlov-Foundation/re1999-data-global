-- chunkname: @modules/logic/store/view/StoreSkinGoodsView2.lua

module("modules.logic.store.view.StoreSkinGoodsView2", package.seeall)

local StoreSkinGoodsView2 = class("StoreSkinGoodsView2", BaseView)
local spineDefaultPos = {
	45,
	-46,
	0
}
local spineBgSpecialPos = {
	-460,
	0,
	0
}
local spineDefaultScale = 0.85
local defaultSignaturePng = "singlebg/signature/color/img_dressing1.png"

function StoreSkinGoodsView2:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_leftbg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_icon")
	self._simagedreesing = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_dreesing")
	self._txtskinname = gohelper.findChildText(self.viewGO, "view/propinfo/#txt_skinname")
	self._txtdesc = gohelper.findChildText(self.viewGO, "view/propinfo/content/desc/#txt_desc")
	self._txtusedesc = gohelper.findChildText(self.viewGO, "view/propinfo/content/desc/usedesc")
	self._goleftbg = gohelper.findChild(self.viewGO, "view/propinfo/content/remain/#go_leftbg")
	self._txtremainday = gohelper.findChildText(self.viewGO, "view/propinfo/content/remain/#go_leftbg/#txt_remainday")
	self._gorightbg = gohelper.findChild(self.viewGO, "view/propinfo/content/remain/#go_rightbg")
	self._txtremain = gohelper.findChildText(self.viewGO, "view/propinfo/content/remain/#go_rightbg/#txt_remain")
	self._scrollproduct = gohelper.findChildScrollRect(self.viewGO, "view/propinfo/#scroll_product")
	self._goicon = gohelper.findChild(self.viewGO, "view/propinfo/#scroll_product/product/go_goods/#go_icon")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "view/#btn_close")
	self._godeco = gohelper.findChild(self.viewGO, "view/bgroot/deco")
	self._simageGeneralSkinIcon = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_icon")
	self._simageUniqueSkinIcon = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_s+icon")
	self._imageUniqueSkinIcon = gohelper.findChildImage(self.viewGO, "view/bgroot/#simage_s+icon")
	self._goUniqueSkinsImage = gohelper.findChild(self.viewGO, "view/bgroot/#simage_s+icon")
	self._goUniqueSkinsSpineRoot = gohelper.findChild(self.viewGO, "view/bgroot/#simage_s+spineroot")
	self._goUniqueSkinsTitle = gohelper.findChild(self.viewGO, "view/bgroot/#simage_s+decoration")
	self._simageUniqueSkinSpineRoot = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_s+spineroot")
	self._imageUniqueSkinSpineRoot = gohelper.findChildImage(self.viewGO, "view/bgroot/#simage_s+spineroot")
	self._goUniqueSkinsSpineRoot2 = gohelper.findChild(self.viewGO, "view/bgroot/#simage_s+spineroot2")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/#btn_buy")
	self._godiscount = gohelper.findChild(self.viewGO, "view/common/#btn_buy/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "view/common/#btn_buy/#go_discount/#txt_discount")
	self._gocost = gohelper.findChild(self.viewGO, "view/common/cost")
	self._btncost1 = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/cost/#btn_cost1")
	self._gounselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/unselect")
	self._goiconunselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/unselect/icon")
	self._imageiconunselect1 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost1/unselect/icon/simage_icon")
	self._txtcurpriceunselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/unselect/txt_Num")
	self._txtoriginalpriceunselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/unselect/#txt_original_price")
	self._goselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/select")
	self._goiconselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/select/icon")
	self._imageiconselect1 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost1/select/icon/simage_icon")
	self._txtcurpriceselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/select/txt_Num")
	self._txtoriginalpriceselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/select/#txt_original_price")
	self._btncost2 = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/cost/#btn_cost2")
	self._gounselect2 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost2/unselect")
	self._imageiconunselect2 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost2/unselect/icon/simage_icon")
	self._txtcurpriceunselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/unselect/txt_Num")
	self._txtoriginalpriceunselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/unselect/#txt_original_price")
	self._goselect2 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost2/select")
	self._imageiconselect2 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost2/select/icon/simage_icon")
	self._txtcurpriceselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/select/txt_Num")
	self._txtoriginalpriceselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/select/#txt_original_price")
	self._gocostsingle = gohelper.findChild(self.viewGO, "view/common/cost_single")
	self._imageiconsingle = gohelper.findChildImage(self.viewGO, "view/common/cost_single/simage_material")
	self._txtcurpricesingle = gohelper.findChildText(self.viewGO, "view/common/cost_single/#txt_materialNum")
	self._txtoriginalpricesingle = gohelper.findChildText(self.viewGO, "view/common/cost_single/#txt_price")
	self.goDiscount3 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost2/#go_discount3")
	self.txtDiscount3 = gohelper.findChildTextMesh(self.viewGO, "view/common/cost/#btn_cost2/#go_discount3/#txt_cost_price")
	self.goStoreSkinTips = gohelper.findChild(self.viewGO, "view/#go_storeskin")
	self.txtStoreSkinTips = gohelper.findChildTextMesh(self.viewGO, "view/#go_storeskin/tips/#txt_tips")
	self.simageStoreSkinTips = gohelper.findChildSingleImage(self.viewGO, "view/#go_storeskin/#simage_package")
	self.btnSkinTips = gohelper.findChildButtonWithAudio(self.viewGO, "view/#go_storeskin/#simage_package")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinGoodsView2:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncost1:AddClickListener(self._btncost1OnClick, self)
	self._btncost2:AddClickListener(self._btncost2OnClick, self)
	self.btnSkinTips:AddClickListener(self._btnSkinTipsOnClick, self)
	self:addEventCb(PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function StoreSkinGoodsView2:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btncost1:RemoveClickListener()
	self._btncost2:RemoveClickListener()
	self.btnSkinTips:RemoveClickListener()
	self:removeEventCb(PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function StoreSkinGoodsView2:_payFinished()
	self:closeThis()
end

function StoreSkinGoodsView2:setCurCostIndex(index)
	self._curCostIndex = index
end

function StoreSkinGoodsView2:getCurCostIndex()
	return self._curCostIndex or 1
end

function StoreSkinGoodsView2:_btnSkinTipsOnClick()
	if not self._mo then
		return
	end

	local goodConfig = self._mo.config
	local productInfo = string.splitToNumber(goodConfig.product, "#")
	local skinId = productInfo[2]
	local isHasStoreId, goodsId = StoreModel.instance:isSkinHasStoreId(skinId)

	if not isHasStoreId then
		return
	end

	local storeGoodsMo = StoreModel.instance:getGoodsMO(goodsId)

	if not storeGoodsMo then
		return
	end

	StoreController.instance:openPackageStoreGoodsView(storeGoodsMo)
end

function StoreSkinGoodsView2:_btncost1OnClick()
	local curIndex = self:getCurCostIndex()

	if curIndex == 1 then
		return
	end

	self:setCurCostIndex(1)
	self:refreshCost()
end

function StoreSkinGoodsView2:_btncost2OnClick()
	local curIndex = self:getCurCostIndex()

	if curIndex == 2 then
		return
	end

	self:setCurCostIndex(2)
	self:refreshCost()
end

function StoreSkinGoodsView2:_btnbuyOnClick()
	if not self._mo then
		return
	end

	local curIndex = self:getCurCostIndex()
	local product = self._mo.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]
	local skinCo = SkinConfig.instance:getSkinCo(skinId)

	if StoreModel.instance:isSkinCanShowMessageBox(skinId) then
		local skinStoreId = skinCo.skinStoreId
		local skinGoodsMo = StoreModel.instance:getGoodsMO(skinStoreId)

		local function func()
			StoreController.instance:openStoreView(StoreEnum.StoreId.VersionPackage, skinStoreId)
			self:closeThis()
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.SkinGoodsJumpTips, MsgBoxEnum.BoxType.Yes_No, func, nil, nil, nil, nil, nil, skinGoodsMo.config.name)
	elseif curIndex == 1 then
		local goodsId = StoreConfig.instance:getSkinChargeGoodsId(skinId)

		if goodsId then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
			PayController.instance:startPay(goodsId)
		else
			GameFacade.showToast(ToastEnum.CanNotBuy)
		end
	else
		local costInfo = string.splitToNumber(self._mo.config.cost, "#")
		local realCost = costInfo[3]

		if self.deductionInfo then
			local offset = realCost - self.deductionInfo.deductionCount

			if offset < 0 then
				local deductionType = self.deductionInfo.currencyType.type
				local deductionId = self.deductionInfo.currencyType.id
				local deductionConfig = ItemModel.instance:getItemConfig(deductionType, deductionId)
				local costConfig = ItemModel.instance:getItemConfig(costInfo[1], costInfo[2])
				local param1 = deductionConfig.name
				local param2 = self._mo.config.name
				local param3 = math.abs(offset)
				local param4 = costConfig.name

				GameFacade.showMessageBox(MessageBoxIdDefine.SkinStoreDeductionUseTips, MsgBoxEnum.BoxType.Yes_No, self._realbuyGoods, nil, nil, self, nil, nil, param1, param2, param3, param4)

				return
			end

			realCost = math.max(0, offset)
		end

		if CurrencyController.instance:checkDiamondEnough(realCost, self.jumpCallBack, self) then
			self:_buyGoods()
		end
	end
end

function StoreSkinGoodsView2:_realbuyGoods()
	local costInfo = string.splitToNumber(self._mo.config.cost, "#")
	local realCost = costInfo[3]

	if self.deductionInfo then
		local offset = realCost - self.deductionInfo.deductionCount

		realCost = math.max(0, offset)
	end

	if CurrencyController.instance:checkDiamondEnough(realCost, self.jumpCallBack, self) then
		self:_buyGoods()
	end
end

function StoreSkinGoodsView2:_buyGoods()
	StoreController.instance:buyGoods(self._mo, 1, self._buyCallback, self)
end

function StoreSkinGoodsView2:jumpCallBack()
	ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	self:closeThis()
end

function StoreSkinGoodsView2:_btncloseOnClick()
	self:closeThis()
end

function StoreSkinGoodsView2:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._goremain = gohelper.findChild(self.viewGO, "view/propinfo/content/remain")
	self._gonormaltitle = gohelper.findChild(self.viewGO, "view/bgroot/#go_normal_title")
	self._goadvancedtitle = gohelper.findChild(self.viewGO, "view/bgroot/#go_advanced_title")
end

function StoreSkinGoodsView2:onUpdateParam()
	return
end

function StoreSkinGoodsView2:onOpen()
	self:setCurCostIndex(self.viewParam and self.viewParam.index or 1)
	self:_updateSkinStore()

	local heroname = lua_character.configDict[self.skinCo.characterId].name

	self._txtusedesc.text = string.format(CommonConfig.instance:getConstStr(ConstEnum.StoreSkinGood), heroname)

	if self._mo then
		StoreController.instance:statOpenChargeGoods(self._mo.belongStoreId, self._mo.config)
	end
end

function StoreSkinGoodsView2:_updateSkinStore()
	self._mo = self.viewParam.goodsMO

	local product = self._mo.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]

	self.skinCo = SkinConfig.instance:getSkinCo(skinId)

	local skinStoreCfg = self._mo.config
	local costInfo = string.splitToNumber(skinStoreCfg.cost, "#")

	self._costType = costInfo[1]
	self._costId = costInfo[2]
	self._costQuantity = costInfo[3]
	self.deductionInfo = nil

	if not string.nilorempty(self._mo.config.deductionItem) then
		local info = GameUtil.splitString2(self._mo.config.deductionItem, true)
		local itemCount = ItemModel.instance:getItemCount(info[1][2])

		if itemCount > 0 then
			self.deductionInfo = {
				deductionCount = info[2][1],
				currencyType = {
					isCurrencySprite = true,
					type = info[1][1],
					id = info[1][2]
				}
			}
		end
	end

	self:_refreshSkinDesc(skinStoreCfg, self.skinCo)
	self:refreshCost(skinStoreCfg)
	self:_refreshSkinIcon(skinStoreCfg)
	self:refreshStoreSkinTips()
end

function StoreSkinGoodsView2:_refreshSkinDesc(skinGoodCfg, skinCfg)
	self._txtskinname.text = skinCfg.characterSkin
	self._txtdesc.text = skinCfg.skinDescription

	local offlineTime = self._mo:getOfflineTime()

	if offlineTime > 0 then
		local limitSec = math.floor(offlineTime - ServerTime.now())

		gohelper.setActive(self._goremain, true)

		self._txtremainday.text = string.format("%s%s", TimeUtil.secondToRoughTime(limitSec))
	else
		gohelper.setActive(self._goremain, false)
	end
end

function StoreSkinGoodsView2:_refreshSkinIcon(skinStoreCfg)
	local isAdvancedSkin = self._mo.config.isAdvancedSkin or self._mo.config.skinLevel == 1
	local isUniqueSkin = self._mo.config.skinLevel == 2

	gohelper.setActive(self._godeco, not isUniqueSkin)
	gohelper.setActive(self._gonormaltitle, not isAdvancedSkin and not isUniqueSkin)
	gohelper.setActive(self._goadvancedtitle, isAdvancedSkin)
	gohelper.setActive(self._simageGeneralSkinIcon.gameObject, not isUniqueSkin)
	gohelper.setActive(self._goUniqueSkinsImage, isUniqueSkin)
	gohelper.setActive(self._goUniqueSkinsSpineRoot, isUniqueSkin)
	gohelper.setActive(self._goUniqueSkinsSpineRoot2, isUniqueSkin)
	gohelper.setActive(self._goUniqueSkinsTitle, isUniqueSkin)

	local signTexturePath = defaultSignaturePng

	if isUniqueSkin then
		self._simagedreesing:LoadImage(ResUrl.getCharacterSkinIcon("bg_zhuangshi"))

		local resPath = self._mo.config.bigImg
		local spineParams = self._mo.config.spineParams

		if not string.nilorempty(spineParams) then
			local paramsArray = string.split(spineParams, "#")
			local arrayLength = #paramsArray
			local spinePrefabPath = paramsArray[1]
			local spine2PrefabPath = paramsArray[2]
			local pos = string.splitToNumber(paramsArray[3], ",")
			local scale = tonumber(paramsArray[4]) or 1
			local bgPath = paramsArray[6]

			signTexturePath = arrayLength > 6 and paramsArray[7] or signTexturePath

			if not self._skinSpine then
				self._skinSpineGO = gohelper.create2d(self._goUniqueSkinsSpineRoot, "uniqueSkinSpine")

				local spineRootRect = self._skinSpineGO.transform

				transformhelper.setLocalPos(spineRootRect, pos[1], pos[2], 0)

				self._skinSpine = GuiSpine.Create(self._skinSpineGO, false)
			end

			self._skinSpine:setResPath(spinePrefabPath, self._onSpine1Loaded, self, true)

			if not string.nilorempty(spine2PrefabPath) then
				if not self._skinSpine2 then
					self._skinSpineGO2 = gohelper.create2d(self._goUniqueSkinsSpineRoot2, "uniqueSkinSpine2")

					local spine2RootRect = self._skinSpineGO2.transform

					transformhelper.setLocalPos(spine2RootRect, pos[1], pos[2], 0)

					self._skinSpine2 = GuiSpine.Create(self._skinSpineGO2, false)
				end

				self._skinSpine2:setResPath(spine2PrefabPath, self._onSpine2Loaded, self, true)
			end

			if self._skinSpineGO then
				transformhelper.setLocalScale(self._skinSpineGO.transform, scale, scale, scale)
			end

			if self._skinSpineGO2 then
				transformhelper.setLocalScale(self._skinSpineGO2.transform, scale, scale, scale)
			end

			if not string.nilorempty(bgPath) then
				self._simageUniqueSkinIcon:LoadImage(bgPath)
				self._simageUniqueSkinSpineRoot:LoadImage(bgPath)
			end

			gohelper.setActive(self._skinSpineGO, true)
		elseif string.find(resPath, "prefab") then
			gohelper.setActive(self._goUniqueSkinsTitle, false)

			local resPathArray = string.split(resPath, "#")
			local arrayLength = #resPathArray
			local spinePrefabPath = resPathArray[1]
			local bgPath = resPathArray[3]

			signTexturePath = arrayLength > 3 and resPathArray[4] or signTexturePath

			if self._skinSpine then
				self._skinSpine:setResPath(spinePrefabPath, self._onSpineLoaded, self, true)
			else
				self._skinSpineGO = gohelper.create2d(self._goUniqueSkinsSpineRoot, "uniqueSkinSpine")
				self._skinSpine = GuiSpine.Create(self._skinSpineGO, false)

				transformhelper.setLocalPos(self._skinSpineGO.transform, spineDefaultPos[1], spineDefaultPos[2], spineDefaultPos[3])
				self._skinSpine:setResPath(spinePrefabPath, self._onSpineLoaded, self, true)
				transformhelper.setLocalPos(self._goUniqueSkinsSpineRoot.transform, spineBgSpecialPos[1], spineBgSpecialPos[2], 0)
			end

			self._simageUniqueSkinIcon:LoadImage(bgPath, self._loadedSpineBgDone, self)
			transformhelper.setLocalPos(self._simageUniqueSkinIcon.transform, spineBgSpecialPos[1], spineBgSpecialPos[2], spineBgSpecialPos[3])
			self._imageUniqueSkinIcon:SetNativeSize()
			self._imageUniqueSkinSpineRoot:SetNativeSize()
			gohelper.setActive(self._skinSpineGO, true)
		elseif not string.nilorempty(resPath) then
			self._simageUniqueSkinIcon:LoadImage(self._mo.config.bigImg)
		else
			self._simageUniqueSkinIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	elseif string.nilorempty(skinStoreCfg.bigImg) == false then
		self._simageGeneralSkinIcon:LoadImage(skinStoreCfg.bigImg)
	else
		self._simageGeneralSkinIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
	end

	self._simagedreesing:LoadImage(signTexturePath, self._loadedSignImage, self)
end

function StoreSkinGoodsView2:_loadedSignImage()
	gohelper.onceAddComponent(self._simagedreesing.gameObject, gohelper.Type_Image):SetNativeSize()
end

function StoreSkinGoodsView2:_loadedSpineBgDone()
	gohelper.onceAddComponent(self._simageUniqueSkinIcon.gameObject, gohelper.Type_Image):SetNativeSize()
end

function StoreSkinGoodsView2:_onSpine1Loaded()
	local spineTr = self._skinSpine:getSpineTr()

	transformhelper.setLocalScale(spineTr, spineDefaultScale, spineDefaultScale, 1)
end

function StoreSkinGoodsView2:_onSpine2Loaded()
	local spineTr = self._skinSpine2:getSpineTr()

	transformhelper.setLocalScale(spineTr, spineDefaultScale, spineDefaultScale, 1)
end

function StoreSkinGoodsView2:_onSpineLoaded()
	local posX = 0
	local posY = 0
	local scaleX = 0.88
	local scaleY = 0.84
	local spineTr = self._skinSpine:getSpineTr()
	local rootTrans = self._simageUniqueSkinIcon.transform

	recthelper.setAnchor(spineTr, recthelper.getAnchor(rootTrans))
	recthelper.setWidth(spineTr, recthelper.getWidth(rootTrans))
	recthelper.setHeight(spineTr, recthelper.getHeight(rootTrans))
	recthelper.setAnchor(spineTr, posX, posY)
	transformhelper.setLocalScale(spineTr, scaleX, scaleY, 1)
	self:setSpineRaycastTarget(self._raycastTarget)
end

function StoreSkinGoodsView2:setSpineRaycastTarget(raycast)
	self._raycastTarget = raycast == true and true or false

	if self._skinSpine then
		local spineGraphic = self._skinSpine:getSkeletonGraphic()

		if spineGraphic then
			spineGraphic.raycastTarget = self._raycastTarget
		end
	end
end

function StoreSkinGoodsView2:refreshStoreSkinTips()
	local goodConfig = self._mo.config
	local productInfo = string.splitToNumber(goodConfig.product, "#")
	local skinId = productInfo[2]
	local isHasStoreId, goodsId = StoreModel.instance:isSkinHasStoreId(skinId)

	gohelper.setActive(self.goStoreSkinTips, isHasStoreId)

	if not isHasStoreId then
		return
	end

	local storeGoodsMo = StoreModel.instance:getGoodsMO(goodsId)

	if not storeGoodsMo then
		return
	end

	local text = luaLang("storeskingoodsview2_storeskin_txt_tips")

	self.txtStoreSkinTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(text, storeGoodsMo.config.name)

	local path = ResUrl.getStorePackageIcon("detail_" .. storeGoodsMo.config.bigImg)

	self.simageStoreSkinTips:LoadImage(path, function()
		ZProj.UGUIHelper.SetImageSize(self.simageStoreSkinTips.gameObject)
	end)
end

function StoreSkinGoodsView2:refreshCost()
	local showCurrency = {}
	local goodConfig = self._mo.config

	if string.nilorempty(goodConfig.cost) then
		gohelper.setActive(self._gocost, false)

		return
	end

	gohelper.setActive(self._gocost, true)

	local curIndex = self:getCurCostIndex()
	local productInfo = string.splitToNumber(goodConfig.product, "#")
	local skinId = productInfo[2]
	local skinCo = SkinConfig.instance:getSkinCo(skinId)
	local price, originalPrice

	if skinCo then
		local isChargePackageValid = StoreModel.instance:isStoreSkinChargePackageValid(skinId)

		if isChargePackageValid then
			price, originalPrice = StoreConfig.instance:getSkinChargePrice(skinId)
		end
	end

	local costs = string.splitToNumber(goodConfig.cost, "#")
	local costQuantity = costs[3]
	local realCost = costQuantity

	table.insert(showCurrency, costs[2])

	local deductionItemCount = 0
	local hasDeductionItem = false

	if not string.nilorempty(goodConfig.deductionItem) then
		local info = GameUtil.splitString2(goodConfig.deductionItem, true)

		deductionItemCount = ItemModel.instance:getItemCount(info[1][2])
		self.txtDiscount3.text = -info[2][1]

		if deductionItemCount > 0 then
			hasDeductionItem = true

			table.insert(showCurrency, {
				isCurrencySprite = true,
				type = info[1][1],
				id = info[1][2]
			})

			realCost = math.max(0, realCost - info[2][1])
		end
	end

	gohelper.setActive(self.goDiscount3, hasDeductionItem)
	self.viewContainer:setCurrencyType(showCurrency)

	local hasOriginalPrice = goodConfig.originalCost > 0
	local offTag = hasOriginalPrice and costQuantity / goodConfig.originalCost or 0

	offTag = math.ceil(offTag * 100)

	if offTag > 0 and offTag < 100 then
		gohelper.setActive(self._godiscount, true)

		self._txtdiscount.text = string.format("-%d%%", 100 - offTag)
	else
		gohelper.setActive(self._godiscount, false)
	end

	if not price then
		gohelper.setActive(self._gocost, false)
		gohelper.setActive(self._gocostsingle, true)

		local costCo, _ = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconsingle, costCo.icon .. "_1", true)

		local hadQuantity = ItemModel.instance:getItemQuantity(costs[1], costs[2])

		if realCost <= hadQuantity then
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpricesingle, "#393939")
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpricesingle, "#bf2e11")
		end

		self._txtcurpricesingle.text = realCost

		if hasOriginalPrice or hasDeductionItem then
			gohelper.setActive(self._txtoriginalpricesingle.gameObject, true)

			self._txtoriginalpricesingle.text = hasOriginalPrice and goodConfig.originalCost or costQuantity
		else
			gohelper.setActive(self._txtoriginalpricesingle.gameObject, false)
		end

		return
	end

	gohelper.setActive(self._gocost, true)
	gohelper.setActive(self._gocostsingle, false)

	local priceStr = string.format("%s%s", StoreModel.instance:getCostStr(price))

	self._txtcurpriceunselect1.text = priceStr
	self._txtcurpriceselect1.text = priceStr

	SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect1, "#393939")
	SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect1, "#ffffff")

	if originalPrice then
		gohelper.setActive(self._txtoriginalpriceselect1.gameObject, true)
		gohelper.setActive(self._txtoriginalpriceunselect1.gameObject, true)

		self._txtoriginalpriceselect1.text = originalPrice
		self._txtoriginalpriceunselect1.text = originalPrice
	else
		gohelper.setActive(self._txtoriginalpriceselect1.gameObject, false)
		gohelper.setActive(self._txtoriginalpriceunselect1.gameObject, false)
	end

	gohelper.setActive(self._goselect1, curIndex == 1)
	gohelper.setActive(self._gounselect1, curIndex ~= 1)

	local costCo, _ = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

	self._txtcurpriceunselect2.text = realCost
	self._txtcurpriceselect2.text = realCost

	local hadQuantity2 = ItemModel.instance:getItemQuantity(costs[1], costs[2])

	if realCost <= hadQuantity2 then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect2, "#393939")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect2, "#ffffff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect2, "#bf2e11")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect2, "#bf2e11")
	end

	if hasOriginalPrice or hasDeductionItem then
		gohelper.setActive(self._txtoriginalpriceselect2.gameObject, true)
		gohelper.setActive(self._txtoriginalpriceunselect2.gameObject, true)

		self._txtoriginalpriceselect2.text = hasOriginalPrice and goodConfig.originalCost or costQuantity
		self._txtoriginalpriceunselect2.text = hasOriginalPrice and goodConfig.originalCost or costQuantity
	else
		gohelper.setActive(self._txtoriginalpriceselect2.gameObject, false)
		gohelper.setActive(self._txtoriginalpriceunselect2.gameObject, false)
	end

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconselect2, costCo.icon .. "_1", true)
	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconunselect2, costCo.icon .. "_1", true)
	gohelper.setActive(self._goselect2, curIndex == 2)
	gohelper.setActive(self._gounselect2, curIndex ~= 2)
end

function StoreSkinGoodsView2:_buyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
		ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	end
end

function StoreSkinGoodsView2:onClickIcon()
	if not self.skinCo then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, self.skinCo.id, false, nil, false)
end

function StoreSkinGoodsView2:onClose()
	return
end

function StoreSkinGoodsView2:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simagedreesing:UnLoadImage()

	if self._skinSpine then
		self._skinSpine:doClear()

		self._skinSpine = nil
	end

	if self._skinSpine2 then
		self._skinSpine2:doClear()

		self._skinSpine2 = nil
	end

	self.simageStoreSkinTips:UnLoadImage()
end

return StoreSkinGoodsView2
