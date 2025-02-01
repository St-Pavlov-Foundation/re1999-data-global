module("modules.logic.fight.system.work.FightWorkRoundStart", package.seeall)

slot0 = class("FightWorkRoundStart", BaseWork)

function slot0.onStart(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.FightRoundStart)
	FightCardModel.instance:onStartRound()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
