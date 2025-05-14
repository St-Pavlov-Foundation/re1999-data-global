module("modules.logic.gm.view.GMErrorViewContainer", package.seeall)

local var_0_0 = class("GMErrorViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "panel/list/list"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "panel/list/list/Viewport/item"
	var_1_1.cellClass = GMErrorItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 900
	var_1_1.cellHeight = 100
	var_1_1.cellSpaceH = 2
	var_1_1.cellSpaceV = 0

	table.insert(var_1_0, GMErrorView.New())
	table.insert(var_1_0, LuaListScrollView.New(GMLogModel.instance.errorModel, var_1_1))

	return var_1_0
end

return var_0_0
