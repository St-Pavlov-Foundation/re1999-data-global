-- chunkname: @modules/logic/minors/view/DateOfBirthSelectionViewContainer.lua

module("modules.logic.minors.view.DateOfBirthSelectionViewContainer", package.seeall)

local DateOfBirthSelectionViewContainer = class("DateOfBirthSelectionViewContainer", BaseViewContainer)

function DateOfBirthSelectionViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()
	local scrollModel = DateOfBirthSelectionViewListModel.instance

	scrollParam.cellClass = DateOfBirthSelectionViewItem
	scrollParam.scrollGOPath = "#scroll_list"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_list/content/item"
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 440
	scrollParam.cellHeight = 112
	scrollParam.cellSpaceH = 58
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	local views = {
		DateOfBirthSelectionView.New(),
		(LuaListScrollView.New(scrollModel, scrollParam))
	}

	return views
end

return DateOfBirthSelectionViewContainer
