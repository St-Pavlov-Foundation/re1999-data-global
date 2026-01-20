-- chunkname: @modules/logic/store/view/ClothesStoreView.lua

module("modules.logic.store.view.ClothesStoreView", package.seeall)

local ClothesStoreView = class("ClothesStoreView", BaseView)

function ClothesStoreView:onInitView()
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_has/character/#simage_title")
	self._simagelogo = gohelper.findChildSingleImage(self.viewGO, "#go_has/character/#simage_logo")
	self._gohas = gohelper.findChild(self.viewGO, "#go_has")
	self._goCharacter = gohelper.findChild(self.viewGO, "#go_has/character")
	self._goBgRoot = gohelper.findChild(self.viewGO, "#go_has/character/bg")
	self._goCharacterSpine = gohelper.findChild(self.viewGO, "#go_has/character/bg/characterSpine")
	self._scrollprop = gohelper.findChildScrollRect(self.viewGO, "#go_has/#scroll_skin")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_has/#scroll_skin/viewport/content")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollprop.gameObject)
	self._gosmallspine = gohelper.findChild(self.viewGO, "#go_has/LeftBtn/smalldynamiccontainer/#go_smallspine")
	self.btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/LeftBtn/#btn_hide")
	self.btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/LeftBtn/#btn_play")
	self.btnSwitch = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/LeftBtn/#btn_switch")
	self.txtSwitch = gohelper.findChildTextMesh(self.viewGO, "#go_has/LeftBtn/#btn_switch/#txt_switch")
	self.btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/RightBtn/#btn_detail")
	self.btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/RightBtn/#btn_buy")
	self.goDiscount = gohelper.findChild(self.viewGO, "#go_has/RightBtn/#btn_buy/#go_discount")
	self.txtDiscount = gohelper.findChildTextMesh(self.viewGO, "#go_has/RightBtn/#btn_buy/#go_discount/#txt_discount")
	self.goCost = gohelper.findChild(self.viewGO, "#go_has/RightBtn/#btn_buy/#go_cost")
	self.goCostCurrency1 = gohelper.findChild(self.goCost, "currency1")
	self.txtPrice = gohelper.findChildTextMesh(self.goCost, "currency1/txt_materialNum")
	self.txtOriginalPrice = gohelper.findChildTextMesh(self.goCost, "currency1/#txt_original_price")
	self.imagematerial = gohelper.findChildImage(self.goCost, "currency2/icon/simage_material")
	self.txtMaterialNum = gohelper.findChildTextMesh(self.goCost, "currency2/txt_materialNum")
	self.goHasget = gohelper.findChild(self.viewGO, "#go_has/RightBtn/#go_hasget")
	self.goSkinTips = gohelper.findChild(self.viewGO, "#go_has/RightBtn/go_tips")
	self.txtPropNum = gohelper.findChildTextMesh(self.goSkinTips, "#txt_Tips")
	self.goDeduction = gohelper.findChild(self.viewGO, "#go_has/character/#go_deduction")
	self.txtDeduction = gohelper.findChildTextMesh(self.goDeduction, "#txt_time")
	self.goCostDeduction = gohelper.findChild(self.viewGO, "#go_has/RightBtn/#btn_buy/#go_deduction")
	self.txtCostDeduction = gohelper.findChildTextMesh(self.viewGO, "#go_has/RightBtn/#btn_buy/#go_deduction/txt_materialNum")
	self.goVideo = gohelper.findChild(self.viewGO, "#go_has/character/bg/video")
	self.videoRoot = gohelper.findChild(self.viewGO, "#go_has/character/bg/video/videoRoot")
	self.goArrow = gohelper.findChild(self.viewGO, "#go_has/#scroll_skin/arrow")
	self.btnArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/#scroll_skin/arrow/ani/image")
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewCanvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

	StoreClothesGoodsItemListModel.instance:initViewParam()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ClothesStoreView:addEvents()
	self:addEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, self._isSkinEmpty, self)
	self:addEventCb(PayController.instance, PayEvent.PayFinished, self._payFinished, self)
	self:addEventCb(StoreController.instance, StoreEvent.SkinPreviewChanged, self._onSkinPreviewChanged, self)
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._scrollprop:AddOnValueChanged(self._onDragging, self)
	self:addClickCb(self.btnHide, self._onClickBtnHide, self)
	self:addClickCb(self.btnPlay, self._onClickBtnPlay, self)
	self:addClickCb(self.btnSwitch, self._onClickBtnSwitch, self)
	self:addClickCb(self.btnDetail, self._onClickBtnDetail, self)
	self:addClickCb(self.btnBuy, self._onClickBtnBuy, self)
	self:addClickCb(self.btnArrow, self._onClickBtnArrow, self)
end

function ClothesStoreView:removeEvents()
	self:removeEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, self._isSkinEmpty, self)
	self:removeEventCb(PayController.instance, PayEvent.PayFinished, self._payFinished, self)
	self:removeEventCb(StoreController.instance, StoreEvent.SkinPreviewChanged, self._onSkinPreviewChanged, self)
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._scrollprop:RemoveOnValueChanged()
	self:removeClickCb(self.btnHide)
	self:removeClickCb(self.btnPlay)
	self:removeClickCb(self.btnSwitch)
	self:removeClickCb(self.btnDetail)
	self:removeClickCb(self.btnBuy)
	self:removeClickCb(self.btnArrow)
end

function ClothesStoreView:_editableInitView()
	self._categoryItemContainer = {}

	gohelper.setActive(self._goempty, false)
end

function ClothesStoreView:_isSkinEmpty(state)
	gohelper.setActive(self._goempty, state)
end

function ClothesStoreView:_payFinished()
	self:_refreshGoods(true)
end

function ClothesStoreView:_onSkinPreviewChanged(isDrag)
	StoreController.instance:dispatchEvent(StoreEvent.OnPlaySkinVideo)

	if isDrag then
		self:locationGoodsItem()
	end

	self:refreshSkinPreview()
end

function ClothesStoreView:_onDragBegin(param, pointerEventData)
	StoreController.instance:dispatchEvent(StoreEvent.DragSkinListBegin)
	self:refreshNewArrow()
end

function ClothesStoreView:_onDragging()
	StoreController.instance:dispatchEvent(StoreEvent.DraggingSkinList)
	self:refreshNewArrow()
end

function ClothesStoreView:_onDragEnd(param, pointerEventData)
	StoreController.instance:dispatchEvent(StoreEvent.DragSkinListEnd)
	self:refreshNewArrow()
end

function ClothesStoreView:_onClickBtnArrow()
	StoreClothesGoodsItemListModel.instance:moveToNewGoods()
end

function ClothesStoreView:_onClickBtnHide()
	self:hideUI()

	if self.skinId then
		StatController.instance:track(StatEnum.EventName.ButtonClick, {
			[StatEnum.EventProperties.skinId] = self.skinId,
			[StatEnum.EventProperties.ButtonName] = "_onClickBtnHide",
			[StatEnum.EventProperties.ViewName] = self.viewName
		})
	end
end

function ClothesStoreView:hideUI(noAnim)
	if noAnim then
		StoreController.instance:dispatchEvent(StoreEvent.PlayHideStoreAnim)
		self:_startDefaultShowView()
	else
		self._viewAnim:Play("hide", 0, 0)
		StoreController.instance:dispatchEvent(StoreEvent.PlayHideStoreAnim)
		TaskDispatcher.cancelTask(self._startDefaultShowView, self)
		TaskDispatcher.runDelay(self._startDefaultShowView, self, 0.16)
	end
end

function ClothesStoreView:_onClickBtnPlay()
	self:playVideo()

	if self.skinId then
		StatController.instance:track(StatEnum.EventName.ButtonClick, {
			[StatEnum.EventProperties.skinId] = self.skinId,
			[StatEnum.EventProperties.ButtonName] = "_onClickBtnPlay",
			[StatEnum.EventProperties.ViewName] = self.viewName
		})
	end
end

function ClothesStoreView:playVideo()
	local isFirstOpen = self.isFirstOpen

	if isFirstOpen then
		self.viewCanvasGroup.alpha = 0
	end

	local goodsMo = StoreClothesGoodsItemListModel.instance:getSelectGoods()

	StoreController.instance:dispatchEvent(StoreEvent.OnPlaySkinVideo, goodsMo)
	self:hideUI(isFirstOpen)
end

function ClothesStoreView:_onClickBtnSwitch()
	StoreController.instance:dispatchEvent(StoreEvent.OnPlaySkinVideo)
	StoreClothesGoodsItemListModel.instance:switchIsLive2d()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)
	self._viewAnim:Play("switch", 0, 0)
	self:setShaderKeyWord(true)
	self:refreshSwitchBtn()
	TaskDispatcher.runDelay(self.refreshSkinPreview, self, 0.23)
	TaskDispatcher.runDelay(self.onSwitchAnimDone, self, 0.6)

	if self.skinId then
		local isLive2d = StoreClothesGoodsItemListModel.instance:getIsLive2d()

		StatController.instance:track(StatEnum.EventName.ButtonClick, {
			[StatEnum.EventProperties.skinId] = self.skinId,
			[StatEnum.EventProperties.ButtonName] = string.format("_onClickBtnSwitch_%s", tostring(isLive2d)),
			[StatEnum.EventProperties.ViewName] = self.viewName
		})
	end
end

function ClothesStoreView:_onClickBtnDetail()
	local mo = StoreClothesGoodsItemListModel.instance:getSelectGoods()

	if not mo then
		return
	end

	ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
		goodsMO = mo
	})

	if self.skinId then
		StatController.instance:track(StatEnum.EventName.ButtonClick, {
			[StatEnum.EventProperties.skinId] = self.skinId,
			[StatEnum.EventProperties.ButtonName] = "_onClickBtnDetail",
			[StatEnum.EventProperties.ViewName] = self.viewName
		})
	end
end

function ClothesStoreView:_onClickBtnBuy()
	local mo = StoreClothesGoodsItemListModel.instance:getSelectGoods()

	if not mo then
		return
	end

	ViewMgr.instance:openView(ViewName.StoreSkinGoodsView2, {
		goodsMO = mo
	})
end

function ClothesStoreView:_startDefaultShowView()
	local data = {}

	data.contentBg = self._goBgRoot
	data.callback = self._showHideCallback
	data.callbackObj = self

	ViewMgr.instance:openView(ViewName.StoreSkinDefaultShowView, data)
end

function ClothesStoreView:_showHideCallback()
	self._viewAnim:Play("show", 0, 0)
	self._goBgRoot.transform:SetParent(self._goCharacter.transform, false)
	gohelper.setAsFirstSibling(self._goBgRoot)
	StoreController.instance:dispatchEvent(StoreEvent.PlayShowStoreAnim)
end

function ClothesStoreView:_refreshTabs(selectTabId, openUpdate)
	local preSelectSecondTabId = self._selectSecondTabId
	local preSelectThirdTabId = self._selectThirdTabId

	self._selectSecondTabId = 0
	self._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(selectTabId) then
		selectTabId = self.viewContainer:getSelectFirstTabId()
	end

	local _

	_, self._selectSecondTabId, self._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(selectTabId)

	local thirdConfig = StoreConfig.instance:getTabConfig(self._selectThirdTabId)
	local secondConfig = StoreConfig.instance:getTabConfig(self._selectSecondTabId)
	local firstConfig = StoreConfig.instance:getTabConfig(self.viewContainer:getSelectFirstTabId())
	local showCurrency = {}

	if thirdConfig and not string.nilorempty(thirdConfig.showCost) then
		showCurrency = string.splitToNumber(thirdConfig.showCost, "#")
	elseif secondConfig and not string.nilorempty(secondConfig.showCost) then
		showCurrency = string.splitToNumber(secondConfig.showCost, "#")
	elseif firstConfig and not string.nilorempty(firstConfig.showCost) then
		showCurrency = string.splitToNumber(firstConfig.showCost, "#")
	end

	local skinTickets = ItemModel.instance:getItemsBySubType(ItemEnum.SubType.SkinTicket)

	if skinTickets[1] then
		table.insert(showCurrency, {
			isCurrencySprite = true,
			type = MaterialEnum.MaterialType.Item,
			id = skinTickets[1].id
		})

		local deadlineTimeHour = 0
		local itemCo = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, skinTickets[1].id)

		if itemCo and not string.nilorempty(itemCo.expireTime) then
			local ts = TimeUtil.stringToTimestamp(itemCo.expireTime)
			local offsetSecond = math.floor(ts - ServerTime.now())

			if offsetSecond >= 0 and offsetSecond <= 259200 then
				deadlineTimeHour = math.floor(offsetSecond / 60 / 60)
				deadlineTimeHour = math.max(deadlineTimeHour, 1)
			end
		end

		if deadlineTimeHour > 0 then
			gohelper.setActive(self.goDeduction, true)

			self.txtDeduction.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_deduction_item_deadtime"), tostring(deadlineTimeHour))
		else
			gohelper.setActive(self.goDeduction, false)
		end
	else
		gohelper.setActive(self.goDeduction, false)
	end

	self.viewContainer:setCurrencyByParams(showCurrency)

	if not openUpdate and preSelectSecondTabId == self._selectSecondTabId and preSelectThirdTabId == self._selectThirdTabId then
		return
	end

	self:_onRefreshRedDot()
	self:_updateInfo()
end

function ClothesStoreView:_refreshGoods(update)
	if update then
		local thirdConfig = StoreConfig.instance:getTabConfig(self._selectThirdTabId)

		self.storeId = thirdConfig and thirdConfig.storeId or 0

		if self.storeId == 0 then
			local secondConfig = StoreConfig.instance:getTabConfig(self._selectSecondTabId)

			self.storeId = secondConfig and secondConfig.storeId or 0
		end

		StoreRpc.instance:sendGetStoreInfosRequest({
			self.storeId
		})
		ChargeRpc.instance:sendGetChargeInfoRequest()
	end
end

function ClothesStoreView:_onRefreshRedDot()
	for _, v in pairs(self._categoryItemContainer) do
		gohelper.setActive(v.go_reddot, StoreModel.instance:isTabFirstRedDotShow(v.tabId))
		gohelper.setActive(v.go_unselectreddot, StoreModel.instance:isTabFirstRedDotShow(v.tabId))

		for _, child in pairs(v.childItemContainer) do
			gohelper.setActive(child.go_subreddot1, StoreModel.instance:isTabSecondRedDotShow(child.tabId))
			gohelper.setActive(child.go_subreddot2, StoreModel.instance:isTabSecondRedDotShow(child.tabId))
		end
	end
end

function ClothesStoreView:onOpen()
	self.isFirstOpen = true

	self._viewAnim:Play("open", 0, 0)

	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()
	local jumpGoodsId = self.viewContainer:getJumpGoodsId()
	local isFocus = self.viewContainer:isJumpFocus()

	self:_refreshTabs(jumpTabId, true)
	self:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, self._onStoreInfoChanged, self)
	self:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshRedDot, self)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self._updateItemList, self)

	if jumpGoodsId then
		if not isFocus then
			ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
				goodsMO = StoreModel.instance:getGoodsMO(tonumber(jumpGoodsId))
			})
		end

		self:locationGoodsItemByGoodsId(jumpGoodsId)

		local goodIndex = StoreClothesGoodsItemListModel.instance:getGoodIndex(jumpGoodsId)

		StoreClothesGoodsItemListModel.instance:setSelectIndex(goodIndex)
	end
end

function ClothesStoreView:locationGoodsItem(goodsMo)
	goodsMo = goodsMo or StoreClothesGoodsItemListModel.instance:getSelectGoods()

	self:locationGoodsItemByGoodsId(goodsMo.goodsId)
end

function ClothesStoreView:locationGoodsItemByGoodsId(goodsId)
	if not goodsId then
		return
	end

	local goodIndex = StoreClothesGoodsItemListModel.instance:getGoodIndex(goodsId)

	if not goodIndex then
		return
	end

	local transform = self._gocontent.transform
	local posX = transformhelper.getLocalPos(transform)
	local param = self.viewContainer._ScrollViewSkinStore._param
	local index = math.ceil(goodIndex / 2)
	local posY = (param.cellHeight + param.cellSpaceV) * (index - 1) + param.startSpace
	local contentHeight = recthelper.getHeight(transform)
	local scrollHeight = recthelper.getHeight(self._scrollprop.transform)
	local heightOffset = contentHeight - scrollHeight
	local moveLimt = math.max(0, heightOffset)

	posY = math.min(moveLimt, posY)

	recthelper.setAnchorY(transform, posY)
end

function ClothesStoreView:_updateItemList()
	local jumpTabId = self.viewContainer:getJumpTabId()

	self:_refreshTabs(jumpTabId, true)
end

function ClothesStoreView:_onStoreInfoChanged()
	self._canPlayVideoLockTime = Time.time + 0.1

	self:_updateInfo()
end

function ClothesStoreView:_isCheckCanPlayVideo()
	if self._canPlayVideoLockTime and self._canPlayVideoLockTime > Time.time then
		return false
	end

	return true
end

function ClothesStoreView:_updateInfo()
	local count = StoreClothesGoodsItemListModel.instance:getCount()
	local isEmpty = count == 0

	gohelper.setActive(self._goempty, isEmpty)
	gohelper.setActive(self._gohas, not isEmpty)

	if isEmpty then
		return
	end

	local height = 870

	if count <= 2 then
		height = 408
	end

	recthelper.setHeight(self._scrollprop.transform, height)
	self:refreshSwitchBtn()
	self:refreshSkinPreview()
end

function ClothesStoreView:onClose()
	self:removeEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, self._isSkinEmpty, self)
	self:removeEventCb(PayController.instance, PayEvent.PayFinished, self._payFinished, self)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self._updateItemList, self)
	self:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, self._onStoreInfoChanged, self)
	self:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshRedDot, self)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self._updateItemList, self)
end

function ClothesStoreView:onUpdateParam()
	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()
	local jumpGoodsId = self.viewContainer:getJumpGoodsId()

	self:_refreshTabs(jumpTabId)

	if jumpGoodsId then
		ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
			goodsMO = StoreModel.instance:getGoodsMO(tonumber(jumpGoodsId))
		})
	end
end

function ClothesStoreView:refreshSwitchBtn()
	local isLive2d = StoreClothesGoodsItemListModel.instance:getIsLive2d()

	self.txtSwitch.text = isLive2d and luaLang("storeskinpreviewview_btnswitch") or "L2D"
end

function ClothesStoreView:refreshSkinPreview()
	local goodsMo = StoreClothesGoodsItemListModel.instance:getSelectGoods()

	if not goodsMo then
		return
	end

	local config = goodsMo.config
	local product = config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]
	local skinCo = SkinConfig.instance:getSkinCo(skinId)

	self.skinId = skinId
	self._goodsMo = goodsMo

	local skinId = CommonConfig.instance:getConstNum(ConstEnum.BPSkinFaceViewSkinId)

	if VersionValidator.instance:isInReviewing() == false and self.skinId == skinId and BpController.instance:isEmptySkinFaceViewStr(skinId) and self:_isCheckCanPlayVideo() then
		ViewMgr.instance:openView(ViewName.BPSkinFaceView_Store, {
			skinId = self.skinId,
			openType = BPSkinFaceView.OPEN_TYPE.StoreSkin,
			closeCallback = self._onRefreshSkinPreview,
			cbObj = self
		})
	else
		self:_onRefreshSkinPreview()
	end
end

function ClothesStoreView:_onRefreshSkinPreview()
	if not self.previewComp then
		self.previewComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goCharacter, ClothesStorePreviewSkinComp)

		self.previewComp:setSmallSpineGO(self._gosmallspine)
	end

	self.previewComp:setGoods(self._goodsMo)
	self:refreshSkinInfo()

	if self._goodsMo and self.skinId ~= self._lastSwitchinSkinId then
		self._lastSwitchinSkinId = self.skinId

		self._viewAnim:Play("switchin", 0, 0)
	end

	self:refreshNewArrow()
end

function ClothesStoreView:refreshSkinInfo()
	if not self._goodsMo then
		return
	end

	local goodsMo = self._goodsMo
	local config = goodsMo.config
	local product = config.product
	local skinId = self.skinId
	local skinCo = SkinConfig.instance:getSkinCo(skinId)

	if string.nilorempty(skinCo.subTitle) then
		gohelper.setActive(self._simagetitle.gameObject, false)
	else
		self._simagetitle:LoadImage(skinCo.subTitle, function()
			ZProj.UGUIHelper.SetImageSize(self._simagetitle.gameObject)
		end)
		gohelper.setActive(self._simagetitle.gameObject, true)
	end

	if string.nilorempty(config.logoRoots) then
		gohelper.setActive(self._simagelogo.gameObject, false)
	else
		self._simagelogo:LoadImage(config.logoRoots, function()
			ZProj.UGUIHelper.SetImageSize(self._simagelogo.gameObject)
		end)
		gohelper.setActive(self._simagelogo.gameObject, true)
	end

	local costInfo = string.splitToNumber(config.cost, "#")
	local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(costInfo[1], costInfo[2])
	local id = costConfig.icon
	local str = string.format("%s_1", id)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self.imagematerial, str, true)

	self.txtMaterialNum.text = costInfo[3]

	gohelper.setActive(self.goDiscount, config.originalCost > 0)

	local offTag = costInfo[3] / config.originalCost

	offTag = math.ceil(offTag * 100)
	self.txtDiscount.text = string.format("-%d%%", 100 - offTag)

	self:refreshChargeInfo(goodsMo, skinCo)

	local skinViewCfg = lua_character_limited.configDict[skinId]
	local isNotInReviewing = not VersionValidator.instance:isInReviewing()
	local hasVideo = skinViewCfg and not string.nilorempty(skinViewCfg.entranceMv)
	local isShowVideoBtn = isNotInReviewing and hasVideo

	gohelper.setActive(self.btnPlay, isShowVideoBtn)

	if self._adjust or not self:_isCheckCanPlayVideo() then
		return
	end

	if isShowVideoBtn and self:checkSkinVideoNotPlayed(skinId) then
		self:setSkinVideoPlayed(skinId)
		self:playVideo()
	elseif self:checkSkinVideoNotPlayed(0) then
		self:setSkinVideoPlayed(0)
		self:hideUI()
	end

	self.isFirstOpen = false
end

function ClothesStoreView:refreshChargeInfo(goodsMo, skinCo)
	local skinId = skinCo.id
	local price, originalPrice

	if skinCo then
		local isChargePackageValid = StoreModel.instance:isStoreSkinChargePackageValid(skinId)

		if isChargePackageValid then
			price, originalPrice = StoreConfig.instance:getSkinChargePrice(skinId)
		end
	end

	gohelper.setActive(self.goCostCurrency1, price ~= nil)

	if price then
		local priceStr = string.format("%s%s", StoreModel.instance:getCostStr(price))

		self.txtPrice.text = priceStr

		if originalPrice then
			self.txtOriginalPrice.text = originalPrice

			local skinChargeGoodsCfg = StoreConfig.instance:getSkinChargeGoodsCfg(skinId)

			if skinChargeGoodsCfg then
				local num, numStr = PayModel.instance:getProductOriginPriceNum(skinChargeGoodsCfg.originalCostGoodsId)

				self.txtOriginalPrice.text = numStr
			end
		end

		gohelper.setActive(self.txtOriginalPrice, originalPrice ~= nil)
	end

	local canRepeatBuy = StoreModel.instance:isSkinGoodsCanRepeatBuy(goodsMo)
	local alreadyHas = goodsMo:alreadyHas() and not canRepeatBuy

	gohelper.setActive(self.btnBuy, not alreadyHas)
	gohelper.setActive(self.goHasget, alreadyHas)
	gohelper.setActive(self.goSkinTips, canRepeatBuy)

	if canRepeatBuy then
		gohelper.setActive(self.goSkinTips, true)

		local compensate = string.splitToNumber(skinCo.compensate, "#")
		local text = luaLang("storeskinview_skintips")
		local str = string.format("<sprite=2>%s", compensate[3])

		self.txtPropNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(text, str)
	end

	local deductionItemCount = 0

	if not string.nilorempty(goodsMo.config.deductionItem) then
		local info = GameUtil.splitString2(goodsMo.config.deductionItem, true)

		deductionItemCount = ItemModel.instance:getItemCount(info[1][2])
		self.txtCostDeduction.text = -info[2][1]
	end

	gohelper.setActive(self.goCostDeduction, deductionItemCount > 0)
end

function ClothesStoreView:refreshNewArrow()
	local newIndex = StoreClothesGoodsItemListModel.instance:findNewGoodsIndex()

	gohelper.setActive(self.goArrow, newIndex ~= nil)
end

function ClothesStoreView:onSwitchAnimDone()
	self:setShaderKeyWord(false)
end

function ClothesStoreView:setShaderKeyWord(enable)
	if enable then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function ClothesStoreView:setSkinVideoPlayed(skinId)
	local key = PlayerPrefsKey.StoreSkinVideoPlayed .. skinId

	GameUtil.playerPrefsSetStringByUserId(key, skinId)
end

function ClothesStoreView:checkSkinVideoNotPlayed(skinId)
	local key = PlayerPrefsKey.StoreSkinVideoPlayed .. skinId
	local value = GameUtil.playerPrefsGetStringByUserId(key, nil)

	return value == nil
end

function ClothesStoreView:onDestroyView()
	self._simagetitle:UnLoadImage()
	self._simagelogo:UnLoadImage()

	if self._categoryItemContainer and #self._categoryItemContainer > 0 then
		for i = 1, #self._categoryItemContainer do
			local categotyItem = self._categoryItemContainer[i]

			categotyItem.btn:RemoveClickListener()

			if categotyItem.childItemContainer and #categotyItem.childItemContainer > 0 then
				for j = 1, #categotyItem.childItemContainer do
					categotyItem.childItemContainer[j].btn:RemoveClickListener()
				end
			end
		end
	end

	TaskDispatcher.cancelTask(self._startDefaultShowView, self)
	TaskDispatcher.cancelTask(self.refreshSkinPreview, self)
	TaskDispatcher.cancelTask(self.onSwitchAnimDone, self)
end

return ClothesStoreView
