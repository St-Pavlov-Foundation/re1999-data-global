module("modules.logic.fight.view.work.FightAutoDetectForceEndWork", package.seeall)

slot0 = class("FightAutoDetectForceEndWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 1)

	if not FightCardModel.instance:isCardOpEnd() then
		FightController.instance:dispatchEvent(FightEvent.ForceEndAutoCardFlow)
	end

	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
