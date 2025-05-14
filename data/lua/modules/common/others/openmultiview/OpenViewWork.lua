module("modules.common.others.openmultiview.OpenViewWork", package.seeall)

local var_0_0 = class("OpenViewWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._openFunction = arg_1_1.openFunction
	arg_1_0._openFunctionObj = arg_1_1.openFunctionObj
	arg_1_0._waitOpenViewName = arg_1_1.waitOpenViewName
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if not arg_2_0._openFunction then
		arg_2_0:onDone(true)

		return
	end

	if not arg_2_0._waitOpenViewName then
		arg_2_0._openFunction(arg_2_0._openFunctionObj)
		arg_2_0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_2_0._onOpenFinish, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, arg_2_0._onOpenFinish, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._overtime, arg_2_0, 5)
	arg_2_0._openFunction(arg_2_0._openFunctionObj)
end

function var_0_0._overtime(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._overtime, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenFinish, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, arg_3_0._onOpenFinish, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0._onOpenFinish(arg_4_0, arg_4_1)
	if arg_4_1 == arg_4_0._waitOpenViewName then
		TaskDispatcher.cancelTask(arg_4_0._overtime, arg_4_0)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenFinish, arg_4_0)
		ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, arg_4_0._onOpenFinish, arg_4_0)
		arg_4_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._overtime, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0._onOpenFinish, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, arg_5_0._onOpenFinish, arg_5_0)
end

return var_0_0
