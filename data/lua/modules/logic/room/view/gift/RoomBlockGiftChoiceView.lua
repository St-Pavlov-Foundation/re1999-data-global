module("modules.logic.room.view.gift.RoomBlockGiftChoiceView", package.seeall)

local var_0_0 = class("RoomBlockGiftChoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnnumber = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/right/#btn_number")
	arg_1_0._btnrare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/right/#btn_rare")
	arg_1_0._btntheme = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/right/#btn_theme")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "#go_switch")
	arg_1_0._btnblock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_switch/#btn_block")
	arg_1_0._btnbuilding = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_switch/#btn_building")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._goconfirm = gohelper.findChild(arg_1_0.viewGO, "#btn_confirm/#go_confirm")
	arg_1_0._gonoconfirm = gohelper.findChild(arg_1_0.viewGO, "#btn_confirm/#go_noconfirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._scrollblock = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_block")
	arg_1_0._scrollbuilding = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_building")
	arg_1_0._scrolltheme = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_theme")
	arg_1_0._gothemeitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_theme/Viewport/Content/#go_themeitem")
	arg_1_0._gostyleName = gohelper.findChild(arg_1_0.viewGO, "#go_styleName")
	arg_1_0._goblockItem = gohelper.findChild(arg_1_0.viewGO, "#go_blockItem")
	arg_1_0._gobuildingItem = gohelper.findChild(arg_1_0.viewGO, "#go_buildingItem")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_Tips/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnumber:AddClickListener(arg_2_0._btnnumberOnClick, arg_2_0)
	arg_2_0._btnrare:AddClickListener(arg_2_0._btnrareOnClick, arg_2_0)
	arg_2_0._btntheme:AddClickListener(arg_2_0._btnthemeOnClick, arg_2_0)
	arg_2_0._btnblock:AddClickListener(arg_2_0._btnblockOnClick, arg_2_0)
	arg_2_0._btnbuilding:AddClickListener(arg_2_0._btnbuildingOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, arg_2_0._onThemeFilterChanged, arg_2_0)
	arg_2_0:addEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSelect, arg_2_0._onRefreshSelect, arg_2_0)
	arg_2_0:addEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSortTheme, arg_2_0._onRefreshTheme, arg_2_0)
	arg_2_0:addEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnStartDragItem, arg_2_0._onStartDragItem, arg_2_0)
	arg_2_0:addEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnDragingItem, arg_2_0._onDragingItem, arg_2_0)
	arg_2_0:addEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnEndDragItem, arg_2_0._onEndDragItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnumber:RemoveClickListener()
	arg_3_0._btnrare:RemoveClickListener()
	arg_3_0._btntheme:RemoveClickListener()
	arg_3_0._btnblock:RemoveClickListener()
	arg_3_0._btnbuilding:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, arg_3_0._onThemeFilterChanged, arg_3_0)
	arg_3_0:removeEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSelect, arg_3_0._onRefreshSelect, arg_3_0)
	arg_3_0:removeEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnSortTheme, arg_3_0._onRefreshTheme, arg_3_0)
	arg_3_0:removeEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnStartDragItem, arg_3_0._onStartDragItem, arg_3_0)
	arg_3_0:removeEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnDragingItem, arg_3_0._onDragingItem, arg_3_0)
	arg_3_0:removeEventCb(RoomBlockGiftController.instance, RoomBlockGiftEvent.OnEndDragItem, arg_3_0._onEndDragItem, arg_3_0)
end

function var_0_0._btnnumberOnClick(arg_4_0)
	RoomBlockBuildingGiftModel.instance:clickSortBlockNum()
	arg_4_0:_refreshSortBtn()
	RoomBlockBuildingGiftModel.instance:onSort()
end

function var_0_0._btnrareOnClick(arg_5_0)
	RoomBlockBuildingGiftModel.instance:clickSortBlockRare()
	arg_5_0:_refreshSortBtn()
	RoomBlockBuildingGiftModel.instance:onSort()
end

function var_0_0._btnthemeOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.RoomThemeFilterView, {
		isGift = true
	})
end

function var_0_0._btnblockOnClick(arg_7_0)
	arg_7_0:_onClickSubTypeBtn(MaterialEnum.MaterialType.BlockPackage)
end

function var_0_0._btnbuildingOnClick(arg_8_0)
	arg_8_0:_onClickSubTypeBtn(MaterialEnum.MaterialType.Building)
end

function var_0_0._btnconfirmOnClick(arg_9_0)
	local function var_9_0()
		arg_9_0:closeThis()
		RoomBlockGiftController.instance:useItemCallback()
		RoomBlockBuildingGiftModel.instance:clear()
	end

	if RoomBlockBuildingGiftModel.instance:getSelectCount() == 0 then
		GameFacade.showToast(ToastEnum.RoomBlockNotSelect)

		return
	end

	local var_9_1 = RoomBlockBuildingGiftModel.instance:getSelectGoodsData(arg_9_0.itemId)

	if var_9_1 then
		ItemRpc.instance:sendUseItemRequest(var_9_1.data, var_9_1.goodsId, var_9_0, arg_9_0)
	end
end

function var_0_0._btncancelOnClick(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0._onThemeFilterChanged(arg_12_0)
	arg_12_0:_refreshThemeBtn()
	arg_12_0:_refreshTheme()
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._goblockselect = gohelper.findChild(arg_13_0.viewGO, "#go_switch/#btn_block/go_select")
	arg_13_0._goblocknormal = gohelper.findChild(arg_13_0.viewGO, "#go_switch/#btn_block/go_normal")
	arg_13_0._gobuildingselect = gohelper.findChild(arg_13_0.viewGO, "#go_switch/#btn_building/go_select")
	arg_13_0._gobuildingnormal = gohelper.findChild(arg_13_0.viewGO, "#go_switch/#btn_building/go_normal")
	arg_13_0._gonumselect = gohelper.findChild(arg_13_0.viewGO, "top/right/#btn_number/go_select")
	arg_13_0._gonumnormal = gohelper.findChild(arg_13_0.viewGO, "top/right/#btn_number/go_normal")
	arg_13_0._gonumselectarrow = gohelper.findChild(arg_13_0.viewGO, "top/right/#btn_number/go_select/txt/go_arrow")
	arg_13_0._gonumselectarrow2 = gohelper.findChild(arg_13_0.viewGO, "top/right/#btn_number/go_select/txt/go_arrow2")
	arg_13_0._gorareselect = gohelper.findChild(arg_13_0.viewGO, "top/right/#btn_rare/go_select")
	arg_13_0._gorarenormal = gohelper.findChild(arg_13_0.viewGO, "top/right/#btn_rare/go_normal")
	arg_13_0._gorareselectarrow = gohelper.findChild(arg_13_0.viewGO, "top/right/#btn_rare/go_select/txt/go_arrow")
	arg_13_0._gorareselectarrow2 = gohelper.findChild(arg_13_0.viewGO, "top/right/#btn_rare/go_select/txt/go_arrow2")
	arg_13_0._gothemeselect = gohelper.findChild(arg_13_0.viewGO, "top/right/#btn_theme/go_select")
	arg_13_0._gothemenormal = gohelper.findChild(arg_13_0.viewGO, "top/right/#btn_theme/go_unselect")
	arg_13_0._txtnumselect = gohelper.findChildText(arg_13_0.viewGO, "top/right/#btn_number/go_select/txt")
	arg_13_0._txtnumnormal = gohelper.findChildText(arg_13_0.viewGO, "top/right/#btn_number/go_normal/txt")
	arg_13_0._buildingScrollView = arg_13_0._scrollbuilding.gameObject:GetComponent(gohelper.Type_ScrollRect)

	local var_13_0 = recthelper.getHeight(arg_13_0._buildingScrollView.transform)

	arg_13_0._dragBuildingMinY = -var_13_0 * 0.5 + 1
	arg_13_0._dragBuildingMaxY = var_13_0 * 0.5 - 1
	arg_13_0._themeScrollView = arg_13_0._scrolltheme.gameObject:GetComponent(gohelper.Type_ScrollRect)

	local var_13_1 = recthelper.getHeight(arg_13_0._scrolltheme.transform)

	arg_13_0._dragThemeMinY = -var_13_1 * 0.5 + 1
	arg_13_0._dragThemeMinMaxY = var_13_1 * 0.5 - 1
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0.rare = arg_15_0.viewParam.rare
	arg_15_0.itemId = arg_15_0.viewParam.id

	RoomBlockBuildingGiftModel.instance:onOpenView(arg_15_0.rare)
	arg_15_0:_refreshView()
	arg_15_0:_onRefreshSelect()
end

function var_0_0.onClickModalMask(arg_16_0)
	arg_16_0:closeThis()
end

function var_0_0._refreshView(arg_17_0)
	local var_17_0 = RoomBlockBuildingGiftModel.instance:getSelectSubType()

	arg_17_0:_refreshBlockBuildingBtn(var_17_0)
	arg_17_0:_refreshSortBtn()
	arg_17_0:_refreshThemeBtn()
	arg_17_0:_refreshTheme()
end

function var_0_0._refreshBlockBuildingBtn(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 == MaterialEnum.MaterialType.Building

	gohelper.setActive(arg_18_0._goblockselect.gameObject, not var_18_0)
	gohelper.setActive(arg_18_0._goblocknormal.gameObject, var_18_0)
	gohelper.setActive(arg_18_0._gobuildingselect.gameObject, var_18_0)
	gohelper.setActive(arg_18_0._gobuildingnormal.gameObject, not var_18_0)

	local var_18_1 = arg_18_0:_isThemeFilter()

	arg_18_0:_refreshModeView(var_18_1, arg_18_1)

	local var_18_2 = RoomBlockGiftEnum.SubTypeInfo[arg_18_1].NumSortTxt

	arg_18_0._txtnumselect.text = luaLang(var_18_2)
	arg_18_0._txtnumnormal.text = luaLang(var_18_2)
end

function var_0_0._refreshModeView(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = not arg_19_1 and arg_19_2 == MaterialEnum.MaterialType.BlockPackage
	local var_19_1 = not arg_19_1 and arg_19_2 == MaterialEnum.MaterialType.Building

	gohelper.setActive(arg_19_0._scrollblock.gameObject, var_19_0)
	gohelper.setActive(arg_19_0._scrollbuilding.gameObject, var_19_1)
	gohelper.setActive(arg_19_0._scrolltheme.gameObject, arg_19_1)
end

function var_0_0._refreshSortBtn(arg_20_0)
	local var_20_0 = RoomBlockBuildingGiftModel.instance:getSortBlockNum()
	local var_20_1 = RoomBlockBuildingGiftModel.instance:getSortBlockRare()

	gohelper.setActive(arg_20_0._gonumselect.gameObject, var_20_0 ~= RoomBlockGiftEnum.SortType.None)
	gohelper.setActive(arg_20_0._gonumnormal.gameObject, var_20_0 == RoomBlockGiftEnum.SortType.None)
	gohelper.setActive(arg_20_0._gonumselectarrow.gameObject, var_20_0 == RoomBlockGiftEnum.SortType.Order)
	gohelper.setActive(arg_20_0._gonumselectarrow2.gameObject, var_20_0 == RoomBlockGiftEnum.SortType.Reverse)
	gohelper.setActive(arg_20_0._gorareselect.gameObject, var_20_1 ~= RoomBlockGiftEnum.SortType.None)
	gohelper.setActive(arg_20_0._gorarenormal.gameObject, var_20_1 == RoomBlockGiftEnum.SortType.None)
	gohelper.setActive(arg_20_0._gorareselectarrow.gameObject, var_20_1 == RoomBlockGiftEnum.SortType.Order)
	gohelper.setActive(arg_20_0._gorareselectarrow2.gameObject, var_20_1 == RoomBlockGiftEnum.SortType.Reverse)
end

function var_0_0._refreshThemeBtn(arg_21_0)
	local var_21_0 = arg_21_0:_isThemeFilter()

	gohelper.setActive(arg_21_0._gothemeselect.gameObject, var_21_0)
	gohelper.setActive(arg_21_0._gothemenormal.gameObject, not var_21_0)
end

function var_0_0._isThemeFilter(arg_22_0)
	return RoomThemeFilterListModel.instance:getSelectCount() > 0
end

function var_0_0._onClickSubTypeBtn(arg_23_0, arg_23_1)
	if RoomBlockBuildingGiftModel.instance:getSelectSubType() == arg_23_1 then
		return
	end

	RoomBlockBuildingGiftModel.instance:openSubType(arg_23_1)
	arg_23_0:_refreshTheme()
	RoomBlockBuildingGiftModel.instance:setThemeList()
	arg_23_0:_refreshBlockBuildingBtn(arg_23_1)
end

function var_0_0._getThemeItem(arg_24_0, arg_24_1)
	if not arg_24_0._themeItems then
		arg_24_0._themeItems = arg_24_0:getUserDataTb_()
	end

	local var_24_0 = arg_24_0._themeItems[arg_24_1]

	if not var_24_0 then
		local var_24_1 = gohelper.cloneInPlace(arg_24_0._gothemeitem)
		local var_24_2 = {
			gotitle = arg_24_0._gostyleName,
			goBlockItem = arg_24_0._goblockItem,
			goBuildingItem = arg_24_0._gobuildingItem
		}

		var_24_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_1, RoomBlockGiftThemeItem, var_24_2)
		arg_24_0._themeItems[arg_24_1] = var_24_0
	end

	return var_24_0
end

function var_0_0._onRefreshSelect(arg_25_0)
	local var_25_0 = RoomBlockBuildingGiftModel.instance:getSelectCount()
	local var_25_1 = RoomBlockBuildingGiftModel.instance:getMaxSelectCount()
	local var_25_2 = var_25_0 == var_25_1 and "roomblockgift_colloctcount2" or "roomblockgift_colloctcount1"
	local var_25_3 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang(var_25_2), var_25_0, var_25_1)
	local var_25_4 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("roomblockgift_select"), var_25_3)

	arg_25_0._txtnum.text = var_25_4

	gohelper.setActive(arg_25_0._goconfirm.gameObject, var_25_0 > 0)
	gohelper.setActive(arg_25_0._gonoconfirm.gameObject, var_25_0 == 0)
end

function var_0_0._refreshTheme(arg_26_0)
	local var_26_0 = arg_26_0:_isThemeFilter()
	local var_26_1 = RoomBlockBuildingGiftModel.instance:getSelectSubType()

	if var_26_0 then
		RoomBlockBuildingGiftModel.instance:getSubTypeListModelInstance(var_26_1):setThemeMoList()
		arg_26_0:_onRefreshTheme()
	end

	arg_26_0:_refreshThemeBtn()
	arg_26_0:_refreshModeView(var_26_0, var_26_1)
end

function var_0_0._onRefreshTheme(arg_27_0)
	local var_27_0 = RoomBlockBuildingGiftModel.instance:getSelectSubType()
	local var_27_1 = RoomBlockBuildingGiftModel.instance:getSubTypeListModelInstance(var_27_0):getThemeMoList()

	if not var_27_1 or not arg_27_0:_isThemeFilter() then
		return
	end

	local var_27_2 = 0

	for iter_27_0, iter_27_1 in ipairs(var_27_1) do
		arg_27_0:_getThemeItem(iter_27_0):onUpdateMO(iter_27_1, var_27_0)

		var_27_2 = var_27_2 + 1
	end

	for iter_27_2 = 1, #arg_27_0._themeItems do
		arg_27_0._themeItems[iter_27_2]:setActive(iter_27_2 <= var_27_2)
	end
end

function var_0_0._onStartDragItem(arg_28_0, arg_28_1)
	if not RoomBlockBuildingGiftModel.instance:getSelectSubType() then
		return
	end

	arg_28_0._canDrag = true

	if arg_28_0:_isThemeFilter() then
		arg_28_0._themeScrollView:OnBeginDrag(arg_28_1)
	else
		arg_28_0._buildingScrollView:OnBeginDrag(arg_28_1)
	end
end

function var_0_0._onDragingItem(arg_29_0, arg_29_1)
	if not arg_29_0._canDrag then
		return
	end

	if not RoomBlockBuildingGiftModel.instance:getSelectSubType() then
		return
	end

	if arg_29_0:_isThemeFilter() then
		local var_29_0 = recthelper.screenPosToAnchorPos(arg_29_1.position, arg_29_0._themeScrollView.transform).y

		if var_29_0 > arg_29_0._dragThemeMinY and var_29_0 < arg_29_0._dragThemeMinMaxY then
			arg_29_0._themeScrollView:OnDrag(arg_29_1)
		end
	else
		local var_29_1 = recthelper.screenPosToAnchorPos(arg_29_1.position, arg_29_0._buildingScrollView.transform).y

		if var_29_1 > arg_29_0._dragBuildingMinY and var_29_1 < arg_29_0._dragBuildingMaxY then
			arg_29_0._buildingScrollView:OnDrag(arg_29_1)
		end
	end
end

function var_0_0._onEndDragItem(arg_30_0, arg_30_1)
	local var_30_0 = RoomBlockBuildingGiftModel.instance:getSelectSubType()

	arg_30_0._canDrag = false

	if not var_30_0 then
		return
	end

	if arg_30_0:_isThemeFilter() then
		arg_30_0._themeScrollView:OnEndDrag(arg_30_1)
	else
		arg_30_0._buildingScrollView:OnEndDrag(arg_30_1)
	end
end

function var_0_0.onClose(arg_31_0)
	RoomBlockBuildingGiftModel.instance:onCloseView()

	arg_31_0._canDrag = false
end

function var_0_0.onDestroyView(arg_32_0)
	return
end

return var_0_0
