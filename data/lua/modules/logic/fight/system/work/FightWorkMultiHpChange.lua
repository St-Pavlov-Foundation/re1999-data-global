module("modules.logic.fight.system.work.FightWorkMultiHpChange", package.seeall)

slot0 = class("FightWorkMultiHpChange", FightEffectBase)

function slot0.onStart(slot0)
	if not slot2 or not (FightHelper.getEntity(slot0._actEffectMO.targetId) and slot2:getMO()) then
		slot0:onDone(true)

		return
	end

	if slot0._actEffectMO.entityMO then
		slot0:cancelFightWorkSafeTimer()

		slot5 = slot0:com_registFlowSequence()

		FightHelper.buildMonsterA2B(slot2, slot5, FightWorkFunction.New(slot0._afterMonsterA2B, slot0, slot4))
		slot5:registFinishCallback(slot0.finishWork, slot0)
		slot5:start()

		return
	end

	slot0:onDone(true)
end

function slot0._afterMonsterA2B(slot0, slot1)
	FightHelper.setEffectEntitySide(slot0._actEffectMO)
	FightEntityModel.instance:replaceEntityMO(slot1)
	slot0:com_sendFightEvent(FightEvent.MultiHpChange, slot1.id)
end

function slot0.clearWork(slot0)
end

return slot0
