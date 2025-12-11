module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_DelaySecond", package.seeall)

local var_0_0 = class("GaoSiNiaoWork_DelaySecond", GaoSiNiaoWorkBase)

function var_0_0.s_create(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0._durationSec = arg_1_0

	return var_1_0
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:clearWork()

	if not arg_2_0._durationSec then
		logWarn("durationSec is null")
		arg_2_0:onSucc()

		return
	end

	if arg_2_0._durationSec <= 0 then
		arg_2_0:onSucc()
	else
		TaskDispatcher.cancelTask(arg_2_0._delaySucc, arg_2_0)
		TaskDispatcher.runDelay(arg_2_0._delaySucc, arg_2_0, arg_2_0._durationSec)
	end
end

function var_0_0._delaySucc(arg_3_0)
	arg_3_0:onSucc()
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delaySucc, arg_4_0)
	V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim.super.clearWork(arg_4_0)
end

return var_0_0
