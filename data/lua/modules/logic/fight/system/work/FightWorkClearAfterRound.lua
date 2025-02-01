module("modules.logic.fight.system.work.FightWorkClearAfterRound", package.seeall)

slot0 = class("FightWorkClearAfterRound", BaseWork)

function slot0.onStart(slot0, slot1)
	FightRoundSequence.roundTempData = {}

	FightPlayCardModel.instance:clearUsedCards()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
