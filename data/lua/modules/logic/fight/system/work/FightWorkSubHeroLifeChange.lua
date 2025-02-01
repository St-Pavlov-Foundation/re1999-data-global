module("modules.logic.fight.system.work.FightWorkSubHeroLifeChange", package.seeall)

slot0 = class("FightWorkSubHeroLifeChange", FightEffectBase)

function slot0.onStart(slot0)
	if FightEntityModel.instance:getById(slot0._actEffectMO.targetId) then
		slot2:setHp(slot2.currentHp + slot0._actEffectMO.effectNum)
		FightController.instance:dispatchEvent(FightEvent.ChangeSubEntityHp, slot2.id, slot0._actEffectMO.effectNum)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
