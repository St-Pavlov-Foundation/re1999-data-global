module("modules.logic.fight.system.work.FightWorkPlayFakeStepTimeline", package.seeall)

local var_0_0 = class("FightWorkPlayFakeStepTimeline", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.timelineName = arg_1_1
	arg_1_0.fightStepData = arg_1_2
	arg_1_0.SAFETIME = 30
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, LuaEventSystem.Low)

	local var_2_0 = FightHelper.getEntity(arg_2_0.fightStepData.fromId)

	if not var_2_0 then
		arg_2_0:onDone(true)

		return
	end

	var_2_0.skill:playTimeline(arg_2_0.timelineName, arg_2_0.fightStepData)
end

function var_0_0._onSkillPlayFinish(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 == arg_3_0.fightStepData then
		arg_3_0:onDone(true)
	end
end

return var_0_0
