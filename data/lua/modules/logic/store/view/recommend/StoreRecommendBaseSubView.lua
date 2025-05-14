module("modules.logic.store.view.recommend.StoreRecommendBaseSubView", package.seeall)

local var_0_0 = class("StoreRecommendBaseSubView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btn:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btn:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)
end

function var_0_0.onOpen(arg_5_0)
	if arg_5_0._animator then
		arg_5_0._animator.enabled = true

		arg_5_0._animator:Play(UIAnimationName.Open, 0, 0)
		arg_5_0._animator:Update(0)
	end
end

function var_0_0.switchClose(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._animator then
		arg_6_0._animator.enabled = false
	end

	if arg_6_0._animatorPlayer then
		arg_6_0._animatorPlayer:Play(UIAnimationName.Close, arg_6_1, arg_6_2)
	end
end

function var_0_0.stopAnimator(arg_7_0)
	if arg_7_0._animatorPlayer then
		arg_7_0._animatorPlayer:Stop()
	end

	if arg_7_0._animator then
		arg_7_0._animator.enabled = false
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

return var_0_0
