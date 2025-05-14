module("modules.logic.seasonver.act123.view1_8.Season123_1_8PickHeroViewContainer", package.seeall)

local var_0_0 = class("Season123_1_8PickHeroViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_1_8CheckCloseView.New(),
		Season123_1_8PickHeroView.New(),
		arg_1_0:getScrollView(),
		Season123_1_8PickHeroDetailView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.getScrollView(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = Season123_1_8PickHeroItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 5
	var_2_0.cellWidth = 200
	var_2_0.cellHeight = 440
	var_2_0.cellSpaceH = 12
	var_2_0.cellSpaceV = 10
	var_2_0.startSpace = 37

	local var_2_1 = {}

	for iter_2_0 = 1, 15 do
		var_2_1[iter_2_0] = math.ceil((iter_2_0 - 1) % 5) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(Season123PickHeroModel.instance, var_2_0, var_2_1)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_3_0._navigateButtonView
		}
	end
end

return var_0_0
