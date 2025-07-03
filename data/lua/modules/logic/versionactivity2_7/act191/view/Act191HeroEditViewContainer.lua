module("modules.logic.versionactivity2_7.act191.view.Act191HeroEditViewContainer", package.seeall)

local var_0_0 = class("Act191HeroEditViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_rolecontainer/layout/#scroll_card"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = Act191HeroEditItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 5
	var_1_0.cellWidth = 200
	var_1_0.cellHeight = 440
	var_1_0.cellSpaceH = 12
	var_1_0.cellSpaceV = 10
	var_1_0.startSpace = 37

	local var_1_1 = {}

	for iter_1_0 = 1, 15 do
		var_1_1[iter_1_0] = math.ceil((iter_1_0 - 1) % 5) * 0.03
	end

	return {
		Act191HeroEditView.New(),
		LuaListScrollViewWithAnimator.New(Act191HeroEditListModel.instance, var_1_0, var_1_1),
		arg_1_0:getQuickEditScroll(),
		CommonRainEffectView.New("bg/go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.getQuickEditScroll(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "#go_rolecontainer/layout/#scroll_quickedit"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = Act191HeroQuickEditItem
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

	return LuaListScrollViewWithAnimator.New(Act191HeroQuickEditListModel.instance, var_2_0, var_2_1)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	arg_3_0._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		arg_3_0._navigateButtonView
	}
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
end

return var_0_0
