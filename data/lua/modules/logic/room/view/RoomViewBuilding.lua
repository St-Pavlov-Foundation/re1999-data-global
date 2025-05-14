module("modules.logic.room.view.RoomViewBuilding", package.seeall)

local var_0_0 = class("RoomViewBuilding", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goemptybuiling = gohelper.findChild(arg_1_0.viewGO, "go_building/#go_emptybuilding")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._btnbackOnClick(arg_4_0)
	RoomBuildingController.instance:setBuildingListShow(false)
	RoomMapController.instance:switchBackBlock(true)
end

function var_0_0._btnresetOnClick(arg_5_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomReset, MsgBoxEnum.BoxType.Yes_No, function()
			RoomMapController.instance:resetRoom()
		end)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._gobuilding = gohelper.findChild(arg_7_0.viewGO, "go_building")
	arg_7_0._gofilterswitch = gohelper.findChild(arg_7_0.viewGO, "go_building/filterswitch")
	arg_7_0._btnfilter = gohelper.findChildButtonWithAudio(arg_7_0.viewGO, "go_building/filterswitch/btn_filter")
	arg_7_0._scrollbuilding = gohelper.findChildScrollRect(arg_7_0.viewGO, "go_building/scroll_building")
	arg_7_0._scrollView = gohelper.findChildComponent(arg_7_0.viewGO, "go_building/scroll_building", gohelper.Type_ScrollRect)
	arg_7_0._rectMaskComp = gohelper.findChildComponent(arg_7_0.viewGO, "go_building/scroll_building/viewport", typeof(UnityEngine.UI.RectMask2D))
	arg_7_0._goscrollContent = gohelper.findChild(arg_7_0.viewGO, "go_building/scroll_building/viewport/content")
	arg_7_0._gorescontent = gohelper.findChild(arg_7_0.viewGO, "go_building/filterswitch/rescontent")
	arg_7_0._gototalitem = gohelper.findChild(arg_7_0.viewGO, "go_building/filterswitch/rescontent/totalitem")
	arg_7_0._goresitem = gohelper.findChild(arg_7_0.viewGO, "go_building/filterswitch/rescontent/resitem")
	arg_7_0._btntheme = gohelper.findChildButtonWithAudio(arg_7_0.viewGO, "go_building/btn_theme")
	arg_7_0._gothemeSelect = gohelper.findChild(arg_7_0.viewGO, "go_building/btn_theme/go_select")
	arg_7_0._gothemeUnSelect = gohelper.findChild(arg_7_0.viewGO, "go_building/btn_theme/go_unselect")
	arg_7_0._gofilterSelect = gohelper.findChild(arg_7_0.viewGO, "go_building/filterswitch/btn_filter/go_select")
	arg_7_0._gofilterUnSelect = gohelper.findChild(arg_7_0.viewGO, "go_building/filterswitch/btn_filter/go_unselect")
	arg_7_0._gofilter = arg_7_0._btnfilter.gameObject
	arg_7_0._scrollViewTransform = arg_7_0._scrollView.transform
	arg_7_0._scrollContentTransform = arg_7_0._goscrollContent.transform

	arg_7_0._btnfilter:AddClickListener(arg_7_0._btnfilterOnClick, arg_7_0)
	arg_7_0._btntheme:AddClickListener(arg_7_0._btnthemeOnClick, arg_7_0)
	gohelper.setActive(arg_7_0._goresitem, false)
	gohelper.setActive(arg_7_0._gototalitem, false)

	local var_7_0 = RoomBuildingEnum.BuildingListViewResTabType
	local var_7_1 = RoomBuildingEnum.BuildingType

	arg_7_0._resDataList = {
		[var_7_0.All] = {
			nameLanguage = "room_building_type_name_all_txt",
			buildingTypes = {}
		},
		[var_7_0.Adornment] = {
			nameLanguage = "room_building_type_name_decoration_txt",
			buildingTypes = {
				var_7_1.Decoration
			}
		},
		[var_7_0.Produce] = {
			nameLanguage = "room_building_type_name_manufacture_txt",
			buildingTypes = {
				var_7_1.Collect,
				var_7_1.Process,
				var_7_1.Manufacture,
				var_7_1.Trade,
				var_7_1.Rest
			}
		},
		[var_7_0.Play] = {
			nameLanguage = "room_building_type_name_interact_txt",
			buildingTypes = {
				var_7_1.Interact
			}
		}
	}

	arg_7_0:_initResList()

	arg_7_0._isShowBuilding = false
	arg_7_0._isHasBuilding = nil

	gohelper.setActive(arg_7_0._gobuilding, false)

	arg_7_0._scene = GameSceneMgr.instance:getCurScene()
	arg_7_0._animator = arg_7_0._gobuilding:GetComponent(typeof(UnityEngine.Animator))

	local var_7_2 = arg_7_0.viewParam and arg_7_0.viewParam.defaultBuildingResType

	if not var_7_2 or var_7_2 <= 0 or var_7_2 > #arg_7_0._resDataList then
		var_7_2 = var_7_0.All
	end

	arg_7_0:_setSelectResData(arg_7_0._resDataList[var_7_2])
end

function var_0_0._btnstoreOnClick(arg_8_0)
	RoomInventorySelectView.tryConfirmAndToStore()
end

function var_0_0._initResList(arg_9_0)
	arg_9_0._resItemList = arg_9_0._resItemList or {}

	for iter_9_0 = #arg_9_0._resItemList + 1, #arg_9_0._resDataList do
		local var_9_0 = arg_9_0._gototalitem
		local var_9_1 = gohelper.clone(var_9_0, arg_9_0._gorescontent, "btn_resItem" .. iter_9_0)

		gohelper.setActive(var_9_1, true)
		gohelper.addUIClickAudio(var_9_1, AudioEnum.UI.play_ui_role_open)

		local var_9_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, RoomViewBuildingResItem, arg_9_0)

		var_9_2:setCallback(arg_9_0._onResItemOnClick, arg_9_0)
		table.insert(arg_9_0._resItemList, var_9_2)
	end

	for iter_9_1 = 1, #arg_9_0._resDataList do
		local var_9_3 = arg_9_0._resItemList[iter_9_1]

		gohelper.setActive(var_9_3:getGO(), true)
		var_9_3:setData(arg_9_0._resDataList[iter_9_1])
		var_9_3:setSelect(arg_9_0._curSelectResData == arg_9_0._resDataList[iter_9_1])
		var_9_3:setLineActive(iter_9_1 > 1)
	end

	for iter_9_2 = #arg_9_0._resDataList + 1, #arg_9_0._resItemList do
		gohelper.setActive(arg_9_0._resItemList[iter_9_2]:getGO(), false)
	end
end

function var_0_0._getHasBuildingResIds(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = lua_block_resource.configList

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if iter_10_1.buildingFilter == 1 then
			table.insert(var_10_0, iter_10_1.id)
		end
	end

	if #var_10_0 > 1 then
		table.sort(var_10_0, function(arg_11_0, arg_11_1)
			if arg_11_0 ~= arg_11_1 then
				return arg_11_0 < arg_11_1
			end
		end)
	end

	return var_10_0
end

function var_0_0._updateResList(arg_12_0)
	arg_12_0:_initResList()

	if not tabletool.indexOf(arg_12_0._resDataList, arg_12_0._curSelectResData) then
		arg_12_0:_setSelectResData(arg_12_0._resDataList[RoomBuildingEnum.BuildingListViewResTabType.All])
	end
end

function var_0_0._refreshFilterUI(arg_13_0)
	local var_13_0 = RoomModel.instance:getBuildingInfoList()
	local var_13_1 = var_13_0 and #var_13_0 > 0 or false

	if arg_13_0._lastHasBuilding ~= var_13_1 then
		gohelper.setActive(arg_13_0._gofilterswitch, var_13_1)
		gohelper.setActive(arg_13_0._gofilter, var_13_1)
		gohelper.setActive(arg_13_0._btntheme, var_13_1)
	end

	arg_13_0:_refreshFilterState()
end

function var_0_0._onResItemOnClick(arg_14_0, arg_14_1)
	if arg_14_0._curSelectResData == arg_14_1 then
		return
	end

	arg_14_0:_setSelectResData(arg_14_1)
end

function var_0_0._setSelectResData(arg_15_0, arg_15_1)
	arg_15_0._curSelectResData = arg_15_1

	for iter_15_0 = 1, #arg_15_0._resItemList do
		local var_15_0 = arg_15_0._resItemList[iter_15_0]

		var_15_0:setSelect(arg_15_1 == var_15_0:getData())
	end

	if arg_15_1 then
		RoomShowBuildingListModel.instance:setFilterType(arg_15_1.buildingTypes)
	else
		RoomShowBuildingListModel.instance:setFilterType({})
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()

	arg_15_0._scrollbuilding.horizontalNormalizedPosition = 0
end

function var_0_0._btnfilterOnClick(arg_16_0)
	ViewMgr.instance:openView(ViewName.RoomBuildingFilterView)
end

function var_0_0._btnthemeOnClick(arg_17_0)
	RoomController.instance:openThemeFilterView(true)
end

function var_0_0._btncloseOnClick(arg_18_0)
	RoomBuildingController.instance:setBuildingListShow(false)
end

function var_0_0._btnconfirmOnClick(arg_19_0)
	RoomInventorySelectView.confirmYesCallback()
end

function var_0_0._refreshUI(arg_20_0)
	if not RoomController.instance:isObMode() then
		return
	end
end

function var_0_0._buildingListViewShowChanged(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._isShowBuilding ~= arg_21_1

	arg_21_0._isShowBuilding = arg_21_1

	RoomShowBuildingListModel.instance:clearSelect()

	if var_21_0 then
		TaskDispatcher.cancelTask(arg_21_0._delayOpenOrClose, arg_21_0)
		TaskDispatcher.runDelay(arg_21_0._delayOpenOrClose, arg_21_0, 0.13333333333333333)

		if not arg_21_1 then
			arg_21_0._animator:Play("close", 0, 0)
		end
	end

	if not arg_21_1 then
		ViewMgr.instance:closeView(ViewName.RoomBuildingFilterView)
	end

	if arg_21_1 then
		RoomShowBuildingListModel.instance:setShowBuildingList()

		arg_21_0._scrollbuilding.horizontalNormalizedPosition = 0

		if var_21_0 and arg_21_0._buildingScrollView then
			arg_21_0._buildingScrollView:playOpenAnimation()
		end
	end
end

function var_0_0._delayOpenOrClose(arg_22_0)
	gohelper.setActive(arg_22_0._gobuilding, arg_22_0._isShowBuilding)

	if arg_22_0._isShowBuilding then
		arg_22_0._animator:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0._newBuildingPush(arg_23_0)
	arg_23_0:_updateResList()
	arg_23_0:_refreshFilterUI()
	RoomShowBuildingListModel.instance:setShowBuildingList()
end

function var_0_0._buildingFilterChanged(arg_24_0)
	arg_24_0._scrollbuilding.horizontalNormalizedPosition = 0

	arg_24_0:_refreshFilterState()
end

function var_0_0._themeFilterChanged(arg_25_0)
	RoomShowBuildingListModel.instance:setShowBuildingList()

	arg_25_0._scrollbuilding.horizontalNormalizedPosition = 0

	arg_25_0:_refreshFilterState()
end

function var_0_0._onListDataChanged(arg_26_0)
	local var_26_0 = RoomShowBuildingListModel.instance:getCount() - RoomShowBuildingListModel.instance:getEmptyCount()

	gohelper.setActive(arg_26_0._goemptybuiling, var_26_0 < 1)

	local var_26_1 = recthelper.getWidth(arg_26_0._scrollViewTransform)
	local var_26_2 = recthelper.getWidth(arg_26_0._scrollContentTransform)

	RoomShowBuildingListModel.instance:setItemAnchorX(0)

	if var_26_1 and var_26_2 and var_26_2 < var_26_1 then
		RoomShowBuildingListModel.instance:setItemAnchorX(var_26_1 - var_26_2)
	end

	arg_26_0._rectMaskComp.padding = var_26_1 - var_26_2 > 0 and Vector4.New(0, 0, -20, 0) or Vector4.New(0, 0, 0, 0)
end

function var_0_0._onListDragBeginListener(arg_27_0, arg_27_1)
	arg_27_0._scrollView:OnBeginDrag(arg_27_1)

	local var_27_0 = recthelper.getWidth(arg_27_0._scrollViewTransform)

	arg_27_0._dragMinX = -var_27_0 * 0.5 + 1
	arg_27_0._dragMaxX = var_27_0 * 0.5 - 1
end

function var_0_0._onListDragListener(arg_28_0, arg_28_1)
	local var_28_0 = recthelper.screenPosToAnchorPos(arg_28_1.position, arg_28_0._scrollViewTransform).x

	if var_28_0 > arg_28_0._dragMinX and var_28_0 < arg_28_0._dragMaxX then
		arg_28_0._scrollView:OnDrag(arg_28_1)
	end
end

function var_0_0._onListDragEndListener(arg_29_0, arg_29_1)
	arg_29_0._scrollView:OnEndDrag(arg_29_1)
end

function var_0_0._addBtnAudio(arg_30_0)
	gohelper.addUIClickAudio(arg_30_0._btnfilter.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function var_0_0.onOpen(arg_31_0)
	arg_31_0:_refreshUI()
	arg_31_0:_addBtnAudio()
	arg_31_0:_onListDataChanged()
	arg_31_0:_refreshFilterUI()
	arg_31_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, arg_31_0._buildingListViewShowChanged, arg_31_0)
	arg_31_0:addEventCb(RoomMapController.instance, RoomEvent.NewBuildingPush, arg_31_0._newBuildingPush, arg_31_0)
	arg_31_0:addEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, arg_31_0._newBuildingPush, arg_31_0)
	arg_31_0:addEventCb(RoomMapController.instance, RoomEvent.BuildingFilterChanged, arg_31_0._buildingFilterChanged, arg_31_0)
	arg_31_0:addEventCb(RoomBuildingController.instance, RoomEvent.ClientPlaceBuilding, arg_31_0._tweenToBuildingUid, arg_31_0)
	arg_31_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListOnDataChanged, arg_31_0._onListDataChanged, arg_31_0)
	arg_31_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListOnDragListener, arg_31_0._onListDragListener, arg_31_0)
	arg_31_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListOnDragBeginListener, arg_31_0._onListDragBeginListener, arg_31_0)
	arg_31_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListOnDragEndListener, arg_31_0._onListDragEndListener, arg_31_0)
	arg_31_0:addEventCb(RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, arg_31_0._themeFilterChanged, arg_31_0)

	if arg_31_0.viewParam and arg_31_0.viewParam.defaultBuildingResType == RoomBuildingEnum.BuildingListViewResTabType.Produce then
		arg_31_0.viewContainer:switch2BuildingView(true)
	end
end

function var_0_0._refreshFilterState(arg_32_0)
	local var_32_0 = RoomThemeFilterListModel.instance:getSelectCount() > 0

	if arg_32_0._isLastThemeOpen ~= var_32_0 then
		arg_32_0._isLastThemeOpen = var_32_0

		gohelper.setActive(arg_32_0._gothemeUnSelect, not var_32_0)
		gohelper.setActive(arg_32_0._gothemeSelect, var_32_0)
	end

	local var_32_1 = arg_32_0:_checkFilterOpen()

	if arg_32_0._isLastFilterOpen ~= var_32_1 then
		arg_32_0._isLastFilterOpen = var_32_1

		gohelper.setActive(arg_32_0._gofilterUnSelect, not var_32_1)
		gohelper.setActive(arg_32_0._gofilterSelect, var_32_1)
	end
end

function var_0_0._checkFilterOpen(arg_33_0)
	local var_33_0 = RoomShowBuildingListModel.instance

	if not var_33_0:isFilterOccupyIdEmpty() or not var_33_0:isFilterUseEmpty() then
		return true
	end

	return false
end

function var_0_0._tweenToBuildingUid(arg_34_0, arg_34_1)
	if arg_34_0._tweenId then
		arg_34_0._scene.tween:killById(arg_34_0._tweenId)

		arg_34_0._tweenId = nil
	end

	local var_34_0 = RoomShowBuildingListModel.instance:getList()
	local var_34_1 = 0

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		if iter_34_1.id == arg_34_1 then
			var_34_1 = iter_34_0

			break
		end
	end

	if var_34_1 == 0 then
		return
	end

	local var_34_2 = recthelper.getWidth(arg_34_0._scrollbuilding.content)
	local var_34_3 = recthelper.getWidth(arg_34_0._scrollbuilding.gameObject.transform)
	local var_34_4 = math.floor(arg_34_0:getBuildingItemWidth())
	local var_34_5 = math.floor(arg_34_0:getBuildingItemSpaceH())
	local var_34_6 = var_34_2 - var_34_3
	local var_34_7 = ((var_34_1 - 0.5) * var_34_4 - 0.5 * var_34_3 + math.max(0, var_34_1 - 1) * var_34_5) / var_34_6
	local var_34_8 = 0.5 * (var_34_3 - var_34_4 - var_34_5) / var_34_6
	local var_34_9 = var_34_7 - var_34_8
	local var_34_10 = var_34_7 + var_34_8
	local var_34_11 = arg_34_0._scrollbuilding.horizontalNormalizedPosition

	if var_34_9 <= var_34_11 and var_34_11 <= var_34_10 then
		return
	elseif var_34_11 < var_34_9 then
		var_34_7 = var_34_9
	elseif var_34_10 < var_34_11 then
		var_34_7 = var_34_10
	end

	local var_34_12 = Mathf.Clamp(var_34_7, 0, 1)

	arg_34_0._tweenId = arg_34_0._scene.tween:tweenFloat(var_34_11, var_34_12, 0.2, arg_34_0._tweenFrameCallback, arg_34_0._tweenFinishCallback, arg_34_0, var_34_12)
end

function var_0_0._tweenFrameCallback(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0._scrollbuilding.horizontalNormalizedPosition = arg_35_1
end

function var_0_0._tweenFinishCallback(arg_36_0, arg_36_1)
	arg_36_0._scrollbuilding.horizontalNormalizedPosition = arg_36_1
end

function var_0_0.onClose(arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0._delayOpenOrClose, arg_37_0)

	if arg_37_0._tweenId then
		arg_37_0._scene.tween:killById(arg_37_0._tweenId)

		arg_37_0._tweenId = nil
	end
end

function var_0_0.onDestroyView(arg_38_0)
	arg_38_0._btnfilter:RemoveClickListener()
	arg_38_0._scrollbuilding:RemoveOnValueChanged()
	arg_38_0._btntheme:RemoveClickListener()
end

function var_0_0.getBuildingListView(arg_39_0)
	if arg_39_0._buildingScrollView then
		return arg_39_0._buildingScrollView
	end

	local var_39_0 = ListScrollParam.New()

	var_39_0.scrollGOPath = "go_building/scroll_building"
	var_39_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_39_0.prefabUrl = "go_building/roombuildingitem"
	var_39_0.cellClass = RoomBuildingItem
	var_39_0.scrollDir = ScrollEnum.ScrollDirH
	var_39_0.lineCount = 1
	var_39_0.cellWidth = arg_39_0:getBuildingItemWidth()
	var_39_0.cellHeight = 234
	var_39_0.cellSpaceH = arg_39_0:getBuildingItemSpaceH()
	var_39_0.cellSpaceV = 0
	var_39_0.startSpace = 0

	local var_39_1 = {}

	for iter_39_0 = 1, 10 do
		var_39_1[iter_39_0] = (iter_39_0 - 1) * 0.03
	end

	arg_39_0._buildingScrollView = LuaListScrollViewWithAnimator.New(RoomShowBuildingListModel.instance, var_39_0, var_39_1)

	return arg_39_0._buildingScrollView
end

function var_0_0.getBuildingItemWidth(arg_40_0)
	return 367.7297
end

function var_0_0.getBuildingItemSpaceH(arg_41_0)
	return 22.5
end

var_0_0.prefabPath = "ui/viewres/room/roomviewbuilding.prefab"

return var_0_0
