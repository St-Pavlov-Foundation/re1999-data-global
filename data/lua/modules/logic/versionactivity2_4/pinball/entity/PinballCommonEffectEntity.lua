module("modules.logic.versionactivity2_4.pinball.entity.PinballCommonEffectEntity", package.seeall)

local var_0_0 = class("PinballCommonEffectEntity", PinballColliderEntity)

function var_0_0.canHit(arg_1_0)
	return false
end

function var_0_0.initByCo(arg_2_0)
	return
end

function var_0_0.setScale(arg_3_0, arg_3_1)
	arg_3_0.scale = arg_3_1

	transformhelper.setLocalScale(arg_3_0.trans, arg_3_0.scale, arg_3_0.scale, arg_3_0.scale)
end

function var_0_0.setDelayDispose(arg_4_0, arg_4_1)
	TaskDispatcher.runDelay(arg_4_0.markDead, arg_4_0, arg_4_1 or 1)
end

function var_0_0.onDestroy(arg_5_0)
	var_0_0.super.onDestroy(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.markDead, arg_5_0)
end

return var_0_0
