module("modules.logic.fight.system.work.FightWorkDouQuQuEnter", package.seeall)

slot0 = class("FightWorkDouQuQuEnter", FightWorkItem)

function slot0.onAwake(slot0, slot1, slot2)
	slot0._index = slot1
	slot0._needClearFight = slot2
end

function slot0.onStart(slot0)
	FightWorkDouQuQuStat.startTime = ServerTime.now()

	slot0:cancelFightWorkSafeTimer()

	if slot0._needClearFight then
		slot1 = slot0:com_registFlowSequence()

		slot1:registWork(Work2FightWork, FightWorkRestartBefore)
		slot1:registFinishCallback(slot0._onClearFinish, slot0)
		slot1:start({
			noReloadScene = true
		})
	else
		slot0:_onClearFinish()
	end
end

function slot0._onClearFinish(slot0)
	slot0:com_registMsg(FightMsgId.FightAct174Reply, slot0._onFightAct174Reply)
	Activity174Rpc.instance:sendViewFightAct174Request(slot0._index, 0)
end

function slot0._onFightAct174Reply(slot0, slot1)
	slot2 = slot1.fight

	FightMgr.instance:startFight(slot2)
	FightModel.instance:updateFight(slot2)
	FightModel.instance:refreshBattleId(slot2)
	FightModel.instance:updateFightRound(slot1.startRound)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.DouQuQu)
	slot0:com_sendFightEvent(FightEvent.RefreshUIRound)
	slot0:com_registEvent(GameSceneMgr.instance, SceneType.Fight, slot0._onFightSceneStart)
	slot0:com_registFightEvent(FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish)
	GameSceneMgr.instance:getCurScene().director:registRespBeginFight()
	FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
end

function slot0._onFightSceneStart(slot0)
	FightSystem.instance:startFight()
end

function slot0._onStartSequenceFinish(slot0)
	slot0:onDone(true)
end

return slot0
