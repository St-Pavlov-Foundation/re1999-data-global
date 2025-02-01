module("modules.logic.room.view.building.RoomFormulaMsgBoxViewViewContainer", package.seeall)

slot0 = class("RoomFormulaMsgBoxViewViewContainer", BaseViewContainer)
slot0.lineCount = 4

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "Exchange/Left/Scroll View"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "Exchange/Left/Scroll View/Viewport/Content/#go_PropItem"
	slot2.cellClass = RoomFormulaMsgBoxItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.cellWidth = 120
	slot2.cellHeight = 106
	slot2.cellSpaceH = 70
	slot2.lineCount = slot0.lineCount

	table.insert(slot1, RoomFormulaMsgBoxView.New())
	table.insert(slot1, LuaListScrollView.New(RoomFormulaMsgBoxModel.instance, slot2))

	return slot1
end

return slot0
