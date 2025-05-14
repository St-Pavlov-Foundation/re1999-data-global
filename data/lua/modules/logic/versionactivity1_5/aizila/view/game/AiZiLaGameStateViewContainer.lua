module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameStateViewContainer", package.seeall)

local var_0_0 = class("AiZiLaGameStateViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._gameStateView = AiZiLaGameStateView.New()

	table.insert(var_1_0, arg_1_0._gameStateView)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0._navigateButtonsView
		}
	end
end

return var_0_0
