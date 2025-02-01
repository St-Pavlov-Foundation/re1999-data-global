module("modules.logic.fight.system.work.FightWorkSpecialDelay", package.seeall)

slot0 = class("FightWorkSpecialDelay", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.5)

	if FightHelper.getEntity(slot0._fightStepMO.fromId) and slot1:getMO() and _G["FightWorkSpecialDelayModelId" .. slot2.modelId] then
		TaskDispatcher.cancelTask(slot0._delayDone, slot0)

		slot0._delayClass = slot3.New(slot0, slot0._fightStepMO)

		return
	end

	slot0:_delayDone()
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)

	if slot0._delayClass then
		slot0._delayClass:releaseSelf()

		slot0._delayClass = nil
	end
end

return slot0
