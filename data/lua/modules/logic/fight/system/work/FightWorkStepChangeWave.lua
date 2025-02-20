module("modules.logic.fight.system.work.FightWorkStepChangeWave", package.seeall)

slot0 = class("FightWorkStepChangeWave", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0._flow = FlowSequence.New()

	slot0._flow:addWork(FightWorkWaveEndDialog.New())
	slot0._flow:addWork(FightWorkStepShowNoteWhenChangeWave.New())
	slot0._flow:addWork(WorkWaitSeconds.New(0.01))
	slot0._flow:addWork(FightWorkChangeWaveView.New())
	slot0._flow:addWork(FightWorkChangeWaveStartDialog.New())
	slot0._flow:registerDoneListener(slot0._startChangeWave, slot0)
	slot0._flow:start()
end

function slot0._startChangeWave(slot0)
	FightController.instance:dispatchEvent(FightEvent.ChangeWaveStart)
	FightPlayCardModel.instance:onEndRound()

	slot0.context.oldEntityIdDict = {}

	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		slot6:resetEntity()

		slot0.context.oldEntityIdDict[slot6.id] = true
	end

	if FightModel.instance:getAndRemoveNextWaveMsg() then
		slot0:_changeWave(slot2)
	else
		logNormal("还没收到FightWavePush，继续等待")
		FightController.instance:registerCallback(FightEvent.PushFightWave, slot0._onPushFightWave, slot0)
	end
end

function slot0._onPushFightWave(slot0)
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, slot0._onPushFightWave, slot0)

	if FightModel.instance:getAndRemoveNextWaveMsg() then
		logNormal("终于等待换波次的信息了")
		slot0:_changeWave(slot1)
		slot0:onDone(true)
	else
		logError("没有换波次的信息")
		slot0:onDone(true)
	end
end

function slot0._changeWave(slot0, slot1)
	FightDataHelper.calMgr:playChangeWave()

	slot0._nextWaveMsg = slot1
	slot2 = FightModel.instance:getFightParam()
	slot3 = FightModel.instance:getCurWaveId()

	if slot2:getSceneLevel(slot3 + 1) and slot6 ~= slot2:getSceneLevel(slot3) then
		slot0._nextLevelId = slot6

		TaskDispatcher.runDelay(slot0._delayDone, slot0, 5)
		TaskDispatcher.runDelay(slot0._startLoadLevel, slot0, 0.25 / FightModel.instance:getSpeed())
	else
		slot0:_changeEntity()
		FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
		slot0:onDone(true)
	end
end

function slot0._changeEntity(slot0)
	logNormal("结束中准备下一波怪")
	GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:changeWave(slot0._nextWaveMsg.fight)

	FightModel.instance.power = FightModel.instance.power

	slot0:_applyExpoint(slot0:_cacheExpoint())
end

function slot0._startLoadLevel(slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	GameSceneMgr.instance:getScene(SceneType.Fight).level:loadLevelWithSwitchEffect(slot0._nextLevelId)
end

function slot0._delayDone(slot0)
	slot0:_changeEntity()
	FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
	slot0:onDone(true)
end

function slot0._onLevelLoaded(slot0)
	slot0:_changeEntity()

	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		slot6:resetStandPos()
	end

	FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._startChangeWave, slot0)
		slot0._flow:stop()

		slot0._flow = nil
	end

	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.cancelTask(slot0._startLoadLevel, slot0)
	TaskDispatcher.cancelTask(slot0._delayCheckNextWaveDialog, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, slot0._onPushFightWave, slot0)
end

function slot0._cacheExpoint(slot0)
	for slot6, slot7 in ipairs(FightHelper.getAllEntitys()) do
		-- Nothing
	end

	return {
		[slot7.id] = slot7:getMO().exPoint
	}
end

function slot0._applyExpoint(slot0, slot1)
	for slot6, slot7 in ipairs(FightHelper.getAllEntitys()) do
		if slot1[slot7.id] then
			slot7:getMO():setExPoint(slot8)
		end
	end
end

return slot0
