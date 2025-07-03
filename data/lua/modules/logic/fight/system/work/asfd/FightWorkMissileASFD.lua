module("modules.logic.fight.system.work.asfd.FightWorkMissileASFD", package.seeall)

local var_0_0 = class("FightWorkMissileASFD", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0.fightStepData = arg_1_1
	arg_1_0.asfdContext = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0.delayDone, arg_2_0, 1)

	local var_2_0 = FightHelper.getASFDMgr()

	if not var_2_0 then
		return arg_2_0:onDone(true)
	end

	var_2_0:emitMissile(arg_2_0.fightStepData, arg_2_0.asfdContext)

	local var_2_1 = FightASFDConfig.instance:getMissileInterval(arg_2_0.asfdContext.emitterAttackNum) / FightModel.instance:getUISpeed()

	TaskDispatcher.runDelay(arg_2_0.waitDone, arg_2_0, var_2_1)
end

function var_0_0.delayDone(arg_3_0)
	logError("发射奥术飞弹 超时了")

	return arg_3_0:onDone(true)
end

function var_0_0.waitDone(arg_4_0)
	return arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.delayDone, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.waitDone, arg_5_0)
end

return var_0_0
