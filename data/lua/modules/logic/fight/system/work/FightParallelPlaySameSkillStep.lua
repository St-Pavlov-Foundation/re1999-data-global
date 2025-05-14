module("modules.logic.fight.system.work.FightParallelPlaySameSkillStep", package.seeall)

local var_0_0 = class("FightParallelPlaySameSkillStep", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.stepMO = arg_1_1
	arg_1_0.prevStepMO = arg_1_2

	FightController.instance:registerCallback(FightEvent.ParallelPlaySameSkillCheck, arg_1_0._parallelPlaySameSkillCheck, arg_1_0)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._parallelPlaySameSkillCheck(arg_3_0, arg_3_1)
	if arg_3_1 ~= arg_3_0.prevStepMO then
		return
	end

	if arg_3_0.stepMO.fromId == arg_3_0.prevStepMO.fromId and arg_3_0.stepMO.actId == arg_3_0.prevStepMO.actId and arg_3_0.stepMO.toId == arg_3_0.prevStepMO.toId then
		FightController.instance:dispatchEvent(FightEvent.ParallelPlaySameSkillDoneThis, arg_3_1)
	end
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlaySameSkillCheck, arg_4_0._parallelPlaySameSkillCheck, arg_4_0)
end

return var_0_0
