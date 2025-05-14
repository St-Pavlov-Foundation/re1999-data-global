module("modules.logic.minors.view.DateOfBirthSelectionViewContainer", package.seeall)

local var_0_0 = class("DateOfBirthSelectionViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()
	local var_1_1 = DateOfBirthSelectionViewListModel.instance

	var_1_0.cellClass = DateOfBirthSelectionViewItem
	var_1_0.scrollGOPath = "#scroll_list"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "#scroll_list/content/item"
	var_1_0.scrollDir = ScrollEnum.ScrollDirH
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 440
	var_1_0.cellHeight = 112
	var_1_0.cellSpaceH = 58
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0
	var_1_0.endSpace = 0

	return {
		DateOfBirthSelectionView.New(),
		(LuaListScrollView.New(var_1_1, var_1_0))
	}
end

return var_0_0
