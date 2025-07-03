module("modules.logic.fight.system.work.asfd.FightWorkCreateASFDEmitter", package.seeall)

local var_0_0 = class("FightWorkCreateASFDEmitter", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0.delayDone, arg_2_0, 1)

	local var_2_0 = FightHelper.getASFDMgr()

	if not var_2_0 then
		return arg_2_0:onDone(true)
	end

	if var_2_0:createEmitterWrap(arg_2_0.fightStepData) then
		TaskDispatcher.runDelay(arg_2_0.waitDone, arg_2_0, FightASFDConfig.instance.emitterWaitTime)
	else
		return arg_2_0:onDone(true)
	end
end

function var_0_0.waitDone(arg_3_0)
	return arg_3_0:onDone(true)
end

function var_0_0.delayDone(arg_4_0)
	logError("创建奥术飞弹发射源，超时了")

	return arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.delayDone, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.waitDone, arg_5_0)
end

return var_0_0
