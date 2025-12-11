module("modules.logic.fight.system.work.FightWorkLoadAnimator", package.seeall)

local var_0_0 = class("FightWorkLoadAnimator", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.url = arg_1_1
	arg_1_0.obj = arg_1_2
	arg_1_0.SAFETIME = 5
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:com_loadAsset(arg_2_0.url, arg_2_0.onLoaded)
end

function var_0_0.onLoaded(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_1 then
		return arg_3_0:onDone(true)
	end

	arg_3_0:com_registTimer(arg_3_0.delaySetAnimator, 0.01, arg_3_2)
end

function var_0_0.delaySetAnimator(arg_4_0, arg_4_1)
	gohelper.onceAddComponent(arg_4_0.obj, typeof(UnityEngine.Animator)).runtimeAnimatorController = arg_4_1:GetResource()

	arg_4_0:onDone(true)
end

return var_0_0
