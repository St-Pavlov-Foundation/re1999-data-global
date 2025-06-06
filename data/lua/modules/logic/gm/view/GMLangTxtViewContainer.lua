﻿module("modules.logic.gm.view.GMLangTxtViewContainer", package.seeall)

local var_0_0 = class("GMLangTxtViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "view/scroll"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "view/scroll/item"
	var_1_1.cellClass = GMLangTxtItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 800
	var_1_1.cellHeight = 60
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	arg_1_0._langTxtView = GMLangTxtView.New()

	table.insert(var_1_0, arg_1_0._langTxtView)
	table.insert(var_1_0, LuaListScrollView.New(GMLangTxtModel.instance, var_1_1))

	return var_1_0
end

function var_0_0.onLangTxtClick(arg_2_0, arg_2_1)
	arg_2_0._langTxtView:onLangTxtClick(arg_2_1)
end

return var_0_0
