module("modules.logic.store.view.DecorateStoreView", package.seeall)

slot0 = class("DecorateStoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "Bg")
	slot0._gotypebg = gohelper.findChild(slot0.viewGO, "Bg/typebg")
	slot0._gotypebg1 = gohelper.findChild(slot0.viewGO, "Bg/typebg/#go_typebg1")
	slot0._simagetypebg1 = gohelper.findChildSingleImage(slot0.viewGO, "Bg/typebg/#go_typebg1/#simage_icon")
	slot0._gotypebg2 = gohelper.findChild(slot0.viewGO, "Bg/typebg/#go_typebg2")
	slot0._gotypebg3 = gohelper.findChild(slot0.viewGO, "Bg/typebg/#go_typebg3")
	slot0._gotypebg5 = gohelper.findChild(slot0.viewGO, "Bg/typebg/#go_typebg5")
	slot0._gotypebg6 = gohelper.findChild(slot0.viewGO, "Bg/typebg/#go_typebg6")
	slot0._gotypebg7 = gohelper.findChild(slot0.viewGO, "Bg/typebg/#go_typebg7")
	slot0._simagetypebg7 = gohelper.findChildSingleImage(slot0.viewGO, "Bg/typebg/#go_typebg7/#simage_icon")
	slot0._gozs = gohelper.findChild(slot0.viewGO, "Bg/typebg/#go_typebg2/zs")
	slot0._goskincontainer = gohelper.findChild(slot0.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer")
	slot0._simageskin = gohelper.findChildSingleImage(slot0.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#simage_skin")
	slot0._simagel2d = gohelper.findChildSingleImage(slot0.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#go_spinecontainer/#simage_l2d")
	slot0._gobigspine = gohelper.findChild(slot0.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	slot0._gospinecontainer = gohelper.findChild(slot0.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#go_spinecontainer")
	slot0._goview1 = gohelper.findChild(slot0.viewGO, "UI/#go_view1")
	slot0._goContent1 = gohelper.findChild(slot0.viewGO, "UI/#go_view1/Viewport/#go_Content1")
	slot0._btnunfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "UI/#go_view1/#btn_unfold")
	slot0._goview2 = gohelper.findChild(slot0.viewGO, "UI/#go_view2")
	slot0._goContent2 = gohelper.findChild(slot0.viewGO, "UI/#go_view2/Viewport/#go_Content2")
	slot0._btnfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "UI/#go_view2/#btn_fold")
	slot0._gocommon = gohelper.findChild(slot0.viewGO, "UI/common")
	slot0._gohideclick = gohelper.findChild(slot0.viewGO, "UI/common/#btn_hide/#go_hideclick")
	slot0._goowned = gohelper.findChild(slot0.viewGO, "UI/common/#go_owned")
	slot0._btnhide = gohelper.findChildButtonWithAudio(slot0.viewGO, "UI/common/layout/#btn_hide")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "UI/common/layout/#btn_switch")
	slot0._txtswitch = gohelper.findChildText(slot0.viewGO, "UI/common/layout/#btn_switch/#txt_switch")
	slot0._godynamiccontainer = gohelper.findChild(slot0.viewGO, "UI/common/layout/smalldynamiccontainer")
	slot0._gosmallspine = gohelper.findChild(slot0.viewGO, "UI/common/layout/smalldynamiccontainer/#go_smallspine")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "UI/common/#btn_buy")
	slot0._godiscount = gohelper.findChild(slot0.viewGO, "UI/common/#btn_buy/#go_discount")
	slot0._txtdiscount = gohelper.findChildText(slot0.viewGO, "UI/common/#btn_buy/#go_discount/#txt_discount")
	slot0._godiscount2 = gohelper.findChild(slot0.viewGO, "UI/common/#btn_buy/#go_discount2")
	slot0._txtdiscount2 = gohelper.findChildText(slot0.viewGO, "UI/common/#btn_buy/#go_discount2/#txt_discount")
	slot0._gosingle = gohelper.findChild(slot0.viewGO, "UI/common/#btn_buy/cost/#go_single")
	slot0._imagesingleicon = gohelper.findChildImage(slot0.viewGO, "UI/common/#btn_buy/cost/#go_single/icon/simage_material")
	slot0._txtcurprice = gohelper.findChildText(slot0.viewGO, "UI/common/#btn_buy/cost/#go_single/txt_materialNum")
	slot0._txtoriginalprice = gohelper.findChildText(slot0.viewGO, "UI/common/#btn_buy/cost/#go_single/#txt_original_price")
	slot0._godouble = gohelper.findChild(slot0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice")
	slot0._imagedoubleicon1 = gohelper.findChildImage(slot0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency1/simage_material")
	slot0._txtcurprice1 = gohelper.findChildText(slot0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency1/txt_materialNum")
	slot0._txtoriginalprice1 = gohelper.findChildText(slot0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency1/#txt_original_price1")
	slot0._imagedoubleicon2 = gohelper.findChildImage(slot0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency2/simage_material")
	slot0._txtcurprice2 = gohelper.findChildText(slot0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency2/txt_materialNum")
	slot0._txtoriginalprice2 = gohelper.findChildText(slot0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency2/#txt_original_price1")
	slot0._gofree = gohelper.findChild(slot0.viewGO, "UI/common/#btn_buy/cost/#go_free")
	slot0._gocostclick = gohelper.findChild(slot0.viewGO, "UI/common/#btn_buy/#go_costclick")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "UI/common/#txt_dec")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "UI/common/title/#txt_title")
	slot0._godiscounttip = gohelper.findChild(slot0.viewGO, "UI/common/#go_discountTips")
	slot0._txtdiscounttip = gohelper.findChildText(slot0.viewGO, "UI/common/#go_discountTips/#txt_discountTips")
	slot0._gotype = gohelper.findChild(slot0.viewGO, "UI/type")
	slot0._gotype2 = gohelper.findChild(slot0.viewGO, "UI/type/type2")
	slot0._txtrolename = gohelper.findChildText(slot0.viewGO, "UI/type/type2/#txt_rolename")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "UI/type/type2/#simage_signature")
	slot0._gotype4 = gohelper.findChild(slot0.viewGO, "UI/type/type4")
	slot0._gotype5 = gohelper.findChild(slot0.viewGO, "UI/type/type5")
	slot0._gostorecategoryitem = gohelper.findChild(slot0.viewGO, "UI/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	slot0._goline = gohelper.findChild(slot0.viewGO, "UI/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_line")
	slot0._gotabreddot1 = gohelper.findChild(slot0.viewGO, "UI/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_tabreddot1")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnunfold:AddClickListener(slot0._btnunfoldOnClick, slot0)
	slot0._btnfold:AddClickListener(slot0._btnfoldOnClick, slot0)
	slot0._btnhide:AddClickListener(slot0._btnhideOnClick, slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnunfold:RemoveClickListener()
	slot0._btnfold:RemoveClickListener()
	slot0._btnhide:RemoveClickListener()
	slot0._btnswitch:RemoveClickListener()
	slot0._btnbuy:RemoveClickListener()
end

function slot0._btnunfoldOnClick(slot0)
	slot0._viewAnim.enabled = true

	slot0._viewAnim:Play("goview2", 0, 0)
	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.UnFold)
	slot0:_refreshGood(true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function slot0._btnfoldOnClick(slot0)
	slot0._viewAnim.enabled = true

	slot0._viewAnim:Play("goview1", 0, 0)
	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.Fold)
	slot0:_refreshGood()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function slot0._btnhideOnClick(slot0)
	slot0._viewAnim:Play("hide", 0, 0)
	StoreController.instance:dispatchEvent(StoreEvent.PlayHideStoreAnim)
	UIBlockMgr.instance:startBlock("decoratehide")
	TaskDispatcher.runDelay(slot0._startDefaultShowView, slot0, 0.34)
end

function slot0._startDefaultShowView(slot0)
	UIBlockMgr.instance:endBlock("decoratehide")

	slot0._viewAnim.enabled = false

	if DecorateStoreModel.getItemType(slot0._selectSecondTabId) == DecorateStoreEnum.DecorateItemType.MainScene then
		ViewMgr.instance:openView(ViewName.MainSceneStoreShowView, {
			sceneId = slot0._sceneId,
			callback = slot0._showHideCallback,
			callbackObj = slot0
		})
	else
		ViewMgr.instance:openView(ViewName.DecorateStoreDefaultShowView, {
			bg = gohelper.findChild(slot0.viewGO.transform.parent.gameObject, "bg"),
			contentBg = slot0._gotypebg,
			callback = slot0._showHideCallback,
			callbackObj = slot0,
			viewCls = slot0._viewCls
		})
	end
end

function slot0._showHideCallback(slot0, slot1)
	slot0._viewAnim.enabled = true

	slot0._viewAnim:Play("show", 0, 0)

	if DecorateStoreModel.getItemType(slot0._selectSecondTabId) ~= DecorateStoreEnum.DecorateItemType.MainScene then
		slot1.bg.transform:SetParent(slot0.viewGO.transform.parent, false)
		gohelper.setAsFirstSibling(slot1.bg)
		slot1.contentBg.transform:SetParent(slot0._gobg.transform, false)
		gohelper.setAsFirstSibling(slot1.contentBg)
	end

	StoreController.instance:dispatchEvent(StoreEvent.PlayShowStoreAnim)
end

function slot0._btnswitchOnClick(slot0)
	slot0._showLive2d = not slot0._showLive2d

	slot0:_refreshBigSkin()
end

function slot0._btnbuyOnClick(slot0)
	StoreController.instance:openDecorateStoreGoodsView(StoreModel.instance:getGoodsMO(DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId)))
end

function slot0._editableInitView(slot0)
	slot0._goodItems = {}
	slot0._categoryItemContainer = {}
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._btnhide.gameObject, true)
	DecorateStoreModel.instance:initDecorateReadState()
end

function slot0._onCloseView(slot0, slot1)
	if (slot1 == ViewName.MainSceneStoreShowView or slot1 == ViewName.MainSceneSwitchInfoView) and slot0._weatherSwitchControlComp then
		MainSceneSwitchCameraController.instance:showScene(slot0._sceneId, slot0._showSceneFinished, slot0)
	end
end

function slot0._addEvents(slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.DecorateGoodItemClick, slot0._onGoodItemClick, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._onGoodsChanged, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._onGoodsChanged, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.DecorateGoodItemClick, slot0._onGoodItemClick, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._onGoodsChanged, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._onGoodsChanged, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onGoodItemClick(slot0)
	slot0._showLive2d = false

	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.Fold)

	if DecorateStoreModel.instance:getCurViewType() == DecorateStoreEnum.DecorateViewType.UnFold then
		slot5 = 0

		if DecorateStoreModel.instance:getDecorateGoodIndex(slot0._selectSecondTabId, DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId)) > 4 then
			slot5 = #DecorateStoreModel.instance:getDecorateGoodList(slot0._selectSecondTabId) - slot3 >= 4 and 55 - 360 * (slot3 - 4) or -360 * (slot3 - 4)
		end

		slot6, slot7 = transformhelper.getLocalPos(slot0._goContent1.transform)

		transformhelper.setLocalPos(slot0._goContent1.transform, slot5, slot7, 0)
		slot0:_startGoodIn()

		return
	end

	slot0._viewAnim:Play("out", 0, 0)
	UIBlockMgr.instance:startBlock("decorateswitch")
	TaskDispatcher.runDelay(slot0._startGoodIn, slot0, 0.17)
end

function slot0._startGoodIn(slot0)
	UIBlockMgr.instance:endBlock("decorateswitch")
	slot0._viewAnim:Play("in", 0, 0)
	slot0:_refreshGood(true)
end

function slot0._onGoodsChanged(slot0)
	if #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.NewDecorateStore) <= 0 then
		return
	end

	slot0:_onRefreshRedDot()
	slot0:_refreshGood()
end

function slot0.onOpen(slot0)
	Activity186Model.instance:checkReadTask(Activity186Enum.ReadTaskId.Task4)

	slot0._opened = true

	slot0:_addEvents()
	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.Fold)

	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId(), true, true)
end

function slot0.onUpdateParam(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId())
end

function slot0._refreshTabs(slot0, slot1, slot2, slot3)
	slot4 = slot0._selectSecondTabId
	slot0._selectSecondTabId = 0

	if not StoreModel.instance:isTabOpen(slot1) then
		slot1 = slot0.viewContainer:getSelectFirstTabId()
	end

	slot5 = nil
	slot5, slot0._selectSecondTabId, slot5 = StoreModel.instance:jumpTabIdToSelectTabId(slot1)
	slot7 = StoreConfig.instance:getTabConfig(slot0.viewContainer:getSelectFirstTabId())

	if StoreConfig.instance:getTabConfig(slot0._selectSecondTabId) and not string.nilorempty(slot6.showCost) then
		slot0.viewContainer:setCurrencyType(slot6.showCost)
	elseif slot7 and not string.nilorempty(slot7.showCost) then
		slot0.viewContainer:setCurrencyType(slot7.showCost)
	else
		slot0.viewContainer:setCurrencyType(nil)
	end

	if not slot2 and slot4 == slot0._selectSecondTabId then
		return
	end

	slot0:_refreshAllSecondTabs()
	StoreController.instance:readTab(slot1)
	slot0:_onRefreshRedDot()

	slot0._resetScrollPos = true

	if slot0._opened then
		slot4 = nil
		slot0._opened = false
	end

	if slot4 and slot0._goodItems[slot4] then
		slot11 = 0
		slot12 = 0

		slot0._viewAnim:Play("out", slot11, slot12)

		for slot11, slot12 in pairs(slot0._goodItems[slot4][DecorateStoreEnum.DecorateViewType.Fold]) do
			slot12:playOut()
		end

		UIBlockMgr.instance:startBlock("decorateswitch")
		TaskDispatcher.runDelay(slot0._switchTabRefresh, slot0, 0.17)
	else
		slot0._viewAnim:Play("in", 0, 0)
		slot0:_refreshGood()
	end
end

function slot0._switchTabRefresh(slot0)
	UIBlockMgr.instance:endBlock("decorateswitch")

	slot1, slot2 = transformhelper.getLocalPos(slot0._goContent1.transform)

	transformhelper.setLocalPos(slot0._goContent1.transform, 0, slot2, 0)
	slot0._viewAnim:Play("in", 0, 0)
	slot0:_refreshGood()
end

function slot0._refreshAllSecondTabs(slot0)
	if StoreModel.instance:getSecondTabs(slot0._selectFirstTabId, true, true) and #slot1 > 0 then
		for slot5 = 1, #slot1 do
			slot0:_refreshSecondTabs(slot5, slot1[slot5])
			gohelper.setActive(slot0._categoryItemContainer[slot5].go, #DecorateStoreModel.instance:getDecorateGoodList(slot1[slot5].id) > 0)
		end

		for slot5 = #slot1 + 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot5].go, false)
		end
	else
		for slot5 = 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot5].go, false)
		end
	end
end

function slot0._refreshSecondTabs(slot0, slot1, slot2)
	slot3 = slot0._categoryItemContainer[slot1] or slot0:initCategoryItemTable(slot1)
	slot3.tabId = slot2.id
	slot3.txt_itemcn1.text = slot2.name
	slot3.txt_itemcn2.text = slot2.name
	slot3.txt_itemen1.text = slot2.nameEn
	slot3.txt_itemen2.text = slot2.nameEn
	slot4 = slot0._selectSecondTabId == slot2.id

	gohelper.setActive(slot3.go_unselected, not slot4)
	gohelper.setActive(slot3.go_selected, slot4)
end

function slot0.initCategoryItemTable(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._gostorecategoryitem, "item" .. slot1)
	slot2.go_unselected = gohelper.findChild(slot2.go, "go_unselected")
	slot2.go_selected = gohelper.findChild(slot2.go, "go_selected")
	slot2.go_line = gohelper.findChild(slot2.go, "go_line")
	slot2.go_reddot = gohelper.findChild(slot2.go, "#go_tabreddot1")
	slot2.txt_itemcn1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemcn1")
	slot2.txt_itemen1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemen1")
	slot2.txt_itemcn2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemcn2")
	slot2.txt_itemen2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemen2")
	slot2.go_childcategory = gohelper.findChild(slot2.go, "go_childcategory")
	slot2.go_childItem = gohelper.findChild(slot2.go, "go_childcategory/go_childitem")
	slot2.childItemContainer = {}
	slot2.btnGO = gohelper.findChild(slot2.go, "clickArea")
	slot2.btn = gohelper.getClickWithAudio(slot2.go, AudioEnum.UI.play_ui_bank_open)
	slot2.tabId = 0

	slot2.btn:AddClickListener(function (slot0)
		slot1 = slot0.tabId

		uv0:_refreshTabs(slot1)
		StoreController.instance:statSwitchStore(slot1)
	end, slot2)
	table.insert(slot0._categoryItemContainer, slot2)
	gohelper.setActive(slot2.go_childItem, false)

	return slot2
end

function slot0._onRefreshRedDot(slot0)
	for slot4, slot5 in pairs(slot0._categoryItemContainer) do
		gohelper.setActive(slot5.go_reddot, StoreModel.instance:isTabSecondRedDotShow(slot5.tabId))
	end
end

function slot0._refreshGood(slot0, slot1)
	slot0:_refreshGoodDetail()
	slot0:_refreshGoodItems(slot1)
end

function slot0._refreshGoodItems(slot0, slot1)
	slot2 = DecorateStoreModel.instance:getDecorateGoodList(slot0._selectSecondTabId)

	if not slot0._goodItems[slot0._selectSecondTabId] then
		slot0._goodItems[slot0._selectSecondTabId] = {
			[DecorateStoreEnum.DecorateViewType.Fold] = {},
			[DecorateStoreEnum.DecorateViewType.UnFold] = {}
		}
	end

	for slot6, slot7 in pairs(slot0._goodItems) do
		for slot11, slot12 in pairs(slot7) do
			for slot16, slot17 in pairs(slot12) do
				slot17:hide()
			end
		end
	end

	for slot6, slot7 in ipairs(slot2) do
		if not slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][slot7.goodsId] then
			slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][slot7.goodsId] = DecorateGoodsItem.New()

			slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][slot7.goodsId]:init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[6], slot0._goContent1, "good_" .. tostring(slot7.goodsId)), slot7)
		else
			slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][slot7.goodsId]:reset(slot7)
		end

		slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][slot7.goodsId]:setFold(true)
		slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][slot7.goodsId]:playIn(slot6, slot1)
		gohelper.setSibling(slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][slot7.goodsId].go, slot6)

		if not slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][slot7.goodsId] then
			slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][slot7.goodsId] = DecorateGoodsItem.New()

			slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][slot7.goodsId]:init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[6], slot0._goContent2, "good_" .. tostring(slot7.goodsId)), slot7)
		else
			slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][slot7.goodsId]:reset(slot7)
		end

		slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][slot7.goodsId]:setFold(false)
		slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][slot7.goodsId]:playIn(slot6, slot1)
		gohelper.setSibling(slot0._goodItems[slot0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][slot7.goodsId].go, slot6)
	end
end

function slot0._refreshGoodDetail(slot0)
	slot1 = DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId)
	slot5 = DecorateStoreModel.instance:getGoodDiscount(slot1) > 0 and slot2 < 100 and DecorateStoreModel.instance:getGoodItemLimitTime(slot1) > 0 and not DecorateStoreModel.instance:isDecorateGoodItemHas(slot1)

	gohelper.setActive(slot0._godiscounttip, slot5)

	if slot5 then
		slot0._txtdiscounttip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("decoratestore_discount_limittime"), {
			TimeUtil.SecondToActivityTimeFormat(slot3)
		})
	end

	DecorateStoreModel.instance:setGoodRead(slot1)

	slot7 = DecorateStoreModel.instance:getCurViewType() == DecorateStoreEnum.DecorateViewType.Fold

	gohelper.setActive(slot0._goview1, slot7)
	gohelper.setActive(slot0._goview2, not slot7)
	gohelper.setActive(slot0._gocommon, slot7)
	gohelper.setActive(slot0._gotypebg3, false)

	if DecorateStoreModel.getItemType(slot0._selectSecondTabId) ~= DecorateStoreEnum.DecorateItemType.Default and slot8 ~= DecorateStoreEnum.DecorateItemType.Icon then
		slot0:_hideDecorateDefault()
	end

	if slot8 ~= DecorateStoreEnum.DecorateItemType.MainScene then
		slot0:_hideMainScene()
	end

	if slot8 ~= DecorateStoreEnum.DecorateItemType.Skin or not slot0._showLive2d then
		slot0:_hideDecorateSkin()
	end

	if slot8 ~= DecorateStoreEnum.DecorateItemType.SelfCard then
		slot0:_hideDecorateSelfCard()
	end

	if slot8 ~= DecorateStoreEnum.DecorateItemType.BuildingVideo then
		slot0:_hideDecorateBuildingVideo()
	end

	if slot8 == DecorateStoreEnum.DecorateItemType.Default or slot8 == DecorateStoreEnum.DecorateItemType.Icon then
		slot0:_updateDecorateDefault()
	elseif slot8 == DecorateStoreEnum.DecorateItemType.Skin then
		slot0:_updateDecorateSkin()
	elseif slot8 == DecorateStoreEnum.DecorateItemType.MainScene then
		slot0:_updateDecorateMainScene()
	elseif slot8 == DecorateStoreEnum.DecorateItemType.SelfCard then
		slot0:_updateDecorateSelfCard()
	elseif slot8 == DecorateStoreEnum.DecorateItemType.BuildingVideo then
		slot0:_updateDecorateBuildingVideo()
	end

	slot0:_refreshCommonDetail()
end

function slot0._refreshCommonDetail(slot0)
	slot1 = DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId)
	slot0._txtdec.text = DecorateStoreConfig.instance:getDecorateConfig(slot1).typeName
	slot0._txttitle.text = GameUtil.setFirstStrSize(StoreModel.instance:getGoodsMO(slot1).config.name, tonumber(luaLang("DecorateStoreView_txttitle_setFirstStrSize")) or 100)

	if DecorateStoreModel.instance:isDecorateGoodItemHas(slot1) then
		gohelper.setActive(slot0._goowned, true)
		gohelper.setActive(slot0._btnbuy.gameObject, false)

		return
	end

	if slot2.config.maxBuyCount > 0 and slot2.config.maxBuyCount <= slot2.buyCount then
		gohelper.setActive(slot0._goowned, true)
		gohelper.setActive(slot0._btnbuy.gameObject, false)

		return
	end

	gohelper.setActive(slot0._goowned, false)
	gohelper.setActive(slot0._btnbuy.gameObject, true)

	if (slot3.offTag > 0 and slot3.offTag or 100) > 0 and slot5 < 100 then
		gohelper.setActive(slot0._godiscount, true)

		slot0._txtdiscount.text = string.format("-%s%%", slot5)
	else
		gohelper.setActive(slot0._godiscount, false)
	end

	if (DecorateStoreModel.instance:getGoodItemLimitTime(slot1) > 0 and DecorateStoreModel.instance:getGoodDiscount(slot1) or 100) == 0 then
		slot7 = 100
	end

	if slot7 > 0 and slot7 < 100 then
		gohelper.setActive(slot0._godiscount, false)
		gohelper.setActive(slot0._godiscount2, true)

		slot0._txtdiscount2.text = string.format("-%s%%", slot7)
	else
		gohelper.setActive(slot0._godiscount2, false)
	end

	if not slot2.config.cost or slot2.config.cost == "" then
		gohelper.setActive(slot0._gosingle, false)
		gohelper.setActive(slot0._godouble, false)
		gohelper.setActive(slot0._gofree, true)

		return
	end

	gohelper.setActive(slot0._gofree, false)

	slot9 = string.splitToNumber(slot2.config.cost, "#")

	if slot2.config.cost2 ~= "" then
		gohelper.setActive(slot0._gosingle, false)
		gohelper.setActive(slot0._godouble, true)

		slot0._txtcurprice1.text = 0.01 * slot7 * slot9[3]

		if slot3.originalCost1 > 0 then
			gohelper.setActive(slot0._txtoriginalprice1.gameObject, true)

			slot0._txtoriginalprice1.text = slot3.originalCost1
		else
			gohelper.setActive(slot0._txtoriginalprice1.gameObject, false)
		end

		slot10, slot11 = ItemModel.instance:getItemConfigAndIcon(slot9[1], slot9[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagedoubleicon1, slot10.icon .. "_1", true)

		slot0._txtcurprice2.text = 0.01 * slot7 * string.splitToNumber(slot2.config.cost2, "#")[3]

		if slot3.originalCost2 > 0 then
			gohelper.setActive(slot0._txtoriginalprice2.gameObject, true)

			slot0._txtoriginalprice2.text = slot3.originalCost2
		else
			gohelper.setActive(slot0._txtoriginalprice2.gameObject, false)
		end

		slot13, slot14 = ItemModel.instance:getItemConfigAndIcon(slot12[1], slot12[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagedoubleicon2, slot13.icon .. "_1", true)
	else
		gohelper.setActive(slot0._gosingle, true)
		gohelper.setActive(slot0._godouble, false)

		slot0._txtcurprice.text = 0.01 * slot7 * slot9[3]

		if slot3.originalCost1 > 0 then
			gohelper.setActive(slot0._txtoriginalprice.gameObject, true)

			slot0._txtoriginalprice.text = slot3.originalCost1
		else
			gohelper.setActive(slot0._txtoriginalprice.gameObject, false)
		end

		slot10, slot11 = ItemModel.instance:getItemConfigAndIcon(slot9[1], slot9[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagesingleicon, slot10.icon .. "_1", true)
	end
end

function slot0._hideDecorateDefault(slot0)
	gohelper.setActive(slot0._gotypebg1, false)
	gohelper.setActive(slot0._gotypebg7, false)
end

function slot0._updateDecorateDefault(slot0)
	if slot0:_checkEffectBigImg(DecorateStoreConfig.instance:getDecorateConfig(DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId))) then
		slot0._simagetypebg7:LoadImage(ResUrl.getDecorateStoreImg(slot2.biglmg))
		gohelper.setActive(slot0._gotypebg1, false)
		gohelper.setActive(slot0._gotypebg7, true)

		return
	end

	gohelper.setActive(slot0._gotypebg7, false)
	gohelper.setActive(slot0._gotypebg1, true)
	slot0._simagetypebg1:LoadImage(ResUrl.getDecorateStoreImg(slot2.biglmg))
end

function slot0._checkEffectBigImg(slot0, slot1)
	slot1 = slot1 or DecorateStoreConfig.instance:getDecorateConfig(DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId))

	return slot1 and slot1.effectbiglmg == 1
end

function slot0._hideDecorateSkin(slot0)
	gohelper.setActive(slot0._gotype2, false)
	gohelper.setActive(slot0._btnswitch.gameObject, false)
	gohelper.setActive(slot0._godynamiccontainer, false)
	gohelper.setActive(slot0._gotypebg2, false)
	gohelper.setActive(slot0._gotype2, false)
end

function slot0._updateDecorateSkin(slot0)
	gohelper.setActive(slot0._btnswitch.gameObject, true)
	gohelper.setActive(slot0._godynamiccontainer, true)
	gohelper.setActive(slot0._gotypebg2, true)
	gohelper.setActive(slot0._gotype2, true)

	slot0._skinCo = SkinConfig.instance:getSkinCo(string.splitToNumber(StoreModel.instance:getGoodsMO(DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId)).config.product, "#")[2])
	slot4 = lua_character.configDict[slot0._skinCo.characterId]
	slot0._txtrolename.text = slot4.name

	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot4.signature))
	slot0:_refreshSmallSpine()
	slot0:_refreshBigSkin()
end

function slot0._refreshBigSkin(slot0)
	if not string.nilorempty(slot0._skinCo.live2dbg) then
		gohelper.setActive(slot0._simagel2d.gameObject, slot0._showLive2d)
		gohelper.setActive(slot0._gozs, slot0._showLive2d)
		slot0._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(slot0._skinCo.live2dbg))
	else
		gohelper.setActive(slot0._simagel2d.gameObject, false)
		gohelper.setActive(slot0._gozs, false)
	end

	if slot0._showLive2d then
		if slot0._uiSpine then
			TaskDispatcher.cancelTask(slot0._playSpineVoice, slot0)
			slot0._uiSpine:onDestroy()
			slot0._uiSpine:stopVoice()

			slot0._uiSpine = nil
		end

		gohelper.setActive(slot0._gobigspine, true)

		slot0._uiSpine = GuiModelAgent.Create(slot0._gobigspine, true)

		slot0._uiSpine:setResPath(slot0._skinCo, slot0._onUISpineLoaded, slot0)

		if not string.nilorempty(slot0._skinCo.live2d) then
			slot0._uiSpine:setLive2dCameraLoadedCallback(slot0._live2DCameraLoaded, slot0)
		end

		slot0._txtswitch.text = luaLang("storeskinpreviewview_btnswitch")
	else
		gohelper.setActive(slot0._gobigspine, false)
		gohelper.setActive(slot0._simageskin.gameObject, true)
		slot0._simageskin:LoadImage(ResUrl.getHeadIconImg(slot0._skinCo.id), slot0._loadedImage, slot0)

		slot0._txtswitch.text = "L2D"
	end
end

function slot0._loadedImage(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simageskin.gameObject)

	if not string.nilorempty(slot0._skinCo.skinViewImgOffset) then
		slot2 = string.splitToNumber(slot1, "#")

		recthelper.setAnchor(slot0._simageskin.transform, tonumber(slot2[1]), tonumber(slot2[2]))
		transformhelper.setLocalScale(slot0._simageskin.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
	else
		recthelper.setAnchor(slot0._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(slot0._simageskin.transform, 0.6, 0.6, 0.6)
	end

	if slot0._adjust then
		return
	end

	recthelper.setAnchor(slot0._goskincontainer.transform, string.splitToNumber(DecorateStoreConfig.instance:getDecorateConfig(DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId)).decorateskinOffset, "#")[1] or 0, slot4[2] or 0)
	transformhelper.setLocalScale(slot0._goskincontainer.transform, slot4[3] or 1, slot4[3] or 1, slot4[3] or 1)
end

function slot0._live2DCameraLoaded(slot0)
	gohelper.setAsFirstSibling(slot0._simagel2d.gameObject)
end

function slot0._onUISpineLoaded(slot0)
	gohelper.setActive(slot0._simageskin.gameObject, false)
	ZProj.UGUIHelper.SetImageSize(slot0._simageskin.gameObject)
	slot0._uiSpine:setAllLayer(UnityLayer.SceneEffect)

	if string.nilorempty(slot0._skinCo.skinViewLive2dOffset) then
		slot1 = slot0._skinCo.characterViewOffset
	end

	slot2 = SkinConfig.instance:getSkinOffset(slot1)

	recthelper.setAnchor(slot0._gobigspine.transform, tonumber(slot2[1]), tonumber(slot2[2]))
	transformhelper.setLocalScale(slot0._gobigspine.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))

	if slot0._adjust then
		return
	end

	recthelper.setAnchor(slot0._goskincontainer.transform, string.splitToNumber(DecorateStoreConfig.instance:getDecorateConfig(DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId)).decorateskinl2dOffset, "#")[1] or 0, slot5[2] or 0)
	transformhelper.setLocalScale(slot0._goskincontainer.transform, slot5[3] or 1, slot5[3] or 1, slot5[3] or 1)
end

function slot0._refreshSmallSpine(slot0)
	if not slot0._smallSpine then
		slot0._smallSpine = GuiSpine.Create(slot0._gosmallspine, false)
	end

	slot0._smallSpine:stopVoice()
	slot0._smallSpine:setResPath(ResUrl.getSpineUIPrefab(slot0._skinCo.spine), nil, , true)

	slot1 = SkinConfig.instance:getSkinOffset(slot0._skinCo.skinSpineOffset)

	recthelper.setAnchor(slot0._gosmallspine.transform, tonumber(slot1[1]), tonumber(slot1[2]))
	transformhelper.setLocalScale(slot0._gosmallspine.transform, tonumber(slot1[3]), tonumber(slot1[3]), tonumber(slot1[3]))
end

function slot0._hideMainScene(slot0)
	if not slot0._needShowMainScene then
		return
	end

	slot0._needShowMainScene = false

	MainSceneSwitchCameraController.instance:hideScene()
	WeatherController.instance:onSceneShow()
	gohelper.setActive(slot0._gotype5, false)
	gohelper.setActive(slot0._rawImage, false)
	gohelper.setActive(slot0._gotypebg3, false)
end

function slot0._updateDecorateMainScene(slot0)
	slot0._sceneId = slot0:_getMainSceneId()

	if not slot0._sceneId then
		logError("DecorateStoreView:_updateDecorateMainScene sceneId is nil")

		return
	end

	gohelper.setActive(slot0._gotypebg3, false)

	slot0._needShowMainScene = true

	gohelper.setActive(slot0._rawImage, false)
	WeatherController.instance:onSceneHide()
	MainSceneSwitchCameraController.instance:showScene(slot0._sceneId, slot0._showSceneFinished, slot0)
end

function slot0._getMainSceneId(slot0)
	slot2 = DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId) and lua_store_goods.configDict[slot1]

	if not (slot2 and slot2.product) then
		return nil
	end

	for slot7, slot8 in ipairs(lua_scene_switch.configList) do
		if string.find(slot3, slot8.itemId) then
			return slot8.id
		end
	end

	return nil
end

function slot0._showSceneFinished(slot0, slot1)
	gohelper.setActive(slot0._gotype5, true)

	if not slot0._weatherSwitchControlComp then
		slot0._weatherSwitchControlComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gotype5, WeatherSwitchControlComp)
		slot0._rawImage = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "Bg/typebg/#go_typebg3/mainscenebg"), gohelper.Type_RawImage)
	end

	gohelper.setActive(slot0._rawImage, true)
	gohelper.setActive(slot0._gotypebg3, true)
	MainSceneSwitchInfoDisplayView.adjustRt(slot0._rawImage, slot1)
	slot0._weatherSwitchControlComp:updateScene(slot0._sceneId, MainSceneSwitchCameraDisplayController.instance)
end

function slot0._hideDecorateSelfCard(slot0)
	gohelper.setActive(slot0._gotypebg5, false)

	if slot0._viewGo then
		gohelper.destroy(slot0._viewGo)

		slot0._viewGo = nil
	end

	if slot0._viewCls then
		slot0._viewCls:onCloseInternal()

		slot0._viewCls = nil
	end

	if slot0._cardLoader then
		slot0._cardLoader:dispose()

		slot0._cardLoader = nil
	end
end

function slot0._updateDecorateSelfCard(slot0)
	slot0._cardPath = string.format("ui/viewres/player/playercard/%s.prefab", string.format("playercardview_%s", string.splitToNumber(StoreModel.instance:getGoodsMO(DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId)).config.product, "#")[2]))
	slot0._cardLoader = MultiAbLoader.New()

	slot0._cardLoader:addPath(slot0._cardPath)
	slot0._cardLoader:startLoad(slot0._onCardLoadFinish, slot0)
end

function slot0._onCardLoadFinish(slot0)
	gohelper.setActive(slot0._gotypebg5, true)

	slot0._viewGo = slot0._viewGo or gohelper.clone(slot0._cardLoader:getAssetItem(slot0._cardPath):GetResource(slot0._cardPath), slot0._gotypebg5)
	slot0._viewCls = slot0._viewCls or MonoHelper.addNoUpdateLuaComOnceToGo(slot0._viewGo, StorePlayerCardView)
	slot0._viewCls.viewParam = {
		userId = PlayerModel.instance:getPlayinfo().userId
	}
	slot0._viewCls.viewContainer = slot0.viewContainer

	slot0._viewCls:onOpen(string.splitToNumber(StoreModel.instance:getGoodsMO(DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId)).config.product, "#")[2])
	slot0._viewCls:backBottomView()
end

function slot0._hideDecorateBuildingVideo(slot0)
	gohelper.setActive(slot0._gotypebg6, false)

	if slot0._videoPlayer then
		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end
end

function slot0._updateDecorateBuildingVideo(slot0)
	gohelper.setActive(slot0._gotypebg6, true)

	if not slot0._videoPlayer then
		slot0._videoPlayer, slot0._displauUGUI = AvProMgr.instance:getVideoPlayer(gohelper.findChild(slot0._gotypebg6, "#go_video"))
	end

	slot0._videoPlayer:Play(slot0._displauUGUI, langVideoUrl(DecorateStoreConfig.instance:getDecorateConfig(DecorateStoreModel.instance:getCurGood(slot0._selectSecondTabId)).video), true, nil, )
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("decorateswitch")
	UIBlockMgr.instance:endBlock("decoratehide")
	TaskDispatcher.cancelTask(slot0._switchTabRefresh, slot0)
	TaskDispatcher.cancelTask(slot0._startDefaultShowView, slot0)
	TaskDispatcher.cancelTask(slot0._startGoodIn, slot0)
	slot0:_removeEvents()
	slot0:_hideMainScene()
end

function slot0.onDestroyView(slot0)
	MainSceneSwitchCameraController.instance:clear()

	if slot0._goodItems then
		for slot4, slot5 in pairs(slot0._goodItems) do
			for slot9, slot10 in pairs(slot5) do
				for slot14, slot15 in pairs(slot10) do
					slot15:destroy()
				end
			end
		end

		slot0._goodItems = nil
	end

	if slot0._categoryItemContainer and #slot0._categoryItemContainer > 0 then
		for slot4 = 1, #slot0._categoryItemContainer do
			slot0._categoryItemContainer[slot4].btn:RemoveClickListener()
		end

		slot0._categoryItemContainer = nil
	end
end

return slot0
