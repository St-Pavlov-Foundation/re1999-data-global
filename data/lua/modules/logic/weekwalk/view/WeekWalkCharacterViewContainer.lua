module("modules.logic.weekwalk.view.WeekWalkCharacterViewContainer", package.seeall)

local var_0_0 = class("WeekWalkCharacterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_rolecontainer/#scroll_card"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = WeekWalkCharacterItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 5
	var_1_0.cellWidth = 300
	var_1_0.cellHeight = 600
	var_1_0.cellSpaceH = 35
	var_1_0.cellSpaceV = -30

	local var_1_1 = {}

	for iter_1_0 = 1, 10 do
		var_1_1[iter_1_0] = math.ceil((iter_1_0 - 1) % 5) * 0.06
	end

	arg_1_0._cardScrollView = LuaListScrollViewWithAnimator.New(WeekWalkCardListModel.instance, var_1_0, var_1_1)

	return {
		arg_1_0._cardScrollView,
		WeekWalkCharacterView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		arg_2_0.navigationView
	}
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0.playCardOpenAnimation(arg_4_0)
	if arg_4_0._cardScrollView then
		arg_4_0._cardScrollView:playOpenAnimation()
	end
end

return var_0_0
