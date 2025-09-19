module("modules.logic.survival.controller.work.SurvivalDecreeVoteShowWork", package.seeall)

local var_0_0 = class("SurvivalDecreeVoteShowWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:initParam(arg_1_1)
end

function var_0_0.initParam(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1.go
	arg_2_0.callback = arg_2_1.callback
	arg_2_0.callbackObj = arg_2_1.callbackObj
	arg_2_0.time = arg_2_1.time or 0
	arg_2_0.audioId = arg_2_1.audioId
end

function var_0_0.onStart(arg_3_0)
	gohelper.setActive(arg_3_0.go, true)

	if arg_3_0.callback then
		arg_3_0.callback(arg_3_0.callbackObj)
	end

	if arg_3_0.audioId then
		AudioMgr.instance:trigger(arg_3_0.audioId)
	end

	TaskDispatcher.runDelay(arg_3_0.onBuildFinish, arg_3_0, arg_3_0.time)
end

function var_0_0.onBuildFinish(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.onBuildFinish, arg_5_0)
end

return var_0_0
