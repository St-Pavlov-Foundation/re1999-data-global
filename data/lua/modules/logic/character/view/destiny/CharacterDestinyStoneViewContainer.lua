module("modules.logic.character.view.destiny.CharacterDestinyStoneViewContainer", package.seeall)

local var_0_0 = class("CharacterDestinyStoneViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._stoneView = CharacterDestinyStoneView.New()

	table.insert(var_1_0, arg_1_0._stoneView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0.overrideCloseFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.setOpenUnlockStoneView(arg_3_0, arg_3_1)
	arg_3_0._openUnlockStoneView = arg_3_1
end

function var_0_0.overrideCloseFunc(arg_4_0)
	if arg_4_0._openUnlockStoneView then
		arg_4_0._stoneView:closeUnlockStoneView()
	else
		arg_4_0:closeThis()
	end
end

function var_0_0.playCloseTransition(arg_5_0)
	arg_5_0._stoneView:playRootOpenCloseAnim(false, arg_5_0.onCloseAnimDone, arg_5_0)
end

function var_0_0.onCloseAnimDone(arg_6_0)
	arg_6_0:onPlayCloseTransitionFinish()
end

return var_0_0
