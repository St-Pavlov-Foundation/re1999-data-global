module("modules.logic.fight.system.work.trigger.FightWorkTriggerTimeline", package.seeall)

local var_0_0 = class("FightWorkTriggerTimeline", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.actEffectData = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._config = lua_trigger_action.configDict[arg_2_0.actEffectData.effectNum]

	local var_2_0 = tonumber(arg_2_0._config.param1)
	local var_2_1 = FightHelper.getEnemyEntityByMonsterId(var_2_0)

	if var_2_0 == 0 then
		var_2_1 = FightHelper.getEntity(FightEntityScene.MySideId)
	end

	if var_2_1 and var_2_1.skill then
		arg_2_0._entityId = var_2_1.id

		local var_2_2 = {
			actId = 0,
			stepUid = 0,
			actEffect = {
				{
					targetId = arg_2_0._entityId
				}
			},
			fromId = arg_2_0._entityId,
			toId = arg_2_0.fightStepData.toId,
			actType = FightEnum.ActType.SKILL
		}

		FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
		TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 20)
		var_2_1.skill:playTimeline(arg_2_0._config.param2, var_2_2)

		return
	end

	arg_2_0:_delayDone()
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0._onSkillPlayFinish(arg_4_0, arg_4_1)
	if arg_4_1.id == arg_4_0._entityId then
		arg_4_0:_delayDone()
	end
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_5_0._onSkillPlayFinish, arg_5_0)
end

return var_0_0
