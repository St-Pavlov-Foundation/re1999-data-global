module("modules.logic.room.view.layout.RoomLayoutBgSelectViewContainer", package.seeall)

slot0 = class("RoomLayoutBgSelectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomLayoutBgSelectView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_content/#scroll_CoverItemList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#go_content/#go_coveritem"
	slot2.cellClass = RoomLayoutBgSelectItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 520
	slot2.cellHeight = 254
	slot2.cellSpaceH = 20
	slot2.cellSpaceV = 20
	slot2.startSpace = 20

	table.insert(slot1, LuaListScrollView.New(RoomLayoutBgResListModel.instance, slot2))

	return slot1
end

return slot0
