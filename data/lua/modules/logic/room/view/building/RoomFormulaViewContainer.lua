module("modules.logic.room.view.building.RoomFormulaViewContainer", package.seeall)

slot0 = class("RoomFormulaViewContainer", BaseViewContainer)
slot0.cellHeightSize = 150

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomFormulaView.New())
	slot0:_buildFormulaItemListView(slot1)

	return slot1
end

function slot0._buildFormulaItemListView(slot0, slot1)
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "view/#scroll_formula"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = RoomFormulaItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 980
	slot2.cellHeight = slot0.cellHeightSize
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	slot0.__scrollView = LuaListScrollView.New(RoomFormulaListModel.instance, slot2)

	table.insert(slot1, slot0.__scrollView)
end

function slot0.getScrollView(slot0)
	return slot0.__scrollView
end

function slot0.getCsListScroll(slot0)
	return slot0:getScrollView():getCsListScroll()
end

return slot0
