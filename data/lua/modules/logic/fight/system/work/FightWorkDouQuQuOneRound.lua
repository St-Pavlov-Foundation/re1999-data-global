module("modules.logic.fight.system.work.FightWorkDouQuQuOneRound", package.seeall)

slot0 = class("FightWorkDouQuQuOneRound", FightWorkItem)

function slot0.onAwake(slot0, slot1)
	slot0.proto = slot1
end

function slot0.onStart(slot0)
	FightCardModel.instance:clearCardOps()
	FightDataHelper.paTaMgr:resetOp()
	slot0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish)
	FightModel.instance:updateFightRound(slot0.proto)
	FightSystem.instance:startRound()
	FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
	slot0:cancelFightWorkSafeTimer()
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:onDone(true)
end

return slot0
