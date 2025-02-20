module("modules.logic.fight.system.work.FightWorkDouQuQuRound", package.seeall)

slot0 = class("FightWorkDouQuQuRound", FightWorkItem)

function slot0.onStart(slot0)
	slot0.douQuQuMgr = FightDataModel.instance.douQuQuMgr

	if slot0.douQuQuMgr.isFinish then
		slot0:onDone(true)

		return
	end

	slot0:cancelFightWorkSafeTimer()
	slot0:com_registMsg(FightMsgId.FightAct174Reply, slot0._onFightAct174Reply)
	Activity174Rpc.instance:sendViewFightAct174Request(slot0.douQuQuMgr.index, slot0.douQuQuMgr.round + 1)
end

function slot0._onFightAct174Reply(slot0, slot1)
	FightCardModel.instance:clearCardOps()
	FightDataHelper.paTaMgr:resetOp()
	slot0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish)
	FightModel.instance:updateFightRound(slot1.fightRound)
	FightSystem.instance:startRound()
	FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
end

function slot0._onRoundSequenceFinish(slot0)
	if slot0.douQuQuMgr.isFinish then
		slot0:onDone(true)

		return
	end

	Activity174Rpc.instance:sendViewFightAct174Request(slot0.douQuQuMgr.index, slot0.douQuQuMgr.round + 1)
end

return slot0
