module("modules.logic.scene.fight.comp.FightSceneFightStatusComp", package.seeall)

slot0 = class("FightSceneFightStatusComp", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceStart, slot0._onRoundSequenceStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:registerCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, slot0._pushEndFight, slot0)
	FightController.instance:registerCallback(FightEvent.ForceUpdatePerformanceData, slot0._onForceUpdatePerformanceData, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onLevelLoaded(slot0)
	slot0._fightScene = GameSceneMgr.instance:getCurScene()
	slot0._sceneObj = slot0._fightScene.level:getSceneGo()
end

function slot0._onFightDialogEnd(slot0)
	slot0:_clearTab()
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.StoryView then
		slot0:_clearTab()
	end
end

function slot0._checkFunc(slot0)
	if FightViewDialog.playingDialog then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.StoryView) then
		return
	end

	slot1 = true
	slot0._hpDic = slot0._hpDic or {}
	slot0._expointDic = slot0._expointDic or {}
	slot0._buffCount = slot0._buffCount or {}

	for slot6, slot7 in ipairs(FightHelper.getAllEntitys()) do
		slot8 = slot7.id

		if slot7:getMO() then
			if slot0._hpDic[slot8] ~= slot9.currentHp then
				slot1 = false
				slot0._hpDic[slot8] = slot10
			end

			if slot0._expointDic[slot8] ~= slot9:getExPoint() then
				slot1 = false
				slot0._expointDic[slot8] = slot11
			end

			if slot0._buffCount[slot8] ~= (slot9:getBuffList() and #slot12 or 0) then
				slot1 = false
				slot0._buffCount[slot8] = slot13
			end
		end
	end

	if slot1 then
		logError("场上角色数据一分钟没有变化了,可能卡住了")
		FightMsgMgr.sendMsg(FightMsgId.MaybeCrashed)
		slot0:_releaseTimer()
	end
end

function slot0._onRoundSequenceStart(slot0)
	TaskDispatcher.runRepeat(slot0._checkFunc, slot0, 60)
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:_releaseTimer()
end

function slot0._onRestartStageBefore(slot0)
	slot0:_releaseTimer()
end

function slot0._releaseTimer(slot0)
	TaskDispatcher.cancelTask(slot0._checkFunc, slot0)
	slot0:_clearTab()
end

function slot0._pushEndFight(slot0)
	slot0:_releaseTimer()
end

function slot0._clearTab(slot0)
	slot0._hpDic = nil
	slot0._expointDic = nil
	slot0._buffCount = nil
end

function slot0._onForceUpdatePerformanceData(slot0, slot1)
	if FightHelper.getEntity(slot1) and slot2.buff then
		slot2.buff:releaseAllBuff()
		slot2.buff:dealStartBuff()
	end
end

function slot0.onSceneClose(slot0, slot1, slot2)
	slot0:_releaseTimer()
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceStart, slot0._onRoundSequenceStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, slot0._pushEndFight, slot0)
	FightController.instance:unregisterCallback(FightEvent.ForceUpdatePerformanceData, slot0._onForceUpdatePerformanceData, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

return slot0
