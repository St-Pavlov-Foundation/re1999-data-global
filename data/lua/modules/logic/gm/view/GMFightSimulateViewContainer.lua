module("modules.logic.gm.view.GMFightSimulateViewContainer", package.seeall)

local var_0_0 = class("GMFightSimulateViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "leftviewport"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "leftviewport/item"
	var_1_0.cellClass = GMFightSimulateLeftItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 350
	var_1_0.cellHeight = 100
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "rightviewport"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "rightviewport/item"
	var_1_1.cellClass = GMFightSimulateRightItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1000
	var_1_1.cellHeight = 100
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0

	local var_1_2 = {}

	table.insert(var_1_2, LuaListScrollView.New(GMFightSimulateLeftModel.instance, var_1_0))
	table.insert(var_1_2, LuaListScrollView.New(GMFightSimulateRightModel.instance, var_1_1))
	table.insert(var_1_2, GMFightSimulateView.New())

	return var_1_2
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
