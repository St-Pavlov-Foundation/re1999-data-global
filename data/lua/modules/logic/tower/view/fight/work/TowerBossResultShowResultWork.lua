module("modules.logic.tower.view.fight.work.TowerBossResultShowResultWork", package.seeall)

local var_0_0 = class("TowerBossResultShowResultWork", BaseWork)
local var_0_1 = 1

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.goResult = arg_1_1
	arg_1_0.audioId = arg_1_2
	arg_1_0.callback = arg_1_3
	arg_1_0.callbackObj = arg_1_4
end

function var_0_0.onStart(arg_2_0)
	gohelper.setActive(arg_2_0.goResult, true)

	if arg_2_0.audioId then
		AudioMgr.instance:trigger(arg_2_0.audioId)
	end

	if arg_2_0.callback then
		arg_2_0.callback(arg_2_0.callbackObj)
	end

	TaskDispatcher.runDelay(arg_2_0._delayFinish, arg_2_0, var_0_1)
end

function var_0_0._delayFinish(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayFinish, arg_4_0)
end

return var_0_0
