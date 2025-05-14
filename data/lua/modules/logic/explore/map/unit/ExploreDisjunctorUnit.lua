module("modules.logic.explore.map.unit.ExploreDisjunctorUnit", package.seeall)

local var_0_0 = class("ExploreDisjunctorUnit", ExploreBaseDisplayUnit)

function var_0_0.onTrigger(arg_1_0)
	var_0_0.super.onTrigger(arg_1_0)
	arg_1_0:doRotate(arg_1_0.mo.unitDir, ExploreHelper.getDir(arg_1_0.mo.unitDir + 90), 0.5)

	arg_1_0._lockTrigger = true

	TaskDispatcher.runDelay(arg_1_0._delayUnlock, arg_1_0, 2.5)
end

function var_0_0.tryTrigger(arg_2_0, ...)
	if arg_2_0._lockTrigger then
		return
	end

	var_0_0.super.tryTrigger(arg_2_0, ...)
end

function var_0_0._delayUnlock(arg_3_0)
	arg_3_0._lockTrigger = false
end

function var_0_0.onDestroy(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayUnlock, arg_4_0)
	var_0_0.super.onDestroy(arg_4_0)
end

return var_0_0
