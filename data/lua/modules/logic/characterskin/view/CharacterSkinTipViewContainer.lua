module("modules.logic.characterskin.view.CharacterSkinTipViewContainer", package.seeall)

local var_0_0 = class("CharacterSkinTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CharacterSkinTipRightView.New())
	table.insert(var_1_0, CharacterSkinLeftView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btntopleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		arg_2_0.navigateView
	}
end

function var_0_0.setHomeBtnVisible(arg_3_0, arg_3_1)
	if arg_3_0.navigateView then
		arg_3_0.navigateView:setParam({
			true,
			arg_3_1,
			false
		})
	end
end

function var_0_0.onPlayOpenTransitionFinish(arg_4_0)
	var_0_0.super.onPlayOpenTransitionFinish(arg_4_0)

	arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator)).enabled = true
end

return var_0_0
