module("modules.logic.room.view.transport.RoomTransportSiteViewContainer", package.seeall)

slot0 = class("RoomTransportSiteViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "go_content/#go_right/#go_buildinglist/#scroll_building"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = RoomTransportBuildingItem.prefabPath
	slot1.cellClass = RoomTransportBuildingItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 540
	slot1.cellHeight = 180
	slot1.cellSpaceV = 10
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "go_content/#go_right/#go_buildinglist/#scroll_buildingskin"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = RoomTransportBuildingSkinItem.prefabPath
	slot2.cellClass = RoomTransportBuildingSkinItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 196
	slot2.cellHeight = 140
	slot2.cellSpaceV = 10
	slot3 = ListScrollParam.New()
	slot3.scrollGOPath = "go_content/#go_right/#go_critterlist/#scroll_critter"
	slot3.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot3.prefabUrl = RoomTransportCritterItem.prefabPath
	slot3.cellClass = RoomTransportCritterItem
	slot3.scrollDir = ScrollEnum.ScrollDirV
	slot3.lineCount = 1
	slot3.cellWidth = 640
	slot3.cellHeight = 175
	slot3.cellSpaceV = 10
	slot4 = {}

	table.insert(slot4, TabViewGroup.New(1, "go_content/#go_BackBtns"))
	table.insert(slot4, RoomTransportSiteView.New())
	table.insert(slot4, LuaListScrollView.New(RoomTransportBuildingListModel.instance, slot1))
	table.insert(slot4, LuaListScrollView.New(RoomTransportBuildingSkinListModel.instance, slot2))

	return slot4
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.RoomTransportHelp)

		slot0.navigateView:setOverrideClose(slot0._overrideCloseFunc, slot0)
		NavigateMgr.instance:addEscape(slot0.viewName, slot0._overrideCloseFunc, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0._overrideCloseFunc(slot0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterListView) then
		ViewMgr.instance:closeView(ViewName.RoomCritterListView)

		return
	end

	slot0:closeThis()
end

function slot0.setUseBuildingUid(slot0, slot1)
	slot0.useBuildingUid = slot1
end

function slot0.getUseBuildingUid(slot0)
	return slot0.useBuildingUid
end

return slot0
