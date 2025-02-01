module("modules.logic.room.view.common.RoomThemeTipViewContainer", package.seeall)

slot0 = class("RoomThemeTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomThemeTipView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "content/go_scroll/#scroll_item"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "content/themeitem"
	slot2.cellClass = RoomThemeTipItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 680
	slot2.cellHeight = 60
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 4
	slot2.startSpace = 0
	slot2.endSpace = 0

	table.insert(slot1, LuaListScrollView.New(RoomThemeItemListModel.instance, slot2))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
