module("modules.logic.weekwalk.view.WeekWalkBuffBindingViewContainer", package.seeall)

local var_0_0 = class("WeekWalkBuffBindingViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_rolecontainer/#scroll_card"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = WeekWalkBuffBindingHeroItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 5
	var_1_0.cellWidth = 211
	var_1_0.cellHeight = 450
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 30

	local var_1_1 = {}

	for iter_1_0 = 1, 15 do
		var_1_1[iter_1_0] = math.ceil((iter_1_0 - 1) % 5) * 0.06
	end

	return {
		LuaListScrollViewWithAnimator.New(WeekWalkCardListModel.instance, var_1_0, var_1_1),
		WeekWalkBuffBindingView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		arg_2_0.navigationView
	}
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.play_ui_checkpoint_click)
end

return var_0_0
