module("modules.logic.fight.system.work.FightWorkSubHeroLifeChange", package.seeall)

local var_0_0 = class("FightWorkSubHeroLifeChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.targetId

	FightController.instance:dispatchEvent(FightEvent.ChangeSubEntityHp, arg_1_0._entityId, arg_1_0.actEffectData.effectNum)
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
