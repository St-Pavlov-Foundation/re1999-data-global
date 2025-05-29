module("modules.logic.store.view.DecorateStoreView", package.seeall)

local var_0_0 = class("DecorateStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "Bg")
	arg_1_0._gotypebg = gohelper.findChild(arg_1_0.viewGO, "Bg/typebg")
	arg_1_0._gotypebg1 = gohelper.findChild(arg_1_0.viewGO, "Bg/typebg/#go_typebg1")
	arg_1_0._simagetypebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Bg/typebg/#go_typebg1/#simage_icon")
	arg_1_0._gotypebg2 = gohelper.findChild(arg_1_0.viewGO, "Bg/typebg/#go_typebg2")
	arg_1_0._gotypebg3 = gohelper.findChild(arg_1_0.viewGO, "Bg/typebg/#go_typebg3")
	arg_1_0._gotypebg5 = gohelper.findChild(arg_1_0.viewGO, "Bg/typebg/#go_typebg5")
	arg_1_0._gotypebg6 = gohelper.findChild(arg_1_0.viewGO, "Bg/typebg/#go_typebg6")
	arg_1_0._gotypebg7 = gohelper.findChild(arg_1_0.viewGO, "Bg/typebg/#go_typebg7")
	arg_1_0._simagetypebg7 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Bg/typebg/#go_typebg7/#simage_icon")
	arg_1_0._gozs = gohelper.findChild(arg_1_0.viewGO, "Bg/typebg/#go_typebg2/zs")
	arg_1_0._goskincontainer = gohelper.findChild(arg_1_0.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer")
	arg_1_0._simageskin = gohelper.findChildSingleImage(arg_1_0.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#simage_skin")
	arg_1_0._simagel2d = gohelper.findChildSingleImage(arg_1_0.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#go_spinecontainer/#simage_l2d")
	arg_1_0._gobigspine = gohelper.findChild(arg_1_0.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	arg_1_0._gospinecontainer = gohelper.findChild(arg_1_0.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#go_spinecontainer")
	arg_1_0._goview1 = gohelper.findChild(arg_1_0.viewGO, "UI/#go_view1")
	arg_1_0._goContent1 = gohelper.findChild(arg_1_0.viewGO, "UI/#go_view1/Viewport/#go_Content1")
	arg_1_0._btnunfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/#go_view1/#btn_unfold")
	arg_1_0._goview2 = gohelper.findChild(arg_1_0.viewGO, "UI/#go_view2")
	arg_1_0._goContent2 = gohelper.findChild(arg_1_0.viewGO, "UI/#go_view2/Viewport/#go_Content2")
	arg_1_0._btnfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/#go_view2/#btn_fold")
	arg_1_0._gocommon = gohelper.findChild(arg_1_0.viewGO, "UI/common")
	arg_1_0._gohideclick = gohelper.findChild(arg_1_0.viewGO, "UI/common/#btn_hide/#go_hideclick")
	arg_1_0._goowned = gohelper.findChild(arg_1_0.viewGO, "UI/common/#go_owned")
	arg_1_0._btnhide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/common/layout/#btn_hide")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/common/layout/#btn_switch")
	arg_1_0._txtswitch = gohelper.findChildText(arg_1_0.viewGO, "UI/common/layout/#btn_switch/#txt_switch")
	arg_1_0._godynamiccontainer = gohelper.findChild(arg_1_0.viewGO, "UI/common/layout/smalldynamiccontainer")
	arg_1_0._gosmallspine = gohelper.findChild(arg_1_0.viewGO, "UI/common/layout/smalldynamiccontainer/#go_smallspine")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "UI/common/#btn_buy")
	arg_1_0._godiscount = gohelper.findChild(arg_1_0.viewGO, "UI/common/#btn_buy/#go_discount")
	arg_1_0._txtdiscount = gohelper.findChildText(arg_1_0.viewGO, "UI/common/#btn_buy/#go_discount/#txt_discount")
	arg_1_0._godiscount2 = gohelper.findChild(arg_1_0.viewGO, "UI/common/#btn_buy/#go_discount2")
	arg_1_0._txtdiscount2 = gohelper.findChildText(arg_1_0.viewGO, "UI/common/#btn_buy/#go_discount2/#txt_discount")
	arg_1_0._gosingle = gohelper.findChild(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_single")
	arg_1_0._imagesingleicon = gohelper.findChildImage(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_single/icon/simage_material")
	arg_1_0._txtcurprice = gohelper.findChildText(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_single/txt_materialNum")
	arg_1_0._txtoriginalprice = gohelper.findChildText(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_single/#txt_original_price")
	arg_1_0._godouble = gohelper.findChild(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice")
	arg_1_0._imagedoubleicon1 = gohelper.findChildImage(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency1/simage_material")
	arg_1_0._txtcurprice1 = gohelper.findChildText(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency1/txt_materialNum")
	arg_1_0._txtoriginalprice1 = gohelper.findChildText(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency1/#txt_original_price1")
	arg_1_0._imagedoubleicon2 = gohelper.findChildImage(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency2/simage_material")
	arg_1_0._txtcurprice2 = gohelper.findChildText(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency2/txt_materialNum")
	arg_1_0._txtoriginalprice2 = gohelper.findChildText(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency2/#txt_original_price1")
	arg_1_0._gofree = gohelper.findChild(arg_1_0.viewGO, "UI/common/#btn_buy/cost/#go_free")
	arg_1_0._gocostclick = gohelper.findChild(arg_1_0.viewGO, "UI/common/#btn_buy/#go_costclick")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "UI/common/#txt_dec")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "UI/common/title/#txt_title")
	arg_1_0._godiscounttip = gohelper.findChild(arg_1_0.viewGO, "UI/common/#go_discountTips")
	arg_1_0._txtdiscounttip = gohelper.findChildText(arg_1_0.viewGO, "UI/common/#go_discountTips/#txt_discountTips")
	arg_1_0._gotype = gohelper.findChild(arg_1_0.viewGO, "UI/type")
	arg_1_0._gotype2 = gohelper.findChild(arg_1_0.viewGO, "UI/type/type2")
	arg_1_0._txtrolename = gohelper.findChildText(arg_1_0.viewGO, "UI/type/type2/#txt_rolename")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "UI/type/type2/#simage_signature")
	arg_1_0._gotype4 = gohelper.findChild(arg_1_0.viewGO, "UI/type/type4")
	arg_1_0._gotype5 = gohelper.findChild(arg_1_0.viewGO, "UI/type/type5")
	arg_1_0._gostorecategoryitem = gohelper.findChild(arg_1_0.viewGO, "UI/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "UI/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_line")
	arg_1_0._gotabreddot1 = gohelper.findChild(arg_1_0.viewGO, "UI/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_tabreddot1")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnunfold:AddClickListener(arg_2_0._btnunfoldOnClick, arg_2_0)
	arg_2_0._btnfold:AddClickListener(arg_2_0._btnfoldOnClick, arg_2_0)
	arg_2_0._btnhide:AddClickListener(arg_2_0._btnhideOnClick, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnunfold:RemoveClickListener()
	arg_3_0._btnfold:RemoveClickListener()
	arg_3_0._btnhide:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
end

function var_0_0._btnunfoldOnClick(arg_4_0)
	arg_4_0._viewAnim.enabled = true

	arg_4_0._viewAnim:Play("goview2", 0, 0)
	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.UnFold)
	arg_4_0:_refreshGood(true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function var_0_0._btnfoldOnClick(arg_5_0)
	arg_5_0._viewAnim.enabled = true

	arg_5_0._viewAnim:Play("goview1", 0, 0)
	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.Fold)
	arg_5_0:_refreshGood()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function var_0_0._btnhideOnClick(arg_6_0)
	arg_6_0._viewAnim:Play("hide", 0, 0)
	StoreController.instance:dispatchEvent(StoreEvent.PlayHideStoreAnim)
	UIBlockMgr.instance:startBlock("decoratehide")
	TaskDispatcher.runDelay(arg_6_0._startDefaultShowView, arg_6_0, 0.34)
end

function var_0_0._startDefaultShowView(arg_7_0)
	UIBlockMgr.instance:endBlock("decoratehide")

	arg_7_0._viewAnim.enabled = false

	if DecorateStoreModel.getItemType(arg_7_0._selectSecondTabId) == DecorateStoreEnum.DecorateItemType.MainScene then
		local var_7_0 = {
			sceneId = arg_7_0._sceneId,
			callback = arg_7_0._showHideCallback,
			callbackObj = arg_7_0
		}

		ViewMgr.instance:openView(ViewName.MainSceneStoreShowView, var_7_0)
	else
		local var_7_1 = {
			bg = gohelper.findChild(arg_7_0.viewGO.transform.parent.gameObject, "bg"),
			contentBg = arg_7_0._gotypebg,
			callback = arg_7_0._showHideCallback,
			callbackObj = arg_7_0,
			viewCls = arg_7_0._viewCls
		}

		ViewMgr.instance:openView(ViewName.DecorateStoreDefaultShowView, var_7_1)
	end
end

function var_0_0._showHideCallback(arg_8_0, arg_8_1)
	arg_8_0._viewAnim.enabled = true

	arg_8_0._viewAnim:Play("show", 0, 0)

	if DecorateStoreModel.getItemType(arg_8_0._selectSecondTabId) == DecorateStoreEnum.DecorateItemType.MainScene then
		-- block empty
	else
		arg_8_1.bg.transform:SetParent(arg_8_0.viewGO.transform.parent, false)
		gohelper.setAsFirstSibling(arg_8_1.bg)
		arg_8_1.contentBg.transform:SetParent(arg_8_0._gobg.transform, false)
		gohelper.setAsFirstSibling(arg_8_1.contentBg)
	end

	StoreController.instance:dispatchEvent(StoreEvent.PlayShowStoreAnim)
end

function var_0_0._btnswitchOnClick(arg_9_0)
	arg_9_0._showLive2d = not arg_9_0._showLive2d

	arg_9_0:_refreshBigSkin()
end

function var_0_0._btnbuyOnClick(arg_10_0)
	local var_10_0 = DecorateStoreModel.instance:getCurGood(arg_10_0._selectSecondTabId)
	local var_10_1 = StoreModel.instance:getGoodsMO(var_10_0)

	StoreController.instance:openDecorateStoreGoodsView(var_10_1)
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._goodItems = {}
	arg_11_0._categoryItemContainer = {}
	arg_11_0._viewAnim = arg_11_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_11_0._btnhide.gameObject, true)
	DecorateStoreModel.instance:initDecorateReadState()
end

function var_0_0._onCloseView(arg_12_0, arg_12_1)
	if (arg_12_1 == ViewName.MainSceneStoreShowView or arg_12_1 == ViewName.MainSceneSwitchInfoView) and arg_12_0._weatherSwitchControlComp then
		MainSceneSwitchCameraController.instance:showScene(arg_12_0._sceneId, arg_12_0._showSceneFinished, arg_12_0)
	end
end

function var_0_0._addEvents(arg_13_0)
	arg_13_0:addEventCb(StoreController.instance, StoreEvent.DecorateGoodItemClick, arg_13_0._onGoodItemClick, arg_13_0)
	arg_13_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_13_0._onGoodsChanged, arg_13_0)
	arg_13_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_13_0._onGoodsChanged, arg_13_0)
	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_13_0._onCloseView, arg_13_0)
end

function var_0_0._removeEvents(arg_14_0)
	arg_14_0:removeEventCb(StoreController.instance, StoreEvent.DecorateGoodItemClick, arg_14_0._onGoodItemClick, arg_14_0)
	arg_14_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_14_0._onGoodsChanged, arg_14_0)
	arg_14_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_14_0._onGoodsChanged, arg_14_0)
	arg_14_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_14_0._onCloseView, arg_14_0)
end

function var_0_0._onGoodItemClick(arg_15_0)
	arg_15_0._showLive2d = false

	local var_15_0 = DecorateStoreModel.instance:getCurViewType()

	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.Fold)

	if var_15_0 == DecorateStoreEnum.DecorateViewType.UnFold then
		local var_15_1 = DecorateStoreModel.instance:getCurGood(arg_15_0._selectSecondTabId)
		local var_15_2 = DecorateStoreModel.instance:getDecorateGoodIndex(arg_15_0._selectSecondTabId, var_15_1)
		local var_15_3 = #DecorateStoreModel.instance:getDecorateGoodList(arg_15_0._selectSecondTabId)
		local var_15_4 = 0

		if var_15_2 > 4 then
			if var_15_3 - var_15_2 >= 4 then
				var_15_4 = 55 - 360 * (var_15_2 - 4)
			else
				var_15_4 = -360 * (var_15_2 - 4)
			end
		end

		local var_15_5, var_15_6 = transformhelper.getLocalPos(arg_15_0._goContent1.transform)

		transformhelper.setLocalPos(arg_15_0._goContent1.transform, var_15_4, var_15_6, 0)
		arg_15_0:_startGoodIn()

		return
	end

	arg_15_0._viewAnim:Play("out", 0, 0)
	UIBlockMgr.instance:startBlock("decorateswitch")
	TaskDispatcher.runDelay(arg_15_0._startGoodIn, arg_15_0, 0.17)
end

function var_0_0._startGoodIn(arg_16_0)
	UIBlockMgr.instance:endBlock("decorateswitch")
	arg_16_0._viewAnim:Play("in", 0, 0)
	arg_16_0:_refreshGood(true)
end

function var_0_0._onGoodsChanged(arg_17_0)
	if #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.NewDecorateStore) <= 0 then
		return
	end

	arg_17_0:_onRefreshRedDot()
	arg_17_0:_refreshGood()
end

function var_0_0.onOpen(arg_18_0)
	Activity186Model.instance:checkReadTask(Activity186Enum.ReadTaskId.Task4)

	arg_18_0._opened = true

	arg_18_0:_addEvents()
	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.Fold)

	arg_18_0._selectFirstTabId = arg_18_0.viewContainer:getSelectFirstTabId()

	local var_18_0 = arg_18_0.viewContainer:getJumpTabId()

	arg_18_0:_refreshTabs(var_18_0, true, true)
end

function var_0_0.onUpdateParam(arg_19_0)
	arg_19_0._selectFirstTabId = arg_19_0.viewContainer:getSelectFirstTabId()

	local var_19_0 = arg_19_0.viewContainer:getJumpTabId()

	arg_19_0:_refreshTabs(var_19_0)
end

function var_0_0._refreshTabs(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0._selectSecondTabId

	arg_20_0._selectSecondTabId = 0

	if not StoreModel.instance:isTabOpen(arg_20_1) then
		arg_20_1 = arg_20_0.viewContainer:getSelectFirstTabId()
	end

	local var_20_1
	local var_20_2, var_20_3

	var_20_2, arg_20_0._selectSecondTabId, var_20_3 = StoreModel.instance:jumpTabIdToSelectTabId(arg_20_1)

	local var_20_4 = StoreConfig.instance:getTabConfig(arg_20_0._selectSecondTabId)
	local var_20_5 = StoreConfig.instance:getTabConfig(arg_20_0.viewContainer:getSelectFirstTabId())

	if var_20_4 and not string.nilorempty(var_20_4.showCost) then
		arg_20_0.viewContainer:setCurrencyType(var_20_4.showCost)
	elseif var_20_5 and not string.nilorempty(var_20_5.showCost) then
		arg_20_0.viewContainer:setCurrencyType(var_20_5.showCost)
	else
		arg_20_0.viewContainer:setCurrencyType(nil)
	end

	if not arg_20_2 and var_20_0 == arg_20_0._selectSecondTabId then
		return
	end

	arg_20_0:_refreshAllSecondTabs()
	StoreController.instance:readTab(arg_20_1)
	arg_20_0:_onRefreshRedDot()

	arg_20_0._resetScrollPos = true

	if arg_20_0._opened then
		var_20_0 = nil
		arg_20_0._opened = false
	end

	if var_20_0 and arg_20_0._goodItems[var_20_0] then
		arg_20_0._viewAnim:Play("out", 0, 0)

		for iter_20_0, iter_20_1 in pairs(arg_20_0._goodItems[var_20_0][DecorateStoreEnum.DecorateViewType.Fold]) do
			iter_20_1:playOut()
		end

		UIBlockMgr.instance:startBlock("decorateswitch")
		TaskDispatcher.runDelay(arg_20_0._switchTabRefresh, arg_20_0, 0.17)
	else
		arg_20_0._viewAnim:Play("in", 0, 0)
		arg_20_0:_refreshGood()
	end
end

function var_0_0._switchTabRefresh(arg_21_0)
	UIBlockMgr.instance:endBlock("decorateswitch")

	local var_21_0, var_21_1 = transformhelper.getLocalPos(arg_21_0._goContent1.transform)

	transformhelper.setLocalPos(arg_21_0._goContent1.transform, 0, var_21_1, 0)
	arg_21_0._viewAnim:Play("in", 0, 0)
	arg_21_0:_refreshGood()
end

function var_0_0._refreshAllSecondTabs(arg_22_0)
	local var_22_0 = StoreModel.instance:getSecondTabs(arg_22_0._selectFirstTabId, true, true)

	if var_22_0 and #var_22_0 > 0 then
		for iter_22_0 = 1, #var_22_0 do
			arg_22_0:_refreshSecondTabs(iter_22_0, var_22_0[iter_22_0])

			local var_22_1 = DecorateStoreModel.instance:getDecorateGoodList(var_22_0[iter_22_0].id)

			gohelper.setActive(arg_22_0._categoryItemContainer[iter_22_0].go, #var_22_1 > 0)
		end

		for iter_22_1 = #var_22_0 + 1, #arg_22_0._categoryItemContainer do
			gohelper.setActive(arg_22_0._categoryItemContainer[iter_22_1].go, false)
		end
	else
		for iter_22_2 = 1, #arg_22_0._categoryItemContainer do
			gohelper.setActive(arg_22_0._categoryItemContainer[iter_22_2].go, false)
		end
	end
end

function var_0_0._refreshSecondTabs(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0._categoryItemContainer[arg_23_1] or arg_23_0:initCategoryItemTable(arg_23_1)

	var_23_0.tabId = arg_23_2.id
	var_23_0.txt_itemcn1.text = arg_23_2.name
	var_23_0.txt_itemcn2.text = arg_23_2.name
	var_23_0.txt_itemen1.text = arg_23_2.nameEn
	var_23_0.txt_itemen2.text = arg_23_2.nameEn

	local var_23_1 = arg_23_0._selectSecondTabId == arg_23_2.id

	gohelper.setActive(var_23_0.go_unselected, not var_23_1)
	gohelper.setActive(var_23_0.go_selected, var_23_1)
end

function var_0_0.initCategoryItemTable(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getUserDataTb_()

	var_24_0.go = gohelper.cloneInPlace(arg_24_0._gostorecategoryitem, "item" .. arg_24_1)
	var_24_0.go_unselected = gohelper.findChild(var_24_0.go, "go_unselected")
	var_24_0.go_selected = gohelper.findChild(var_24_0.go, "go_selected")
	var_24_0.go_line = gohelper.findChild(var_24_0.go, "go_line")
	var_24_0.go_reddot = gohelper.findChild(var_24_0.go, "#go_tabreddot1")
	var_24_0.txt_itemcn1 = gohelper.findChildText(var_24_0.go, "go_unselected/txt_itemcn1")
	var_24_0.txt_itemen1 = gohelper.findChildText(var_24_0.go, "go_unselected/txt_itemen1")
	var_24_0.txt_itemcn2 = gohelper.findChildText(var_24_0.go, "go_selected/txt_itemcn2")
	var_24_0.txt_itemen2 = gohelper.findChildText(var_24_0.go, "go_selected/txt_itemen2")
	var_24_0.go_childcategory = gohelper.findChild(var_24_0.go, "go_childcategory")
	var_24_0.go_childItem = gohelper.findChild(var_24_0.go, "go_childcategory/go_childitem")
	var_24_0.childItemContainer = {}
	var_24_0.btnGO = gohelper.findChild(var_24_0.go, "clickArea")
	var_24_0.btn = gohelper.getClickWithAudio(var_24_0.go, AudioEnum.UI.play_ui_bank_open)
	var_24_0.tabId = 0

	var_24_0.btn:AddClickListener(function(arg_25_0)
		local var_25_0 = arg_25_0.tabId

		arg_24_0:_refreshTabs(var_25_0)
		StoreController.instance:statSwitchStore(var_25_0)
	end, var_24_0)
	table.insert(arg_24_0._categoryItemContainer, var_24_0)
	gohelper.setActive(var_24_0.go_childItem, false)

	return var_24_0
end

function var_0_0._onRefreshRedDot(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0._categoryItemContainer) do
		local var_26_0 = StoreModel.instance:isTabSecondRedDotShow(iter_26_1.tabId)

		gohelper.setActive(iter_26_1.go_reddot, var_26_0)
	end
end

function var_0_0._refreshGood(arg_27_0, arg_27_1)
	arg_27_0:_refreshGoodDetail()
	arg_27_0:_refreshGoodItems(arg_27_1)
end

function var_0_0._refreshGoodItems(arg_28_0, arg_28_1)
	local var_28_0 = DecorateStoreModel.instance:getDecorateGoodList(arg_28_0._selectSecondTabId)

	if not arg_28_0._goodItems[arg_28_0._selectSecondTabId] then
		arg_28_0._goodItems[arg_28_0._selectSecondTabId] = {}
		arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold] = {}
		arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold] = {}
	end

	for iter_28_0, iter_28_1 in pairs(arg_28_0._goodItems) do
		for iter_28_2, iter_28_3 in pairs(iter_28_1) do
			for iter_28_4, iter_28_5 in pairs(iter_28_3) do
				iter_28_5:hide()
			end
		end
	end

	for iter_28_6, iter_28_7 in ipairs(var_28_0) do
		if not arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][iter_28_7.goodsId] then
			local var_28_1 = arg_28_0.viewContainer:getSetting().otherRes[6]
			local var_28_2 = arg_28_0:getResInst(var_28_1, arg_28_0._goContent1, "good_" .. tostring(iter_28_7.goodsId))

			arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][iter_28_7.goodsId] = DecorateGoodsItem.New()

			arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][iter_28_7.goodsId]:init(var_28_2, iter_28_7)
		else
			arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][iter_28_7.goodsId]:reset(iter_28_7)
		end

		arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][iter_28_7.goodsId]:setFold(true)
		arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][iter_28_7.goodsId]:playIn(iter_28_6, arg_28_1)
		gohelper.setSibling(arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold][iter_28_7.goodsId].go, iter_28_6)

		if not arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][iter_28_7.goodsId] then
			local var_28_3 = arg_28_0.viewContainer:getSetting().otherRes[6]
			local var_28_4 = arg_28_0:getResInst(var_28_3, arg_28_0._goContent2, "good_" .. tostring(iter_28_7.goodsId))

			arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][iter_28_7.goodsId] = DecorateGoodsItem.New()

			arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][iter_28_7.goodsId]:init(var_28_4, iter_28_7)
		else
			arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][iter_28_7.goodsId]:reset(iter_28_7)
		end

		arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][iter_28_7.goodsId]:setFold(false)
		arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][iter_28_7.goodsId]:playIn(iter_28_6, arg_28_1)
		gohelper.setSibling(arg_28_0._goodItems[arg_28_0._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold][iter_28_7.goodsId].go, iter_28_6)
	end
end

function var_0_0._refreshGoodDetail(arg_29_0)
	local var_29_0 = DecorateStoreModel.instance:getCurGood(arg_29_0._selectSecondTabId)
	local var_29_1 = DecorateStoreModel.instance:getGoodDiscount(var_29_0)
	local var_29_2 = DecorateStoreModel.instance:getGoodItemLimitTime(var_29_0)
	local var_29_3 = DecorateStoreModel.instance:isDecorateGoodItemHas(var_29_0)
	local var_29_4 = var_29_1 > 0 and var_29_1 < 100 and var_29_2 > 0 and not var_29_3

	gohelper.setActive(arg_29_0._godiscounttip, var_29_4)

	if var_29_4 then
		local var_29_5 = TimeUtil.SecondToActivityTimeFormat(var_29_2)

		arg_29_0._txtdiscounttip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("decoratestore_discount_limittime"), {
			var_29_5
		})
	end

	DecorateStoreModel.instance:setGoodRead(var_29_0)

	local var_29_6 = DecorateStoreModel.instance:getCurViewType() == DecorateStoreEnum.DecorateViewType.Fold

	gohelper.setActive(arg_29_0._goview1, var_29_6)
	gohelper.setActive(arg_29_0._goview2, not var_29_6)
	gohelper.setActive(arg_29_0._gocommon, var_29_6)
	gohelper.setActive(arg_29_0._gotypebg3, false)

	local var_29_7 = DecorateStoreModel.getItemType(arg_29_0._selectSecondTabId)

	if var_29_7 ~= DecorateStoreEnum.DecorateItemType.Default and var_29_7 ~= DecorateStoreEnum.DecorateItemType.Icon then
		arg_29_0:_hideDecorateDefault()
	end

	if var_29_7 ~= DecorateStoreEnum.DecorateItemType.MainScene then
		arg_29_0:_hideMainScene()
	end

	if var_29_7 ~= DecorateStoreEnum.DecorateItemType.Skin or not arg_29_0._showLive2d then
		arg_29_0:_hideDecorateSkin()
	end

	if var_29_7 ~= DecorateStoreEnum.DecorateItemType.SelfCard then
		arg_29_0:_hideDecorateSelfCard()
	end

	if var_29_7 ~= DecorateStoreEnum.DecorateItemType.BuildingVideo then
		arg_29_0:_hideDecorateBuildingVideo()
	end

	if var_29_7 == DecorateStoreEnum.DecorateItemType.Default or var_29_7 == DecorateStoreEnum.DecorateItemType.Icon then
		arg_29_0:_updateDecorateDefault()
	elseif var_29_7 == DecorateStoreEnum.DecorateItemType.Skin then
		arg_29_0:_updateDecorateSkin()
	elseif var_29_7 == DecorateStoreEnum.DecorateItemType.MainScene then
		arg_29_0:_updateDecorateMainScene()
	elseif var_29_7 == DecorateStoreEnum.DecorateItemType.SelfCard then
		arg_29_0:_updateDecorateSelfCard()
	elseif var_29_7 == DecorateStoreEnum.DecorateItemType.BuildingVideo then
		arg_29_0:_updateDecorateBuildingVideo()
	end

	arg_29_0:_refreshCommonDetail()
end

function var_0_0._refreshCommonDetail(arg_30_0)
	local var_30_0 = DecorateStoreModel.instance:getCurGood(arg_30_0._selectSecondTabId)
	local var_30_1 = StoreModel.instance:getGoodsMO(var_30_0)
	local var_30_2 = DecorateStoreConfig.instance:getDecorateConfig(var_30_0)

	arg_30_0._txtdec.text = var_30_2.typeName
	arg_30_0._txttitle.text = GameUtil.setFirstStrSize(var_30_1.config.name, tonumber(luaLang("DecorateStoreView_txttitle_setFirstStrSize")) or 100)

	if DecorateStoreModel.instance:isDecorateGoodItemHas(var_30_0) then
		gohelper.setActive(arg_30_0._goowned, true)
		gohelper.setActive(arg_30_0._btnbuy.gameObject, false)

		return
	end

	if var_30_1.config.maxBuyCount > 0 and var_30_1.buyCount >= var_30_1.config.maxBuyCount then
		gohelper.setActive(arg_30_0._goowned, true)
		gohelper.setActive(arg_30_0._btnbuy.gameObject, false)

		return
	end

	gohelper.setActive(arg_30_0._goowned, false)
	gohelper.setActive(arg_30_0._btnbuy.gameObject, true)

	local var_30_3 = var_30_2.offTag > 0 and var_30_2.offTag or 100

	if var_30_3 > 0 and var_30_3 < 100 then
		gohelper.setActive(arg_30_0._godiscount, true)

		arg_30_0._txtdiscount.text = string.format("-%s%%", var_30_3)
	else
		gohelper.setActive(arg_30_0._godiscount, false)
	end

	local var_30_4 = DecorateStoreModel.instance:getGoodItemLimitTime(var_30_0) > 0 and DecorateStoreModel.instance:getGoodDiscount(var_30_0) or 100

	var_30_4 = var_30_4 == 0 and 100 or var_30_4

	if var_30_4 > 0 and var_30_4 < 100 then
		gohelper.setActive(arg_30_0._godiscount, false)
		gohelper.setActive(arg_30_0._godiscount2, true)

		arg_30_0._txtdiscount2.text = string.format("-%s%%", var_30_4)
	else
		gohelper.setActive(arg_30_0._godiscount2, false)
	end

	if not var_30_1.config.cost or var_30_1.config.cost == "" then
		gohelper.setActive(arg_30_0._gosingle, false)
		gohelper.setActive(arg_30_0._godouble, false)
		gohelper.setActive(arg_30_0._gofree, true)

		return
	end

	gohelper.setActive(arg_30_0._gofree, false)

	local var_30_5 = string.splitToNumber(var_30_1.config.cost, "#")

	if var_30_1.config.cost2 ~= "" then
		gohelper.setActive(arg_30_0._gosingle, false)
		gohelper.setActive(arg_30_0._godouble, true)

		arg_30_0._txtcurprice1.text = 0.01 * var_30_4 * var_30_5[3]

		if var_30_2.originalCost1 > 0 then
			gohelper.setActive(arg_30_0._txtoriginalprice1.gameObject, true)

			arg_30_0._txtoriginalprice1.text = var_30_2.originalCost1
		else
			gohelper.setActive(arg_30_0._txtoriginalprice1.gameObject, false)
		end

		local var_30_6, var_30_7 = ItemModel.instance:getItemConfigAndIcon(var_30_5[1], var_30_5[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_30_0._imagedoubleicon1, var_30_6.icon .. "_1", true)

		local var_30_8 = string.splitToNumber(var_30_1.config.cost2, "#")

		arg_30_0._txtcurprice2.text = 0.01 * var_30_4 * var_30_8[3]

		if var_30_2.originalCost2 > 0 then
			gohelper.setActive(arg_30_0._txtoriginalprice2.gameObject, true)

			arg_30_0._txtoriginalprice2.text = var_30_2.originalCost2
		else
			gohelper.setActive(arg_30_0._txtoriginalprice2.gameObject, false)
		end

		local var_30_9, var_30_10 = ItemModel.instance:getItemConfigAndIcon(var_30_8[1], var_30_8[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_30_0._imagedoubleicon2, var_30_9.icon .. "_1", true)
	else
		gohelper.setActive(arg_30_0._gosingle, true)
		gohelper.setActive(arg_30_0._godouble, false)

		arg_30_0._txtcurprice.text = 0.01 * var_30_4 * var_30_5[3]

		if var_30_2.originalCost1 > 0 then
			gohelper.setActive(arg_30_0._txtoriginalprice.gameObject, true)

			arg_30_0._txtoriginalprice.text = var_30_2.originalCost1
		else
			gohelper.setActive(arg_30_0._txtoriginalprice.gameObject, false)
		end

		local var_30_11, var_30_12 = ItemModel.instance:getItemConfigAndIcon(var_30_5[1], var_30_5[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_30_0._imagesingleicon, var_30_11.icon .. "_1", true)
	end
end

function var_0_0._hideDecorateDefault(arg_31_0)
	gohelper.setActive(arg_31_0._gotypebg1, false)
	gohelper.setActive(arg_31_0._gotypebg7, false)
end

function var_0_0._updateDecorateDefault(arg_32_0)
	local var_32_0 = DecorateStoreModel.instance:getCurGood(arg_32_0._selectSecondTabId)
	local var_32_1 = DecorateStoreConfig.instance:getDecorateConfig(var_32_0)

	if arg_32_0:_checkEffectBigImg(var_32_1) then
		arg_32_0._simagetypebg7:LoadImage(ResUrl.getDecorateStoreImg(var_32_1.biglmg))
		gohelper.setActive(arg_32_0._gotypebg1, false)
		gohelper.setActive(arg_32_0._gotypebg7, true)

		return
	end

	gohelper.setActive(arg_32_0._gotypebg7, false)
	gohelper.setActive(arg_32_0._gotypebg1, true)
	arg_32_0._simagetypebg1:LoadImage(ResUrl.getDecorateStoreImg(var_32_1.biglmg))
end

function var_0_0._checkEffectBigImg(arg_33_0, arg_33_1)
	if not arg_33_1 then
		local var_33_0 = DecorateStoreModel.instance:getCurGood(arg_33_0._selectSecondTabId)

		arg_33_1 = DecorateStoreConfig.instance:getDecorateConfig(var_33_0)
	end

	return arg_33_1 and arg_33_1.effectbiglmg == 1
end

function var_0_0._hideDecorateSkin(arg_34_0)
	gohelper.setActive(arg_34_0._gotype2, false)
	gohelper.setActive(arg_34_0._btnswitch.gameObject, false)
	gohelper.setActive(arg_34_0._godynamiccontainer, false)
	gohelper.setActive(arg_34_0._gotypebg2, false)
	gohelper.setActive(arg_34_0._gotype2, false)
end

function var_0_0._updateDecorateSkin(arg_35_0)
	gohelper.setActive(arg_35_0._btnswitch.gameObject, true)
	gohelper.setActive(arg_35_0._godynamiccontainer, true)
	gohelper.setActive(arg_35_0._gotypebg2, true)
	gohelper.setActive(arg_35_0._gotype2, true)

	local var_35_0 = DecorateStoreModel.instance:getCurGood(arg_35_0._selectSecondTabId)
	local var_35_1 = StoreModel.instance:getGoodsMO(var_35_0)
	local var_35_2 = string.splitToNumber(var_35_1.config.product, "#")

	arg_35_0._skinCo = SkinConfig.instance:getSkinCo(var_35_2[2])

	local var_35_3 = lua_character.configDict[arg_35_0._skinCo.characterId]

	arg_35_0._txtrolename.text = var_35_3.name

	arg_35_0._simagesignature:LoadImage(ResUrl.getSignature(var_35_3.signature))
	arg_35_0:_refreshSmallSpine()
	arg_35_0:_refreshBigSkin()
end

function var_0_0._refreshBigSkin(arg_36_0)
	if not string.nilorempty(arg_36_0._skinCo.live2dbg) then
		gohelper.setActive(arg_36_0._simagel2d.gameObject, arg_36_0._showLive2d)
		gohelper.setActive(arg_36_0._gozs, arg_36_0._showLive2d)
		arg_36_0._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(arg_36_0._skinCo.live2dbg))
	else
		gohelper.setActive(arg_36_0._simagel2d.gameObject, false)
		gohelper.setActive(arg_36_0._gozs, false)
	end

	if arg_36_0._showLive2d then
		if arg_36_0._uiSpine then
			TaskDispatcher.cancelTask(arg_36_0._playSpineVoice, arg_36_0)
			arg_36_0._uiSpine:onDestroy()
			arg_36_0._uiSpine:stopVoice()

			arg_36_0._uiSpine = nil
		end

		gohelper.setActive(arg_36_0._gobigspine, true)

		arg_36_0._uiSpine = GuiModelAgent.Create(arg_36_0._gobigspine, true)

		arg_36_0._uiSpine:setResPath(arg_36_0._skinCo, arg_36_0._onUISpineLoaded, arg_36_0)

		if not string.nilorempty(arg_36_0._skinCo.live2d) then
			arg_36_0._uiSpine:setLive2dCameraLoadedCallback(arg_36_0._live2DCameraLoaded, arg_36_0)
		end

		arg_36_0._txtswitch.text = luaLang("storeskinpreviewview_btnswitch")
	else
		gohelper.setActive(arg_36_0._gobigspine, false)
		gohelper.setActive(arg_36_0._simageskin.gameObject, true)
		arg_36_0._simageskin:LoadImage(ResUrl.getHeadIconImg(arg_36_0._skinCo.id), arg_36_0._loadedImage, arg_36_0)

		arg_36_0._txtswitch.text = "L2D"
	end
end

function var_0_0._loadedImage(arg_37_0)
	ZProj.UGUIHelper.SetImageSize(arg_37_0._simageskin.gameObject)

	local var_37_0 = arg_37_0._skinCo.skinViewImgOffset

	if not string.nilorempty(var_37_0) then
		local var_37_1 = string.splitToNumber(var_37_0, "#")

		recthelper.setAnchor(arg_37_0._simageskin.transform, tonumber(var_37_1[1]), tonumber(var_37_1[2]))
		transformhelper.setLocalScale(arg_37_0._simageskin.transform, tonumber(var_37_1[3]), tonumber(var_37_1[3]), tonumber(var_37_1[3]))
	else
		recthelper.setAnchor(arg_37_0._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(arg_37_0._simageskin.transform, 0.6, 0.6, 0.6)
	end

	if arg_37_0._adjust then
		return
	end

	local var_37_2 = DecorateStoreModel.instance:getCurGood(arg_37_0._selectSecondTabId)
	local var_37_3 = DecorateStoreConfig.instance:getDecorateConfig(var_37_2)
	local var_37_4 = string.splitToNumber(var_37_3.decorateskinOffset, "#")

	recthelper.setAnchor(arg_37_0._goskincontainer.transform, var_37_4[1] or 0, var_37_4[2] or 0)
	transformhelper.setLocalScale(arg_37_0._goskincontainer.transform, var_37_4[3] or 1, var_37_4[3] or 1, var_37_4[3] or 1)
end

function var_0_0._live2DCameraLoaded(arg_38_0)
	gohelper.setAsFirstSibling(arg_38_0._simagel2d.gameObject)
end

function var_0_0._onUISpineLoaded(arg_39_0)
	gohelper.setActive(arg_39_0._simageskin.gameObject, false)
	ZProj.UGUIHelper.SetImageSize(arg_39_0._simageskin.gameObject)
	arg_39_0._uiSpine:setAllLayer(UnityLayer.SceneEffect)

	local var_39_0 = arg_39_0._skinCo.skinViewLive2dOffset

	if string.nilorempty(var_39_0) then
		var_39_0 = arg_39_0._skinCo.characterViewOffset
	end

	local var_39_1 = SkinConfig.instance:getSkinOffset(var_39_0)

	recthelper.setAnchor(arg_39_0._gobigspine.transform, tonumber(var_39_1[1]), tonumber(var_39_1[2]))
	transformhelper.setLocalScale(arg_39_0._gobigspine.transform, tonumber(var_39_1[3]), tonumber(var_39_1[3]), tonumber(var_39_1[3]))

	if arg_39_0._adjust then
		return
	end

	local var_39_2 = DecorateStoreModel.instance:getCurGood(arg_39_0._selectSecondTabId)
	local var_39_3 = DecorateStoreConfig.instance:getDecorateConfig(var_39_2)
	local var_39_4 = string.splitToNumber(var_39_3.decorateskinl2dOffset, "#")

	recthelper.setAnchor(arg_39_0._goskincontainer.transform, var_39_4[1] or 0, var_39_4[2] or 0)
	transformhelper.setLocalScale(arg_39_0._goskincontainer.transform, var_39_4[3] or 1, var_39_4[3] or 1, var_39_4[3] or 1)
end

function var_0_0._refreshSmallSpine(arg_40_0)
	if not arg_40_0._smallSpine then
		arg_40_0._smallSpine = GuiSpine.Create(arg_40_0._gosmallspine, false)
	end

	arg_40_0._smallSpine:stopVoice()
	arg_40_0._smallSpine:setResPath(ResUrl.getSpineUIPrefab(arg_40_0._skinCo.spine), nil, nil, true)

	local var_40_0 = SkinConfig.instance:getSkinOffset(arg_40_0._skinCo.skinSpineOffset)

	recthelper.setAnchor(arg_40_0._gosmallspine.transform, tonumber(var_40_0[1]), tonumber(var_40_0[2]))
	transformhelper.setLocalScale(arg_40_0._gosmallspine.transform, tonumber(var_40_0[3]), tonumber(var_40_0[3]), tonumber(var_40_0[3]))
end

function var_0_0._hideMainScene(arg_41_0)
	if not arg_41_0._needShowMainScene then
		return
	end

	arg_41_0._needShowMainScene = false

	MainSceneSwitchCameraController.instance:hideScene()
	WeatherController.instance:onSceneShow()
	gohelper.setActive(arg_41_0._gotype5, false)
	gohelper.setActive(arg_41_0._rawImage, false)
	gohelper.setActive(arg_41_0._gotypebg3, false)
end

function var_0_0._updateDecorateMainScene(arg_42_0)
	arg_42_0._sceneId = arg_42_0:_getMainSceneId()

	if not arg_42_0._sceneId then
		logError("DecorateStoreView:_updateDecorateMainScene sceneId is nil")

		return
	end

	gohelper.setActive(arg_42_0._gotypebg3, false)

	arg_42_0._needShowMainScene = true

	gohelper.setActive(arg_42_0._rawImage, false)
	WeatherController.instance:onSceneHide()
	MainSceneSwitchCameraController.instance:showScene(arg_42_0._sceneId, arg_42_0._showSceneFinished, arg_42_0)
end

function var_0_0._getMainSceneId(arg_43_0)
	local var_43_0 = DecorateStoreModel.instance:getCurGood(arg_43_0._selectSecondTabId)
	local var_43_1 = var_43_0 and lua_store_goods.configDict[var_43_0]
	local var_43_2 = var_43_1 and var_43_1.product

	if not var_43_2 then
		return nil
	end

	for iter_43_0, iter_43_1 in ipairs(lua_scene_switch.configList) do
		if string.find(var_43_2, iter_43_1.itemId) then
			return iter_43_1.id
		end
	end

	return nil
end

function var_0_0._showSceneFinished(arg_44_0, arg_44_1)
	gohelper.setActive(arg_44_0._gotype5, true)

	if not arg_44_0._weatherSwitchControlComp then
		arg_44_0._weatherSwitchControlComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_44_0._gotype5, WeatherSwitchControlComp)
		arg_44_0._rawImage = gohelper.onceAddComponent(gohelper.findChild(arg_44_0.viewGO, "Bg/typebg/#go_typebg3/mainscenebg"), gohelper.Type_RawImage)
	end

	gohelper.setActive(arg_44_0._rawImage, true)
	gohelper.setActive(arg_44_0._gotypebg3, true)
	MainSceneSwitchInfoDisplayView.adjustRt(arg_44_0._rawImage, arg_44_1)
	arg_44_0._weatherSwitchControlComp:updateScene(arg_44_0._sceneId, MainSceneSwitchCameraDisplayController.instance)
end

function var_0_0._hideDecorateSelfCard(arg_45_0)
	gohelper.setActive(arg_45_0._gotypebg5, false)

	if arg_45_0._viewGo then
		gohelper.destroy(arg_45_0._viewGo)

		arg_45_0._viewGo = nil
	end

	if arg_45_0._viewCls then
		arg_45_0._viewCls:onCloseInternal()

		arg_45_0._viewCls = nil
	end

	if arg_45_0._cardLoader then
		arg_45_0._cardLoader:dispose()

		arg_45_0._cardLoader = nil
	end
end

function var_0_0._updateDecorateSelfCard(arg_46_0)
	local var_46_0 = DecorateStoreModel.instance:getCurGood(arg_46_0._selectSecondTabId)
	local var_46_1 = StoreModel.instance:getGoodsMO(var_46_0)
	local var_46_2 = string.splitToNumber(var_46_1.config.product, "#")
	local var_46_3 = string.format("playercardview_%s", var_46_2[2])

	arg_46_0._cardPath = string.format("ui/viewres/player/playercard/%s.prefab", var_46_3)
	arg_46_0._cardLoader = MultiAbLoader.New()

	arg_46_0._cardLoader:addPath(arg_46_0._cardPath)
	arg_46_0._cardLoader:startLoad(arg_46_0._onCardLoadFinish, arg_46_0)
end

function var_0_0._onCardLoadFinish(arg_47_0)
	local var_47_0 = DecorateStoreModel.instance:getCurGood(arg_47_0._selectSecondTabId)
	local var_47_1 = StoreModel.instance:getGoodsMO(var_47_0)
	local var_47_2 = string.splitToNumber(var_47_1.config.product, "#")

	gohelper.setActive(arg_47_0._gotypebg5, true)

	local var_47_3 = arg_47_0._cardLoader:getAssetItem(arg_47_0._cardPath):GetResource(arg_47_0._cardPath)

	arg_47_0._viewGo = arg_47_0._viewGo or gohelper.clone(var_47_3, arg_47_0._gotypebg5)
	arg_47_0._viewCls = arg_47_0._viewCls or MonoHelper.addNoUpdateLuaComOnceToGo(arg_47_0._viewGo, StorePlayerCardView)
	arg_47_0._viewCls.viewParam = {
		userId = PlayerModel.instance:getPlayinfo().userId
	}
	arg_47_0._viewCls.viewContainer = arg_47_0.viewContainer

	local var_47_4 = DecorateStoreConfig.instance:getDecorateConfig(var_47_0).showskinId

	arg_47_0._viewCls:onOpen(var_47_4, var_47_2[2])
	arg_47_0._viewCls:backBottomView()
end

function var_0_0._hideDecorateBuildingVideo(arg_48_0)
	gohelper.setActive(arg_48_0._gotypebg6, false)

	if arg_48_0._videoPlayer then
		arg_48_0._videoPlayer:Clear()

		arg_48_0._videoPlayer = nil
	end
end

function var_0_0._updateDecorateBuildingVideo(arg_49_0)
	gohelper.setActive(arg_49_0._gotypebg6, true)

	if not arg_49_0._videoPlayer then
		local var_49_0 = gohelper.findChild(arg_49_0._gotypebg6, "#go_video")

		arg_49_0._videoPlayer, arg_49_0._displauUGUI = AvProMgr.instance:getVideoPlayer(var_49_0)
	end

	local var_49_1 = DecorateStoreModel.instance:getCurGood(arg_49_0._selectSecondTabId)
	local var_49_2 = DecorateStoreConfig.instance:getDecorateConfig(var_49_1)

	arg_49_0._videoPlayer:Play(arg_49_0._displauUGUI, langVideoUrl(var_49_2.video), true, nil, nil)
end

function var_0_0.onClose(arg_50_0)
	UIBlockMgr.instance:endBlock("decorateswitch")
	UIBlockMgr.instance:endBlock("decoratehide")
	TaskDispatcher.cancelTask(arg_50_0._switchTabRefresh, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._startDefaultShowView, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._startGoodIn, arg_50_0)
	arg_50_0:_removeEvents()
	arg_50_0:_hideMainScene()
end

function var_0_0.onDestroyView(arg_51_0)
	MainSceneSwitchCameraController.instance:clear()

	if arg_51_0._goodItems then
		for iter_51_0, iter_51_1 in pairs(arg_51_0._goodItems) do
			for iter_51_2, iter_51_3 in pairs(iter_51_1) do
				for iter_51_4, iter_51_5 in pairs(iter_51_3) do
					iter_51_5:destroy()
				end
			end
		end

		arg_51_0._goodItems = nil
	end

	if arg_51_0._categoryItemContainer and #arg_51_0._categoryItemContainer > 0 then
		for iter_51_6 = 1, #arg_51_0._categoryItemContainer do
			arg_51_0._categoryItemContainer[iter_51_6].btn:RemoveClickListener()
		end

		arg_51_0._categoryItemContainer = nil
	end
end

return var_0_0
