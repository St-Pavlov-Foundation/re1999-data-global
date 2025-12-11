module("modules.logic.currency.view.PowerItemFlyItem", package.seeall)

local var_0_0 = class("PowerItemFlyItem", LuaCompBase)
local var_0_1 = "powerview_fly"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.animPlayer = SLFramework.AnimatorPlayer.Get(arg_1_1)
	arg_1_0.isFlying = false
end

function var_0_0.fly(arg_2_0, arg_2_1)
	arg_2_0.isFlying = true

	gohelper.setActive(arg_2_0.go, false)
	TaskDispatcher.cancelTask(arg_2_0._playFlyAnim, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._playFlyAnim, arg_2_0, arg_2_1)
end

function var_0_0._playFlyAnim(arg_3_0)
	gohelper.setActive(arg_3_0.go, true)
	arg_3_0.animPlayer:Play(var_0_1, arg_3_0._flyCallback, arg_3_0)
end

function var_0_0._flyCallback(arg_4_0)
	arg_4_0.isFlying = false

	gohelper.setActive(arg_4_0.go, false)
end

function var_0_0.isCanfly(arg_5_0)
	return not arg_5_0.isFlying
end

function var_0_0.onDestroy(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._playFlyAnim, arg_6_0)

	arg_6_0.isFlying = false
end

return var_0_0
