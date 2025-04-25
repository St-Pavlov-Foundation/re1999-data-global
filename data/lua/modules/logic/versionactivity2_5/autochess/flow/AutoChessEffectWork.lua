module("modules.logic.versionactivity2_5.autochess.flow.AutoChessEffectWork", package.seeall)

slot0 = class("AutoChessEffectWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.effect = slot1
	slot0.mgr = AutoChessEntityMgr.instance
	slot0.chessMo = AutoChessModel.instance:getChessMo()

	if slot0.effect.effectType == AutoChessEnum.EffectType.NextFightStep then
		logError("异常:NextFightStep类型的数据不该出现在这里")
	end
end

function slot0.markSkillEffect(slot0, slot1)
	slot0.skillEffectId = slot1
end

function slot0.onStart(slot0, slot1)
	if slot0.skillEffectId and slot0.mgr:tryGetEntity(slot0.effect.targetId) then
		slot2.effectComp:playEffect(slot0.skillEffectId)
	end

	if AutoChessEffectHandleFunc.instance:getHandleFunc(slot0.effect.effectType) then
		slot2(slot0)
	else
		slot0:finishWork()
	end
end

function slot0.onStop(slot0)
	if slot0.damageWork then
		slot0.damageWork:onStopInternal()
	else
		TaskDispatcher.cancelTask(slot0.delayAttack, slot0)
		TaskDispatcher.cancelTask(slot0.delayFloatLeader, slot0)
		TaskDispatcher.cancelTask(slot0.finishWork, slot0)
	end
end

function slot0.onResume(slot0)
	if slot0.damageWork then
		slot0.damageWork:onResumeInternal()
	else
		slot0:finishWork()
	end
end

function slot0.clearWork(slot0)
	if slot0.damageWork then
		slot0.damageWork:unregisterDoneListener(slot0.finishWork, slot0)

		slot0.damageWork = nil
	end

	TaskDispatcher.cancelTask(slot0.delayAttack, slot0)
	TaskDispatcher.cancelTask(slot0.delayFloatLeader, slot0)
	TaskDispatcher.cancelTask(slot0.finishWork, slot0)

	slot0.effect = nil
	slot0.mgr = nil
	slot0.chessMo = nil
	slot0.skillEffectId = nil
end

function slot0.finishWork(slot0)
	if slot0.effect.effectType == AutoChessEnum.EffectType.ChessDie then
		AutoChessEntityMgr.instance:removeEntity(slot0.effect.targetId)
	end

	slot0:onDone(true)
end

function slot0.delayAttack(slot0)
	slot1 = 0
	slot3 = slot0.mgr:getLeaderEntity(slot0.effect.targetId)

	if slot0.mgr:getLeaderEntity(slot0.effect.fromId) and slot3 then
		slot1 = slot2:ranged(slot3.transform.position, 20002)
	end

	TaskDispatcher.runDelay(slot0.delayFloatLeader, slot0, slot1)
end

function slot0.delayFloatLeader(slot0)
	if slot0.mgr:getLeaderEntity(slot0.effect.targetId) then
		slot1:floatHp(slot0.effect.effectNum)
	end

	TaskDispatcher.runDelay(slot0.finishWork, slot0, 1)
end

return slot0
