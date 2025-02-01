module("modules.logic.room.view.RoomInitBuildingViewContainer", package.seeall)

slot0 = class("RoomInitBuildingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_navigatebuttonscontainer"))

	slot0._roomInitBuildingView = RoomInitBuildingView.New()

	table.insert(slot1, slot0._roomInitBuildingView)
	table.insert(slot1, RoomInitBuildingViewChange.New())
	table.insert(slot1, RoomInitBuildingSkinView.New())
	table.insert(slot1, RoomViewTopRight.New("#go_topright", slot0._viewSetting.otherRes[1], {
		{
			initAnim = "idle",
			type = 2,
			id = 5,
			supportFlyEffect = true,
			classDefine = RoomViewTopRightMaterialItem,
			listeningItems = {
				{
					id = 5,
					type = 2
				},
				{
					id = 3,
					type = 2
				}
			}
		},
		{
			initAnim = "idle",
			type = 2,
			id = 3,
			supportFlyEffect = true,
			classDefine = RoomViewTopRightMaterialItem,
			listeningItems = {
				{
					id = 5,
					type = 2
				},
				{
					id = 3,
					type = 2
				}
			}
		}
	}))
	table.insert(slot1, slot0:_createShowDegreeListView())
	table.insert(slot1, slot0:_createRoomSkinListView())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.RoomInitBuilding, slot0._closeCallback, nil, , slot0)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0._closeCallback(slot0)
	if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		ViewMgr.instance:closeView(ViewName.RoomFormulaView)
	end

	RoomMapController.instance:onCloseRoomInitBuildingView()
end

function slot0.setSelectLine(slot0, slot1)
	slot0._selectLineId = slot1
end

function slot0.getSelectLine(slot0)
	return slot0._selectLineId
end

function slot0.setSelectPartId(slot0, slot1)
	slot0._selectPartId = slot1
end

function slot0.getCurrentViewParam(slot0)
	return {
		partId = slot0._selectPartId,
		lineId = slot0._selectLineId
	}
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetCloseBtnAudioId(0)
end

function slot0._createShowDegreeListView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "right/#go_init/#go_activeList/#scroll_activeList"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "right/#go_init/#go_activeList/#scroll_activeList/viewport/content/#go_degreeItem"
	slot1.cellClass = RoomInitBuildingDegreeItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.cellWidth = 635
	slot1.cellHeight = 60
	slot1.cellSpaceV = 4
	slot1.startSpace = 0

	for slot6 = 1, 10 do
	end

	return LuaListScrollViewWithAnimator.New(RoomShowDegreeListModel.instance, slot1, {
		[slot6] = (slot6 - 1) * 0.03
	})
end

function slot0._createRoomSkinListView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "right/#go_skin/#scroll_view"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "right/#go_skin/#scroll_view/viewport/content/#go_skinitem"
	slot1.cellClass = RoomInitBuildingSkinItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.cellWidth = 600
	slot1.cellHeight = 184
	slot1.cellSpaceV = 20
	slot1.startSpace = 14

	return LuaListScrollView.New(RoomSkinListModel.instance, slot1)
end

function slot0.setIsShowTitle(slot0, slot1)
	if not slot0._roomInitBuildingView then
		return
	end

	slot0._roomInitBuildingView:setTitleShow(slot1)
end

return slot0
