module("modules.logic.fight.system.work.trigger.FightWorkTriggerSceneAnimator", package.seeall)

local var_0_0 = class("FightWorkTriggerSceneAnimator", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.actEffectData = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._config = lua_trigger_action.configDict[arg_2_0.actEffectData.effectNum]

	local var_2_0 = GameSceneMgr.instance:getCurScene()

	if var_2_0 and var_2_0.level:getSceneGo() then
		FightController.instance:dispatchEvent(FightEvent.TriggerSceneAnimator, arg_2_0._config)
	end

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
