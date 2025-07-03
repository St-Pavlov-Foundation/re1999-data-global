module("modules.logic.fight.system.work.trigger.FightWorkTriggerDelay", package.seeall)

local var_0_0 = class("FightWorkTriggerDelay", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.actEffectData = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._config = lua_trigger_action.configDict[arg_2_0.actEffectData.effectNum]

	if arg_2_0._config then
		arg_2_0._startTime = ServerTime.now()
		arg_2_0._delayTime = arg_2_0._config.param1 / 1000

		FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, arg_2_0._onUpdateSpeed, arg_2_0)
		TaskDispatcher.runDelay(arg_2_0._delay, arg_2_0, arg_2_0._delayTime / FightModel.instance:getSpeed())
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._onUpdateSpeed(arg_3_0)
	local var_3_0 = ServerTime.now() - arg_3_0._startTime

	TaskDispatcher.runDelay(arg_3_0._delay, arg_3_0, (arg_3_0._delayTime - var_3_0) / FightModel.instance:getSpeed())
end

function var_0_0._delay(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, arg_5_0._onUpdateSpeed, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delay, arg_5_0)
end

return var_0_0
