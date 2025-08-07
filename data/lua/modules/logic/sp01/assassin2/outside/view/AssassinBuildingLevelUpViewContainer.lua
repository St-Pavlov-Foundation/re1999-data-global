module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingLevelUpViewContainer", package.seeall)

local var_0_0 = class("AssassinBuildingLevelUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AssassinBuildingLevelUpView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.playCloseTransition(arg_3_0)
	ZProj.ProjAnimatorPlayer.Get(arg_3_0.viewGO):Play(UIAnimationName.Close, arg_3_0.onCloseAnimDone, arg_3_0)
end

function var_0_0.onCloseAnimDone(arg_4_0)
	arg_4_0:onPlayCloseTransitionFinish()
end

return var_0_0
