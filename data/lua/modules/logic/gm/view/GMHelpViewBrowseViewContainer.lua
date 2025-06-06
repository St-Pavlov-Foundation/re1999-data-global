﻿module("modules.logic.gm.view.GMHelpViewBrowseViewContainer", package.seeall)

local var_0_0 = class("GMHelpViewBrowseViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "view/scroll"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "view/scroll/item"
	var_1_1.cellClass = GMHelpViewBrowseItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 962.5
	var_1_1.cellHeight = 85
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0

	table.insert(var_1_0, GMHelpViewBrowseView.New())
	table.insert(var_1_0, LuaListScrollView.New(GMHelpViewBrowseModel.instance, var_1_1))

	return var_1_0
end

return var_0_0
