module("modules.logic.minors.view.DateOfBirthSelectionViewContainer", package.seeall)

slot0 = class("DateOfBirthSelectionViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.cellClass = DateOfBirthSelectionViewItem
	slot1.scrollGOPath = "#scroll_list"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#scroll_list/content/item"
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 440
	slot1.cellHeight = 112
	slot1.cellSpaceH = 58
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot1.endSpace = 0

	return {
		DateOfBirthSelectionView.New(),
		LuaListScrollView.New(DateOfBirthSelectionViewListModel.instance, slot1)
	}
end

return slot0
