module("modules.logic.fight.system.work.FightWorkAssistBossSkillChange", package.seeall)

slot0 = class("FightWorkAssistBossSkillChange", FightEffectBase)

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossPowerChange)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)
	FightController.instance:dispatchEvent(FightEvent.OnSwitchAssistBossSkill)
	slot0:onDone(true)
end

return slot0
