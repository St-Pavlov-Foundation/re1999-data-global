module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameViewContainer", package.seeall)

local var_0_0 = class("AssassinStealthGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AssassinStealthGameView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.AssassinStealthGame)

		arg_2_0.navigateView:setOverrideClose(arg_2_0.overrideCloseFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.overrideCloseFunc(arg_3_0)
	AssassinController.instance:openAssassinStealthGamePauseView()
end

return var_0_0
