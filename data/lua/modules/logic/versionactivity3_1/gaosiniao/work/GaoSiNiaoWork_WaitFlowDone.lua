module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_WaitFlowDone", package.seeall)

local var_0_0 = class("GaoSiNiaoWork_WaitFlowDone", GaoSiNiaoWorkBase)

function var_0_0.s_create(arg_1_0, ...)
	local var_1_0 = var_0_0.New()

	if isDebugBuild then
		assert(isTypeOf(arg_1_0, GaoSiNiaoFlowSequence_Base), debug.traceback())
	end

	var_1_0._flowObj = arg_1_0
	var_1_0._startParams = {
		...
	}

	return var_1_0
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0._flowObj then
		logWarn("flowObj is invalid")
		arg_2_0:onSucc()

		return
	end

	arg_2_0._flowObj:reset()
	arg_2_0._flowObj:registerDoneListener(arg_2_0.onSucc, arg_2_0)
	arg_2_0._flowObj:start(unpack(arg_2_0._startParams))
end

function var_0_0.clearWork(arg_3_0)
	GameUtil.onDestroyViewMember(arg_3_0, "_flowObj")
	var_0_0.super.clearWork(arg_3_0)
end

return var_0_0
