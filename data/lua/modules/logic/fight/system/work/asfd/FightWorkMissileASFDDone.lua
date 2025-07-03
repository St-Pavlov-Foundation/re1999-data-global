module("modules.logic.fight.system.work.asfd.FightWorkMissileASFDDone", package.seeall)

local var_0_0 = class("FightWorkMissileASFDDone", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 1)

	local var_2_0 = FightHelper.getASFDMgr()

	if var_2_0 then
		var_2_0:clearEmitterEffect(arg_2_0.fightStepData)
	end

	return arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
end

function var_0_0._delayDone(arg_4_0)
	logError("奥术飞弹 等待发射完成 超时了")

	return arg_4_0:onDone(true)
end

return var_0_0
