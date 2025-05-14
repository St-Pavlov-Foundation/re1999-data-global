module("modules.logic.gm.view.GMResetCardsViewContainer", package.seeall)

local var_0_0 = class("GMResetCardsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "viewport1"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "viewport1/item"
	var_1_0.cellClass = GMResetCardsItem1
	var_1_0.scrollDir = ScrollEnum.ScrollDirH
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 170
	var_1_0.cellHeight = 250
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "viewport2"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "viewport2/item"
	var_1_1.cellClass = GMResetCardsItem2
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 2
	var_1_1.cellWidth = 170
	var_1_1.cellHeight = 250
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 20
	var_1_1.startSpace = 0

	local var_1_2 = {}

	table.insert(var_1_2, GMResetCardsView.New())
	table.insert(var_1_2, LuaListScrollView.New(GMResetCardsModel.instance:getModel1(), var_1_0))
	table.insert(var_1_2, LuaListScrollView.New(GMResetCardsModel.instance:getModel2(), var_1_1))

	return var_1_2
end

return var_0_0
