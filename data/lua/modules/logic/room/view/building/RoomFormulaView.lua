module("modules.logic.room.view.building.RoomFormulaView", package.seeall)

local var_0_0 = class("RoomFormulaView", BaseView)
local var_0_1 = "#FF7C40"
local var_0_2 = "#787878"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_bg2")
	arg_1_0._scrollcategory = gohelper.findChildScrollRect(arg_1_0.viewGO, "view/#scroll_category")
	arg_1_0._goshowtypeitem = gohelper.findChild(arg_1_0.viewGO, "view/#scroll_category/viewport/content/#go_showtypeitem")
	arg_1_0._scrollformula = gohelper.findChildScrollRect(arg_1_0.viewGO, "view/#scroll_formula")
	arg_1_0._scrollRectFormula = arg_1_0._scrollformula:GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#btn_close")
	arg_1_0._btnquality = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/sortBtn/#btn_quality")
	arg_1_0._btnconsumetime = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/sortBtn/#btn_consumetime")
	arg_1_0._btnorder = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/sortBtn/#btn_order")
	arg_1_0._btnList = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/ListBtn")
	arg_1_0._imageBtnList = gohelper.findChildImage(arg_1_0.viewGO, "view/ListBtn/image_ListBtn")
	arg_1_0._goNeed = gohelper.findChild(arg_1_0.viewGO, "view/#go_NeedProp")
	arg_1_0._txtNeed = gohelper.findChildText(arg_1_0.viewGO, "view/#go_NeedProp/#txt_NeedProp")
	arg_1_0._btnNeedClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#go_NeedProp/btnClick")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnquality:AddClickListener(arg_2_0._btnqualityOnClick, arg_2_0)
	arg_2_0._btnconsumetime:AddClickListener(arg_2_0._btnconsumetimeOnClick, arg_2_0)
	arg_2_0._btnorder:AddClickListener(arg_2_0._btnorderOnClick, arg_2_0)
	arg_2_0._btnList:AddClickListener(arg_2_0._btnListOnClick, arg_2_0)
	arg_2_0._btnNeedClick:AddClickListener(arg_2_0._btnNeedOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomBuildingController.instance, RoomEvent.NewFormulaPush, arg_2_0._newFormulaPush, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(RoomController.instance, RoomEvent.ProduceLineLevelUp, arg_2_0._onProduceLineLevelUp, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, arg_2_0._onSelectFormulaIdChanged, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.RefreshNeedFormula, arg_2_0._onNeedFormulaRefresh, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._refreshNeedText, arg_2_0)
	gohelper.addUIClickAudio(arg_2_0._btnList.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnquality:RemoveClickListener()
	arg_3_0._btnconsumetime:RemoveClickListener()
	arg_3_0._btnorder:RemoveClickListener()
	arg_3_0._btnList:RemoveClickListener()
	arg_3_0._btnNeedClick:RemoveClickListener()
	arg_3_0:removeEventCb(RoomBuildingController.instance, RoomEvent.NewFormulaPush, arg_3_0._newFormulaPush, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(RoomController.instance, RoomEvent.ProduceLineLevelUp, arg_3_0._onProduceLineLevelUp, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, arg_3_0._onSelectFormulaIdChanged, arg_3_0)
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._refreshNeedText, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomMapController.instance:dispatchEvent(RoomEvent.ShowInitBuildingChangeTitle)
end

function var_0_0._btnqualityOnClick(arg_5_0)
	if RoomFormulaListModel.instance:getOrder() == RoomBuildingEnum.FormulaOrderType.RareDown then
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareUp)
	else
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareDown)
	end

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(arg_5_0._lineMO.level)
	arg_5_0:_refreshOrderSelect()
end

function var_0_0._btnconsumetimeOnClick(arg_6_0)
	if RoomFormulaListModel.instance:getOrder() == RoomBuildingEnum.FormulaOrderType.CostTimeDown then
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.CostTimeUp)
	else
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.CostTimeDown)
	end

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(arg_6_0._lineMO.level)
	arg_6_0:_refreshOrderSelect()
end

function var_0_0._btnorderOnClick(arg_7_0)
	if RoomFormulaListModel.instance:getOrder() == RoomBuildingEnum.FormulaOrderType.OrderDown then
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.OrderUp)
	else
		RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.OrderDown)
	end

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(arg_7_0._lineMO.level)
	arg_7_0:_refreshOrderSelect()
end

function var_0_0._btnclickOnClick(arg_8_0, arg_8_1)
	if arg_8_0._selectIndex == arg_8_1 then
		return
	end

	local var_8_0 = arg_8_0._showTypeItemList[arg_8_1]

	if not var_8_0 then
		return
	end

	if var_8_0.unlockLevel > arg_8_0._lineMO.level then
		GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, arg_8_0._lineMO.config.name, var_8_0.unlockLevel)

		return
	end

	arg_8_0._selectIndex = arg_8_1

	AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_first_tabs_click)
	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	arg_8_0:_refreshShowTypeSelect()
	arg_8_0:focusPos()
end

function var_0_0._btnListOnClick(arg_9_0)
	local var_9_0 = not RoomFormulaListModel.instance:getIsInList()

	RoomFormulaListModel.instance:setIsInList(var_9_0)

	if var_9_0 then
		arg_9_0._imageBtnList.color = GameUtil.parseColor(var_0_1)
	else
		arg_9_0._imageBtnList.color = GameUtil.parseColor(var_0_2)
	end

	RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
	RoomFormulaListModel.instance:setFormulaList(arg_9_0._lineMO.level)
	arg_9_0:focusPos()
end

function var_0_0._btnNeedOnClick(arg_10_0)
	if arg_10_0._needFormulaShowType then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._showTypeItemList) do
			if iter_10_1.unlockLevel <= arg_10_0._lineMO.level and iter_10_1.formulaShowType == arg_10_0._needFormulaShowType and arg_10_0._selectIndex ~= iter_10_1.index then
				arg_10_0._selectIndex = iter_10_1.index

				RoomFormulaListModel.instance:changeSelectFormulaToTopLevel()
				arg_10_0:_refreshShowTypeSelect()
			end
		end
	end

	arg_10_0._scrollRectFormula.velocity = Vector2(0, 0)

	if arg_10_0._needFormulaStrId then
		local var_10_0 = RoomFormulaListModel.instance:getSelectFormulaStrId()

		if arg_10_0._needFormulaStrId ~= var_10_0 then
			RoomBuildingFormulaController.instance:setSelectFormulaStrId(arg_10_0._needFormulaStrId)
		end

		arg_10_0:focusPos()
	end
end

function var_0_0._onEscapeBtnClick(arg_11_0)
	if arg_11_0.viewParam and arg_11_0.viewParam.openInOutside then
		ViewMgr.instance:closeView(ViewName.RoomInitBuildingView, true)
	else
		arg_11_0:_btncloseOnClick()
	end
end

function var_0_0._onCloseView(arg_12_0, arg_12_1)
	if arg_12_1 == ViewName.RoomInitBuildingView then
		ViewMgr.instance:closeView(arg_12_0.viewName, true, true)
	end
end

function var_0_0._onProduceLineLevelUp(arg_13_0)
	arg_13_0:_refreshUI()
end

function var_0_0._newFormulaPush(arg_14_0)
	RoomFormulaListModel.instance:setFormulaList(arg_14_0._lineMO.level)

	arg_14_0._scrollformula.verticalNormalizedPosition = 1
end

function var_0_0._onSelectFormulaIdChanged(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = RoomFormulaListModel.instance:getSelectFormulaStrId()

	if not RoomFormulaListModel.instance:getIsInList() then
		return
	end

	local var_15_1 = false

	if not string.nilorempty(var_15_0) then
		if arg_15_1 then
			local var_15_2 = RoomFormulaListModel.instance:getSelectFormulaMo()

			if var_15_2 then
				local var_15_3 = var_15_2:getFormulaTreeLevel()
				local var_15_4 = var_15_2:getIsExpandTree()

				var_15_1 = var_15_3 == RoomFormulaModel.DEFAULT_TREE_LEVEL and not var_15_4
			end
		else
			var_15_1 = true
		end
	end

	local var_15_5 = RoomFormulaListModel.instance:expandOrHideTreeFormulaList(arg_15_1, arg_15_2)

	if var_15_1 then
		if var_15_5 then
			TaskDispatcher.runDelay(arg_15_0.focusPos, arg_15_0, RoomFormulaListModel.ANIMATION_WAIT_TIME)
		else
			arg_15_0:focusPos()
		end
	end
end

function var_0_0._onNeedFormulaRefresh(arg_16_0)
	arg_16_0._needFormulaShowType, arg_16_0._needFormulaStrId = RoomProductionHelper.getNeedFormulaShowTypeAndFormulaStrId(arg_16_0._lineMO)

	arg_16_0:_refreshNeedText()
	arg_16_0:_btnNeedOnClick()
end

function var_0_0.focusPos(arg_17_0)
	if not arg_17_0.viewportHeight or not arg_17_0.viewportCapacity or not arg_17_0.viewContainer or gohelper.isNil(arg_17_0._scrollcontent) then
		return
	end

	local var_17_0 = RoomFormulaListModel.instance:getSelectFormulaStrIdIndex()
	local var_17_1 = RoomFormulaListModel.instance:getCount()

	if var_17_0 > 0 and var_17_1 > arg_17_0.viewportCapacity then
		local var_17_2 = 0

		if var_17_1 - var_17_0 < arg_17_0.viewportCapacity - 1 then
			var_17_2 = arg_17_0.viewportCapacity * arg_17_0.viewContainer.cellHeightSize - arg_17_0.viewportHeight
			var_17_0 = var_17_1 - arg_17_0.viewportCapacity + 1
		end

		local var_17_3 = (var_17_0 - 1) * arg_17_0.viewContainer.cellHeightSize + var_17_2

		recthelper.setAnchorY(arg_17_0._scrollcontent.transform, var_17_3)
		arg_17_0.viewContainer:getCsListScroll():UpdateCells(false)
	end
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_18_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_18_0._scrollcontent = gohelper.findChild(arg_18_0._scrollformula.gameObject, "viewport/content")
	arg_18_0._scrollViewport = gohelper.findChild(arg_18_0._scrollformula.gameObject, "viewport")
	arg_18_0._scrollHeight = recthelper.getHeight(arg_18_0._scrollformula.transform)
	arg_18_0._goNeedHeight = recthelper.getHeight(arg_18_0._goNeed.transform)

	gohelper.setActive(arg_18_0._btnconsumetime.gameObject, false)

	arg_18_0._showTypeItemList = {}

	gohelper.setActive(arg_18_0._goshowtypeitem, false)

	arg_18_0._rareItem = arg_18_0:getUserDataTb_()
	arg_18_0._costTimeItem = arg_18_0:getUserDataTb_()
	arg_18_0._orderItem = arg_18_0:getUserDataTb_()
	arg_18_0._rareItem.go = arg_18_0._btnquality.gameObject
	arg_18_0._costTimeItem.go = arg_18_0._btnconsumetime.gameObject
	arg_18_0._orderItem.go = arg_18_0._btnorder.gameObject

	arg_18_0:_initSortItem(arg_18_0._rareItem)
	arg_18_0:_initSortItem(arg_18_0._costTimeItem)
	arg_18_0:_initSortItem(arg_18_0._orderItem)
	RoomFormulaListModel.instance:resetIsInList()
	gohelper.addUIClickAudio(arg_18_0._btnquality.gameObject, AudioEnum.UI.UI_vertical_second_tabs_click)
	gohelper.addUIClickAudio(arg_18_0._btnconsumetime.gameObject, AudioEnum.UI.UI_vertical_second_tabs_click)
	gohelper.addUIClickAudio(arg_18_0._btnorder.gameObject, AudioEnum.UI.UI_vertical_second_tabs_click)
	gohelper.removeUIClickAudio(arg_18_0._btnclose.gameObject)
end

function var_0_0._initSortItem(arg_19_0, arg_19_1)
	arg_19_1.gounselect = gohelper.findChild(arg_19_1.go, "btn1")
	arg_19_1.goselect = gohelper.findChild(arg_19_1.go, "btn2")
	arg_19_1.selectArrow = gohelper.findChild(arg_19_1.go, "btn2/txt/arrow")
	arg_19_1.unselectArrow = gohelper.findChild(arg_19_1.go, "btn1/txt/arrow")
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0._lineMO = arg_20_0.viewParam.lineMO
	arg_20_0._buildingType = arg_20_0.viewParam.buildingType
	arg_20_0._needFormulaShowType = nil
	arg_20_0._needFormulaStrId = nil
	arg_20_0._needFormulaShowType, arg_20_0._needFormulaStrId = RoomProductionHelper.getNeedFormulaShowTypeAndFormulaStrId(arg_20_0._lineMO)

	if arg_20_0.viewParam.openInOutside then
		gohelper.setActive(arg_20_0._btnclose.gameObject, false)
		PostProcessingMgr.instance:setViewBlur(arg_20_0.viewName, 1)
	else
		PostProcessingMgr.instance:setViewBlur(arg_20_0.viewName, 2)
		gohelper.setActive(arg_20_0._btnclose.gameObject, true)
	end

	NavigateMgr.instance:addEscape(ViewName.RoomFormulaView, arg_20_0._onEscapeBtnClick, arg_20_0)
	RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareDown)
	arg_20_0:_refreshUI()
end

function var_0_0.onUpdateParam(arg_21_0)
	arg_21_0._lineMO = arg_21_0.viewParam.lineMO
	arg_21_0._buildingType = arg_21_0.viewParam.buildingType

	RoomFormulaListModel.instance:setOrder(RoomBuildingEnum.FormulaOrderType.RareDown)
	arg_21_0:_refreshUI()
end

function var_0_0._refreshUI(arg_22_0)
	arg_22_0:_refreshShowType()
	arg_22_0:_refreshOrderSelect()
	arg_22_0:_refreshNeedText()
	TaskDispatcher.runDelay(arg_22_0._refreshScrollContent, arg_22_0, 0.01)

	if arg_22_0._needFormulaStrId then
		RoomBuildingFormulaController.instance:setSelectFormulaStrId(arg_22_0._needFormulaStrId, true)
		arg_22_0:focusPos()
	end
end

function var_0_0._refreshShowType(arg_23_0)
	arg_23_0._selectIndex = nil

	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(lua_formula_showtype.configList) do
		if iter_23_1.buildingType == arg_23_0._buildingType then
			table.insert(var_23_0, iter_23_1)
		end
	end

	table.sort(var_23_0, function(arg_24_0, arg_24_1)
		local var_24_0 = RoomFormulaModel.instance:getTopTreeLevelFormulaCount(arg_24_0.id) > 0
		local var_24_1 = RoomFormulaModel.instance:getTopTreeLevelFormulaCount(arg_24_1.id) > 0

		if var_24_0 and not var_24_1 then
			return true
		elseif var_24_1 and not var_24_0 then
			return false
		else
			return arg_24_0.id < arg_24_1.id
		end
	end)

	for iter_23_2, iter_23_3 in ipairs(var_23_0) do
		local var_23_1 = arg_23_0._showTypeItemList[iter_23_2]

		if not var_23_1 then
			var_23_1 = arg_23_0:getUserDataTb_()
			var_23_1.index = iter_23_2
			var_23_1.go = gohelper.cloneInPlace(arg_23_0._goshowtypeitem, "showtypeitem" .. iter_23_2)
			var_23_1.goselect = gohelper.findChild(var_23_1.go, "go_select")
			var_23_1.goitem = gohelper.findChild(var_23_1.go, "go_item")
			var_23_1.goline = gohelper.findChild(var_23_1.go, "go_item/go_line")
			var_23_1.gofirstline = gohelper.findChild(var_23_1.go, "go_item/go_firstline")
			var_23_1.golock = gohelper.findChild(var_23_1.go, "go_lock")
			var_23_1.imageicon = gohelper.findChildImage(var_23_1.go, "go_item/image_recipe")
			var_23_1.txtname = gohelper.findChildText(var_23_1.go, "go_item/txt_recipeName")
			var_23_1.txtnameEn = gohelper.findChildText(var_23_1.go, "go_item/txt_recipeName/txt_recipeNameEn")
			var_23_1.btnclick = gohelper.findChildButton(var_23_1.go, "btn_click")

			var_23_1.btnclick:AddClickListener(arg_23_0._btnclickOnClick, arg_23_0, var_23_1.index)
			table.insert(arg_23_0._showTypeItemList, var_23_1)
		end

		var_23_1.formulaShowType = iter_23_3.id
		var_23_1.unlockLevel = RoomProductionHelper.isFormulaShowTypeUnlock(var_23_1.formulaShowType)

		local var_23_2 = var_23_1.unlockLevel <= arg_23_0._lineMO.level
		local var_23_3 = false

		if arg_23_0._needFormulaShowType then
			var_23_3 = var_23_1.formulaShowType == arg_23_0._needFormulaShowType
		end

		if var_23_2 and (not arg_23_0._selectIndex or var_23_3) then
			arg_23_0._selectIndex = var_23_1.index
		end

		var_23_1.goitem:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = var_23_1.unlockLevel <= arg_23_0._lineMO.level and 1 or 0.3

		gohelper.setActive(var_23_1.golock, var_23_1.unlockLevel > arg_23_0._lineMO.level)
		ZProj.UGUIHelper.SetColorAlpha(var_23_1.imageicon, var_23_1.unlockLevel > arg_23_0._lineMO.level and 0.5 or 1)
		ZProj.UGUIHelper.SetColorAlpha(var_23_1.txtname, var_23_1.unlockLevel > arg_23_0._lineMO.level and 0.5 or 1)

		var_23_1.txtname.text = iter_23_3.name
		var_23_1.txtnameEn.text = iter_23_3.nameEn

		UISpriteSetMgr.instance:setRoomSprite(var_23_1.imageicon, "formulate_" .. iter_23_3.icon)
		gohelper.setActive(var_23_1.go, true)
	end

	for iter_23_4 = #var_23_0 + 1, #arg_23_0._showTypeItemList do
		local var_23_4 = arg_23_0._showTypeItemList[iter_23_4]

		gohelper.setActive(var_23_4.go, false)
	end

	arg_23_0._scrollcategory.verticalNormalizedPosition = 1

	arg_23_0:_refreshShowTypeSelect()
end

function var_0_0._refreshShowTypeSelect(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0._showTypeItemList) do
		gohelper.setActive(iter_25_1.goselect, iter_25_1.index == arg_25_0._selectIndex)
		gohelper.setActive(iter_25_1.gofirstline, iter_25_1.index ~= arg_25_0._selectIndex and iter_25_0 == 1)
		gohelper.setActive(arg_25_0._showTypeItemList[arg_25_0._selectIndex].goline, iter_25_1.index ~= arg_25_0._selectIndex)

		if arg_25_0._selectIndex > 1 then
			gohelper.setActive(arg_25_0._showTypeItemList[arg_25_0._selectIndex - 1].goline, iter_25_1.index ~= arg_25_0._selectIndex)
		end

		SLFramework.UGUI.GuiHelper.SetColor(iter_25_1.txtname, iter_25_1.index == arg_25_0._selectIndex and "E99B56" or "#CAC8C5")
		SLFramework.UGUI.GuiHelper.SetColor(iter_25_1.txtnameEn, iter_25_1.index == arg_25_0._selectIndex and "E99B56" or "#CAC8C5")
	end

	if arg_25_0._selectIndex then
		local var_25_0 = arg_25_0._showTypeItemList[arg_25_0._selectIndex]

		if var_25_0 and var_25_0.unlockLevel <= arg_25_0._lineMO.level then
			RoomFormulaListModel.instance:setFormulaShowType(var_25_0.formulaShowType)
		else
			RoomFormulaListModel.instance:setFormulaShowType(nil)
		end
	else
		RoomFormulaListModel.instance:setFormulaShowType(nil)
	end

	RoomFormulaListModel.instance:setFormulaList(arg_25_0._lineMO.level)

	arg_25_0._scrollformula.verticalNormalizedPosition = 1

	arg_25_0:_refreshScrollContent()
end

function var_0_0._refreshOrderSelect(arg_26_0)
	local var_26_0 = RoomFormulaListModel.instance:getOrder()

	if var_26_0 == RoomBuildingEnum.FormulaOrderType.RareUp then
		arg_26_0:_setSortItemUp(arg_26_0._rareItem)
	elseif var_26_0 == RoomBuildingEnum.FormulaOrderType.RareDown then
		arg_26_0:_setSortItemDown(arg_26_0._rareItem)
	else
		arg_26_0:_setSortItemDefault(arg_26_0._rareItem)
	end

	if var_26_0 == RoomBuildingEnum.FormulaOrderType.CostTimeUp then
		arg_26_0:_setSortItemUp(arg_26_0._costTimeItem)
	elseif var_26_0 == RoomBuildingEnum.FormulaOrderType.CostTimeDown then
		arg_26_0:_setSortItemDown(arg_26_0._costTimeItem)
	else
		arg_26_0:_setSortItemDefault(arg_26_0._costTimeItem)
	end

	if var_26_0 == RoomBuildingEnum.FormulaOrderType.OrderUp then
		arg_26_0:_setSortItemUp(arg_26_0._orderItem)
	elseif var_26_0 == RoomBuildingEnum.FormulaOrderType.OrderDown then
		arg_26_0:_setSortItemDown(arg_26_0._orderItem)
	else
		arg_26_0:_setSortItemDefault(arg_26_0._orderItem)
	end
end

function var_0_0._setSortItemDefault(arg_27_0, arg_27_1)
	gohelper.setActive(arg_27_1.gounselect, true)
	gohelper.setActive(arg_27_1.goselect, false)
end

function var_0_0._setSortItemDown(arg_28_0, arg_28_1)
	gohelper.setActive(arg_28_1.gounselect, false)
	gohelper.setActive(arg_28_1.goselect, true)

	local var_28_0, var_28_1, var_28_2 = transformhelper.getLocalScale(arg_28_1.selectArrow.transform)

	transformhelper.setLocalScale(arg_28_1.selectArrow.transform, var_28_0, math.abs(var_28_1), var_28_2)
	transformhelper.setLocalScale(arg_28_1.unselectArrow.transform, var_28_0, math.abs(var_28_1), var_28_2)
end

function var_0_0._setSortItemUp(arg_29_0, arg_29_1)
	gohelper.setActive(arg_29_1.gounselect, false)
	gohelper.setActive(arg_29_1.goselect, true)

	local var_29_0, var_29_1, var_29_2 = transformhelper.getLocalScale(arg_29_1.selectArrow.transform)

	transformhelper.setLocalScale(arg_29_1.selectArrow.transform, var_29_0, -math.abs(var_29_1), var_29_2)
	transformhelper.setLocalScale(arg_29_1.unselectArrow.transform, var_29_0, -math.abs(var_29_1), var_29_2)
end

function var_0_0._refreshNeedText(arg_30_0)
	local var_30_0 = false
	local var_30_1 = JumpModel.instance:getRecordFarmItem()

	if var_30_1 then
		var_30_0 = true

		local var_30_2 = ItemModel.instance:getItemConfig(var_30_1.type, var_30_1.id)
		local var_30_3 = ItemModel.instance:getItemQuantity(var_30_1.type, var_30_1.id)
		local var_30_4 = ""

		if var_30_1.quantity and var_30_1.quantity ~= 0 then
			local var_30_5 = "#D97373"

			if var_30_3 >= var_30_1.quantity then
				var_30_5 = "#81ce83"
			end

			local var_30_6 = GameUtil.numberDisplay(var_30_3)
			local var_30_7 = GameUtil.numberDisplay(var_30_1.quantity)

			var_30_4 = string.format("<color=%s>%s</color>/%s", var_30_5, var_30_6, var_30_7)
		end

		local var_30_8 = {
			var_30_2.name,
			var_30_4
		}

		arg_30_0._txtNeed.text = GameUtil.getSubPlaceholderLuaLang(luaLang("room_formula_need_desc"), var_30_8)

		local var_30_9 = arg_30_0._txtNeed.preferredWidth

		recthelper.setWidth(arg_30_0._btnNeedClick.transform, var_30_9)
	end

	local var_30_10 = arg_30_0._scrollHeight

	if var_30_0 then
		var_30_10 = arg_30_0._scrollHeight - arg_30_0._goNeedHeight
	end

	recthelper.setHeight(arg_30_0._scrollformula.transform, var_30_10)
	gohelper.setActive(arg_30_0._goNeed, var_30_0)

	arg_30_0.viewportHeight = recthelper.getHeight(arg_30_0._scrollViewport.transform)
	arg_30_0.viewportCapacity = math.ceil(arg_30_0.viewportHeight / arg_30_0.viewContainer.cellHeightSize)
end

function var_0_0._refreshScrollContent(arg_31_0)
	if not arg_31_0._scrollHeight or gohelper.isNil(arg_31_0._scrollcontent) then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(arg_31_0._scrollcontent.transform)

	arg_31_0._couldScroll = recthelper.getHeight(arg_31_0._scrollcontent.transform) > arg_31_0._scrollHeight and true or false
end

function var_0_0.onClose(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0.focusPos, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._refreshScrollContent, arg_32_0)

	if arg_32_0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function var_0_0.onDestroyView(arg_33_0)
	arg_33_0._simagebg1:UnLoadImage()
	arg_33_0._simagebg2:UnLoadImage()

	for iter_33_0, iter_33_1 in ipairs(arg_33_0._showTypeItemList) do
		iter_33_1.btnclick:RemoveClickListener()
	end

	RoomFormulaListModel.instance:resetIsInList()
end

return var_0_0
