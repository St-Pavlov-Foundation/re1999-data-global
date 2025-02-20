module("modules.logic.fight.system.work.FightWorkDouQuQuGMEnter", package.seeall)

slot0 = class("FightWorkDouQuQuGMEnter", FightWorkItem)

function slot0.onAwake(slot0, slot1, slot2)
	slot0.fight = slot1
	slot0.startRound = slot2
end

function slot0.onStart(slot0)
	slot0:cancelFightWorkSafeTimer()
	slot0:_onClearFinish()
end

function slot0._onClearFinish(slot0)
	FightMgr.instance:startFight(slot0.fight, slot0.startRound)
	FightModel.instance:updateFight(slot0.fight)
	FightModel.instance:refreshBattleId(slot0.fight)
	FightModel.instance:updateFightRound(slot0.startRound)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.DouQuQu)
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
