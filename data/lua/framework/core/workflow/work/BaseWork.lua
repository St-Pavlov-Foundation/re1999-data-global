module("framework.core.workflow.work.BaseWork", package.seeall)

local var_0_0 = class("BaseWork")
local var_0_1 = "done"

function var_0_0.initInternal(arg_1_0)
	arg_1_0.context = nil
	arg_1_0.root = nil
	arg_1_0.parent = nil
	arg_1_0.isSuccess = false
	arg_1_0.status = WorkStatus.Init
	arg_1_0.flowName = nil
end

function var_0_0.setRootInternal(arg_2_0, arg_2_1)
	arg_2_0.root = arg_2_1
end

function var_0_0.setParentInternal(arg_3_0, arg_3_1)
	arg_3_0.parent = arg_3_1
end

function var_0_0.onStartInternal(arg_4_0, arg_4_1)
	arg_4_0.context = arg_4_1
	arg_4_0.status = WorkStatus.Running

	return arg_4_0:onStart(arg_4_1)
end

function var_0_0.onStopInternal(arg_5_0)
	arg_5_0.status = WorkStatus.Stopped

	arg_5_0:onStop()
end

function var_0_0.onResumeInternal(arg_6_0)
	arg_6_0.status = WorkStatus.Running

	arg_6_0:onResume()
end

function var_0_0.onResetInternal(arg_7_0)
	arg_7_0.status = WorkStatus.Init

	arg_7_0:onReset()
end

function var_0_0.onDestroyInternal(arg_8_0)
	arg_8_0:onDestroy()

	arg_8_0.context = nil
	arg_8_0.parent = nil
end

function var_0_0.onDone(arg_9_0, arg_9_1)
	arg_9_0.isSuccess = arg_9_1
	arg_9_0.status = WorkStatus.Done

	if arg_9_0.beforeClearWork then
		arg_9_0:beforeClearWork()
	end

	arg_9_0:clearWork()

	if arg_9_0.parent then
		if arg_9_0._dispatcher then
			arg_9_0.parent:onWorkDone(arg_9_0)
		else
			return arg_9_0.parent:onWorkDone(arg_9_0)
		end
	end

	if arg_9_0._dispatcher then
		arg_9_0._dispatcher:dispatchEvent(var_0_1, arg_9_1)
	end
end

function var_0_0.registerDoneListener(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._dispatcher then
		arg_10_0._dispatcher = {}

		LuaEventSystem.addEventMechanism(arg_10_0._dispatcher)
	end

	arg_10_0._dispatcher:registerCallback(var_0_1, arg_10_1, arg_10_2)
end

function var_0_0.unregisterDoneListener(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._dispatcher then
		arg_11_0._dispatcher:unregisterCallback(var_0_1, arg_11_1, arg_11_2)
	end
end

function var_0_0.ctor(arg_12_0)
	return
end

function var_0_0.onStart(arg_13_0, arg_13_1)
	return
end

function var_0_0.onStop(arg_14_0)
	if arg_14_0.beforeClearWork then
		arg_14_0:beforeClearWork()
	end

	arg_14_0:clearWork()
end

function var_0_0.onResume(arg_15_0)
	return
end

function var_0_0.onReset(arg_16_0)
	if arg_16_0.beforeClearWork then
		arg_16_0:beforeClearWork()
	end

	arg_16_0:clearWork()
end

function var_0_0.onDestroy(arg_17_0)
	if arg_17_0.beforeClearWork then
		arg_17_0:beforeClearWork()
	end

	arg_17_0:clearWork()
end

function var_0_0.clearWork(arg_18_0)
	return
end

return var_0_0
