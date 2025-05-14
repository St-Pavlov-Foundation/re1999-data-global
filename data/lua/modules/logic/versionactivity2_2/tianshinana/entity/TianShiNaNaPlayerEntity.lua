module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaPlayerEntity", package.seeall)

local var_0_0 = class("TianShiNaNaPlayerEntity", TianShiNaNaUnitEntityBase)

function var_0_0.onMoving(arg_1_0)
	if not arg_1_0.trans then
		return
	end

	local var_1_0 = arg_1_0:getLocalPos()

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.PlayerMove, var_1_0)
end

function var_0_0.updatePosAndDir(arg_2_0)
	var_0_0.super.updatePosAndDir(arg_2_0)
	arg_2_0:onMoving()
end

function var_0_0.onResLoaded(arg_3_0)
	arg_3_0._anim = arg_3_0._resGo:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.reAdd(arg_4_0)
	if arg_4_0._anim then
		arg_4_0._anim:Play("open", 0, 1)
	end
end

function var_0_0.playCloseAnim(arg_5_0)
	if arg_5_0._anim then
		arg_5_0._anim:Play("close", 0, 0)
	end
end

return var_0_0
