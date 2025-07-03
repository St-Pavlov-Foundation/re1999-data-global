module("modules.logic.fight.system.work.trigger.FightWorkTriggerSceneEffect", package.seeall)

local var_0_0 = class("FightWorkTriggerSceneEffect", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.actEffectData = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._config = lua_trigger_action.configDict[arg_2_0.actEffectData.effectNum]

	local var_2_0 = GameSceneMgr.instance:getCurScene()

	if var_2_0 and var_2_0.level:getSceneGo() then
		local var_2_1 = FightHelper.getEntity(FightEntityScene.MySideId)

		if var_2_1 then
			if arg_2_0._config.param2 == 0 then
				var_2_1.effect:removeEffectByEffectName(arg_2_0._config.param1)
			else
				var_2_1.effect:addGlobalEffect(arg_2_0._config.param1)
			end
		end
	end

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
