module("modules.logic.fight.system.work.FightWorkDouQuQuGMForceIndexEnter", package.seeall)

slot0 = class("FightWorkDouQuQuGMForceIndexEnter", FightWorkItem)

function slot0.onAwake(slot0, slot1, slot2)
	slot0._index = slot1
	slot0._needClearFight = slot2
end

function slot0.onStart(slot0)
	slot0:cancelFightWorkSafeTimer()

	if slot0._needClearFight then
		slot1 = slot0:com_registFlowSequence()

		slot1:registWork(Work2FightWork, FightWorkRestartBefore)
		slot1:registFinishCallback(slot0._onClearFinish, slot0)
		slot1:start()
	else
		slot0:_onClearFinish()
	end
end

function slot0._onClearFinish(slot0)
	slot0._msgItem = slot0:com_registMsg(FightMsgId.FightAct174Reply, slot0._onFightAct174Reply)

	Activity174Rpc.instance:sendViewFightAct174Request(slot0._index, 0)
end

function slot0._onFightAct174Reply(slot0, slot1)
	slot2 = slot1.fight

	FightMgr.instance:startFight(slot2)
	FightModel.instance:updateFight(slot2)
	FightModel.instance:refreshBattleId(slot2)
	FightModel.instance:updateFightRound(slot1.startRound)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.DouQuQu)
	slot0:com_registEvent(GameSceneMgr.instance, SceneType.Fight, slot0._onFightSceneStart)
	slot0:com_registFightEvent(FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish)

	if FightDataModel.instance.douQuQuMgr.isGMStartRound <= 1 then
		GameSceneMgr.instance:getCurScene().director:registRespBeginFight()
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	else
		slot0:com_removeMsg(slot0._msgItem)

		slot8 = slot0._onFightAct174ReplyRound

		slot0:com_registMsg(FightMsgId.FightAct174Reply, slot8)

		slot0._endRound = slot4.isGMStartRound - 1

		for slot8 = 1, slot0._endRound do
			Activity174Rpc.instance:sendViewFightAct174Request(slot4.index, slot8)
		end
	end
end

function slot0._onFightAct174ReplyRound(slot0, slot1)
	slot0._endRound = slot0._endRound - 1

	FightCardModel.instance:clearCardOps()
	FightDataHelper.paTaMgr:resetOp()
	FightModel.instance:updateFightRound(slot1.fightRound)

	if slot0._endRound == 0 then
		FightDataHelper.coverData(FightLocalDataMgr.instance, FightDataMgr.instance, {
			dataMgr = true,
			cacheFightMgr = true,
			class = true
		})
		FightCardModel.instance:coverCard(FightDataHelper.handCardMgr.handCard)

		FightModel.instance._curRoundId = FightDataModel.instance.douQuQuMgr.isGMStartRound

		slot0:com_sendFightEvent(FightEvent.ChangeRound)

		FightModel.instance:getCurRoundMO().fightStepMOs = nil

		GameSceneMgr.instance:getCurScene().director:registRespBeginFight()
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	end
end

function slot0._onFightSceneStart(slot0)
	FightSystem.instance:startFight()
end

function slot0._onStartSequenceFinish(slot0)
	slot0:com_registTimer(slot0._delayDone, 1)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

return slot0
