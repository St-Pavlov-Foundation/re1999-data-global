module("modules.logic.versionactivity2_5.autochess.flow.AutoChessDamageWork", package.seeall)

slot0 = class("AutoChessDamageWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.effect = slot1
	slot0.entityMgr = AutoChessEntityMgr.instance
	slot0.attackEntity = slot0.entityMgr:tryGetEntity(slot0.effect.fromId) or slot0.entityMgr:getLeaderEntity(slot0.effect.fromId)
end

function slot0.onStart(slot0, slot1)
	if tonumber(slot0.effect.effectNum) == AutoChessEnum.DamageType.Ranged then
		slot4 = lua_auto_chess_effect.configDict[AutoChessStrEnum.Tag2EffectId.Ranged]
		slot5 = slot0.entityMgr:getEntity(slot0.effect.targetIds[1])

		if slot0.attackEntity and slot5 then
			slot0.attackEntity:ranged(slot5.transform.position, slot4)
		end

		TaskDispatcher.runDelay(slot0.playBeingAttack, slot0, slot4.duration)
		TaskDispatcher.runDelay(slot0.finishWork, slot0, slot4.duration + 0.5)
	elseif slot2 == AutoChessEnum.DamageType.Skill then
		slot0:playBeingAttack()
		TaskDispatcher.runDelay(slot0.finishWork, slot0, 1)
	else
		if slot0.attackEntity then
			slot0.attackEntity:attack()
		end

		TaskDispatcher.runDelay(slot0.playBeingAttack, slot0, AutoChessEnum.ChessAniTime.Melee - 0.3)
		TaskDispatcher.runDelay(slot0.finishWork, slot0, AutoChessEnum.ChessAniTime.Melee)
	end
end

function slot0.playBeingAttack(slot0)
	if tonumber(slot0.effect.effectNum) == AutoChessEnum.DamageType.MeleeAoe then
		for slot5, slot6 in ipairs(slot0.effect.targetIds) do
			if slot0.entityMgr:getEntity(slot6) then
				slot7.effectComp:playEffect(slot5 == 1 and 20001 or 20003)
			end
		end
	else
		for slot5, slot6 in ipairs(slot0.effect.targetIds) do
			if slot0.entityMgr:getEntity(slot6) then
				slot7.effectComp:playEffect(20001)
			end
		end
	end
end

function slot0.onStop(slot0)
	TaskDispatcher.cancelTask(slot0.finishWork, slot0)
end

function slot0.onResume(slot0)
	slot0:finishWork()
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0.playBeingAttack, slot0)
	TaskDispatcher.cancelTask(slot0.finishWork, slot0)

	slot0.effect = nil
end

function slot0.finishWork(slot0)
	slot0:onDone(true)
end

return slot0
