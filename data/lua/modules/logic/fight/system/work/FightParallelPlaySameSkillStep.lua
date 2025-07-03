module("modules.logic.fight.system.work.FightParallelPlaySameSkillStep", package.seeall)

local var_0_0 = class("FightParallelPlaySameSkillStep", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.preStepData = arg_1_2

	FightController.instance:registerCallback(FightEvent.ParallelPlaySameSkillCheck, arg_1_0._parallelPlaySameSkillCheck, arg_1_0)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._parallelPlaySameSkillCheck(arg_3_0, arg_3_1)
	if arg_3_1 ~= arg_3_0.preStepData then
		return
	end

	if arg_3_0.fightStepData.fromId == arg_3_0.preStepData.fromId and arg_3_0.fightStepData.actId == arg_3_0.preStepData.actId and arg_3_0.fightStepData.toId == arg_3_0.preStepData.toId then
		FightController.instance:dispatchEvent(FightEvent.ParallelPlaySameSkillDoneThis, arg_3_1)
	end
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlaySameSkillCheck, arg_4_0._parallelPlaySameSkillCheck, arg_4_0)
end

return var_0_0
