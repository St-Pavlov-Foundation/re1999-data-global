module("modules.logic.fight.system.work.FightWorkKill", package.seeall)

slot0 = class("FightWorkKill", FightEffectBase)

function slot0.onStart(slot0)
	slot0:_startKill()
end

function slot0._startKill(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	slot3 = slot2:getMO()

	slot3:setHp(0)
	FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, slot0._actEffectMO.targetId, slot3.currentHp, 0)
	slot0:_onDone()
end

function slot0._onDone(slot0)
	slot0:clearWork()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
