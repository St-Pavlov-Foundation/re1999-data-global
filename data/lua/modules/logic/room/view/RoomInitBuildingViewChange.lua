module("modules.logic.room.view.RoomInitBuildingViewChange", package.seeall)

local var_0_0 = class("RoomInitBuildingViewChange", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gochange = gohelper.findChild(arg_1_0.viewGO, "right/#go_part/#go_change")
	arg_1_0._goCategory = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_catagory")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncoin:AddClickListener(arg_2_0._btncoinOnClick, arg_2_0)
	arg_2_0._inputvalue:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
	arg_2_0._btnnoformula:AddClickListener(arg_2_0._btnnoformulaOnClick, arg_2_0)
	arg_2_0._btncombine:AddClickListener(arg_2_0._btncombineOnClick, arg_2_0)
	arg_2_0._btnproduct:AddClickListener(arg_2_0._btnproductOnClick, arg_2_0)

	local var_2_0 = {}

	var_2_0[1] = 0.5

	for iter_2_0 = 2, RoomBuildingEnum.MachineSlotMaxCount do
		local var_2_1 = 0.7 * var_2_0[iter_2_0 - 1]
		local var_2_2 = math.max(var_2_1, 0.1)

		table.insert(var_2_0, var_2_2)
	end

	arg_2_0._subPress = SLFramework.UGUI.UILongPressListener.Get(arg_2_0._gosub)

	arg_2_0._subPress:SetLongPressTime(var_2_0)
	arg_2_0._subPress:AddLongPressListener(arg_2_0._subLongPressTimeEnd, arg_2_0)

	arg_2_0._subClick = SLFramework.UGUI.UIClickListener.Get(arg_2_0._gosub)

	arg_2_0._subClick:AddClickListener(arg_2_0._subClickOnClick, arg_2_0)
	arg_2_0._subClick:AddClickUpListener(arg_2_0._subClickUp, arg_2_0)

	arg_2_0._addPress = SLFramework.UGUI.UILongPressListener.Get(arg_2_0._goadd)

	arg_2_0._addPress:SetLongPressTime(var_2_0)
	arg_2_0._addPress:AddLongPressListener(arg_2_0._addLongPressTimeEnd, arg_2_0)

	arg_2_0._addClick = SLFramework.UGUI.UIClickListener.Get(arg_2_0._goadd)

	arg_2_0._addClick:AddClickListener(arg_2_0._addClickOnClick, arg_2_0)
	arg_2_0._addClick:AddClickUpListener(arg_2_0._addClickUp, arg_2_0)
	arg_2_0:addEventCb(RoomController.instance, RoomEvent.StartProductionLineReply, arg_2_0._startProductionLine, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.ChangeSelectFormulaToTopLevel, arg_2_0._refreshNeedTag, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, arg_2_0._onSelectFormulaIdChanged, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.ShowInitBuildingChangeTitle, arg_2_0._onShowInitBuildingChangeTitle, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._refresh, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.RefreshNeedFormula, arg_2_0._refreshNeedTag, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._refresh, arg_2_0)
	arg_2_0:addEventCb(JumpController.instance, JumpEvent.JumpBtnClick, arg_2_0._onJumpBtnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncoin:RemoveClickListener()
	arg_3_0._inputvalue:RemoveOnValueChanged()
	arg_3_0._btnnoformula:RemoveClickListener()
	arg_3_0._btncombine:RemoveClickListener()
	arg_3_0._btnproduct:RemoveClickListener()
	arg_3_0._subPress:RemoveLongPressListener()
	arg_3_0._subClick:RemoveClickListener()
	arg_3_0._subClick:RemoveClickUpListener()
	arg_3_0._addPress:RemoveLongPressListener()
	arg_3_0._addClick:RemoveClickListener()
	arg_3_0._addClick:RemoveClickUpListener()
	arg_3_0:removeEventCb(RoomController.instance, RoomEvent.StartProductionLineReply, arg_3_0._startProductionLine, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.ChangeSelectFormulaToTopLevel, arg_3_0._refreshNeedTag, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, arg_3_0._onSelectFormulaIdChanged, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.ShowInitBuildingChangeTitle, arg_3_0._onShowInitBuildingChangeTitle, arg_3_0)
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._refresh, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.RefreshNeedFormula, arg_3_0._refreshNeedTag, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._refresh, arg_3_0)
	arg_3_0:removeEventCb(JumpController.instance, JumpEvent.JumpBtnClick, arg_3_0._onJumpBtnClick, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
end

function var_0_0._onJumpBtnClick(arg_4_0, arg_4_1)
	if arg_4_0.viewParam and arg_4_0.viewParam.openInOutside then
		local var_4_0 = JumpConfig.instance:getJumpView(arg_4_1)

		if var_4_0 ~= JumpEnum.JumpView.RoomProductLineView and var_4_0 ~= JumpEnum.JumpView.StoreView then
			arg_4_0:closeThis()
		end
	end
end

function var_0_0._btncoinOnClick(arg_5_0)
	local var_5_0 = {
		type = MaterialEnum.MaterialType.Currency,
		id = CurrencyEnum.CurrencyType.Gold,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	}

	if arg_5_0._toatalNeedSocre and arg_5_0._toatalNeedSocre > 0 then
		var_5_0.quantity = arg_5_0._toatalNeedSocre
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Gold, nil, nil, nil, var_5_0)
end

function var_0_0._btncombineOnClick(arg_6_0)
	local var_6_0 = RoomFormulaListModel.instance:getSelectFormulaId()

	if not var_6_0 or var_6_0 == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	local var_6_1 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()

	if arg_6_0.isEasyCombine then
		local var_6_2 = RoomProductionHelper.getFormulaProduceItem(var_6_0)

		if not var_6_2 then
			return
		end

		local var_6_3, var_6_4 = RoomProductionHelper.getEasyCombineFormulaAndCostItemList(var_6_0, var_6_1)

		if var_6_3 then
			local var_6_5 = arg_6_0.viewContainer:getSelectLine()
			local var_6_6 = {
				type = var_6_2.type,
				id = var_6_2.id,
				quantity = var_6_1
			}

			RoomProductionHelper.openRoomFormulaMsgBoxView(var_6_4, {
				var_6_6
			}, var_6_5, arg_6_0.setStartFormulaStrId, arg_6_0)
		else
			GameFacade.showToast(ToastEnum.RoomFormulaCantUse)
		end
	else
		if not RoomProductionHelper.isEnoughCoin(var_6_0, var_6_1) then
			GameFacade.showToast(ToastEnum.RoomFormulaNotEnoughCoin)

			return
		end

		if not RoomProductionHelper.isEnoughMaterial(var_6_0, var_6_1) then
			GameFacade.showToast(ToastEnum.RoomFormulaCantUse)

			return
		end

		local var_6_7 = arg_6_0.viewContainer:getSelectLine()
		local var_6_8 = RoomProductionModel.instance:getLineMO(var_6_7)

		PopupController.instance:setPause("roominitbuildingview_changestart", true)
		UIBlockMgr.instance:startBlock("roominitbuildingview_changestart")
		arg_6_0:setStartFormulaStrId()
		RoomRpc.instance:sendStartProductionLineRequest(var_6_8.id, {
			{
				formulaId = var_6_0,
				count = var_6_1
			}
		})
	end
end

function var_0_0._btnproductOnClick(arg_7_0)
	if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		local var_7_0 = RoomFormulaListModel.instance:getSelectFormulaId()

		if var_7_0 and var_7_0 ~= 0 then
			local var_7_1 = RoomProductionHelper.getFormulaProduceItem(var_7_0)

			if var_7_1 then
				local var_7_2 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
				local var_7_3 = {
					type = var_7_1.type,
					id = var_7_1.id,
					quantity = var_7_2,
					sceneType = GameSceneMgr.instance:getCurSceneType(),
					openedViewNameList = JumpController.instance:getCurrentOpenedView()
				}

				MaterialTipController.instance:showMaterialInfo(var_7_1.type, var_7_1.id, nil, nil, nil, var_7_3, nil, var_7_2, true, arg_7_0.jumpFinishCallback, arg_7_0)
			end
		end
	end

	arg_7_0:_openSelectFormulaView()
end

function var_0_0.jumpFinishCallback(arg_8_0)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshNeedFormula)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshNeedFormulaItem)
end

function var_0_0._btnitemOnClick(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._materialItemList[arg_9_1]

	if var_9_0 and var_9_0.costItem then
		if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
			if not var_9_0.isEmpty then
				var_9_0.costItem:_onClick(true)
			end
		else
			arg_9_0:_openSelectFormulaView()
		end
	else
		arg_9_0:_openSelectFormulaView()
	end
end

function var_0_0._openSelectFormulaView(arg_10_0)
	local var_10_0 = arg_10_0.viewContainer:getSelectLine()
	local var_10_1 = RoomProductionModel.instance:getLineMO(var_10_0)

	if not ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		ViewMgr.instance:openView(ViewName.RoomFormulaView, {
			lineMO = var_10_1,
			buildingType = RoomBuildingEnum.FormulaBuildingType.Change,
			openInOutside = arg_10_0.viewParam and arg_10_0.viewParam.openInOutside
		})
	end

	arg_10_0:_setTitleAndCategoryVisibility(false)
end

function var_0_0._subLongPressTimeEnd(arg_11_0)
	local var_11_0 = RoomFormulaListModel.instance:getSelectFormulaId()

	if not var_11_0 or var_11_0 == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	if arg_11_0._blockLongPress then
		return
	end

	local var_11_1 = arg_11_0._isLongPress

	arg_11_0._isLongPress = true

	local var_11_2 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
	local var_11_3 = arg_11_0:_trySetCount(var_11_2 - 1, true)

	if not var_11_1 and var_11_3 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function var_0_0._subClickOnClick(arg_12_0)
	local var_12_0 = RoomFormulaListModel.instance:getSelectFormulaId()

	if not var_12_0 or var_12_0 == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	local var_12_1 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()

	if arg_12_0:_trySetCount(var_12_1 - 1, true) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function var_0_0._subClickUp(arg_13_0)
	arg_13_0._blockLongPress = false
	arg_13_0._isLongPress = false
end

function var_0_0._addLongPressTimeEnd(arg_14_0)
	local var_14_0 = RoomFormulaListModel.instance:getSelectFormulaId()

	if not var_14_0 or var_14_0 == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	if arg_14_0._blockLongPress then
		return
	end

	if not arg_14_0._isLongPress then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end

	local var_14_1 = arg_14_0._isLongPress

	arg_14_0._isLongPress = true

	local var_14_2 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
	local var_14_3 = arg_14_0:_trySetCount(var_14_2 + 1, true, true)

	if not var_14_1 and var_14_3 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function var_0_0._addClickOnClick(arg_15_0)
	local var_15_0 = RoomFormulaListModel.instance:getSelectFormulaId()

	if not var_15_0 or var_15_0 == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	local var_15_1 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()

	if arg_15_0:_trySetCount(var_15_1 + 1, true, true) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function var_0_0._addClickUp(arg_16_0)
	arg_16_0._blockLongPress = false
	arg_16_0._isLongPress = false
end

function var_0_0._onValueChanged(arg_17_0, arg_17_1)
	local var_17_0 = RoomFormulaListModel.instance:getSelectFormulaId()

	if not var_17_0 or var_17_0 == 0 then
		return
	end

	local var_17_1 = tonumber(arg_17_1)

	if var_17_1 then
		arg_17_0:_trySetCount(var_17_1, true)
	else
		arg_17_0:_trySetCount(1, true)
	end
end

function var_0_0._btnnoformulaOnClick(arg_18_0)
	GameFacade.showToast(ToastEnum.RoomInitBuildingToast)
end

function var_0_0._onSelectFormulaIdChanged(arg_19_0, arg_19_1)
	local var_19_0 = RoomFormulaListModel.instance:getSelectFormulaStrId()

	if arg_19_1 ~= var_19_0 then
		local var_19_1 = true

		if not string.nilorempty(var_19_0) then
			local var_19_2 = RoomFormulaModel.instance:getFormulaMo(var_19_0)
			local var_19_3 = not var_19_2:isTreeFormula()
			local var_19_4 = var_19_2:getIsExpandTree()

			var_19_1 = var_19_3 and not var_19_4
		end

		if not arg_19_1 or var_19_1 then
			arg_19_0:_resetCount()
		end
	end

	arg_19_0:_refreshFormula()

	if var_19_0 then
		gohelper.setActive(arg_19_0._gobgvx, false)
		gohelper.setActive(arg_19_0._gobgvx, true)
	end
end

function var_0_0._startProductionLine(arg_20_0)
	RoomMapController.instance:dispatchEvent(RoomEvent.OnChangePartStart, arg_20_0._startFormulaStrId)
	PopupController.instance:setPause("roominitbuildingview_changestart", false)
	UIBlockMgr.instance:endBlock("roominitbuildingview_changestart")
	arg_20_0:_resetCount()
	arg_20_0:_refreshFormula()
	gohelper.setActive(arg_20_0._gohechengeffect, false)
	gohelper.setActive(arg_20_0._gohechengeffect, true)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_fountain_mix)
end

function var_0_0._onShowInitBuildingChangeTitle(arg_21_0)
	arg_21_0:_setTitleAndCategoryVisibility(true)
end

function var_0_0._onOpenView(arg_22_0, arg_22_1)
	if arg_22_1 == ViewName.RoomFormulaView then
		arg_22_0:_setTitleAndCategoryVisibility(false)
	end
end

function var_0_0._setTitleAndCategoryVisibility(arg_23_0, arg_23_1)
	arg_23_0.viewContainer:setIsShowTitle(arg_23_1)
	gohelper.setActive(arg_23_0._goCategory, arg_23_1)
end

function var_0_0._editableInitView(arg_24_0)
	arg_24_0._gocombine3 = gohelper.findChild(arg_24_0._gochange, "combine/#go_combine3")
	arg_24_0._goproduct = gohelper.findChild(arg_24_0._gochange, "go_product")
	arg_24_0._simageproducticon = gohelper.findChildSingleImage(arg_24_0._gochange, "combine/combineproduct/go_product/simage_producticon")
	arg_24_0._imageproductrare = gohelper.findChildImage(arg_24_0._gochange, "combine/combineproduct/go_product/image_productrare")
	arg_24_0._inputvalue = gohelper.findChildTextMeshInputField(arg_24_0._gochange, "go_product/productnum/valuebg/input_value")
	arg_24_0._btnnoformula = gohelper.findChildButtonWithAudio(arg_24_0._gochange, "go_product/productnum/valuebg/btn_noformula")
	arg_24_0._gosub = gohelper.findChild(arg_24_0._gochange, "go_product/productnum/sub/go_sub")
	arg_24_0._goadd = gohelper.findChild(arg_24_0._gochange, "go_product/productnum/add/go_add")
	arg_24_0._txtgold = gohelper.findChildText(arg_24_0._gochange, "combine/go_combine3/itemcoin/go_gooditem/countbg/txt_gold")
	arg_24_0._goempty = gohelper.findChild(arg_24_0._gochange, "combine/go_combine3/itemcoin/go_empty")
	arg_24_0._gogooditem = gohelper.findChild(arg_24_0._gochange, "combine/go_combine3/itemcoin/go_gooditem")
	arg_24_0._btncoin = gohelper.findChildButtonWithAudio(arg_24_0._gochange, "combine/go_combine3/itemcoin/btn_coin")
	arg_24_0._btnproduct = gohelper.findChildButtonWithAudio(arg_24_0._gochange, "combine/combineproduct/btn_product")
	arg_24_0._goproducticon = gohelper.findChild(arg_24_0._gochange, "combine/combineproduct/btn_product/icon")
	arg_24_0._goproductadd = gohelper.findChild(arg_24_0._gochange, "combine/combineproduct/go_add")
	arg_24_0._goCanCombine = gohelper.findChild(arg_24_0._gochange, "combine/combineproduct/#go_Mix")
	arg_24_0._txtCanCombine = gohelper.findChildText(arg_24_0._gochange, "combine/combineproduct/#go_Mix/#txt_Mix")
	arg_24_0._btncombine = gohelper.findChildButton(arg_24_0._gochange, "go_product/btn_combine")
	arg_24_0._golevelupbeffect = gohelper.findChild(arg_24_0._gochange, "go_product/btn_combine/#go_levelupbeffect")
	arg_24_0._txtCombine = gohelper.findChildText(arg_24_0._gochange, "go_product/btn_combine/textcn")
	arg_24_0._simagecombinebg = gohelper.findChildSingleImage(arg_24_0._gochange, "combine/go_combine3/#simage_combinebg")
	arg_24_0._gocoinitempos = gohelper.findChild(arg_24_0._gochange, "combine/go_combine3/itemcoin/go_gooditem/go_gooditempos")
	arg_24_0._txtNeed = gohelper.findChildText(arg_24_0._gochange, "go_product/#txt_NeedProp")
	arg_24_0._gobgvx = gohelper.findChild(arg_24_0._gochange, "combine/go_combine3/#bgvx")
	arg_24_0._gohechengeffect = gohelper.findChild(arg_24_0._gochange, "combine/#hechengeffect")

	arg_24_0._simagecombinebg:LoadImage(ResUrl.getRoomImage("bg_hechengdiban"))
	gohelper.addUIClickAudio(arg_24_0._btnproduct.gameObject, AudioEnum.UI.UI_transverse_tabs_click)

	arg_24_0._materialItemList = {}

	for iter_24_0 = 1, 3 do
		local var_24_0 = arg_24_0:getUserDataTb_()

		var_24_0.go = gohelper.findChild(arg_24_0._gochange, "combine/go_combine3/item" .. iter_24_0)
		var_24_0.goempty = gohelper.findChild(var_24_0.go, "go_empty")
		var_24_0.gogooditem = gohelper.findChild(var_24_0.go, "go_gooditem")
		var_24_0.gogooditempos = gohelper.findChild(var_24_0.go, "go_gooditem/go_gooditempos")
		var_24_0.txtcount = gohelper.findChildText(var_24_0.go, "go_gooditem/countbg/txt_count")
		var_24_0.btnitem = gohelper.findChildButtonWithAudio(var_24_0.go, "btn_item")

		var_24_0.btnitem:AddClickListener(function(arg_25_0)
			arg_25_0:_btnitemOnClick(iter_24_0)
		end, arg_24_0)
		gohelper.addUIClickAudio(var_24_0.btnitem.gameObject, AudioEnum.UI.UI_transverse_tabs_click)

		var_24_0.isEmpty = false

		table.insert(arg_24_0._materialItemList, var_24_0)
	end

	arg_24_0._coinItem = IconMgr.instance:getRoomGoodsItem(arg_24_0._gocoinitempos, arg_24_0.viewContainer)

	arg_24_0._coinItem:canShowRareCircle(false)
	arg_24_0._coinItem:setMOValue(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Gold, 0)
	arg_24_0._coinItem:isEnableClick(false)
	arg_24_0._coinItem:isShowCount(false)
	arg_24_0._coinItem:setRecordFarmItem(true)
	arg_24_0._coinItem:setConsume(true)
	RoomBuildingFormulaController.instance:resetSelectFormulaStrId()
end

function var_0_0.onOpen(arg_26_0)
	arg_26_0:_refresh()

	if arg_26_0.viewParam and arg_26_0.viewParam.showFormulaView then
		arg_26_0.viewContainer:setSelectLine(7)
		arg_26_0:_openSelectFormulaView()
	end
end

function var_0_0._refresh(arg_27_0)
	arg_27_0:_refreshFormula()
end

function var_0_0._refreshFormula(arg_28_0)
	local var_28_0 = RoomFormulaListModel.instance:getSelectFormulaId()
	local var_28_1 = var_28_0 and var_28_0 ~= 0

	arg_28_0._inputvalue.inputField.interactable = var_28_1

	gohelper.setActive(arg_28_0._btnnoformula.gameObject, not var_28_1)
	gohelper.setActive(arg_28_0._goproducticon.gameObject, var_28_1)

	if var_28_1 then
		arg_28_0:_refreshSelect()
	else
		arg_28_0:_refreshEmpty()
	end

	arg_28_0:_refreshNeedTag()
	arg_28_0:_refreshCombineBtn()
	arg_28_0:_refreshInputField()
end

function var_0_0._refreshSelect(arg_29_0)
	arg_29_0:_refreshProduce()
	arg_29_0:_refreshCostCoinCount()
	arg_29_0:_refreshCostMaterial()
end

function var_0_0._refreshCostCoinCount(arg_30_0)
	local var_30_0 = 0
	local var_30_1 = 0
	local var_30_2 = RoomFormulaListModel.instance:getSelectFormulaId()
	local var_30_3 = RoomProductionHelper.getCostCoinItemList(var_30_2)[1]

	if var_30_3 then
		var_30_0 = var_30_3.quantity or 0
		var_30_1 = ItemModel.instance:getItemQuantity(var_30_3.type, var_30_3.id)
	end

	local var_30_4 = var_30_0 * RoomFormulaListModel.instance:getSelectFormulaCombineCount()

	if var_30_1 < var_30_4 then
		arg_30_0._txtgold.text = string.format("<color=#d97373>%s</color>", var_30_4)
	else
		arg_30_0._txtgold.text = GameUtil.numberDisplay(var_30_4)
	end

	arg_30_0._toatalNeedSocre = var_30_4

	gohelper.setActive(arg_30_0._gogooditem, var_30_4 > 0)
	gohelper.setActive(arg_30_0._goempty, var_30_4 <= 0)
end

function var_0_0._refreshCostMaterial(arg_31_0)
	local var_31_0 = RoomFormulaListModel.instance:getSelectFormulaId()
	local var_31_1 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
	local var_31_2 = RoomProductionHelper.getCostMaterialItemList(var_31_0)

	for iter_31_0 = 1, math.min(#var_31_2, #arg_31_0._materialItemList) do
		local var_31_3 = var_31_2[iter_31_0]
		local var_31_4 = arg_31_0._materialItemList[iter_31_0]

		if var_31_4 then
			var_31_4.costItem = var_31_4.costItem or IconMgr.instance:getRoomGoodsItem(var_31_4.gogooditempos, arg_31_0.viewContainer)

			var_31_4.costItem:canShowRareCircle(false)
			var_31_4.costItem:setMOValue(var_31_3.type, var_31_3.id, var_31_3.quantity * var_31_1)
			var_31_4.costItem:isEnableClick(false)
			var_31_4.costItem:isShowCount(false)
			var_31_4.costItem:setRecordFarmItem(true)
			var_31_4.costItem:setConsume(true)
			var_31_4.costItem:setJumpFinishCallback(arg_31_0.jumpFinishCallback, arg_31_0)

			local var_31_5 = ItemModel.instance:getItemQuantity(var_31_3.type, var_31_3.id)
			local var_31_6 = var_31_3.quantity * var_31_1

			if var_31_5 < var_31_6 then
				var_31_4.txtcount.text = string.format("<color=#d97373>%s/%s</color>", var_31_5, var_31_6)

				var_31_4.costItem:setGrayscale(true)
			else
				var_31_4.txtcount.text = string.format("%s/%s", RoomProductionHelper.formatItemNum(var_31_5), var_31_6)

				var_31_4.costItem:setGrayscale(false)
			end

			var_31_4.isEmpty = false

			gohelper.setActive(var_31_4.go, true)
			gohelper.setActive(var_31_4.goempty, false)
			gohelper.setActive(var_31_4.gogooditem, true)
		end
	end

	for iter_31_1 = math.min(#var_31_2, #arg_31_0._materialItemList) + 1, #arg_31_0._materialItemList do
		local var_31_7 = arg_31_0._materialItemList[iter_31_1]

		var_31_7.isEmpty = true

		gohelper.setActive(var_31_7.go, true)
		gohelper.setActive(var_31_7.goempty, true)
		gohelper.setActive(var_31_7.gogooditem, false)
	end
end

function var_0_0._refreshProduce(arg_32_0)
	local var_32_0 = RoomFormulaListModel.instance:getSelectFormulaId()
	local var_32_1 = RoomProductionHelper.getFormulaProduceItem(var_32_0)

	gohelper.setActive(arg_32_0._simageproducticon.gameObject, var_32_1)
	gohelper.setActive(arg_32_0._imageproductrare.gameObject, var_32_1)
	gohelper.setActive(arg_32_0._goproductadd, var_32_1 == nil)

	if var_32_1 then
		local var_32_2, var_32_3 = ItemModel.instance:getItemConfigAndIcon(var_32_1.type, var_32_1.id)

		arg_32_0._simageproducticon:LoadImage(var_32_3)
		UISpriteSetMgr.instance:setRoomSprite(arg_32_0._imageproductrare, "huangyuan_pz_" .. CharacterEnum.Color[var_32_2.rare])
	end
end

function var_0_0._refreshEmpty(arg_33_0)
	arg_33_0._inputvalue:SetText(tostring(0))
	gohelper.setActive(arg_33_0._simageproducticon.gameObject, false)
	gohelper.setActive(arg_33_0._imageproductrare.gameObject, false)
	gohelper.setActive(arg_33_0._goproductadd, true)

	for iter_33_0, iter_33_1 in ipairs(arg_33_0._materialItemList) do
		gohelper.setActive(iter_33_1.go, true)
		gohelper.setActive(iter_33_1.goempty, true)
		gohelper.setActive(iter_33_1.gogooditem, false)
	end

	gohelper.setActive(arg_33_0._goempty, true)
	gohelper.setActive(arg_33_0._gogooditem, false)
end

function var_0_0._refreshNeedTag(arg_34_0)
	local var_34_0
	local var_34_1
	local var_34_2
	local var_34_3 = RoomFormulaListModel.instance:getSelectFormulaMo()

	if var_34_3 then
		local var_34_4 = var_34_3:getId()
		local var_34_5 = var_34_3:getFormulaId()

		var_34_2 = RoomProductionHelper.getFormulaNeedQuantity(var_34_4)

		local var_34_6 = RoomProductionHelper.getFormulaProduceItem(var_34_5)

		if var_34_6 then
			var_34_1 = ItemModel.instance:getItemQuantity(var_34_6.type, var_34_6.id)
		end

		var_34_0 = var_34_3:isTreeFormula() and "room_formula_need_desc2" or "room_formula_need_desc3"
	end

	if var_34_1 and var_34_2 and var_34_0 and var_34_2 ~= 0 then
		local var_34_7 = "#D97373"

		if var_34_2 <= var_34_1 then
			var_34_7 = "#81ce83"
		end

		local var_34_8 = GameUtil.numberDisplay(var_34_1)
		local var_34_9 = GameUtil.numberDisplay(var_34_2)
		local var_34_10 = string.format("<color=%s>%s</color>/%s", var_34_7, var_34_8, var_34_9)

		arg_34_0._txtNeed.text = formatLuaLang(var_34_0, var_34_10)

		gohelper.setActive(arg_34_0._txtNeed.gameObject, true)
	else
		gohelper.setActive(arg_34_0._txtNeed.gameObject, false)
	end
end

function var_0_0._refreshCombineBtn(arg_35_0)
	local var_35_0 = RoomFormulaListModel.instance:getSelectFormulaId()
	local var_35_1 = false
	local var_35_2 = 0

	if var_35_0 and var_35_0 ~= 0 then
		var_35_2 = RoomProductionHelper.getTotalCanCombineNum(var_35_0)
		var_35_1 = var_35_2 ~= 0
	end

	local var_35_3 = false
	local var_35_4 = "room_formula_combine"
	local var_35_5 = false

	if var_35_1 then
		local var_35_6 = GameUtil.numberDisplay(var_35_2)

		arg_35_0._txtCanCombine.text = formatLuaLang("room_formula_can_combine", var_35_6)

		local var_35_7 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
		local var_35_8 = RoomProductionHelper.isEnoughCoin(var_35_0, var_35_7)
		local var_35_9 = RoomProductionHelper.isEnoughMaterial(var_35_0, var_35_7)

		var_35_3 = var_35_8 and var_35_9

		if var_35_3 then
			var_35_5 = true
		elseif var_35_7 <= var_35_2 then
			var_35_5 = true
			var_35_4 = "room_formula_easy_combine"
		end
	end

	arg_35_0._txtCombine.text = luaLang(var_35_4)
	arg_35_0.isEasyCombine = not var_35_3

	gohelper.setActive(arg_35_0._goCanCombine, var_35_1)
	gohelper.setActive(arg_35_0._golevelupbeffect, var_35_5)
	ZProj.UGUIHelper.SetGrayscale(arg_35_0._btncombine.gameObject, not var_35_5)
end

function var_0_0._refreshInputField(arg_36_0)
	local var_36_0 = RoomFormulaListModel.instance:getSelectFormulaStrId()

	if string.nilorempty(var_36_0) then
		return
	end

	local var_36_1 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()

	arg_36_0._inputvalue:RemoveOnValueChanged()
	arg_36_0._inputvalue:SetText(tostring(var_36_1))
	arg_36_0._inputvalue:AddOnValueChanged(arg_36_0._onValueChanged, arg_36_0)
end

function var_0_0.setStartFormulaStrId(arg_37_0)
	arg_37_0._startFormulaStrId = RoomFormulaListModel.instance:getSelectFormulaStrId()
end

function var_0_0._resetCount(arg_38_0)
	local var_38_0 = RoomFormulaListModel.instance:getSelectFormulaStrId()

	if string.nilorempty(var_38_0) then
		return
	end

	local var_38_1 = RoomFormulaModel.instance:getFormulaMo(var_38_0)

	if var_38_1 then
		var_38_1:resetFormulaCombineCount()
	end
end

function var_0_0._trySetCount(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = RoomFormulaListModel.instance:getSelectFormulaStrId()

	if string.nilorempty(var_39_0) then
		return
	end

	local var_39_1 = true
	local var_39_2 = math.max(1, arg_39_1)

	if var_39_2 >= 0 and var_39_2 > RoomBuildingEnum.MachineSlotMaxCount then
		var_39_2 = RoomBuildingEnum.MachineSlotMaxCount

		if arg_39_2 and not arg_39_0._blockLongPress then
			GameFacade.showToast(ToastEnum.RoomInitBuildingSetCount)

			var_39_1 = false
		end

		arg_39_0:_setBlockLongPress()
	end

	if var_39_2 > RoomFormulaListModel.instance:getSelectFormulaCombineCount() and arg_39_3 then
		gohelper.setActive(arg_39_0._gobgvx, false)
		gohelper.setActive(arg_39_0._gobgvx, true)
	end

	local var_39_3 = RoomFormulaModel.instance:getFormulaMo(var_39_0)

	if var_39_3 then
		var_39_3:setFormulaCombineCount(var_39_2)
	end

	arg_39_0:_refreshFormula()

	return var_39_1
end

function var_0_0._setBlockLongPress(arg_40_0)
	if arg_40_0._isLongPress then
		arg_40_0._blockLongPress = true
	end
end

function var_0_0.onClose(arg_41_0)
	JumpModel.instance:clearRecordFarmItem()
end

function var_0_0.onDestroyView(arg_42_0)
	PopupController.instance:setPause("roominitbuildingview_changestart", false)
	UIBlockMgr.instance:endBlock("roominitbuildingview_changestart")

	for iter_42_0, iter_42_1 in ipairs(arg_42_0._materialItemList) do
		iter_42_1.btnitem:RemoveClickListener()
	end

	arg_42_0._simageproducticon:UnLoadImage()
	arg_42_0._simagecombinebg:UnLoadImage()
end

return var_0_0
