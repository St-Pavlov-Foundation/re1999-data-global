module("framework.core.workflow.flow.BaseFlow", package.seeall)

local var_0_0 = class("BaseFlow", BaseWork)

function var_0_0.start(arg_1_0, arg_1_1)
	arg_1_0:onStartInternal(arg_1_1)
end

function var_0_0.stop(arg_2_0)
	arg_2_0:onStopInternal()
end

function var_0_0.resume(arg_3_0)
	arg_3_0:onResumeInternal()
end

function var_0_0.destroy(arg_4_0)
	arg_4_0:onDestroyInternal()
end

function var_0_0.reset(arg_5_0)
	arg_5_0:onResetInternal()
end

function var_0_0.addWork(arg_6_0, arg_6_1)
	arg_6_1:initInternal()

	arg_6_1.flowName = arg_6_0.flowName

	arg_6_1:setParentInternal(arg_6_0)
end

function var_0_0.onWorkDone(arg_7_0, arg_7_1)
	arg_7_1:onResetInternal()
end

return var_0_0
