module("modules.logic.fight.system.work.FightWorkPlayAnimator", package.seeall)

local var_0_0 = class("FightWorkPlayAnimator", FightWorkItem)
local var_0_1 = SLFramework.AnimatorPlayer

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.obj = arg_1_1
	arg_1_0.name = arg_1_2
	arg_1_0.speed = arg_1_3 or 1
	arg_1_0.callback = arg_1_4
	arg_1_0.handle = arg_1_5
	arg_1_0.SAFETIME = arg_1_6 or 5
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = var_0_1.Get(arg_2_0.obj)

	var_2_0.animator.speed = arg_2_0.speed

	var_2_0:Play(arg_2_0.name, arg_2_0.onAniFinish, arg_2_0)
end

function var_0_0.onAniFinish(arg_3_0)
	if arg_3_0.IS_DISPOSED then
		return
	end

	if arg_3_0.callback then
		arg_3_0.callback(arg_3_0.handle)
	end

	arg_3_0:onDone(true)
end

return var_0_0
