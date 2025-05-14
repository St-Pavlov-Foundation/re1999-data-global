module("modules.logic.herogroup.view.HeroGroupAnimView", package.seeall)

local var_0_0 = class("HeroGroupAnimView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goherogroupcontain = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._goBtnContain = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, arg_2_0._playHeroGroupExitEffect, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, arg_2_0._playCloseHeroGroupAnimation, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, arg_3_0._playHeroGroupExitEffect, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, arg_3_0._playCloseHeroGroupAnimation, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._heroContainAnim = arg_4_0._goherogroupcontain:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._anim = arg_4_0._gocontainer:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._btnContainAnim = arg_4_0._goBtnContain:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._playHeroGroupExitEffect(arg_5_0)
	arg_5_0._anim:Play(UIAnimationName.Close, 0, 0)
	arg_5_0._btnContainAnim:Play(UIAnimationName.Close, 0, 0)
end

function var_0_0._playCloseHeroGroupAnimation(arg_6_0)
	arg_6_0._anim:Play(UIAnimationName.Close, 0, 0)
	arg_6_0._btnContainAnim:Play(UIAnimationName.Close, 0, 0)

	arg_6_0._heroContainAnim.enabled = true

	arg_6_0._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.runDelay(arg_6_0._closeHeroContainAnim, arg_6_0, 0.133)
end

function var_0_0._closeHeroContainAnim(arg_7_0)
	if arg_7_0._heroContainAnim then
		arg_7_0._heroContainAnim.enabled = false
	end
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:_playHeroGroupExitEffect()

	arg_8_0._heroContainAnim.enabled = true

	arg_8_0._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.cancelTask(arg_8_0._closeHeroContainAnim, arg_8_0)
end

return var_0_0
