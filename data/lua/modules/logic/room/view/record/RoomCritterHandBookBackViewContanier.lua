module("modules.logic.room.view.record.RoomCritterHandBookBackViewContanier", package.seeall)

slot0 = class("RoomCritterHandBookBackViewContanier", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "bg/#scroll_view/"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "bg/#scroll_view/Viewport/Content/item"
	slot1.cellClass = RoomCritterHandBookBackItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.cellWidth = 230
	slot1.cellHeight = 220
	slot1.cellSpaceV = 0
	slot1.cellSpaceH = 20
	slot1.startSpace = 20
	slot1.cellSpaceH = 0
	slot1.lineCount = 4
	slot0._handbookbackView = RoomCritterHandBookBackView.New()
	slot0._handbookbackScrollView = LuaListScrollView.New(RoomHandBookBackListModel.instance, slot1)
	slot2 = {}

	table.insert(slot2, slot0._handbookbackView)
	table.insert(slot2, slot0._handbookbackScrollView)

	return slot2
end

function slot0.getScrollView(slot0)
	return slot0._handbookbackScrollView
end

return slot0
