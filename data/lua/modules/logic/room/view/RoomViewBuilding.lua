module("modules.logic.room.view.RoomViewBuilding", package.seeall)

slot0 = class("RoomViewBuilding", BaseView)

function slot0.onInitView(slot0)
	slot0._goemptybuiling = gohelper.findChild(slot0.viewGO, "go_building/#go_emptybuilding")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnbackOnClick(slot0)
	RoomBuildingController.instance:setBuildingListShow(false)
	RoomMapController.instance:switchBackBlock(true)
end

function slot0._btnresetOnClick(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomReset, MsgBoxEnum.BoxType.Yes_No, function ()
			RoomMapController.instance:resetRoom()
		end)
	end
end

function slot0._editableInitView(slot0)
	slot0._gobuilding = gohelper.findChild(slot0.viewGO, "go_building")
	slot0._gofilterswitch = gohelper.findChild(slot0.viewGO, "go_building/filterswitch")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_building/filterswitch/btn_filter")
	slot0._scrollbuilding = gohelper.findChildScrollRect(slot0.viewGO, "go_building/scroll_building")
	slot0._scrollView = gohelper.findChildComponent(slot0.viewGO, "go_building/scroll_building", gohelper.Type_ScrollRect)
	slot0._rectMaskComp = gohelper.findChildComponent(slot0.viewGO, "go_building/scroll_building/viewport", typeof(UnityEngine.UI.RectMask2D))
	slot0._goscrollContent = gohelper.findChild(slot0.viewGO, "go_building/scroll_building/viewport/content")
	slot0._gorescontent = gohelper.findChild(slot0.viewGO, "go_building/filterswitch/rescontent")
	slot0._gototalitem = gohelper.findChild(slot0.viewGO, "go_building/filterswitch/rescontent/totalitem")
	slot0._goresitem = gohelper.findChild(slot0.viewGO, "go_building/filterswitch/rescontent/resitem")
	slot0._btntheme = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_building/btn_theme")
	slot0._gothemeSelect = gohelper.findChild(slot0.viewGO, "go_building/btn_theme/go_select")
	slot0._gothemeUnSelect = gohelper.findChild(slot0.viewGO, "go_building/btn_theme/go_unselect")
	slot0._gofilterSelect = gohelper.findChild(slot0.viewGO, "go_building/filterswitch/btn_filter/go_select")
	slot0._gofilterUnSelect = gohelper.findChild(slot0.viewGO, "go_building/filterswitch/btn_filter/go_unselect")
	slot0._gofilter = slot0._btnfilter.gameObject
	slot0._scrollViewTransform = slot0._scrollView.transform
	slot0._scrollContentTransform = slot0._goscrollContent.transform

	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
	slot0._btntheme:AddClickListener(slot0._btnthemeOnClick, slot0)
	gohelper.setActive(slot0._goresitem, false)
	gohelper.setActive(slot0._gototalitem, false)

	slot1 = RoomBuildingEnum.BuildingListViewResTabType
	slot2 = RoomBuildingEnum.BuildingType
	slot0._resDataList = {
		[slot1.All] = {
			nameLanguage = "room_building_type_name_all_txt",
			buildingTypes = {}
		},
		[slot1.Adornment] = {
			nameLanguage = "room_building_type_name_decoration_txt",
			buildingTypes = {
				slot2.Decoration
			}
		},
		[slot1.Produce] = {
			nameLanguage = "room_building_type_name_manufacture_txt",
			buildingTypes = {
				slot2.Collect,
				slot2.Process,
				slot2.Manufacture,
				slot2.Trade,
				slot2.Rest
			}
		},
		[slot1.Play] = {
			nameLanguage = "room_building_type_name_interact_txt",
			buildingTypes = {
				slot2.Interact
			}
		}
	}

	slot0:_initResList()

	slot0._isShowBuilding = false
	slot0._isHasBuilding = nil

	gohelper.setActive(slot0._gobuilding, false)

	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._animator = slot0._gobuilding:GetComponent(typeof(UnityEngine.Animator))

	if not slot0.viewParam or not slot0.viewParam.defaultBuildingResType or slot3 <= 0 or slot3 > #slot0._resDataList then
		slot3 = slot1.All
	end

	slot0:_setSelectResData(slot0._resDataList[slot3])
end

function slot0._btnstoreOnClick(slot0)
	RoomInventorySelectView.tryConfirmAndToStore()
end

function slot0._initResList(slot0)
	slot0._resItemList = slot0._resItemList or {}

	for slot4 = #slot0._resItemList + 1, #slot0._resDataList do
		slot6 = gohelper.clone(slot0._gototalitem, slot0._gorescontent, "btn_resItem" .. slot4)

		gohelper.setActive(slot6, true)
		gohelper.addUIClickAudio(slot6, AudioEnum.UI.play_ui_role_open)

		slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot6, RoomViewBuildingResItem, slot0)

		slot7:setCallback(slot0._onResItemOnClick, slot0)
		table.insert(slot0._resItemList, slot7)
	end

	for slot4 = 1, #slot0._resDataList do
		slot5 = slot0._resItemList[slot4]

		gohelper.setActive(slot5:getGO(), true)
		slot5:setData(slot0._resDataList[slot4])
		slot5:setSelect(slot0._curSelectResData == slot0._resDataList[slot4])
		slot5:setLineActive(slot4 > 1)
	end

	for slot4 = #slot0._resDataList + 1, #slot0._resItemList do
		gohelper.setActive(slot0._resItemList[slot4]:getGO(), false)
	end
end

function slot0._getHasBuildingResIds(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(lua_block_resource.configList) do
		if slot7.buildingFilter == 1 then
			table.insert(slot1, slot7.id)
		end
	end

	if #slot1 > 1 then
		table.sort(slot1, function (slot0, slot1)
			if slot0 ~= slot1 then
				return slot0 < slot1
			end
		end)
	end

	return slot1
end

function slot0._updateResList(slot0)
	slot0:_initResList()

	if not tabletool.indexOf(slot0._resDataList, slot0._curSelectResData) then
		slot0:_setSelectResData(slot0._resDataList[RoomBuildingEnum.BuildingListViewResTabType.All])
	end
end

function slot0._refreshFilterUI(slot0)
	if slot0._lastHasBuilding ~= (RoomModel.instance:getBuildingInfoList() and #slot1 > 0 or false) then
		gohelper.setActive(slot0._gofilterswitch, slot2)
		gohelper.setActive(slot0._gofilter, slot2)
		gohelper.setActive(slot0._btntheme, slot2)
	end

	slot0:_refreshFilterState()
end

function slot0._onResItemOnClick(slot0, slot1)
	if slot0._curSelectResData == slot1 then
		return
	end

	slot0:_setSelectResData(slot1)
end

function slot0._setSelectResData(slot0, slot1)
	slot0._curSelectResData = slot1

	for slot5 = 1, #slot0._resItemList do
		slot6 = slot0._resItemList[slot5]

		slot6:setSelect(slot1 == slot6:getData())
	end

	if slot1 then
		RoomShowBuildingListModel.instance:setFilterType(slot1.buildingTypes)
	else
		RoomShowBuildingListModel.instance:setFilterType({})
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()

	slot0._scrollbuilding.horizontalNormalizedPosition = 0
end

function slot0._btnfilterOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RoomBuildingFilterView)
end

function slot0._btnthemeOnClick(slot0)
	RoomController.instance:openThemeFilterView(true)
end

function slot0._btncloseOnClick(slot0)
	RoomBuildingController.instance:setBuildingListShow(false)
end

function slot0._btnconfirmOnClick(slot0)
	RoomInventorySelectView.confirmYesCallback()
end

function slot0._refreshUI(slot0)
	if not RoomController.instance:isObMode() then
		return
	end
end

function slot0._buildingListViewShowChanged(slot0, slot1)
	slot0._isShowBuilding = slot1

	RoomShowBuildingListModel.instance:clearSelect()

	if slot0._isShowBuilding ~= slot1 then
		TaskDispatcher.cancelTask(slot0._delayOpenOrClose, slot0)
		TaskDispatcher.runDelay(slot0._delayOpenOrClose, slot0, 0.13333333333333333)

		if not slot1 then
			slot0._animator:Play("close", 0, 0)
		end
	end

	if not slot1 then
		ViewMgr.instance:closeView(ViewName.RoomBuildingFilterView)
	end

	if slot1 then
		RoomShowBuildingListModel.instance:setShowBuildingList()

		slot0._scrollbuilding.horizontalNormalizedPosition = 0

		if slot2 and slot0._buildingScrollView then
			slot0._buildingScrollView:playOpenAnimation()
		end
	end
end

function slot0._delayOpenOrClose(slot0)
	gohelper.setActive(slot0._gobuilding, slot0._isShowBuilding)

	if slot0._isShowBuilding then
		slot0._animator:Play(UIAnimationName.Open, 0, 0)
	end
end

function slot0._newBuildingPush(slot0)
	slot0:_updateResList()
	slot0:_refreshFilterUI()
	RoomShowBuildingListModel.instance:setShowBuildingList()
end

function slot0._buildingFilterChanged(slot0)
	slot0._scrollbuilding.horizontalNormalizedPosition = 0

	slot0:_refreshFilterState()
end

function slot0._themeFilterChanged(slot0)
	RoomShowBuildingListModel.instance:setShowBuildingList()

	slot0._scrollbuilding.horizontalNormalizedPosition = 0

	slot0:_refreshFilterState()
end

function slot0._onListDataChanged(slot0)
	gohelper.setActive(slot0._goemptybuiling, RoomShowBuildingListModel.instance:getCount() - RoomShowBuildingListModel.instance:getEmptyCount() < 1)

	slot3 = recthelper.getWidth(slot0._scrollContentTransform)

	RoomShowBuildingListModel.instance:setItemAnchorX(0)

	if recthelper.getWidth(slot0._scrollViewTransform) and slot3 and slot3 < slot2 then
		RoomShowBuildingListModel.instance:setItemAnchorX(slot2 - slot3)
	end

	slot0._rectMaskComp.padding = slot2 - slot3 > 0 and Vector4.New(0, 0, -20, 0) or Vector4.New(0, 0, 0, 0)
end

function slot0._onListDragBeginListener(slot0, slot1)
	slot0._scrollView:OnBeginDrag(slot1)

	slot2 = recthelper.getWidth(slot0._scrollViewTransform)
	slot0._dragMinX = -slot2 * 0.5 + 1
	slot0._dragMaxX = slot2 * 0.5 - 1
end

function slot0._onListDragListener(slot0, slot1)
	if slot0._dragMinX < recthelper.screenPosToAnchorPos(slot1.position, slot0._scrollViewTransform).x and slot3 < slot0._dragMaxX then
		slot0._scrollView:OnDrag(slot1)
	end
end

function slot0._onListDragEndListener(slot0, slot1)
	slot0._scrollView:OnEndDrag(slot1)
end

function slot0._addBtnAudio(slot0)
	gohelper.addUIClickAudio(slot0._btnfilter.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
	slot0:_addBtnAudio()
	slot0:_onListDataChanged()
	slot0:_refreshFilterUI()
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, slot0._buildingListViewShowChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.NewBuildingPush, slot0._newBuildingPush, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, slot0._newBuildingPush, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BuildingFilterChanged, slot0._buildingFilterChanged, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.ClientPlaceBuilding, slot0._tweenToBuildingUid, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListOnDataChanged, slot0._onListDataChanged, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListOnDragListener, slot0._onListDragListener, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListOnDragBeginListener, slot0._onListDragBeginListener, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListOnDragEndListener, slot0._onListDragEndListener, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, slot0._themeFilterChanged, slot0)

	if slot0.viewParam and slot0.viewParam.defaultBuildingResType == RoomBuildingEnum.BuildingListViewResTabType.Produce then
		slot0.viewContainer:switch2BuildingView(true)
	end
end

function slot0._refreshFilterState(slot0)
	if slot0._isLastThemeOpen ~= (RoomThemeFilterListModel.instance:getSelectCount() > 0) then
		slot0._isLastThemeOpen = slot1

		gohelper.setActive(slot0._gothemeUnSelect, not slot1)
		gohelper.setActive(slot0._gothemeSelect, slot1)
	end

	if slot0._isLastFilterOpen ~= slot0:_checkFilterOpen() then
		slot0._isLastFilterOpen = slot1

		gohelper.setActive(slot0._gofilterUnSelect, not slot1)
		gohelper.setActive(slot0._gofilterSelect, slot1)
	end
end

function slot0._checkFilterOpen(slot0)
	if not RoomShowBuildingListModel.instance:isFilterOccupyIdEmpty() or not slot1:isFilterUseEmpty() then
		return true
	end

	return false
end

function slot0._tweenToBuildingUid(slot0, slot1)
	if slot0._tweenId then
		slot0._scene.tween:killById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot3 = 0

	for slot7, slot8 in ipairs(RoomShowBuildingListModel.instance:getList()) do
		if slot8.id == slot1 then
			slot3 = slot7

			break
		end
	end

	if slot3 == 0 then
		return
	end

	slot5 = recthelper.getWidth(slot0._scrollbuilding.gameObject.transform)
	slot6 = math.floor(slot0:getBuildingItemWidth())
	slot7 = math.floor(slot0:getBuildingItemSpaceH())
	slot8 = recthelper.getWidth(slot0._scrollbuilding.content) - slot5
	slot10 = ((slot3 - 0.5) * slot6 - 0.5 * slot5 + math.max(0, slot3 - 1) * slot7) / slot8
	slot11 = 0.5 * (slot5 - slot6 - slot7) / slot8

	if slot10 - slot11 <= slot0._scrollbuilding.horizontalNormalizedPosition and slot14 <= slot10 + slot11 then
		return
	elseif slot14 < slot12 then
		slot10 = slot12
	elseif slot13 < slot14 then
		slot10 = slot13
	end

	slot10 = Mathf.Clamp(slot10, 0, 1)
	slot0._tweenId = slot0._scene.tween:tweenFloat(slot14, slot10, 0.2, slot0._tweenFrameCallback, slot0._tweenFinishCallback, slot0, slot10)
end

function slot0._tweenFrameCallback(slot0, slot1, slot2)
	slot0._scrollbuilding.horizontalNormalizedPosition = slot1
end

function slot0._tweenFinishCallback(slot0, slot1)
	slot0._scrollbuilding.horizontalNormalizedPosition = slot1
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayOpenOrClose, slot0)

	if slot0._tweenId then
		slot0._scene.tween:killById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.onDestroyView(slot0)
	slot0._btnfilter:RemoveClickListener()
	slot0._scrollbuilding:RemoveOnValueChanged()
	slot0._btntheme:RemoveClickListener()
end

function slot0.getBuildingListView(slot0)
	if slot0._buildingScrollView then
		return slot0._buildingScrollView
	end

	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "go_building/scroll_building"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "go_building/roombuildingitem"
	slot1.cellClass = RoomBuildingItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = slot0:getBuildingItemWidth()
	slot1.cellHeight = 234
	slot1.cellSpaceH = slot0:getBuildingItemSpaceH()
	slot1.cellSpaceV = 0
	slot1.startSpace = 0

	for slot6 = 1, 10 do
	end

	slot0._buildingScrollView = LuaListScrollViewWithAnimator.New(RoomShowBuildingListModel.instance, slot1, {
		[slot6] = (slot6 - 1) * 0.03
	})

	return slot0._buildingScrollView
end

function slot0.getBuildingItemWidth(slot0)
	return 367.7297
end

function slot0.getBuildingItemSpaceH(slot0)
	return 22.5
end

slot0.prefabPath = "ui/viewres/room/roomviewbuilding.prefab"

return slot0
