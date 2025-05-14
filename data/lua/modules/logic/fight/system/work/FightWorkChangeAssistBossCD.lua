module("modules.logic.fight.system.work.FightWorkChangeAssistBossCD", package.seeall)

local var_0_0 = class("FightWorkChangeAssistBossCD", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
