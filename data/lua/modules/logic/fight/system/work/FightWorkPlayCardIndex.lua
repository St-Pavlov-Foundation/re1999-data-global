module("modules.logic.fight.system.work.FightWorkPlayCardIndex", package.seeall)

slot0 = class("FightWorkPlayCardIndex", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
end

function slot0.onStart(slot0, slot1)
	if FightHelper.isPlayerCardSkill(slot0._fightStepMO) then
		FightController.instance:dispatchEvent(FightEvent.InvalidUsedCard, slot0._fightStepMO.cardIndex, -1)
		FightPlayCardModel.instance:playCard(slot0._fightStepMO.cardIndex)
		TaskDispatcher.runDelay(slot0._delayAfterDissolveCard, slot0, 1 / FightModel.instance:getUISpeed())
	else
		slot0:onDone(true)
	end
end

function slot0._delayAfterDissolveCard(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayAfterDissolveCard, slot0)
end

return slot0
