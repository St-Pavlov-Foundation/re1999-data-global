module("modules.logic.fight.entity.comp.skill.FightTLEventCatapult", package.seeall)

slot0 = class("FightTLEventCatapult")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._paramsArr = slot3
	slot0._fightStepMO = slot1
	slot0._duration = slot2
	slot0.index = FightTLHelper.getNumberParam(slot3[1])
	slot0.effectName = slot3[2]
	slot0.hangPoint = slot3[3]
	slot4 = FightTLHelper.getTableParam(slot3[4], ",", true)
	slot5 = FightTLHelper.getTableParam(slot3[5], ",", true)
	slot0.bezierParam = slot3[6]
	slot0.catapultAudio = FightTLHelper.getNumberParam(slot3[7])
	slot0.hitEffectName = slot3[8]
	slot0.hitStartTime = FightTLHelper.getNumberParam(slot3[9]) or 0.01
	slot0.hitEffectHangPoint = slot3[10]
	slot0.hitAudio = FightTLHelper.getNumberParam(slot3[11])
	slot0.buffIdList = FightTLHelper.getTableParam(slot3[12], "#", true)
	slot0.buffStartTime = FightTLHelper.getNumberParam(slot3[13]) or 0.01
	slot0.alwaysForceLookForward = FightTLHelper.getBoolParam(slot3[14])
	slot0.catapultReleaseTime = FightTLHelper.getNumberParam(slot3[15])
	slot0.hitReleaseTime = FightTLHelper.getNumberParam(slot3[16])

	if string.nilorempty(slot0.effectName) then
		logError("effect name is nil")

		return
	end

	slot0.skillUser = FightHelper.getEntity(slot1.fromId)
	slot0.side = slot0.skillUser:getSide()
	slot0.skillUserId = slot0.skillUser.id
	slot7 = slot0:getEndEntity()

	if not slot0:getStartEntity() then
		return
	end

	if not slot7 then
		return
	end

	slot0.startEntity = slot6
	slot0.endEntity = slot7
	slot0.catapultBuffCount = slot0:getCatapultBuffCount(slot0.index + 1)
	slot10, slot11, slot12 = transformhelper.getPos(slot6:getHangPoint(slot0.hangPoint).transform)
	slot13, slot14, slot15 = transformhelper.getPos(slot7:getHangPoint(slot0.hangPoint).transform)
	slot0.effectWrap = slot0.skillUser.effect:addGlobalEffect(slot0.effectName, nil, slot0.catapultReleaseTime)

	FightRenderOrderMgr.instance:onAddEffectWrap(slot0.skillUserId, slot0.effectWrap)
	slot0:startBezierMove(slot10 + slot4[1], slot11 + slot4[2], slot12, slot13 + slot5[1], slot14 + slot5[2], slot15)
	slot0:changeLookDir()
	slot0:playHitEffect()
	slot0:playAddBuff()
	slot0:playAddFirstBuff()
end

function slot0.playAddFirstBuff(slot0)
	if slot0.index ~= 1 then
		return
	end

	if slot0:getCatapultBuffCount(slot0.index) < 1 then
		return
	end

	for slot8, slot9 in ipairs(slot0._fightStepMO.actEffectMOs) do
		if not slot9:isDone() and slot0.startEntity.id == slot9.targetId and slot9.effectType == FightEnum.EffectType.BUFFADD and slot0:inCheckNeedPlayBuff(slot9.effectNum) then
			FightSkillBuffMgr.instance:playSkillBuff(slot0._fightStepMO, slot9)
			FightDataHelper.playEffectData(slot9)

			if slot1 <= 0 + 1 then
				return
			end
		end
	end
end

function slot0.getCatapultBuffCount(slot0, slot1)
	for slot6, slot7 in ipairs(slot0._fightStepMO.actEffectMOs) do
		if slot7.effectType == FightEnum.EffectType.CATAPULTBUFF and slot7.effectNum == slot1 then
			return tonumber(slot7.reserveId)
		end
	end

	return 0
end

function slot0.getStartEntity(slot0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return slot0:getPosEntity(slot0.index)
	else
		return slot0:get217EffectEntity(slot0.index)
	end
end

function slot0.getEndEntity(slot0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return slot0:getPosEntity(slot0.index + 1)
	else
		return slot0:get217EffectEntity(slot0.index + 1)
	end
end

function slot0.get217EffectEntity(slot0, slot1)
	for slot6, slot7 in ipairs(slot0._fightStepMO.actEffectMOs) do
		if slot7.effectType == FightEnum.EffectType.CATAPULTBUFF and slot7.effectNum == slot1 then
			return GameSceneMgr.instance:getCurScene().entityMgr:getEntity(slot7.targetId)
		end
	end
end

function slot0.getPosEntity(slot0, slot1)
	return GameSceneMgr.instance:getCurScene().entityMgr:getEntityByPosId(SceneTag.UnitMonster, slot1) or slot2.entityMgr:getEntityByPosId(SceneTag.UnitMonster, 1)
end

function slot0.startBezierMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.effectWrap:setWorldPos(slot1, slot2, slot3)

	slot0.mover = MonoHelper.addLuaComOnceToGo(slot0.effectWrap.containerGO, UnitMoverBezier)

	MonoHelper.addLuaComOnceToGo(slot0.effectWrap.containerGO, UnitMoverHandler)
	slot0.mover:setBezierParam(slot0.bezierParam)
	slot0.mover:simpleMove(slot1, slot2, slot3, slot4, slot5, slot6, slot0._duration)
	FightAudioMgr.instance:playAudio(slot0.catapultAudio)
end

function slot0.changeLookDir(slot0)
	if not slot0.alwaysForceLookForward then
		return
	end

	slot0.tempForwards = Vector3.New()

	slot0.mover:registerCallback(UnitMoveEvent.PosChanged, slot0._onPosChange, slot0)
end

function slot0.playHitEffect(slot0)
	if string.nilorempty(slot0.hitEffectName) then
		return
	end

	TaskDispatcher.cancelTask(slot0._playHitEffect, slot0)
	TaskDispatcher.runDelay(slot0._playHitEffect, slot0, slot0.hitStartTime)
end

function slot0._playHitEffect(slot0)
	slot1 = slot0.endEntity.effect:addHangEffect(slot0.hitEffectName, slot0.hitEffectHangPoint, nil, slot0.hitReleaseTime)

	slot1:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(slot0.endEntity.id, slot1)
	FightAudioMgr.instance:playAudio(slot0.hitAudio)
end

function slot0.playAddBuff(slot0)
	if not slot0.buffIdList then
		return
	end

	TaskDispatcher.cancelTask(slot0._playAddBuff, slot0)
	TaskDispatcher.runDelay(slot0._playAddBuff, slot0, slot0.buffStartTime)
end

function slot0._playAddBuff(slot0)
	for slot7, slot8 in ipairs(slot0._fightStepMO.actEffectMOs) do
		if not slot8:isDone() and slot0.endEntity.id == slot8.targetId and slot8.effectType == FightEnum.EffectType.BUFFADD and slot0:inCheckNeedPlayBuff(slot8.effectNum) then
			FightSkillBuffMgr.instance:playSkillBuff(slot0._fightStepMO, slot8)
			FightDataHelper.playEffectData(slot8)

			if slot0.catapultBuffCount <= 0 + 1 then
				return
			end
		end
	end
end

function slot0.inCheckNeedPlayBuff(slot0, slot1)
	return slot0.buffIdList and slot1 and tabletool.indexOf(slot0.buffIdList, slot1)
end

function slot0._onPosChange(slot0, slot1)
	slot2, slot3, slot4 = slot1:getPos()
	slot5, slot6, slot7 = slot1:getPrePos()

	slot0.tempForwards:Set(slot2 - slot5, slot3 - slot6, slot4 - slot7)

	if slot0.tempForwards:Magnitude() < 1e-06 then
		return
	end

	slot11 = Quaternion.LookRotation(slot0.tempForwards, Vector3.up) * FightHelper.getEffectLookDirQuaternion(slot0.side) * FightEnum.RotationQuaternion.Ninety

	transformhelper.setRotation(slot0.effectWrap.containerTr, slot11.x, slot11.y, slot11.z, slot11.w)
end

function slot0.removeEffectMover(slot0)
	if not slot0.effectWrap then
		return
	end

	MonoHelper.removeLuaComFromGo(slot1.containerGO, UnitMoverBezier)
	MonoHelper.removeLuaComFromGo(slot1.containerGO, UnitMoverHandler)

	slot0.effectWrap = nil
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.onSkillEnd(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0:removeEffectMover()
	TaskDispatcher.cancelTask(slot0._playHitEffect, slot0)
	TaskDispatcher.cancelTask(slot0._playAddBuff, slot0)

	slot0.mover = nil
	slot0.skillUser = nil
	slot0.skillUser = nil
	slot0.side = nil
	slot0.skillUserId = nil
	slot0.startEntity = nil
	slot0.endEntity = nil
end

function slot0.dispose(slot0)
	slot0:clear()
end

return slot0
