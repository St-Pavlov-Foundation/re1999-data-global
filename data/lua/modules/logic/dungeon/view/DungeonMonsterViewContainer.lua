module("modules.logic.dungeon.view.DungeonMonsterViewContainer", package.seeall)

local var_0_0 = class("DungeonMonsterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, DungeonMonsterView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_monster"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "content_prefab"
	var_1_1.cellClass = DungeonMonsterItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 4
	var_1_1.cellWidth = 130
	var_1_1.cellHeight = 130
	var_1_1.cellSpaceH = 40
	var_1_1.cellSpaceV = 40
	var_1_1.startSpace = 24
	var_1_1.endSpace = 0
	arg_1_0._scrollView = LuaListScrollView.New(DungeonMonsterListModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0._scrollView)
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		}, 100)
	}
end

function var_0_0.getScrollView(arg_3_0)
	return arg_3_0._scrollView
end

return var_0_0
