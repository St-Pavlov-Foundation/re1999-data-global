module("modules.logic.fight.system.work.FightWorkSubHeroLifeChange", package.seeall)

slot0 = class("FightWorkSubHeroLifeChange", FightEffectBase)

function slot0.onStart(slot0)
	slot0._entityId = slot0._actEffectMO.targetId

	FightController.instance:dispatchEvent(FightEvent.ChangeSubEntityHp, slot0._entityId, slot0._actEffectMO.effectNum)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
