module("modules.logic.fight.system.work.FightWorkAssistBossSkillChange", package.seeall)

local var_0_0 = class("FightWorkAssistBossSkillChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossPowerChange)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)
	FightController.instance:dispatchEvent(FightEvent.OnSwitchAssistBossSkill)
	arg_1_0:onDone(true)
end

return var_0_0
