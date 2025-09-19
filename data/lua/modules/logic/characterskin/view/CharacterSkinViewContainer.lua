module("modules.logic.characterskin.view.CharacterSkinViewContainer", package.seeall)

local var_0_0 = class("CharacterSkinViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CharacterSkinSwitchRightView.New())
	table.insert(var_1_0, CharacterSkinLeftView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btntopleft"))
	table.insert(var_1_0, CharacterSkinSwitchSpineGCView.New())

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

function var_0_0.playOpenTransition(arg_3_0)
	arg_3_0:_cancelBlock()
	arg_3_0:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local var_3_0 = ZProj.ProjAnimatorPlayer.Get(arg_3_0.viewGO)

	if arg_3_0.viewParam and arg_3_0.viewParam.storyMode then
		var_3_0:Play("left_open", arg_3_0.onOpenAnimDone, arg_3_0)
	else
		var_3_0:Play(UIAnimationName.Open, arg_3_0.onOpenAnimDone, arg_3_0)
	end
end

function var_0_0.onOpenAnimDone(arg_4_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	arg_4_0:onPlayOpenTransitionFinish()
end

function var_0_0.playCloseTransition(arg_5_0)
	arg_5_0:_cancelBlock()
	arg_5_0:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local var_5_0 = ZProj.ProjAnimatorPlayer.Get(arg_5_0.viewGO)

	if arg_5_0.viewParam and arg_5_0.viewParam.storyMode then
		var_5_0:Play("left_out", arg_5_0.onCloseAnimDone, arg_5_0)
	else
		var_5_0:Play(UIAnimationName.Close, arg_5_0.onCloseAnimDone, arg_5_0)
	end
end

function var_0_0.onCloseAnimDone(arg_6_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	arg_6_0:onPlayCloseTransitionFinish()
end

return var_0_0
