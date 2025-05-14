module("modules.logic.player.view.PlayerViewContainer", package.seeall)

local var_0_0 = class("PlayerViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, PlayerView.New())
	table.insert(var_1_0, PlayerViewAchievement.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
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
	arg_3_0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_Player_Interface_Close)
end

return var_0_0
