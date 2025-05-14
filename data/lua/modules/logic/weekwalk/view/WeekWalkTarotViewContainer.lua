module("modules.logic.weekwalk.view.WeekWalkTarotViewContainer", package.seeall)

local var_0_0 = class("WeekWalkTarotViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, WeekWalkTarotView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_tarot"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = WeekWalkTarotItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 5
	var_1_1.cellWidth = 340
	var_1_1.cellHeight = 650
	var_1_1.cellSpaceH = 110.3
	var_1_1.cellSpaceV = 40
	var_1_1.startSpace = 10.6
	var_1_1.endSpace = 20

	local var_1_2 = LuaListScrollView.New(WeekWalkTarotListModel.instance, var_1_1)

	table.insert(var_1_0, var_1_2)

	return var_1_0
end

return var_0_0
