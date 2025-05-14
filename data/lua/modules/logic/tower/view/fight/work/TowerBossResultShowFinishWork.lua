module("modules.logic.tower.view.fight.work.TowerBossResultShowFinishWork", package.seeall)

local var_0_0 = class("TowerBossResultShowFinishWork", BaseWork)
local var_0_1 = 2

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.goFinish = arg_1_1
	arg_1_0.audioId = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	gohelper.setActive(arg_2_0.goFinish, true)

	if arg_2_0.audioId then
		AudioMgr.instance:trigger(arg_2_0.audioId)
	end

	TaskDispatcher.runDelay(arg_2_0._delayFinish, arg_2_0, var_0_1)
end

function var_0_0._delayFinish(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	gohelper.setActive(arg_4_0.goFinish, false)
	TaskDispatcher.cancelTask(arg_4_0._delayFinish, arg_4_0)
end

return var_0_0
