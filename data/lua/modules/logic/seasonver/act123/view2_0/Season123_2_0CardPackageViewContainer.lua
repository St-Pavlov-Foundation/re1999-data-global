module("modules.logic.seasonver.act123.view2_0.Season123_2_0CardPackageViewContainer", package.seeall)

local var_0_0 = class("Season123_2_0CardPackageViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0:buildScrollViews()

	return {
		Season123_2_0CardPackageView.New(),
		arg_1_0.scrollView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		var_2_0:setHelpId(HelpEnum.HelpId.Season2_0CardGetViewHelp)
		var_2_0:hideHelpIcon()

		return {
			var_2_0
		}
	end
end

function var_0_0.buildScrollViews(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "#go_cardget/mask/#scroll_cardget"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[1]
	var_3_0.cellClass = Season123_2_0CardPackageItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.lineCount = 5
	var_3_0.cellWidth = 204
	var_3_0.cellHeight = 290
	var_3_0.cellSpaceH = 0
	var_3_0.cellSpaceV = 50
	var_3_0.frameUpdateMs = 100

	local var_3_1 = {}

	for iter_3_0 = 1, 15 do
		var_3_1[iter_3_0] = math.ceil(iter_3_0 / 5) * 0.06
	end

	arg_3_0.scrollView = LuaListScrollViewWithAnimator.New(Season123CardPackageModel.instance, var_3_0, var_3_1)
end

return var_0_0
