module("modules.logic.fight.system.work.FightNonTimelineSkillStep", package.seeall)

local var_0_0 = class("FightNonTimelineSkillStep", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.OnInvokeSkill, arg_2_0.fightStepData)
	arg_2_0:onDone(true)
end

return var_0_0
