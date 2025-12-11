module("modules.logic.store.view.ClothesStoreView", package.seeall)

local var_0_0 = class("ClothesStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_has/character/#simage_title")
	arg_1_0._simagelogo = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_has/character/#simage_logo")
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "#go_has")
	arg_1_0._goCharacter = gohelper.findChild(arg_1_0.viewGO, "#go_has/character")
	arg_1_0._goBgRoot = gohelper.findChild(arg_1_0.viewGO, "#go_has/character/bg")
	arg_1_0._goCharacterSpine = gohelper.findChild(arg_1_0.viewGO, "#go_has/character/bg/characterSpine")
	arg_1_0._scrollprop = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_has/#scroll_skin")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_has/#scroll_skin/viewport/content")
	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._scrollprop.gameObject)
	arg_1_0._gosmallspine = gohelper.findChild(arg_1_0.viewGO, "#go_has/LeftBtn/smalldynamiccontainer/#go_smallspine")
	arg_1_0.btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_has/LeftBtn/#btn_hide")
	arg_1_0.btnPlay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_has/LeftBtn/#btn_play")
	arg_1_0.btnSwitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_has/LeftBtn/#btn_switch")
	arg_1_0.txtSwitch = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_has/LeftBtn/#btn_switch/#txt_switch")
	arg_1_0.btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_has/RightBtn/#btn_detail")
	arg_1_0.btnBuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_has/RightBtn/#btn_buy")
	arg_1_0.goDiscount = gohelper.findChild(arg_1_0.viewGO, "#go_has/RightBtn/#btn_buy/#go_discount")
	arg_1_0.txtDiscount = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_has/RightBtn/#btn_buy/#go_discount/#txt_discount")
	arg_1_0.goCost = gohelper.findChild(arg_1_0.viewGO, "#go_has/RightBtn/#btn_buy/#go_cost")
	arg_1_0.goCostCurrency1 = gohelper.findChild(arg_1_0.goCost, "currency1")
	arg_1_0.txtPrice = gohelper.findChildTextMesh(arg_1_0.goCost, "currency1/txt_materialNum")
	arg_1_0.txtOriginalPrice = gohelper.findChildTextMesh(arg_1_0.goCost, "currency1/#txt_original_price")
	arg_1_0.imagematerial = gohelper.findChildImage(arg_1_0.goCost, "currency2/icon/simage_material")
	arg_1_0.txtMaterialNum = gohelper.findChildTextMesh(arg_1_0.goCost, "currency2/txt_materialNum")
	arg_1_0.goHasget = gohelper.findChild(arg_1_0.viewGO, "#go_has/RightBtn/#go_hasget")
	arg_1_0.goSkinTips = gohelper.findChild(arg_1_0.viewGO, "#go_has/RightBtn/go_tips")
	arg_1_0.txtPropNum = gohelper.findChildTextMesh(arg_1_0.goSkinTips, "#txt_Tips")
	arg_1_0.goDeduction = gohelper.findChild(arg_1_0.viewGO, "#go_has/character/#go_deduction")
	arg_1_0.txtDeduction = gohelper.findChildTextMesh(arg_1_0.goDeduction, "#txt_time")
	arg_1_0.goCostDeduction = gohelper.findChild(arg_1_0.viewGO, "#go_has/RightBtn/#btn_buy/#go_deduction")
	arg_1_0.txtCostDeduction = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_has/RightBtn/#btn_buy/#go_deduction/txt_materialNum")
	arg_1_0.goVideo = gohelper.findChild(arg_1_0.viewGO, "#go_has/character/bg/video")
	arg_1_0.videoRoot = gohelper.findChild(arg_1_0.viewGO, "#go_has/character/bg/video/videoRoot")
	arg_1_0.goArrow = gohelper.findChild(arg_1_0.viewGO, "#go_has/#scroll_skin/arrow")
	arg_1_0.btnArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_has/#scroll_skin/arrow/ani/image")
	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.viewCanvasGroup = gohelper.onceAddComponent(arg_1_0.viewGO, typeof(UnityEngine.CanvasGroup))

	StoreClothesGoodsItemListModel.instance:initViewParam()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, arg_2_0._isSkinEmpty, arg_2_0)
	arg_2_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_2_0._payFinished, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.SkinPreviewChanged, arg_2_0._onSkinPreviewChanged, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0._scrollprop:AddOnValueChanged(arg_2_0._onDragging, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnHide, arg_2_0._onClickBtnHide, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnPlay, arg_2_0._onClickBtnPlay, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnSwitch, arg_2_0._onClickBtnSwitch, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnDetail, arg_2_0._onClickBtnDetail, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnBuy, arg_2_0._onClickBtnBuy, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnArrow, arg_2_0._onClickBtnArrow, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, arg_3_0._isSkinEmpty, arg_3_0)
	arg_3_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_3_0._payFinished, arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.SkinPreviewChanged, arg_3_0._onSkinPreviewChanged, arg_3_0)
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._scrollprop:RemoveOnValueChanged()
	arg_3_0:removeClickCb(arg_3_0.btnHide)
	arg_3_0:removeClickCb(arg_3_0.btnPlay)
	arg_3_0:removeClickCb(arg_3_0.btnSwitch)
	arg_3_0:removeClickCb(arg_3_0.btnDetail)
	arg_3_0:removeClickCb(arg_3_0.btnBuy)
	arg_3_0:removeClickCb(arg_3_0.btnArrow)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._categoryItemContainer = {}

	gohelper.setActive(arg_4_0._goempty, false)
end

function var_0_0._isSkinEmpty(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goempty, arg_5_1)
end

function var_0_0._payFinished(arg_6_0)
	arg_6_0:_refreshGoods(true)
end

function var_0_0._onSkinPreviewChanged(arg_7_0, arg_7_1)
	StoreController.instance:dispatchEvent(StoreEvent.OnPlaySkinVideo)

	if arg_7_1 then
		arg_7_0:locationGoodsItem()
	end

	arg_7_0:refreshSkinPreview()
end

function var_0_0._onDragBegin(arg_8_0, arg_8_1, arg_8_2)
	StoreController.instance:dispatchEvent(StoreEvent.DragSkinListBegin)
	arg_8_0:refreshNewArrow()
end

function var_0_0._onDragging(arg_9_0)
	StoreController.instance:dispatchEvent(StoreEvent.DraggingSkinList)
	arg_9_0:refreshNewArrow()
end

function var_0_0._onDragEnd(arg_10_0, arg_10_1, arg_10_2)
	StoreController.instance:dispatchEvent(StoreEvent.DragSkinListEnd)
	arg_10_0:refreshNewArrow()
end

function var_0_0._onClickBtnArrow(arg_11_0)
	StoreClothesGoodsItemListModel.instance:moveToNewGoods()
end

function var_0_0._onClickBtnHide(arg_12_0)
	arg_12_0:hideUI()

	if arg_12_0.skinId then
		StatController.instance:track(StatEnum.EventName.ButtonClick, {
			[StatEnum.EventProperties.skinId] = arg_12_0.skinId,
			[StatEnum.EventProperties.ButtonName] = "_onClickBtnHide",
			[StatEnum.EventProperties.ViewName] = arg_12_0.viewName
		})
	end
end

function var_0_0.hideUI(arg_13_0, arg_13_1)
	if arg_13_1 then
		StoreController.instance:dispatchEvent(StoreEvent.PlayHideStoreAnim)
		arg_13_0:_startDefaultShowView()
	else
		arg_13_0._viewAnim:Play("hide", 0, 0)
		StoreController.instance:dispatchEvent(StoreEvent.PlayHideStoreAnim)
		TaskDispatcher.cancelTask(arg_13_0._startDefaultShowView, arg_13_0)
		TaskDispatcher.runDelay(arg_13_0._startDefaultShowView, arg_13_0, 0.16)
	end
end

function var_0_0._onClickBtnPlay(arg_14_0)
	arg_14_0:playVideo()

	if arg_14_0.skinId then
		StatController.instance:track(StatEnum.EventName.ButtonClick, {
			[StatEnum.EventProperties.skinId] = arg_14_0.skinId,
			[StatEnum.EventProperties.ButtonName] = "_onClickBtnPlay",
			[StatEnum.EventProperties.ViewName] = arg_14_0.viewName
		})
	end
end

function var_0_0.playVideo(arg_15_0)
	local var_15_0 = arg_15_0.isFirstOpen

	if var_15_0 then
		arg_15_0.viewCanvasGroup.alpha = 0
	end

	local var_15_1 = StoreClothesGoodsItemListModel.instance:getSelectGoods()

	StoreController.instance:dispatchEvent(StoreEvent.OnPlaySkinVideo, var_15_1)
	arg_15_0:hideUI(var_15_0)
end

function var_0_0._onClickBtnSwitch(arg_16_0)
	StoreController.instance:dispatchEvent(StoreEvent.OnPlaySkinVideo)
	StoreClothesGoodsItemListModel.instance:switchIsLive2d()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)
	arg_16_0._viewAnim:Play("switch", 0, 0)
	arg_16_0:setShaderKeyWord(true)
	arg_16_0:refreshSwitchBtn()
	TaskDispatcher.runDelay(arg_16_0.refreshSkinPreview, arg_16_0, 0.23)
	TaskDispatcher.runDelay(arg_16_0.onSwitchAnimDone, arg_16_0, 0.6)

	if arg_16_0.skinId then
		local var_16_0 = StoreClothesGoodsItemListModel.instance:getIsLive2d()

		StatController.instance:track(StatEnum.EventName.ButtonClick, {
			[StatEnum.EventProperties.skinId] = arg_16_0.skinId,
			[StatEnum.EventProperties.ButtonName] = string.format("_onClickBtnSwitch_%s", tostring(var_16_0)),
			[StatEnum.EventProperties.ViewName] = arg_16_0.viewName
		})
	end
end

function var_0_0._onClickBtnDetail(arg_17_0)
	local var_17_0 = StoreClothesGoodsItemListModel.instance:getSelectGoods()

	if not var_17_0 then
		return
	end

	ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
		goodsMO = var_17_0
	})

	if arg_17_0.skinId then
		StatController.instance:track(StatEnum.EventName.ButtonClick, {
			[StatEnum.EventProperties.skinId] = arg_17_0.skinId,
			[StatEnum.EventProperties.ButtonName] = "_onClickBtnDetail",
			[StatEnum.EventProperties.ViewName] = arg_17_0.viewName
		})
	end
end

function var_0_0._onClickBtnBuy(arg_18_0)
	local var_18_0 = StoreClothesGoodsItemListModel.instance:getSelectGoods()

	if not var_18_0 then
		return
	end

	ViewMgr.instance:openView(ViewName.StoreSkinGoodsView2, {
		goodsMO = var_18_0
	})
end

function var_0_0._startDefaultShowView(arg_19_0)
	local var_19_0 = {
		contentBg = arg_19_0._goBgRoot,
		callback = arg_19_0._showHideCallback,
		callbackObj = arg_19_0
	}

	ViewMgr.instance:openView(ViewName.StoreSkinDefaultShowView, var_19_0)
end

function var_0_0._showHideCallback(arg_20_0)
	arg_20_0._viewAnim:Play("show", 0, 0)
	arg_20_0._goBgRoot.transform:SetParent(arg_20_0._goCharacter.transform, false)
	gohelper.setAsFirstSibling(arg_20_0._goBgRoot)
	StoreController.instance:dispatchEvent(StoreEvent.PlayShowStoreAnim)
end

function var_0_0._refreshTabs(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0._selectSecondTabId
	local var_21_1 = arg_21_0._selectThirdTabId

	arg_21_0._selectSecondTabId = 0
	arg_21_0._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(arg_21_1) then
		arg_21_1 = arg_21_0.viewContainer:getSelectFirstTabId()
	end

	local var_21_2
	local var_21_3

	var_21_3, arg_21_0._selectSecondTabId, arg_21_0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(arg_21_1)

	local var_21_4 = StoreConfig.instance:getTabConfig(arg_21_0._selectThirdTabId)
	local var_21_5 = StoreConfig.instance:getTabConfig(arg_21_0._selectSecondTabId)
	local var_21_6 = StoreConfig.instance:getTabConfig(arg_21_0.viewContainer:getSelectFirstTabId())
	local var_21_7 = {}

	if var_21_4 and not string.nilorempty(var_21_4.showCost) then
		var_21_7 = string.splitToNumber(var_21_4.showCost, "#")
	elseif var_21_5 and not string.nilorempty(var_21_5.showCost) then
		var_21_7 = string.splitToNumber(var_21_5.showCost, "#")
	elseif var_21_6 and not string.nilorempty(var_21_6.showCost) then
		var_21_7 = string.splitToNumber(var_21_6.showCost, "#")
	end

	local var_21_8 = ItemModel.instance:getItemsBySubType(ItemEnum.SubType.SkinTicket)

	if var_21_8[1] then
		table.insert(var_21_7, {
			isCurrencySprite = true,
			type = MaterialEnum.MaterialType.Item,
			id = var_21_8[1].id
		})

		local var_21_9 = 0
		local var_21_10 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, var_21_8[1].id)

		if var_21_10 and not string.nilorempty(var_21_10.expireTime) then
			local var_21_11 = TimeUtil.stringToTimestamp(var_21_10.expireTime)
			local var_21_12 = math.floor(var_21_11 - ServerTime.now())

			if var_21_12 >= 0 and var_21_12 <= 259200 then
				var_21_9 = math.floor(var_21_12 / 60 / 60)
				var_21_9 = math.max(var_21_9, 1)
			end
		end

		if var_21_9 > 0 then
			gohelper.setActive(arg_21_0.goDeduction, true)

			arg_21_0.txtDeduction.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_deduction_item_deadtime"), tostring(var_21_9))
		else
			gohelper.setActive(arg_21_0.goDeduction, false)
		end
	else
		gohelper.setActive(arg_21_0.goDeduction, false)
	end

	arg_21_0.viewContainer:setCurrencyByParams(var_21_7)

	if not arg_21_2 and var_21_0 == arg_21_0._selectSecondTabId and var_21_1 == arg_21_0._selectThirdTabId then
		return
	end

	arg_21_0:_onRefreshRedDot()
	arg_21_0:_updateInfo()
end

function var_0_0._refreshGoods(arg_22_0, arg_22_1)
	if arg_22_1 then
		local var_22_0 = StoreConfig.instance:getTabConfig(arg_22_0._selectThirdTabId)

		arg_22_0.storeId = var_22_0 and var_22_0.storeId or 0

		if arg_22_0.storeId == 0 then
			local var_22_1 = StoreConfig.instance:getTabConfig(arg_22_0._selectSecondTabId)

			arg_22_0.storeId = var_22_1 and var_22_1.storeId or 0
		end

		StoreRpc.instance:sendGetStoreInfosRequest({
			arg_22_0.storeId
		})
		ChargeRpc.instance:sendGetChargeInfoRequest()
	end
end

function var_0_0._onRefreshRedDot(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0._categoryItemContainer) do
		gohelper.setActive(iter_23_1.go_reddot, StoreModel.instance:isTabFirstRedDotShow(iter_23_1.tabId))
		gohelper.setActive(iter_23_1.go_unselectreddot, StoreModel.instance:isTabFirstRedDotShow(iter_23_1.tabId))

		for iter_23_2, iter_23_3 in pairs(iter_23_1.childItemContainer) do
			gohelper.setActive(iter_23_3.go_subreddot1, StoreModel.instance:isTabSecondRedDotShow(iter_23_3.tabId))
			gohelper.setActive(iter_23_3.go_subreddot2, StoreModel.instance:isTabSecondRedDotShow(iter_23_3.tabId))
		end
	end
end

function var_0_0.onOpen(arg_24_0)
	arg_24_0.isFirstOpen = true

	arg_24_0._viewAnim:Play("open", 0, 0)

	arg_24_0._selectFirstTabId = arg_24_0.viewContainer:getSelectFirstTabId()

	local var_24_0 = arg_24_0.viewContainer:getJumpTabId()
	local var_24_1 = arg_24_0.viewContainer:getJumpGoodsId()
	local var_24_2 = arg_24_0.viewContainer:isJumpFocus()

	arg_24_0:_refreshTabs(var_24_0, true)
	arg_24_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_24_0._updateInfo, arg_24_0)
	arg_24_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_24_0._updateInfo, arg_24_0)
	arg_24_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_24_0._onRefreshRedDot, arg_24_0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_24_0._updateItemList, arg_24_0)

	if var_24_1 then
		if not var_24_2 then
			ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
				goodsMO = StoreModel.instance:getGoodsMO(tonumber(var_24_1))
			})
		end

		arg_24_0:locationGoodsItemByGoodsId(var_24_1)

		local var_24_3 = StoreClothesGoodsItemListModel.instance:getGoodIndex(var_24_1)

		StoreClothesGoodsItemListModel.instance:setSelectIndex(var_24_3)
	end
end

function var_0_0.locationGoodsItem(arg_25_0, arg_25_1)
	arg_25_1 = arg_25_1 or StoreClothesGoodsItemListModel.instance:getSelectGoods()

	arg_25_0:locationGoodsItemByGoodsId(arg_25_1.goodsId)
end

function var_0_0.locationGoodsItemByGoodsId(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return
	end

	local var_26_0 = StoreClothesGoodsItemListModel.instance:getGoodIndex(arg_26_1)

	if not var_26_0 then
		return
	end

	local var_26_1 = arg_26_0._gocontent.transform
	local var_26_2 = transformhelper.getLocalPos(var_26_1)
	local var_26_3 = arg_26_0.viewContainer._ScrollViewSkinStore._param
	local var_26_4 = math.ceil(var_26_0 / 2)
	local var_26_5 = (var_26_3.cellHeight + var_26_3.cellSpaceV) * (var_26_4 - 1) + var_26_3.startSpace
	local var_26_6 = recthelper.getHeight(var_26_1) - recthelper.getHeight(arg_26_0._scrollprop.transform)
	local var_26_7 = math.max(0, var_26_6)
	local var_26_8 = math.min(var_26_7, var_26_5)

	recthelper.setAnchorY(var_26_1, var_26_8)
end

function var_0_0._updateItemList(arg_27_0)
	local var_27_0 = arg_27_0.viewContainer:getJumpTabId()

	arg_27_0:_refreshTabs(var_27_0, true)
end

function var_0_0._updateInfo(arg_28_0)
	local var_28_0 = StoreClothesGoodsItemListModel.instance:getCount()
	local var_28_1 = var_28_0 == 0

	gohelper.setActive(arg_28_0._goempty, var_28_1)
	gohelper.setActive(arg_28_0._gohas, not var_28_1)

	if var_28_1 then
		return
	end

	local var_28_2 = 870

	if var_28_0 <= 2 then
		var_28_2 = 408
	end

	recthelper.setHeight(arg_28_0._scrollprop.transform, var_28_2)
	arg_28_0:refreshSwitchBtn()
	arg_28_0:refreshSkinPreview()
end

function var_0_0.onClose(arg_29_0)
	arg_29_0:removeEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, arg_29_0._isSkinEmpty, arg_29_0)
	arg_29_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_29_0._payFinished, arg_29_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_29_0._updateItemList, arg_29_0)
	arg_29_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_29_0._updateInfo, arg_29_0)
	arg_29_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_29_0._updateInfo, arg_29_0)
	arg_29_0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_29_0._onRefreshRedDot, arg_29_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_29_0._updateItemList, arg_29_0)
end

function var_0_0.onUpdateParam(arg_30_0)
	arg_30_0._selectFirstTabId = arg_30_0.viewContainer:getSelectFirstTabId()

	local var_30_0 = arg_30_0.viewContainer:getJumpTabId()
	local var_30_1 = arg_30_0.viewContainer:getJumpGoodsId()

	arg_30_0:_refreshTabs(var_30_0)

	if var_30_1 then
		ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
			goodsMO = StoreModel.instance:getGoodsMO(tonumber(var_30_1))
		})
	end
end

function var_0_0.refreshSwitchBtn(arg_31_0)
	local var_31_0 = StoreClothesGoodsItemListModel.instance:getIsLive2d()

	arg_31_0.txtSwitch.text = var_31_0 and luaLang("storeskinpreviewview_btnswitch") or "L2D"
end

function var_0_0.refreshSkinPreview(arg_32_0)
	local var_32_0 = StoreClothesGoodsItemListModel.instance:getSelectGoods()

	if not var_32_0 then
		return
	end

	if not arg_32_0.previewComp then
		arg_32_0.previewComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_32_0._goCharacter, ClothesStorePreviewSkinComp)

		arg_32_0.previewComp:setSmallSpineGO(arg_32_0._gosmallspine)
	end

	arg_32_0.previewComp:setGoods(var_32_0)
	arg_32_0:refreshSkinInfo(var_32_0)

	if arg_32_0._goodsMo and arg_32_0._goodsMo ~= var_32_0 then
		arg_32_0._viewAnim:Play("switchin", 0, 0)
	end

	arg_32_0._goodsMo = var_32_0

	arg_32_0:refreshNewArrow()
end

function var_0_0.refreshSkinInfo(arg_33_0, arg_33_1)
	if not arg_33_1 then
		return
	end

	local var_33_0 = arg_33_1.config
	local var_33_1 = var_33_0.product
	local var_33_2 = string.splitToNumber(var_33_1, "#")[2]
	local var_33_3 = SkinConfig.instance:getSkinCo(var_33_2)

	arg_33_0.skinId = var_33_2

	if string.nilorempty(var_33_3.subTitle) then
		gohelper.setActive(arg_33_0._simagetitle.gameObject, false)
	else
		arg_33_0._simagetitle:LoadImage(var_33_3.subTitle, function()
			ZProj.UGUIHelper.SetImageSize(arg_33_0._simagetitle.gameObject)
		end)
		gohelper.setActive(arg_33_0._simagetitle.gameObject, true)
	end

	if string.nilorempty(var_33_0.logoRoots) then
		gohelper.setActive(arg_33_0._simagelogo.gameObject, false)
	else
		arg_33_0._simagelogo:LoadImage(var_33_0.logoRoots, function()
			ZProj.UGUIHelper.SetImageSize(arg_33_0._simagelogo.gameObject)
		end)
		gohelper.setActive(arg_33_0._simagelogo.gameObject, true)
	end

	local var_33_4 = string.splitToNumber(var_33_0.cost, "#")
	local var_33_5, var_33_6 = ItemModel.instance:getItemConfigAndIcon(var_33_4[1], var_33_4[2])
	local var_33_7 = var_33_5.icon
	local var_33_8 = string.format("%s_1", var_33_7)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_33_0.imagematerial, var_33_8, true)

	arg_33_0.txtMaterialNum.text = var_33_4[3]

	gohelper.setActive(arg_33_0.goDiscount, var_33_0.originalCost > 0)

	local var_33_9 = var_33_4[3] / var_33_0.originalCost
	local var_33_10 = math.ceil(var_33_9 * 100)

	arg_33_0.txtDiscount.text = string.format("-%d%%", 100 - var_33_10)

	arg_33_0:refreshChargeInfo(arg_33_1, var_33_3)

	local var_33_11 = lua_character_limited.configDict[var_33_2]
	local var_33_12 = not VersionValidator.instance:isInReviewing()
	local var_33_13 = var_33_11 and not string.nilorempty(var_33_11.entranceMv)
	local var_33_14 = var_33_12 and var_33_13

	gohelper.setActive(arg_33_0.btnPlay, var_33_14)

	if arg_33_0._adjust then
		return
	end

	if var_33_14 and arg_33_0:checkSkinVideoNotPlayed(var_33_2) then
		arg_33_0:setSkinVideoPlayed(var_33_2)
		arg_33_0:playVideo()
	elseif arg_33_0:checkSkinVideoNotPlayed(0) then
		arg_33_0:setSkinVideoPlayed(0)
		arg_33_0:hideUI()
	end

	arg_33_0.isFirstOpen = false
end

function var_0_0.refreshChargeInfo(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_2.id
	local var_36_1
	local var_36_2

	if arg_36_2 and StoreModel.instance:isStoreSkinChargePackageValid(var_36_0) then
		var_36_1, var_36_2 = StoreConfig.instance:getSkinChargePrice(var_36_0)
	end

	gohelper.setActive(arg_36_0.goCostCurrency1, var_36_1 ~= nil)

	if var_36_1 then
		local var_36_3 = string.format("%s%s", StoreModel.instance:getCostStr(var_36_1))

		arg_36_0.txtPrice.text = var_36_3

		if var_36_2 then
			arg_36_0.txtOriginalPrice.text = var_36_2

			local var_36_4 = StoreConfig.instance:getSkinChargeGoodsCfg(var_36_0)

			if var_36_4 then
				local var_36_5, var_36_6 = PayModel.instance:getProductOriginPriceNum(var_36_4.originalCostGoodsId)

				arg_36_0.txtOriginalPrice.text = var_36_6
			end
		end

		gohelper.setActive(arg_36_0.txtOriginalPrice, var_36_2 ~= nil)
	end

	local var_36_7 = StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_36_1)
	local var_36_8 = arg_36_1:alreadyHas() and not var_36_7

	gohelper.setActive(arg_36_0.btnBuy, not var_36_8)
	gohelper.setActive(arg_36_0.goHasget, var_36_8)
	gohelper.setActive(arg_36_0.goSkinTips, var_36_7)

	if var_36_7 then
		gohelper.setActive(arg_36_0.goSkinTips, true)

		local var_36_9 = string.splitToNumber(arg_36_2.compensate, "#")
		local var_36_10 = luaLang("storeskinview_skintips")
		local var_36_11 = string.format("<sprite=2>%s", var_36_9[3])

		arg_36_0.txtPropNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_36_10, var_36_11)
	end

	local var_36_12 = 0

	if not string.nilorempty(arg_36_1.config.deductionItem) then
		local var_36_13 = GameUtil.splitString2(arg_36_1.config.deductionItem, true)

		var_36_12 = ItemModel.instance:getItemCount(var_36_13[1][2])
		arg_36_0.txtCostDeduction.text = -var_36_13[2][1]
	end

	gohelper.setActive(arg_36_0.goCostDeduction, var_36_12 > 0)
end

function var_0_0.refreshNewArrow(arg_37_0)
	local var_37_0 = StoreClothesGoodsItemListModel.instance:findNewGoodsIndex()

	gohelper.setActive(arg_37_0.goArrow, var_37_0 ~= nil)
end

function var_0_0.onSwitchAnimDone(arg_38_0)
	arg_38_0:setShaderKeyWord(false)
end

function var_0_0.setShaderKeyWord(arg_39_0, arg_39_1)
	if arg_39_1 then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function var_0_0.setSkinVideoPlayed(arg_40_0, arg_40_1)
	local var_40_0 = PlayerPrefsKey.StoreSkinVideoPlayed .. arg_40_1

	GameUtil.playerPrefsSetStringByUserId(var_40_0, arg_40_1)
end

function var_0_0.checkSkinVideoNotPlayed(arg_41_0, arg_41_1)
	local var_41_0 = PlayerPrefsKey.StoreSkinVideoPlayed .. arg_41_1

	return GameUtil.playerPrefsGetStringByUserId(var_41_0, nil) == nil
end

function var_0_0.onDestroyView(arg_42_0)
	arg_42_0._simagetitle:UnLoadImage()
	arg_42_0._simagelogo:UnLoadImage()

	if arg_42_0._categoryItemContainer and #arg_42_0._categoryItemContainer > 0 then
		for iter_42_0 = 1, #arg_42_0._categoryItemContainer do
			local var_42_0 = arg_42_0._categoryItemContainer[iter_42_0]

			var_42_0.btn:RemoveClickListener()

			if var_42_0.childItemContainer and #var_42_0.childItemContainer > 0 then
				for iter_42_1 = 1, #var_42_0.childItemContainer do
					var_42_0.childItemContainer[iter_42_1].btn:RemoveClickListener()
				end
			end
		end
	end

	TaskDispatcher.cancelTask(arg_42_0._startDefaultShowView, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0.refreshSkinPreview, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0.onSwitchAnimDone, arg_42_0)
end

return var_0_0
