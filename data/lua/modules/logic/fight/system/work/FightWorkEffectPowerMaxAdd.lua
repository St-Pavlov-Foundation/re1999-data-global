module("modules.logic.fight.system.work.FightWorkEffectPowerMaxAdd", package.seeall)

slot0 = class("FightWorkEffectPowerMaxAdd", FightEffectBase)

function slot0.onStart(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	if not slot2:getMO() then
		slot0:onDone(true)

		return
	end

	if slot3:getPowerInfo(slot0._actEffectMO.configEffect) then
		FightController.instance:dispatchEvent(FightEvent.PowerMaxChange, slot1, slot4, slot0._actEffectMO.effectNum)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
