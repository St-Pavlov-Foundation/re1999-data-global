module("modules.logic.herogrouppreset.view.HeroGroupPresetTeamViewContainer", package.seeall)

local var_0_0 = class("HeroGroupPresetTeamViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, HeroGroupPresetTeamView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))
	arg_1_0:_addTabList(var_1_0)
	arg_1_0:_addItemList(var_1_0)

	return var_1_0
end

function var_0_0._addTabList(arg_2_0, arg_2_1)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "#scroll_tab"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = HeroGroupPresetTeamTabItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 1
	var_2_0.cellWidth = 482
	var_2_0.cellHeight = 171
	var_2_0.cellSpaceH = 8
	var_2_0.cellSpaceV = 0.8
	var_2_0.startSpace = -6

	local var_2_1 = {}

	for iter_2_0 = 1, 10 do
		var_2_1[iter_2_0] = (iter_2_0 - 1) * 0.03
	end

	table.insert(arg_2_1, LuaListScrollViewWithAnimator.New(HeroGroupPresetTabListModel.instance, var_2_0, var_2_1))
end

function var_0_0._addItemList(arg_3_0, arg_3_1)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "#scroll_group"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[2]
	var_3_0.cellClass = HeroGroupPresetTeamItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 1340
	var_3_0.cellHeight = 220
	var_3_0.cellSpaceV = 58.8
	var_3_0.startSpace = 45

	local var_3_1 = {}

	for iter_3_0 = 1, 10 do
		var_3_1[iter_3_0] = (iter_3_0 - 1) * 0.03
	end

	table.insert(arg_3_1, LuaListScrollViewWithAnimator.New(HeroGroupPresetItemListModel.instance, var_3_0, var_3_1))
end

function var_0_0.buildTabViews(arg_4_0, arg_4_1)
	if arg_4_1 == 1 then
		arg_4_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_4_0.navigateView
		}
	end
end

return var_0_0
