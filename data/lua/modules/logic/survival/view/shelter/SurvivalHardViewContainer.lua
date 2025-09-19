module("modules.logic.survival.view.shelter.SurvivalHardViewContainer", package.seeall)

local var_0_0 = class("SurvivalHardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Panel/Right/#scroll_List"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "Panel/Right/#scroll_List/Viewport/Content/#go_Item"
	var_1_1.cellClass = SurvivalHardItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 740
	var_1_1.cellHeight = 150
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	arg_1_0.scrollView = LuaListScrollViewWithAnimator.New(SurvivalDifficultyModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, SurvivalHardView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			var_2_0
		}
	end
end

return var_0_0
