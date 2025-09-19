module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErGameViewContainer", package.seeall)

local var_0_0 = class("MoLiDeErGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, MoLiDeErGameView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setCloseCheck(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	MoLiDeErController.instance:statGameExit(StatEnum.MoLiDeErGameExitType.Exit)
	arg_3_0:closeThis()
end

return var_0_0
