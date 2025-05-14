module("modules.logic.versionactivity2_4.pinball.entity.PinballResEntity", package.seeall)

local var_0_0 = class("PinballResEntity", PinballColliderEntity)

function var_0_0.doHit(arg_1_0, arg_1_1)
	if arg_1_0.isDead then
		return
	end

	arg_1_0:onHitCount(arg_1_1)

	if arg_1_0.isDead then
		arg_1_0._waitAnim = true

		TaskDispatcher.runDelay(arg_1_0._delayDestory, arg_1_0, 1.5)
		arg_1_0:playAnim("disapper")
	else
		arg_1_0:playAnim("hit")
	end
end

function var_0_0.onHitCount(arg_2_0, arg_2_1)
	return
end

function var_0_0._delayDestory(arg_3_0)
	gohelper.destroy(arg_3_0.go)
end

function var_0_0.onDestroy(arg_4_0)
	var_0_0.super.onDestroy(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDestory, arg_4_0)
end

function var_0_0.dispose(arg_5_0)
	if not arg_5_0._waitAnim then
		gohelper.destroy(arg_5_0.go)
	end
end

return var_0_0
