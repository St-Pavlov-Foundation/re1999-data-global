module("modules.logic.room.view.RoomInitBuildingViewChange", package.seeall)

slot0 = class("RoomInitBuildingViewChange", BaseView)

function slot0.onInitView(slot0)
	slot0._gochange = gohelper.findChild(slot0.viewGO, "right/#go_part/#go_change")
	slot0._goCategory = gohelper.findChild(slot0.viewGO, "left/#scroll_catagory")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncoin:AddClickListener(slot0._btncoinOnClick, slot0)
	slot0._inputvalue:AddOnValueChanged(slot0._onValueChanged, slot0)
	slot0._btnnoformula:AddClickListener(slot0._btnnoformulaOnClick, slot0)
	slot0._btncombine:AddClickListener(slot0._btncombineOnClick, slot0)

	slot5 = slot0

	slot0._btnproduct:AddClickListener(slot0._btnproductOnClick, slot5)

	slot1 = {
		0.5
	}

	for slot5 = 2, RoomBuildingEnum.MachineSlotMaxCount do
		table.insert(slot1, math.max(0.7 * slot1[slot5 - 1], 0.1))
	end

	slot0._subPress = SLFramework.UGUI.UILongPressListener.Get(slot0._gosub)

	slot0._subPress:SetLongPressTime(slot1)
	slot0._subPress:AddLongPressListener(slot0._subLongPressTimeEnd, slot0)

	slot0._subClick = SLFramework.UGUI.UIClickListener.Get(slot0._gosub)

	slot0._subClick:AddClickListener(slot0._subClickOnClick, slot0)
	slot0._subClick:AddClickUpListener(slot0._subClickUp, slot0)

	slot0._addPress = SLFramework.UGUI.UILongPressListener.Get(slot0._goadd)

	slot0._addPress:SetLongPressTime(slot1)
	slot0._addPress:AddLongPressListener(slot0._addLongPressTimeEnd, slot0)

	slot0._addClick = SLFramework.UGUI.UIClickListener.Get(slot0._goadd)

	slot0._addClick:AddClickListener(slot0._addClickOnClick, slot0)
	slot0._addClick:AddClickUpListener(slot0._addClickUp, slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.StartProductionLineReply, slot0._startProductionLine, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ChangeSelectFormulaToTopLevel, slot0._refreshNeedTag, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, slot0._onSelectFormulaIdChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ShowInitBuildingChangeTitle, slot0._onShowInitBuildingChangeTitle, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refresh, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.RefreshNeedFormula, slot0._refreshNeedTag, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refresh, slot0)
	slot0:addEventCb(JumpController.instance, JumpEvent.JumpBtnClick, slot0._onJumpBtnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncoin:RemoveClickListener()
	slot0._inputvalue:RemoveOnValueChanged()
	slot0._btnnoformula:RemoveClickListener()
	slot0._btncombine:RemoveClickListener()
	slot0._btnproduct:RemoveClickListener()
	slot0._subPress:RemoveLongPressListener()
	slot0._subClick:RemoveClickListener()
	slot0._subClick:RemoveClickUpListener()
	slot0._addPress:RemoveLongPressListener()
	slot0._addClick:RemoveClickListener()
	slot0._addClick:RemoveClickUpListener()
	slot0:removeEventCb(RoomController.instance, RoomEvent.StartProductionLineReply, slot0._startProductionLine, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.ChangeSelectFormulaToTopLevel, slot0._refreshNeedTag, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, slot0._onSelectFormulaIdChanged, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.ShowInitBuildingChangeTitle, slot0._onShowInitBuildingChangeTitle, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refresh, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.RefreshNeedFormula, slot0._refreshNeedTag, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refresh, slot0)
	slot0:removeEventCb(JumpController.instance, JumpEvent.JumpBtnClick, slot0._onJumpBtnClick, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0._onJumpBtnClick(slot0, slot1)
	if slot0.viewParam and slot0.viewParam.openInOutside and JumpConfig.instance:getJumpView(slot1) ~= JumpEnum.JumpView.RoomProductLineView and slot2 ~= JumpEnum.JumpView.StoreView then
		slot0:closeThis()
	end
end

function slot0._btncoinOnClick(slot0)
	if slot0._toatalNeedSocre and slot0._toatalNeedSocre > 0 then
		-- Nothing
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Gold, nil, , , {
		type = MaterialEnum.MaterialType.Currency,
		id = CurrencyEnum.CurrencyType.Gold,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView(),
		quantity = slot0._toatalNeedSocre
	})
end

function slot0._btncombineOnClick(slot0)
	if not RoomFormulaListModel.instance:getSelectFormulaId() or slot1 == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	slot2 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()

	if slot0.isEasyCombine then
		if not RoomProductionHelper.getFormulaProduceItem(slot1) then
			return
		end

		slot5, slot6 = RoomProductionHelper.getEasyCombineFormulaAndCostItemList(slot1, slot2)

		if slot5 then
			ViewMgr.instance:openView(ViewName.RoomFormulaMsgBoxView, {
				costItemAndFormulaIdList = slot6,
				produce = {
					type = slot3.type,
					id = slot3.id,
					quantity = slot2
				},
				lineId = slot0.viewContainer:getSelectLine(),
				callback = slot0.setStartFormulaStrId,
				callbackObj = slot0
			})
		else
			GameFacade.showToast(ToastEnum.RoomFormulaCantUse)
		end
	else
		if not RoomProductionHelper.isEnoughCoin(slot1, slot2) then
			GameFacade.showToast(ToastEnum.RoomFormulaNotEnoughCoin)

			return
		end

		if not RoomProductionHelper.isEnoughMaterial(slot1, slot2) then
			GameFacade.showToast(ToastEnum.RoomFormulaCantUse)

			return
		end

		PopupController.instance:setPause("roominitbuildingview_changestart", true)
		UIBlockMgr.instance:startBlock("roominitbuildingview_changestart")
		slot0:setStartFormulaStrId()
		RoomRpc.instance:sendStartProductionLineRequest(RoomProductionModel.instance:getLineMO(slot0.viewContainer:getSelectLine()).id, {
			{
				formulaId = slot1,
				count = slot2
			}
		})
	end
end

function slot0._btnproductOnClick(slot0)
	if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) and RoomFormulaListModel.instance:getSelectFormulaId() and slot1 ~= 0 and RoomProductionHelper.getFormulaProduceItem(slot1) then
		slot3 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()

		MaterialTipController.instance:showMaterialInfo(slot2.type, slot2.id, nil, , , {
			type = slot2.type,
			id = slot2.id,
			quantity = slot3,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = JumpController.instance:getCurrentOpenedView()
		}, nil, slot3, true, slot0.jumpFinishCallback, slot0)
	end

	slot0:_openSelectFormulaView()
end

function slot0.jumpFinishCallback(slot0)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshNeedFormula)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshNeedFormulaItem)
end

function slot0._btnitemOnClick(slot0, slot1)
	if slot0._materialItemList[slot1] and slot2.costItem then
		if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
			if not slot2.isEmpty then
				slot2.costItem:_onClick(true)
			end
		else
			slot0:_openSelectFormulaView()
		end
	else
		slot0:_openSelectFormulaView()
	end
end

function slot0._openSelectFormulaView(slot0)
	if not ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		ViewMgr.instance:openView(ViewName.RoomFormulaView, {
			lineMO = RoomProductionModel.instance:getLineMO(slot0.viewContainer:getSelectLine()),
			buildingType = RoomBuildingEnum.FormulaBuildingType.Change,
			openInOutside = slot0.viewParam and slot0.viewParam.openInOutside
		})
	end

	slot0:_setTitleAndCategoryVisibility(false)
end

function slot0._subLongPressTimeEnd(slot0)
	if not RoomFormulaListModel.instance:getSelectFormulaId() or slot1 == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	if slot0._blockLongPress then
		return
	end

	slot0._isLongPress = true

	if not slot0._isLongPress and slot0:_trySetCount(RoomFormulaListModel.instance:getSelectFormulaCombineCount() - 1, true) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function slot0._subClickOnClick(slot0)
	if not RoomFormulaListModel.instance:getSelectFormulaId() or slot1 == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	if slot0:_trySetCount(RoomFormulaListModel.instance:getSelectFormulaCombineCount() - 1, true) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function slot0._subClickUp(slot0)
	slot0._blockLongPress = false
	slot0._isLongPress = false
end

function slot0._addLongPressTimeEnd(slot0)
	if not RoomFormulaListModel.instance:getSelectFormulaId() or slot1 == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	if slot0._blockLongPress then
		return
	end

	if not slot0._isLongPress then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end

	slot0._isLongPress = true

	if not slot0._isLongPress and slot0:_trySetCount(RoomFormulaListModel.instance:getSelectFormulaCombineCount() + 1, true, true) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function slot0._addClickOnClick(slot0)
	if not RoomFormulaListModel.instance:getSelectFormulaId() or slot1 == 0 then
		GameFacade.showToast(ToastEnum.RoomInitBuildingToast)

		return
	end

	if slot0:_trySetCount(RoomFormulaListModel.instance:getSelectFormulaCombineCount() + 1, true, true) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function slot0._addClickUp(slot0)
	slot0._blockLongPress = false
	slot0._isLongPress = false
end

function slot0._onValueChanged(slot0, slot1)
	if not RoomFormulaListModel.instance:getSelectFormulaId() or slot2 == 0 then
		return
	end

	if tonumber(slot1) then
		slot0:_trySetCount(slot3, true)
	else
		slot0:_trySetCount(1, true)
	end
end

function slot0._btnnoformulaOnClick(slot0)
	GameFacade.showToast(ToastEnum.RoomInitBuildingToast)
end

function slot0._onSelectFormulaIdChanged(slot0, slot1)
	if slot1 ~= RoomFormulaListModel.instance:getSelectFormulaStrId() then
		slot3 = true

		if not string.nilorempty(slot2) then
			slot4 = RoomFormulaModel.instance:getFormulaMo(slot2)
			slot3 = slot4:isTreeFormula() or not slot4:getIsExpandTree()
		end

		if not slot1 or slot3 then
			slot0:_resetCount()
		end
	end

	slot0:_refreshFormula()

	if slot2 then
		gohelper.setActive(slot0._gobgvx, false)
		gohelper.setActive(slot0._gobgvx, true)
	end
end

function slot0._startProductionLine(slot0)
	RoomMapController.instance:dispatchEvent(RoomEvent.OnChangePartStart, slot0._startFormulaStrId)
	PopupController.instance:setPause("roominitbuildingview_changestart", false)
	UIBlockMgr.instance:endBlock("roominitbuildingview_changestart")
	slot0:_resetCount()
	slot0:_refreshFormula()
	gohelper.setActive(slot0._gohechengeffect, false)
	gohelper.setActive(slot0._gohechengeffect, true)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_fountain_mix)
end

function slot0._onShowInitBuildingChangeTitle(slot0)
	slot0:_setTitleAndCategoryVisibility(true)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.RoomFormulaView then
		slot0:_setTitleAndCategoryVisibility(false)
	end
end

function slot0._setTitleAndCategoryVisibility(slot0, slot1)
	slot0.viewContainer:setIsShowTitle(slot1)
	gohelper.setActive(slot0._goCategory, slot1)
end

function slot0._editableInitView(slot0)
	slot0._gocombine3 = gohelper.findChild(slot0._gochange, "combine/#go_combine3")
	slot0._goproduct = gohelper.findChild(slot0._gochange, "go_product")
	slot0._simageproducticon = gohelper.findChildSingleImage(slot0._gochange, "combine/combineproduct/go_product/simage_producticon")
	slot0._imageproductrare = gohelper.findChildImage(slot0._gochange, "combine/combineproduct/go_product/image_productrare")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0._gochange, "go_product/productnum/valuebg/input_value")
	slot0._btnnoformula = gohelper.findChildButtonWithAudio(slot0._gochange, "go_product/productnum/valuebg/btn_noformula")
	slot0._gosub = gohelper.findChild(slot0._gochange, "go_product/productnum/sub/go_sub")
	slot0._goadd = gohelper.findChild(slot0._gochange, "go_product/productnum/add/go_add")
	slot0._txtgold = gohelper.findChildText(slot0._gochange, "combine/go_combine3/itemcoin/go_gooditem/countbg/txt_gold")
	slot0._goempty = gohelper.findChild(slot0._gochange, "combine/go_combine3/itemcoin/go_empty")
	slot0._gogooditem = gohelper.findChild(slot0._gochange, "combine/go_combine3/itemcoin/go_gooditem")
	slot0._btncoin = gohelper.findChildButtonWithAudio(slot0._gochange, "combine/go_combine3/itemcoin/btn_coin")
	slot0._btnproduct = gohelper.findChildButtonWithAudio(slot0._gochange, "combine/combineproduct/btn_product")
	slot0._goproducticon = gohelper.findChild(slot0._gochange, "combine/combineproduct/btn_product/icon")
	slot0._goproductadd = gohelper.findChild(slot0._gochange, "combine/combineproduct/go_add")
	slot0._goCanCombine = gohelper.findChild(slot0._gochange, "combine/combineproduct/#go_Mix")
	slot0._txtCanCombine = gohelper.findChildText(slot0._gochange, "combine/combineproduct/#go_Mix/#txt_Mix")
	slot0._btncombine = gohelper.findChildButton(slot0._gochange, "go_product/btn_combine")
	slot0._golevelupbeffect = gohelper.findChild(slot0._gochange, "go_product/btn_combine/#go_levelupbeffect")
	slot0._txtCombine = gohelper.findChildText(slot0._gochange, "go_product/btn_combine/textcn")
	slot0._simagecombinebg = gohelper.findChildSingleImage(slot0._gochange, "combine/go_combine3/#simage_combinebg")
	slot0._gocoinitempos = gohelper.findChild(slot0._gochange, "combine/go_combine3/itemcoin/go_gooditem/go_gooditempos")
	slot0._txtNeed = gohelper.findChildText(slot0._gochange, "go_product/#txt_NeedProp")
	slot0._gobgvx = gohelper.findChild(slot0._gochange, "combine/go_combine3/#bgvx")
	slot0._gohechengeffect = gohelper.findChild(slot0._gochange, "combine/#hechengeffect")

	slot0._simagecombinebg:LoadImage(ResUrl.getRoomImage("bg_hechengdiban"))

	slot4 = AudioEnum.UI.UI_transverse_tabs_click

	gohelper.addUIClickAudio(slot0._btnproduct.gameObject, slot4)

	slot0._materialItemList = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0._gochange, "combine/go_combine3/item" .. slot4)
		slot5.goempty = gohelper.findChild(slot5.go, "go_empty")
		slot5.gogooditem = gohelper.findChild(slot5.go, "go_gooditem")
		slot5.gogooditempos = gohelper.findChild(slot5.go, "go_gooditem/go_gooditempos")
		slot5.txtcount = gohelper.findChildText(slot5.go, "go_gooditem/countbg/txt_count")
		slot5.btnitem = gohelper.findChildButtonWithAudio(slot5.go, "btn_item")

		slot5.btnitem:AddClickListener(function (slot0)
			slot0:_btnitemOnClick(uv0)
		end, slot0)
		gohelper.addUIClickAudio(slot5.btnitem.gameObject, AudioEnum.UI.UI_transverse_tabs_click)

		slot5.isEmpty = false

		table.insert(slot0._materialItemList, slot5)
	end

	slot0._coinItem = IconMgr.instance:getRoomGoodsItem(slot0._gocoinitempos, slot0.viewContainer)

	slot0._coinItem:canShowRareCircle(false)
	slot0._coinItem:setMOValue(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Gold, 0)
	slot0._coinItem:isEnableClick(false)
	slot0._coinItem:isShowCount(false)
	slot0._coinItem:setRecordFarmItem(true)
	slot0._coinItem:setConsume(true)
	RoomBuildingFormulaController.instance:resetSelectFormulaStrId()
end

function slot0.onOpen(slot0)
	slot0:_refresh()

	if slot0.viewParam and slot0.viewParam.showFormulaView then
		slot0.viewContainer:setSelectLine(7)
		slot0:_openSelectFormulaView()
	end
end

function slot0._refresh(slot0)
	slot0:_refreshFormula()
end

function slot0._refreshFormula(slot0)
	slot2 = RoomFormulaListModel.instance:getSelectFormulaId() and slot1 ~= 0
	slot0._inputvalue.inputField.interactable = slot2

	gohelper.setActive(slot0._btnnoformula.gameObject, not slot2)
	gohelper.setActive(slot0._goproducticon.gameObject, slot2)

	if slot2 then
		slot0:_refreshSelect()
	else
		slot0:_refreshEmpty()
	end

	slot0:_refreshNeedTag()
	slot0:_refreshCombineBtn()
	slot0:_refreshInputField()
end

function slot0._refreshSelect(slot0)
	slot0:_refreshProduce()
	slot0:_refreshCostCoinCount()
	slot0:_refreshCostMaterial()
end

function slot0._refreshCostCoinCount(slot0)
	slot1 = 0
	slot2 = 0

	if RoomProductionHelper.getCostCoinItemList(RoomFormulaListModel.instance:getSelectFormulaId())[1] then
		slot1 = slot5.quantity or 0
		slot2 = ItemModel.instance:getItemQuantity(slot5.type, slot5.id)
	end

	if slot2 < slot1 * RoomFormulaListModel.instance:getSelectFormulaCombineCount() then
		slot0._txtgold.text = string.format("<color=#d97373>%s</color>", slot7)
	else
		slot0._txtgold.text = GameUtil.numberDisplay(slot7)
	end

	slot0._toatalNeedSocre = slot7

	gohelper.setActive(slot0._gogooditem, slot7 > 0)
	gohelper.setActive(slot0._goempty, slot7 <= 0)
end

function slot0._refreshCostMaterial(slot0)
	slot2 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()
	slot7 = #RoomProductionHelper.getCostMaterialItemList(RoomFormulaListModel.instance:getSelectFormulaId())

	for slot7 = 1, math.min(slot7, #slot0._materialItemList) do
		slot8 = slot3[slot7]

		if slot0._materialItemList[slot7] then
			slot9.costItem = slot9.costItem or IconMgr.instance:getRoomGoodsItem(slot9.gogooditempos, slot0.viewContainer)

			slot9.costItem:canShowRareCircle(false)
			slot9.costItem:setMOValue(slot8.type, slot8.id, slot8.quantity * slot2)
			slot9.costItem:isEnableClick(false)
			slot9.costItem:isShowCount(false)
			slot9.costItem:setRecordFarmItem(true)
			slot9.costItem:setConsume(true)
			slot9.costItem:setJumpFinishCallback(slot0.jumpFinishCallback, slot0)

			if ItemModel.instance:getItemQuantity(slot8.type, slot8.id) < slot8.quantity * slot2 then
				slot9.txtcount.text = string.format("<color=#d97373>%s/%s</color>", slot10, slot11)

				slot9.costItem:setGrayscale(true)
			else
				slot9.txtcount.text = string.format("%s/%s", RoomProductionHelper.formatItemNum(slot10), slot11)

				slot9.costItem:setGrayscale(false)
			end

			slot9.isEmpty = false

			gohelper.setActive(slot9.go, true)
			gohelper.setActive(slot9.goempty, false)
			gohelper.setActive(slot9.gogooditem, true)
		end
	end

	slot7 = #slot0._materialItemList

	for slot7 = math.min(#slot3, slot7) + 1, #slot0._materialItemList do
		slot8 = slot0._materialItemList[slot7]
		slot8.isEmpty = true

		gohelper.setActive(slot8.go, true)
		gohelper.setActive(slot8.goempty, true)
		gohelper.setActive(slot8.gogooditem, false)
	end
end

function slot0._refreshProduce(slot0)
	slot2 = RoomProductionHelper.getFormulaProduceItem(RoomFormulaListModel.instance:getSelectFormulaId())

	gohelper.setActive(slot0._simageproducticon.gameObject, slot2)
	gohelper.setActive(slot0._imageproductrare.gameObject, slot2)
	gohelper.setActive(slot0._goproductadd, slot2 == nil)

	if slot2 then
		slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot2.type, slot2.id)

		slot0._simageproducticon:LoadImage(slot4)
		UISpriteSetMgr.instance:setRoomSprite(slot0._imageproductrare, "huangyuan_pz_" .. CharacterEnum.Color[slot3.rare])
	end
end

function slot0._refreshEmpty(slot0)
	slot0._inputvalue:SetText(tostring(0))
	gohelper.setActive(slot0._simageproducticon.gameObject, false)
	gohelper.setActive(slot0._imageproductrare.gameObject, false)

	slot4 = true

	gohelper.setActive(slot0._goproductadd, slot4)

	for slot4, slot5 in ipairs(slot0._materialItemList) do
		gohelper.setActive(slot5.go, true)
		gohelper.setActive(slot5.goempty, true)
		gohelper.setActive(slot5.gogooditem, false)
	end

	gohelper.setActive(slot0._goempty, true)
	gohelper.setActive(slot0._gogooditem, false)
end

function slot0._refreshNeedTag(slot0)
	slot1, slot2, slot3 = nil

	if RoomFormulaListModel.instance:getSelectFormulaMo() then
		slot3 = RoomProductionHelper.getFormulaNeedQuantity(slot4:getId())

		if RoomProductionHelper.getFormulaProduceItem(slot4:getFormulaId()) then
			slot2 = ItemModel.instance:getItemQuantity(slot7.type, slot7.id)
		end

		slot1 = slot4:isTreeFormula() and "room_formula_need_desc2" or "room_formula_need_desc3"
	end

	if slot2 and slot3 and slot1 and slot3 ~= 0 then
		slot5 = "#D97373"

		if slot3 <= slot2 then
			slot5 = "#81ce83"
		end

		slot0._txtNeed.text = formatLuaLang(slot1, string.format("<color=%s>%s</color>/%s", slot5, GameUtil.numberDisplay(slot2), GameUtil.numberDisplay(slot3)))

		gohelper.setActive(slot0._txtNeed.gameObject, true)
	else
		gohelper.setActive(slot0._txtNeed.gameObject, false)
	end
end

function slot0._refreshCombineBtn(slot0)
	slot2 = false
	slot3 = 0

	if RoomFormulaListModel.instance:getSelectFormulaId() and slot1 ~= 0 then
		slot2 = RoomProductionHelper.getTotalCanCombineNum(slot1) ~= 0
	end

	slot4 = false
	slot5 = "room_formula_combine"
	slot6 = false

	if slot2 then
		slot0._txtCanCombine.text = formatLuaLang("room_formula_can_combine", GameUtil.numberDisplay(slot3))
		slot8 = RoomFormulaListModel.instance:getSelectFormulaCombineCount()

		if RoomProductionHelper.isEnoughCoin(slot1, slot8) and RoomProductionHelper.isEnoughMaterial(slot1, slot8) then
			slot6 = true
		elseif slot8 <= slot3 then
			slot6 = true
			slot5 = "room_formula_easy_combine"
		end
	end

	slot0._txtCombine.text = luaLang(slot5)
	slot0.isEasyCombine = not slot4

	gohelper.setActive(slot0._goCanCombine, slot2)
	gohelper.setActive(slot0._golevelupbeffect, slot6)
	ZProj.UGUIHelper.SetGrayscale(slot0._btncombine.gameObject, not slot6)
end

function slot0._refreshInputField(slot0)
	if string.nilorempty(RoomFormulaListModel.instance:getSelectFormulaStrId()) then
		return
	end

	slot0._inputvalue:RemoveOnValueChanged()
	slot0._inputvalue:SetText(tostring(RoomFormulaListModel.instance:getSelectFormulaCombineCount()))
	slot0._inputvalue:AddOnValueChanged(slot0._onValueChanged, slot0)
end

function slot0.setStartFormulaStrId(slot0)
	slot0._startFormulaStrId = RoomFormulaListModel.instance:getSelectFormulaStrId()
end

function slot0._resetCount(slot0)
	if string.nilorempty(RoomFormulaListModel.instance:getSelectFormulaStrId()) then
		return
	end

	if RoomFormulaModel.instance:getFormulaMo(slot1) then
		slot2:resetFormulaCombineCount()
	end
end

function slot0._trySetCount(slot0, slot1, slot2, slot3)
	if string.nilorempty(RoomFormulaListModel.instance:getSelectFormulaStrId()) then
		return
	end

	slot5 = true

	if math.max(1, slot1) >= 0 and RoomBuildingEnum.MachineSlotMaxCount < slot6 then
		slot6 = RoomBuildingEnum.MachineSlotMaxCount

		if slot2 and not slot0._blockLongPress then
			GameFacade.showToast(ToastEnum.RoomInitBuildingSetCount)

			slot5 = false
		end

		slot0:_setBlockLongPress()
	end

	if RoomFormulaListModel.instance:getSelectFormulaCombineCount() < slot6 and slot3 then
		gohelper.setActive(slot0._gobgvx, false)
		gohelper.setActive(slot0._gobgvx, true)
	end

	if RoomFormulaModel.instance:getFormulaMo(slot4) then
		slot8:setFormulaCombineCount(slot6)
	end

	slot0:_refreshFormula()

	return slot5
end

function slot0._setBlockLongPress(slot0)
	if slot0._isLongPress then
		slot0._blockLongPress = true
	end
end

function slot0.onClose(slot0)
	JumpModel.instance:clearRecordFarmItem()
end

function slot0.onDestroyView(slot0)
	slot5 = false

	PopupController.instance:setPause("roominitbuildingview_changestart", slot5)

	slot4 = "roominitbuildingview_changestart"

	UIBlockMgr.instance:endBlock(slot4)

	for slot4, slot5 in ipairs(slot0._materialItemList) do
		slot5.btnitem:RemoveClickListener()
	end

	slot0._simageproducticon:UnLoadImage()
	slot0._simagecombinebg:UnLoadImage()
end

return slot0
