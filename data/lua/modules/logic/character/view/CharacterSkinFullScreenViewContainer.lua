module("modules.logic.character.view.CharacterSkinFullScreenViewContainer", package.seeall)

local var_0_0 = class("CharacterSkinFullScreenViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))
	table.insert(var_1_0, CharacterSkinFullScreenView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		}, 100)
	}
end

function var_0_0.playOpenTransition(arg_3_0)
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	var_0_0.super.playOpenTransition(arg_3_0)
end

function var_0_0.onPlayOpenTransitionFinish(arg_4_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	var_0_0.super.onPlayOpenTransitionFinish(arg_4_0)
end

return var_0_0
