module("modules.logic.room.view.debug.RoomDebugThemeFilterViewContainer", package.seeall)

slot0 = class("RoomDebugThemeFilterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomDebugThemeFilterView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_content/#scroll_theme"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#go_content/#go_themeitem"
	slot2.cellClass = RoomDebugThemeFilterItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 3
	slot2.cellWidth = 386
	slot2.cellHeight = 80
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	slot2.endSpace = 0

	table.insert(slot1, LuaListScrollView.New(RoomDebugThemeFilterListModel.instance, slot2))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
