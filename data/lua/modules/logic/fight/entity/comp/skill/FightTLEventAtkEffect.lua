module("modules.logic.fight.entity.comp.skill.FightTLEventAtkEffect", package.seeall)

slot0 = class("FightTLEventAtkEffect")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if not FightHelper.detectTimelinePlayEffectCondition(slot1, slot3[10]) then
		return
	end

	slot0._attacker = FightHelper.getEntity(slot1.fromId)

	if slot0._attacker.skill and slot0._attacker.skill:atkEffectNeedFilter(slot3[1]) then
		return
	end

	slot0.fightStepMO = slot1
	slot0.duration = slot2
	slot0.paramsArr = slot3
	slot0.release_time = not string.nilorempty(slot3[9]) and slot3[9] ~= "0" and tonumber(slot3[9])

	if slot3[6] == "1" then
		slot0._targetEntity = slot0._attacker
	elseif not string.nilorempty(slot4) then
		if GameSceneMgr.instance:getCurScene().entityMgr:getUnit(SceneTag.UnitNpc, slot1.stepUid .. "_" .. slot4) then
			slot0._targetEntity = slot7
		else
			slot0.load_entity_id = slot6

			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)

			return
		end
	else
		slot0._targetEntity = slot0._attacker
	end

	slot0:_bootLogic(slot1, slot2, slot3)

	if not string.nilorempty(slot3[11]) then
		AudioMgr.instance:trigger(tonumber(slot3[11]))
	end
end

function slot0._bootLogic(slot0, slot1, slot2, slot3)
	slot0._effectName = slot3[1]

	if not string.nilorempty(slot3[12]) and slot0._attacker:getMO() and slot4.skin then
		for slot10, slot11 in ipairs(string.split(slot3[12], "|")) do
			if tonumber(string.split(slot11, "#")[1]) == slot5 then
				slot0._effectName = slot12[2]

				break
			end
		end
	end

	slot0._hangPoint = slot3[2]
	slot0._offsetZ = 0
	slot0._offsetY = 0
	slot0._offsetX = 0

	if slot3[3] then
		slot0._offsetX = string.split(slot3[3], ",")[1] and tonumber(slot4[1]) or slot0._offsetX
		slot0._offsetY = slot4[2] and tonumber(slot4[2]) or slot0._offsetY
		slot0._offsetZ = slot4[3] and tonumber(slot4[3]) or slot0._offsetZ
	end

	slot4 = tonumber(slot3[4]) or -1
	slot0._notHangCenter = slot3[5]
	slot5 = slot3[6]
	slot6 = slot3[7] == "1"
	slot7 = slot3[8] == "1"

	if slot0._targetEntity and not slot0._targetEntity:isMySide() then
		slot0._offsetX = -slot0._offsetX
	end

	if string.nilorempty(slot0._effectName) then
		logError("atk effect name is nil,攻击特效配了空，")
	else
		slot0._effectWrap = slot0:_createEffect(slot0._effectName, slot0._hangPoint)

		if slot0._effectWrap then
			slot0:_setRenderOrder(slot0._effectWrap, slot4)

			if string.nilorempty(slot0._hangPoint) and slot6 then
				TaskDispatcher.runRepeat(slot0._onFrameUpdateEffectPos, slot0, 0.01)
			end

			if slot7 then
				TaskDispatcher.runRepeat(slot0._onFrameUpdateEffectRotation, slot0, 0.01)
			end
		end
	end
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_removeEffect()
end

function slot0._createEffect(slot0)
	slot1 = nil

	if not string.nilorempty(slot0._hangPoint) then
		slot0._targetEntity.effect:addHangEffect(slot0._effectName, slot0._hangPoint, nil, slot0.release_time, {
			x = slot0._offsetX,
			y = slot0._offsetY,
			z = slot0._offsetZ
		}):setLocalPos(slot0._offsetX, slot0._offsetY, slot0._offsetZ)
	else
		slot2, slot3, slot4 = slot0:_getTargetPosXYZ()

		slot0._targetEntity.effect:addGlobalEffect(slot0._effectName, nil, slot0.release_time):setWorldPos(slot2 + slot0._offsetX, slot3 + slot0._offsetY, slot4 + slot0._offsetZ)
	end

	if slot0.paramsArr[1] == "v2a2_tsnn/tsnn_unique_08_s5" or slot0.paramsArr[1] == "v2a2_tsnn/tsnn_unique_09_s6" then
		TaskDispatcher.runRepeat(function ()
			uv0:setLocalPos(0, 0, 0)
		end, slot0, 0.01, 5)
	end

	return slot1
end

function slot0._getTargetPosXYZ(slot0)
	slot1, slot2, slot3 = nil

	if slot0._notHangCenter == "0" then
		slot1, slot2, slot3 = FightHelper.getEntityWorldBottomPos(slot0._targetEntity)
	elseif slot0._notHangCenter == "1" then
		slot1, slot2, slot3 = FightHelper.getEntityWorldCenterPos(slot0._targetEntity)
	elseif slot0._notHangCenter == "2" then
		slot1, slot2, slot3 = FightHelper.getEntityWorldTopPos(slot0._targetEntity)
	elseif slot0._notHangCenter == "3" then
		slot1, slot2, slot3 = transformhelper.getPos(slot0._targetEntity.go.transform)
	elseif slot0._notHangCenter == "4" then
		slot1, slot2, slot3 = FightHelper.getEntityStandPos(FightDataHelper.entityMgr:getById(slot0._targetEntity.id))
	elseif not string.nilorempty(slot0._notHangCenter) and slot0._targetEntity:getHangPoint(slot0._notHangCenter) then
		slot5 = slot4.transform.position
		slot3 = slot5.z
		slot2 = slot5.y
		slot1 = slot5.x
	else
		slot1, slot2, slot3 = transformhelper.getPos(slot0._targetEntity.go.transform)
	end

	return slot1, slot2, slot3
end

function slot0._setRenderOrder(slot0, slot1, slot2)
	if slot2 == -1 then
		FightRenderOrderMgr.instance:onAddEffectWrap(slot0._attacker.id, slot1)
	else
		FightRenderOrderMgr.instance:setEffectOrder(slot1, slot2)
	end
end

function slot0._onFrameUpdateEffectPos(slot0)
	if not slot0._targetEntity then
		return
	end

	if gohelper.isNil(slot0._targetEntity.go) then
		return
	end

	if slot0._effectWrap then
		slot1, slot2, slot3 = slot0:_getTargetPosXYZ()

		slot0._effectWrap:setWorldPos(slot1 + slot0._offsetX, slot2 + slot0._offsetY, slot3 + slot0._offsetZ)
	end
end

function slot0._onFrameUpdateEffectRotation(slot0)
	if not slot0._targetEntity then
		return
	end

	if gohelper.isNil(slot0._targetEntity.go) then
		return
	end

	if slot0._effectWrap and not gohelper.isNil(slot0._effectWrap.containerTr) then
		transformhelper.setRotation(slot0._effectWrap.containerTr, 0, 0, 0, 1)
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot1 and slot1.unitSpawn and slot1.unitSpawn.id == slot0.load_entity_id then
		slot0._targetEntity = slot1.unitSpawn

		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
		slot0:_bootLogic(slot0.fightStepMO, slot0.duration, slot0.paramsArr)
	end
end

function slot0.reset(slot0)
	slot0:_removeEffect()
	TaskDispatcher.cancelTask(slot0._onFrameUpdateEffectPos, slot0)
	TaskDispatcher.cancelTask(slot0._onFrameUpdateEffectRotation, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
end

function slot0.dispose(slot0)
	slot0:_removeEffect()
	TaskDispatcher.cancelTask(slot0._onFrameUpdateEffectPos, slot0)
	TaskDispatcher.cancelTask(slot0._onFrameUpdateEffectRotation, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
end

function slot0._removeEffect(slot0)
	if slot0._effectWrap and not slot0.release_time then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._targetEntity.id, slot0._effectWrap)
		slot0._targetEntity.effect:removeEffect(slot0._effectWrap)

		slot0._effectWrap = nil
	end

	slot0._targetEntity = nil
end

return slot0
