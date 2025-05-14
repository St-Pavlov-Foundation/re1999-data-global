module("modules.logic.fight.system.work.FightWorkBFSGSkillEnd", package.seeall)

local var_0_0 = class("FightWorkBFSGSkillEnd", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill = false
	FightModel.forceParallelSkill = false

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, false, true)
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
