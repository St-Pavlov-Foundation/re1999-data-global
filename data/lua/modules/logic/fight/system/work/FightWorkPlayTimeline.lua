module("modules.logic.fight.system.work.FightWorkPlayTimeline", package.seeall)

local var_0_0 = class("FightWorkPlayTimeline", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._entity = arg_1_1
	arg_1_0._entityId = arg_1_1.id
	arg_1_0._timeline = arg_1_2
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if arg_2_0._entity.IS_REMOVED then
		arg_2_0:onDone(true)
	else
		arg_2_0:_playTimeline()
	end
end

function var_0_0._playTimeline(arg_3_0)
	if string.nilorempty(arg_3_0._timeline) then
		arg_3_0:onDone(true)

		return
	end

	if arg_3_0._entity.skill then
		local var_3_0 = {
			actId = 0,
			actEffect = {
				{
					targetId = arg_3_0._entityId
				}
			},
			fromId = arg_3_0._entityId,
			toId = arg_3_0._entityId,
			actType = FightEnum.ActType.SKILL,
			stepUid = FightTLEventEntityVisible.latestStepUid or 0
		}

		FightController.instance:registerCallback(FightEvent.BeforeDestroyEntity, arg_3_0._onBeforeDestroyEntity, arg_3_0)
		FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0, LuaEventSystem.Low)
		TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, 30)
		arg_3_0._entity.skill:playTimeline(arg_3_0._timeline, var_3_0)
	else
		arg_3_0:onDone(true)
	end
end

function var_0_0._onBeforeDestroyEntity(arg_4_0, arg_4_1)
	if arg_4_1 == arg_4_0._entity then
		arg_4_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_5_0)
	arg_5_0:onDone(true)
end

function var_0_0._onSkillPlayFinish(arg_6_0, arg_6_1)
	if arg_6_1.id == arg_6_0._entityId then
		arg_6_0:_delayDone()
	end
end

function var_0_0.clearWork(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._delayDone, arg_7_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_7_0._onSkillPlayFinish, arg_7_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDestroyEntity, arg_7_0._onBeforeDestroyEntity, arg_7_0)
end

return var_0_0
