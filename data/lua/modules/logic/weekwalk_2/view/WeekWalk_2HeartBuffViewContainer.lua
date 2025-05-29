module("modules.logic.weekwalk_2.view.WeekWalk_2HeartBuffViewContainer", package.seeall)

local var_0_0 = class("WeekWalk_2HeartBuffViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "Root/Left/Scroll View"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = WeekWalk_2HeartBuffItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 3
	var_1_0.cellWidth = 240
	var_1_0.cellHeight = 220

	local var_1_1 = {}

	table.insert(var_1_1, WeekWalk_2HeartBuffView.New())
	table.insert(var_1_1, LuaListScrollView.New(WeekWalk_2BuffListModel.instance, var_1_0))

	return var_1_1
end

function var_0_0.onContainerOpen(arg_2_0)
	local var_2_0 = arg_2_0.viewParam and arg_2_0.viewParam.isBattle

	WeekWalk_2BuffListModel.instance:initBuffList(var_2_0)
end

function var_0_0.onContainerClickModalMask(arg_3_0)
	arg_3_0:closeThis()
end

return var_0_0
