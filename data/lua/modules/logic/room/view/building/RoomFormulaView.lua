module("modules.logic.room.view.building.RoomFormulaView", package.seeall)

slot0 = class("RoomFormulaView", BaseView)
slot1 = "#FF7C40"
slot2 = "#787878"

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_bg2")
	slot0._scrollcategory = gohelper.findChildScrollRect(slot0.viewGO, "view/#scroll_category")
	slot0._goshowtypeitem = gohelper.findChild(slot0.viewGO, "view/#scroll_category/viewport/content/#go_showtypeitem")
	slot0._scrollformula = gohelper.findChildScrollRect(slot0.viewGO, "view/#scroll_formula")
	slot0._scrollRectFormula = slot0._scrollformula:GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/#btn_close")
	slot0._btnquality = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/sortBtn/#btn_quality")
	slot0._btnconsumetime = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/sortBtn/#btn_consumetime")
	slot0._btnorder = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/sortBtn/#btn_order")
	slot0._btnList = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/ListBtn")
	slot0._imageBtnList = gohelper.findChildImage(slot0.viewGO, "view/ListBtn/image_ListBtn")
	slot0._goNeed = gohelper.findChild(slot0.viewGO, "view/#go_NeedProp")
	slot0._txtNeed = gohelper.findChildText(slot0.viewGO, "view/#go_NeedProp/#txt_NeedProp")
	slot0._btnNeedClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/#go_NeedProp/btnClick")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnquality:AddClickListener(slot0._btnqualityOnClick, slot0)
	slot0._btnconsumetime:AddClickListener(slot0._btnconsumetimeOnClick, slot0)
	slot0._btnorder:AddClickListener(slot0._btnorderOnClick, slot0)
	slot0._btnList:AddClickListener(slot0._btnListOnClick, slot0)
	slot0._btnNeedClick:AddClickListener(slot0._btnNeedOnClick, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.NewFormulaPush, slot0._newFormulaPush, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.ProduceLineLevelUp, slot0._onProduceLineLevelUp, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, slot0._onSelectFormulaIdChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.RefreshNeedFormula, slot0._onNeedFormulaRefresh, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshNeedText, slot0)
	gohelper.addUIClickAudio(slot0._btnList.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnquality:RemoveClickListener()
	slot0._btnconsumetime:RemoveClickListener()
	slot0._btnorder:RemoveClickListener()
	slot0._btnList:RemoveClickListener()
	slot0._btnNeedClick:RemoveClickListener()
	slot0:removeEventCb(RoomBuildingController.instance, RoomEvent.NewFormulaPush, slot0._newFormulaPush, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(RoomController.instance, RoomEvent.ProduceLineLevelUp, slot0._onProduceLineLevelUp, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, slot0._onSelectFormulaIdChanged, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshNeedText, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomMapController.instance:dispatchEvent(RoomEvent.ShowInitBuildingChangeTitle)
end

function slot0._btnqualityOnClick(slot0)
	if RoomFormulaListModel.instance:getOrder() == RoomBuildingEnum.FormulaOrderType.RareDown then
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareUp)
	else
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareDown)
	end

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(slot0._lineMO.level)
	slot0:_refreshOrderSelect()
end

function slot0._btnconsumetimeOnClick(slot0)
	if RoomFormulaListModel.instance:getOrder() == RoomBuildingEnum.FormulaOrderType.CostTimeDown then
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.CostTimeUp)
	else
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.CostTimeDown)
	end

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(slot0._lineMO.level)
	slot0:_refreshOrderSelect()
end

function slot0._btnorderOnClick(slot0)
	if RoomFormulaListModel.instance:getOrder() == RoomBuildingEnum.FormulaOrderType.OrderDown then
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.OrderUp)
	else
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.OrderDown)
	end

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(slot0._lineMO.level)
	slot0:_refreshOrderSelect()
end

function slot0._btnclickOnClick(slot0, slot1)
	if slot0._selectIndex == slot1 then
		return
	end

	if not slot0._showTypeItemList[slot1] then
		return
	end

	if slot0._lineMO.level < slot2.unlockLevel then
		GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, slot0._lineMO.config.name, slot2.unlockLevel)

		return
	end

	slot0._selectIndex = slot1

	AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_first_tabs_click)
	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	slot0:_refreshShowTypeSelect()
	slot0:focusPos()
end

function slot0._btnListOnClick(slot0)
	slot1 = not RoomFormulaListModel.instance:getIsInList()

	RoomFormulaListModel.instance:setIsInList(slot1)

	if slot1 then
		slot0._imageBtnList.color = GameUtil.parseColor(uv0)
	else
		slot0._imageBtnList.color = GameUtil.parseColor(uv1)
	end

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(slot0._lineMO.level)
	slot0:focusPos()
end

function slot0._btnNeedOnClick(slot0)
	if slot0._needFormulaShowType then
		for slot4, slot5 in ipairs(slot0._showTypeItemList) do
			if slot5.unlockLevel <= slot0._lineMO.level and slot5.formulaShowType == slot0._needFormulaShowType and slot0._selectIndex ~= slot5.index then
				slot0._selectIndex = slot5.index

				RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
				slot0:_refreshShowTypeSelect()
			end
		end
	end

	slot0._scrollRectFormula.velocity = Vector2(0, 0)

	if slot0._needFormulaStrId then
		if slot0._needFormulaStrId ~= RoomFormulaListModel.instance:getSelectFormulaStrId() then
			RoomBuildingFormulaController.instance:setSelectFormulaStrId(slot0._needFormulaStrId)
		end

		slot0:focusPos()
	end
end

function slot0._onEscapeBtnClick(slot0)
	if slot0.viewParam and slot0.viewParam.openInOutside then
		ViewMgr.instance:closeView(ViewName.RoomInitBuildingView, true)
	else
		slot0:_btncloseOnClick()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.RoomInitBuildingView then
		ViewMgr.instance:closeView(slot0.viewName, true, true)
	end
end

function slot0._onProduceLineLevelUp(slot0)
	slot0:_refreshUI()
end

function slot0._newFormulaPush(slot0)
	RoomFormulaListModel.instance:setFormulaList(slot0._lineMO.level)

	slot0._scrollformula.verticalNormalizedPosition = 1
end

function slot0._onSelectFormulaIdChanged(slot0, slot1, slot2)
	slot3 = RoomFormulaListModel.instance:getSelectFormulaStrId()

	if not RoomFormulaListModel.instance:getIsInList() then
		return
	end

	slot5 = false

	if not string.nilorempty(slot3) then
		if slot1 then
			if RoomFormulaListModel.instance:getSelectFormulaMo() then
				if slot6:getFormulaTreeLevel() == RoomFormulaModel.DEFAULT_TREE_LEVEL then
					slot5 = not slot6:getIsExpandTree()
				else
					slot5 = false
				end
			end
		else
			slot5 = true
		end
	end

	if slot5 then
		if RoomFormulaListModel.instance:expandOrHideTreeFormulaList(slot1, slot2) then
			TaskDispatcher.runDelay(slot0.focusPos, slot0, RoomFormulaListModel.ANIMATION_WAIT_TIME)
		else
			slot0:focusPos()
		end
	end
end

function slot0._onNeedFormulaRefresh(slot0)
	slot0._needFormulaShowType, slot0._needFormulaStrId = RoomProductionHelper.getNeedFormulaShowTypeAndFormulaStrId(slot0._lineMO)

	slot0:_refreshNeedText()
	slot0:_btnNeedOnClick()
end

function slot0.focusPos(slot0)
	if not slot0.viewportHeight or not slot0.viewportCapacity or not slot0.viewContainer or gohelper.isNil(slot0._scrollcontent) then
		return
	end

	slot2 = RoomFormulaListModel.instance:getCount()

	if RoomFormulaListModel.instance:getSelectFormulaStrIdIndex() > 0 and slot0.viewportCapacity < slot2 then
		slot3 = 0

		if slot2 - slot1 < slot0.viewportCapacity - 1 then
			slot3 = slot0.viewportCapacity * slot0.viewContainer.cellHeightSize - slot0.viewportHeight
			slot1 = slot2 - slot0.viewportCapacity + 1
		end

		recthelper.setAnchorY(slot0._scrollcontent.transform, (slot1 - 1) * slot0.viewContainer.cellHeightSize + slot3)
		slot0.viewContainer:getCsListScroll():UpdateCells(false)
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._scrollcontent = gohelper.findChild(slot0._scrollformula.gameObject, "viewport/content")
	slot0._scrollViewport = gohelper.findChild(slot0._scrollformula.gameObject, "viewport")
	slot0._scrollHeight = recthelper.getHeight(slot0._scrollformula.transform)
	slot0._goNeedHeight = recthelper.getHeight(slot0._goNeed.transform)

	gohelper.setActive(slot0._btnconsumetime.gameObject, false)

	slot0._showTypeItemList = {}

	gohelper.setActive(slot0._goshowtypeitem, false)

	slot0._rareItem = slot0:getUserDataTb_()
	slot0._costTimeItem = slot0:getUserDataTb_()
	slot0._orderItem = slot0:getUserDataTb_()
	slot0._rareItem.go = slot0._btnquality.gameObject
	slot0._costTimeItem.go = slot0._btnconsumetime.gameObject
	slot0._orderItem.go = slot0._btnorder.gameObject

	slot0:_initSortItem(slot0._rareItem)
	slot0:_initSortItem(slot0._costTimeItem)
	slot0:_initSortItem(slot0._orderItem)
	RoomFormulaListModel.instance:resetIsInList()
	gohelper.addUIClickAudio(slot0._btnquality.gameObject, AudioEnum.UI.UI_vertical_second_tabs_click)
	gohelper.addUIClickAudio(slot0._btnconsumetime.gameObject, AudioEnum.UI.UI_vertical_second_tabs_click)
	gohelper.addUIClickAudio(slot0._btnorder.gameObject, AudioEnum.UI.UI_vertical_second_tabs_click)
	gohelper.removeUIClickAudio(slot0._btnclose.gameObject)
end

function slot0._initSortItem(slot0, slot1)
	slot1.gounselect = gohelper.findChild(slot1.go, "btn1")
	slot1.goselect = gohelper.findChild(slot1.go, "btn2")
	slot1.selectArrow = gohelper.findChild(slot1.go, "btn2/txt/arrow")
	slot1.unselectArrow = gohelper.findChild(slot1.go, "btn1/txt/arrow")
end

function slot0.onOpen(slot0)
	slot0._lineMO = slot0.viewParam.lineMO
	slot0._buildingType = slot0.viewParam.buildingType
	slot0._needFormulaShowType = nil
	slot0._needFormulaStrId = nil
	slot0._needFormulaShowType, slot0._needFormulaStrId = RoomProductionHelper.getNeedFormulaShowTypeAndFormulaStrId(slot0._lineMO)

	if slot0.viewParam.openInOutside then
		gohelper.setActive(slot0._btnclose.gameObject, false)
		PostProcessingMgr.instance:setViewBlur(slot0.viewName, 1)
	else
		PostProcessingMgr.instance:setViewBlur(slot0.viewName, 2)
		gohelper.setActive(slot0._btnclose.gameObject, true)
	end

	NavigateMgr.instance:addEscape(ViewName.RoomFormulaView, slot0._onEscapeBtnClick, slot0)
	RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareDown)
	slot0:_refreshUI()
end

function slot0.onUpdateParam(slot0)
	slot0._lineMO = slot0.viewParam.lineMO
	slot0._buildingType = slot0.viewParam.buildingType

	RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareDown)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0:_refreshShowType()
	slot0:_refreshOrderSelect()
	slot0:_refreshNeedText()
	TaskDispatcher.runDelay(slot0._refreshScrollContent, slot0, 0.01)

	if slot0._needFormulaStrId then
		RoomBuildingFormulaController.instance:setSelectFormulaStrId(slot0._needFormulaStrId, true)
		slot0:focusPos()
	end
end

function slot0._refreshShowType(slot0)
	slot0._selectIndex = nil
	slot1 = {}

	for slot5, slot6 in ipairs(lua_formula_showtype.configList) do
		if slot6.buildingType == slot0._buildingType then
			table.insert(slot1, slot6)
		end
	end

	function slot5(slot0, slot1)
		if RoomFormulaModel.instance:getTopTreeLevelFormulaCount(slot0.id) > 0 and not (RoomFormulaModel.instance:getTopTreeLevelFormulaCount(slot1.id) > 0) then
			return true
		elseif slot3 and not slot2 then
			return false
		else
			return slot0.id < slot1.id
		end
	end

	table.sort(slot1, slot5)

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._showTypeItemList[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.index = slot5
			slot7.go = gohelper.cloneInPlace(slot0._goshowtypeitem, "showtypeitem" .. slot5)
			slot7.goselect = gohelper.findChild(slot7.go, "go_select")
			slot7.goitem = gohelper.findChild(slot7.go, "go_item")
			slot7.goline = gohelper.findChild(slot7.go, "go_item/go_line")
			slot7.gofirstline = gohelper.findChild(slot7.go, "go_item/go_firstline")
			slot7.golock = gohelper.findChild(slot7.go, "go_lock")
			slot7.imageicon = gohelper.findChildImage(slot7.go, "go_item/image_recipe")
			slot7.txtname = gohelper.findChildText(slot7.go, "go_item/txt_recipeName")
			slot7.txtnameEn = gohelper.findChildText(slot7.go, "go_item/txt_recipeName/txt_recipeNameEn")
			slot7.btnclick = gohelper.findChildButton(slot7.go, "btn_click")

			slot7.btnclick:AddClickListener(slot0._btnclickOnClick, slot0, slot7.index)
			table.insert(slot0._showTypeItemList, slot7)
		end

		slot7.formulaShowType = slot6.id
		slot7.unlockLevel = RoomProductionHelper.isFormulaShowTypeUnlock(slot7.formulaShowType)
		slot8 = slot7.unlockLevel <= slot0._lineMO.level
		slot9 = false

		if slot0._needFormulaShowType then
			slot9 = slot7.formulaShowType == slot0._needFormulaShowType
		end

		if slot8 and (not slot0._selectIndex or slot9) then
			slot0._selectIndex = slot7.index
		end

		slot7.goitem:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = slot7.unlockLevel <= slot0._lineMO.level and 1 or 0.3

		gohelper.setActive(slot7.golock, slot0._lineMO.level < slot7.unlockLevel)
		ZProj.UGUIHelper.SetColorAlpha(slot7.imageicon, slot0._lineMO.level < slot7.unlockLevel and 0.5 or 1)
		ZProj.UGUIHelper.SetColorAlpha(slot7.txtname, slot0._lineMO.level < slot7.unlockLevel and 0.5 or 1)

		slot7.txtname.text = slot6.name
		slot7.txtnameEn.text = slot6.nameEn

		UISpriteSetMgr.instance:setRoomSprite(slot7.imageicon, "formulate_" .. slot6.icon)
		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._showTypeItemList do
		gohelper.setActive(slot0._showTypeItemList[slot5].go, false)
	end

	slot0._scrollcategory.verticalNormalizedPosition = 1

	slot0:_refreshShowTypeSelect()
end

function slot0._refreshShowTypeSelect(slot0)
	for slot4, slot5 in ipairs(slot0._showTypeItemList) do
		gohelper.setActive(slot5.goselect, slot5.index == slot0._selectIndex)
		gohelper.setActive(slot5.gofirstline, slot5.index ~= slot0._selectIndex and slot4 == 1)
		gohelper.setActive(slot0._showTypeItemList[slot0._selectIndex].goline, slot5.index ~= slot0._selectIndex)

		if slot0._selectIndex > 1 then
			gohelper.setActive(slot0._showTypeItemList[slot0._selectIndex - 1].goline, slot5.index ~= slot0._selectIndex)
		end

		SLFramework.UGUI.GuiHelper.SetColor(slot5.txtname, slot5.index == slot0._selectIndex and "E99B56" or "#CAC8C5")
		SLFramework.UGUI.GuiHelper.SetColor(slot5.txtnameEn, slot5.index == slot0._selectIndex and "E99B56" or "#CAC8C5")
	end

	if slot0._selectIndex then
		if slot0._showTypeItemList[slot0._selectIndex] and slot1.unlockLevel <= slot0._lineMO.level then
			RoomFormulaListModel.instance:setFormulaShowType(slot1.formulaShowType)
		else
			RoomFormulaListModel.instance:setFormulaShowType(nil)
		end
	else
		RoomFormulaListModel.instance:setFormulaShowType(nil)
	end

	RoomFormulaListModel.instance:setFormulaList(slot0._lineMO.level)

	slot0._scrollformula.verticalNormalizedPosition = 1

	slot0:_refreshScrollContent()
end

function slot0._refreshOrderSelect(slot0)
	if RoomFormulaListModel.instance:getOrder() == RoomBuildingEnum.FormulaOrderType.RareUp then
		slot0:_setSortItemUp(slot0._rareItem)
	elseif slot1 == RoomBuildingEnum.FormulaOrderType.RareDown then
		slot0:_setSortItemDown(slot0._rareItem)
	else
		slot0:_setSortItemDefault(slot0._rareItem)
	end

	if slot1 == RoomBuildingEnum.FormulaOrderType.CostTimeUp then
		slot0:_setSortItemUp(slot0._costTimeItem)
	elseif slot1 == RoomBuildingEnum.FormulaOrderType.CostTimeDown then
		slot0:_setSortItemDown(slot0._costTimeItem)
	else
		slot0:_setSortItemDefault(slot0._costTimeItem)
	end

	if slot1 == RoomBuildingEnum.FormulaOrderType.OrderUp then
		slot0:_setSortItemUp(slot0._orderItem)
	elseif slot1 == RoomBuildingEnum.FormulaOrderType.OrderDown then
		slot0:_setSortItemDown(slot0._orderItem)
	else
		slot0:_setSortItemDefault(slot0._orderItem)
	end
end

function slot0._setSortItemDefault(slot0, slot1)
	gohelper.setActive(slot1.gounselect, true)
	gohelper.setActive(slot1.goselect, false)
end

function slot0._setSortItemDown(slot0, slot1)
	gohelper.setActive(slot1.gounselect, false)
	gohelper.setActive(slot1.goselect, true)

	slot2, slot3, slot4 = transformhelper.getLocalScale(slot1.selectArrow.transform)

	transformhelper.setLocalScale(slot1.selectArrow.transform, slot2, math.abs(slot3), slot4)
	transformhelper.setLocalScale(slot1.unselectArrow.transform, slot2, math.abs(slot3), slot4)
end

function slot0._setSortItemUp(slot0, slot1)
	gohelper.setActive(slot1.gounselect, false)
	gohelper.setActive(slot1.goselect, true)

	slot2, slot3, slot4 = transformhelper.getLocalScale(slot1.selectArrow.transform)

	transformhelper.setLocalScale(slot1.selectArrow.transform, slot2, -math.abs(slot3), slot4)
	transformhelper.setLocalScale(slot1.unselectArrow.transform, slot2, -math.abs(slot3), slot4)
end

function slot0._refreshNeedText(slot0)
	slot1 = false

	if JumpModel.instance:getRecordFarmItem() then
		slot1 = true
		slot3 = ItemModel.instance:getItemConfig(slot2.type, slot2.id)
		slot4 = ItemModel.instance:getItemQuantity(slot2.type, slot2.id)
		slot5 = ""

		if slot2.quantity and slot2.quantity ~= 0 then
			slot6 = "#D97373"

			if slot2.quantity <= slot4 then
				slot6 = "#81ce83"
			end

			slot5 = string.format("<color=%s>%s</color>/%s", slot6, GameUtil.numberDisplay(slot4), GameUtil.numberDisplay(slot2.quantity))
		end

		slot0._txtNeed.text = GameUtil.getSubPlaceholderLuaLang(luaLang("room_formula_need_desc"), {
			slot3.name,
			slot5
		})

		recthelper.setWidth(slot0._btnNeedClick.transform, slot0._txtNeed.preferredWidth)
	end

	slot3 = slot0._scrollHeight

	if slot1 then
		slot3 = slot0._scrollHeight - slot0._goNeedHeight
	end

	recthelper.setHeight(slot0._scrollformula.transform, slot3)
	gohelper.setActive(slot0._goNeed, slot1)

	slot0.viewportHeight = recthelper.getHeight(slot0._scrollViewport.transform)
	slot0.viewportCapacity = math.ceil(slot0.viewportHeight / slot0.viewContainer.cellHeightSize)
end

function slot0._refreshScrollContent(slot0)
	if not slot0._scrollHeight or gohelper.isNil(slot0._scrollcontent) then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._scrollcontent.transform)

	slot0._couldScroll = slot0._scrollHeight < recthelper.getHeight(slot0._scrollcontent.transform) and true or false
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.focusPos, slot0)
	TaskDispatcher.cancelTask(slot0._refreshScrollContent, slot0)

	if slot0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()

	for slot4, slot5 in ipairs(slot0._showTypeItemList) do
		slot5.btnclick:RemoveClickListener()
	end

	RoomFormulaListModel.instance:resetIsInList()
end

return slot0
