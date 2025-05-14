module("modules.logic.explore.view.ExploreBlackView", package.seeall)

local var_0_0 = class("ExploreBlackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onOpenFinish(arg_2_0)
	if arg_2_0._has_onOpen then
		arg_2_0.anim.enabled = true

		arg_2_0.anim:Play("loop", 0, 0)
	end
end

return var_0_0
