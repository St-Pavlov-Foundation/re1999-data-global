module("modules.logic.character.view.CharacterViewContainer", package.seeall)

local var_0_0 = class("CharacterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._equipView = CharacterDefaultEquipView.New()
	arg_1_0._extraView = CharacterDefaultExtraView.New()

	table.insert(var_1_0, CharacterView.New())
	table.insert(var_1_0, arg_1_0._equipView)
	table.insert(var_1_0, arg_1_0._extraView)
	table.insert(var_1_0, CharacterSpineGCView.New())
	table.insert(var_1_0, CommonRainEffectView.New("anim/bgcanvas/#go_glowcontainer"))

	arg_1_0.helpShowView = HelpShowView.New()

	table.insert(var_1_0, arg_1_0.helpShowView)

	return var_1_0
end

function var_0_0.getEquipView(arg_2_0)
	return arg_2_0._equipView
end

function var_0_0.playOpenTransition(arg_3_0)
	arg_3_0:_cancelBlock()
	arg_3_0:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	ZProj.ProjAnimatorPlayer.Get(arg_3_0.viewGO):Play(UIAnimationName.Open, arg_3_0.onOpenAnimDone, arg_3_0)
	arg_3_0:startViewOpenBlock()
end

function var_0_0.onOpenAnimDone(arg_4_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	arg_4_0:onPlayOpenTransitionFinish()
	arg_4_0:_cancelBlock()
	arg_4_0:_stopOpenCloseAnim()
end

function var_0_0.playCloseTransition(arg_5_0)
	arg_5_0:_cancelBlock()
	arg_5_0:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	ZProj.ProjAnimatorPlayer.Get(arg_5_0.viewGO):Play(UIAnimationName.Close, arg_5_0.onCloseAnimDone, arg_5_0)
	arg_5_0:startViewCloseBlock()
end

function var_0_0.onCloseAnimDone(arg_6_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	arg_6_0:onPlayCloseTransitionFinish()
	arg_6_0:_cancelBlock()
	arg_6_0:_stopOpenCloseAnim()
end

function var_0_0.setIsOwnHero(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0._isOwnHero = arg_7_1.isOwnHero
	else
		arg_7_0._isOwnHero = true
	end
end

function var_0_0.isOwnHero(arg_8_0)
	return arg_8_0._isOwnHero
end

return var_0_0
