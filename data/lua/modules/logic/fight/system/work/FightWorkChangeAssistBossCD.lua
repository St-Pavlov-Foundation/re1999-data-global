module("modules.logic.fight.system.work.FightWorkChangeAssistBossCD", package.seeall)

slot0 = class("FightWorkChangeAssistBossCD", FightEffectBase)

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
