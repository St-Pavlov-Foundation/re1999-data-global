module("modules.logic.fight.system.work.FightWorkBFSGSkillStart", package.seeall)

local var_0_0 = class("FightWorkBFSGSkillStart", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	var_0_0.BeiFangShaoGeUniqueSkill = 1
	FightModel.forceParallelSkill = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, false)
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
