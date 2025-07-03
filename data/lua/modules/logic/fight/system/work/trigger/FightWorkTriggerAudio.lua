module("modules.logic.fight.system.work.trigger.FightWorkTriggerAudio", package.seeall)

local var_0_0 = class("FightWorkTriggerAudio", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.actEffectData = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._config = lua_trigger_action.configDict[arg_2_0.actEffectData.effectNum]

	AudioMgr.instance:trigger(tonumber(arg_2_0._config.param1))
	arg_2_0:_delayDone()
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	return
end

return var_0_0
