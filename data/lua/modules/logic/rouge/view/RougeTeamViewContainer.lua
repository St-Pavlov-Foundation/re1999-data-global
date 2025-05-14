module("modules.logic.rouge.view.RougeTeamViewContainer", package.seeall)

local var_0_0 = class("RougeTeamViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_rolecontainer/#scroll_view"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = RougeTeamHeroItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 6
	var_1_0.cellWidth = 250
	var_1_0.cellHeight = 555
	var_1_0.cellSpaceH = 20
	var_1_0.cellSpaceV = 56
	var_1_0.startSpace = 50

	local var_1_1 = {}

	for iter_1_0 = 1, 21 do
		var_1_1[iter_1_0] = math.ceil((iter_1_0 - 1) % 6) * 0.03
	end

	local var_1_2 = {}

	table.insert(var_1_2, RougeTeamView.New())
	table.insert(var_1_2, LuaListScrollViewWithAnimator.New(RougeTeamListModel.instance, var_1_0, var_1_1))
	table.insert(var_1_2, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_2
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
