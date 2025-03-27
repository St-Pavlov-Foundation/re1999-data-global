module("modules.logic.fight.entity.comp.skill.FightTLEventAtkFlyEffect", package.seeall)

slot0 = class("FightTLEventAtkFlyEffect")
slot1 = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true
}

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._attacker = FightHelper.getEntity(slot1.fromId)

	if slot0._attacker.skill:flyEffectNeedFilter(slot3[1]) then
		return
	end

	slot0._paramsArr = slot3
	slot0._effectName = slot3[1]
	slot0._fightStepMO = slot1
	slot0._duration = slot2

	if string.nilorempty(slot0._effectName) then
		logError("atk effect name is nil")

		return
	end

	slot4 = string.nilorempty(slot3[2]) and 2 or tonumber(slot3[2])
	slot6 = 0
	slot7 = 0

	if slot3[4] then
		if string.split(slot3[4], ",")[1] then
			slot5 = tonumber(slot8[1]) or 0
		end

		if slot8[2] then
			slot6 = tonumber(slot8[2]) or slot6
		end

		if slot8[3] then
			slot7 = tonumber(slot8[3]) or slot7
		end
	end

	slot9 = 0
	slot10 = 0

	if slot3[5] then
		if string.split(slot3[5], ",")[1] then
			slot8 = tonumber(slot11[1]) or 0
		end

		if slot11[2] then
			slot9 = tonumber(slot11[2]) or slot9
		end

		if slot11[3] then
			slot10 = tonumber(slot11[3]) or slot10
		end
	end

	slot0._easeFunc = slot3[6]
	slot0._parabolaHeight = tonumber(slot3[7])
	slot0._bezierParam = slot3[8]
	slot0._curveParam = slot3[9]
	slot0._previousFrame = slot3[10] and tonumber(slot3[10]) or 0
	slot0._afterFrame = slot3[11] and tonumber(slot3[11]) or 0
	slot0._withRotation = slot3[12] and tonumber(slot3[12]) or 1
	slot0._tCurveParam = slot3[13]
	slot0._alwayForceLookForward = slot3[14] and tonumber(slot3[14])
	slot0._act_on_index_entity = slot3[15] and tonumber(slot3[15])
	slot0._onlyActOnToId = slot3[19] == "1"
	slot0._actSide = nil

	if not string.nilorempty(slot3[20]) then
		if slot3[20] == "1" then
			slot0._actSide = FightEnum.EntitySide.EnemySide
		elseif slot11 == "2" then
			slot0._actSide = FightEnum.EntitySide.MySide
		end
	end

	if slot0._act_on_index_entity then
		slot0._actEffectMOs_list = FightHelper.dealDirectActEffectData(slot0._fightStepMO.actEffectMOs, slot0._act_on_index_entity, uv0)
	else
		slot0._actEffectMOs_list = slot0._fightStepMO.actEffectMOs
	end

	if string.nilorempty(slot3[16]) then
		slot0._act_entity_finished = nil
	else
		slot0._act_entity_finished = {}
	end

	slot0._attacker = FightHelper.getEntity(slot1.fromId)

	if not slot0._attacker:isMySide() then
		slot5 = -slot5
	end

	slot11, slot12, slot13 = transformhelper.getPos(slot0._attacker.go.transform)

	if slot3[17] == "1" then
		slot11, slot12, slot13 = transformhelper.getPos(FightHelper.getEntity(slot1.toId).go.transform)
	elseif slot3[17] == "2" then
		slot11, slot12, slot13 = FightHelper.getProcessEntityStancePos(slot0._attacker:getMO())
	elseif slot3[17] == "3" then
		slot11, slot12, slot13 = FightHelper.getEntityWorldCenterPos(FightHelper.getEntity(slot1.toId))
	end

	slot14 = slot11 + slot5
	slot15 = slot12 + slot6
	slot16 = slot13 + slot7

	if slot3[3] == "1" then
		if not slot0._attacker:isMySide() then
			slot14 = -(string.split(slot3[4], ",")[1] and tonumber(slot17[1]) or 0)
		end

		slot15 = slot17[2] and tonumber(slot17[2]) or 0
		slot16 = slot17[3] and tonumber(slot17[3]) or 0
	end

	if slot4 == 1 then
		slot0:_flyEffectSingle(slot14, slot15, slot16, slot8, slot9, slot10)
	elseif slot4 == 2 then
		slot0:_flyEffectTarget(slot14, slot15, slot16, slot8, slot9, slot10, FightHelper.getEntityWorldCenterPos)
	elseif slot4 == 3 then
		slot0:_flyEffectTarget(slot14, slot15, slot16, slot8, slot9, slot10, false)
	elseif slot4 == 4 then
		slot0:_flyEffectSingle(slot14, slot15, slot16, slot8, slot9, slot10, true)
	elseif slot4 == 5 then
		slot17, slot18, slot19 = FightHelper.getProcessEntitySpinePos(slot0._attacker)

		if not slot0._attacker:isMySide() then
			slot8 = -(slot8 + slot17)
		end

		slot0:_flyEffectSingle(slot14, slot15, slot16, slot8, slot9 + slot18, slot10 + slot19)
	elseif slot4 == 6 then
		slot0:_flyEffectAbsolutely(slot14, slot15, slot16, slot8, slot9, slot10)
	else
		slot0:_flyEffectTarget(slot14, slot15, slot16, slot8, slot9, slot10, FightHelper.getEntityHangPointPos, slot3[2])
	end

	slot0._totalFrame = slot0._binder:GetFrameFloatByTime(slot0._duration * FightModel.instance:getSpeed()) - slot0._previousFrame - slot0._afterFrame
	slot0._startFrame = slot0._binder.CurFrameFloat + 1

	slot0:_startFly()
end

function slot0.handleSkillEventEnd(slot0)
	if slot0._paramsArr and slot0._paramsArr[18] ~= "1" then
		slot0:_removeEffect()
		slot0:_removeMover()
	end
end

function slot0._flyEffectAbsolutely(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot0._attacker:isEnemySide() then
		slot4 = -slot4
	end

	slot0:_addFlyEffect(slot1, slot2, slot3, slot4, slot5, slot6)
end

function slot0._flyEffectSingle(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	for slot11, slot12 in ipairs(slot0._actEffectMOs_list) do
		if not uv0[slot12.effectType] and slot12.effectType ~= FightEnum.EffectType.EXPOINTCHANGE and slot12.effectType ~= FightEnum.EffectType.FIGHTSTEP and slot0._act_entity_finished and not slot0._act_entity_finished[slot12.targetId] then
			slot13 = true
		end

		slot14 = FightHelper.getEntity(slot12.targetId)

		if slot7 and FightHelper.getEntity(slot0._fightStepMO.fromId) and slot14 and slot15:getSide() == slot14:getSide() then
			slot13 = false
		end

		if slot0._onlyActOnToId and slot12.targetId ~= slot0._fightStepMO.toId then
			slot13 = false
		end

		if slot0._actSide and slot14 and slot0._actSide ~= slot14:getSide() then
			slot13 = false
		end

		if slot13 and slot14 then
			if slot14:isMySide() then
				slot4 = -slot4 or slot4
			end

			slot0:_addFlyEffect(slot1, slot2, slot3, slot4, slot5, slot6)

			if slot0._act_entity_finished then
				slot0._act_entity_finished[slot14.id] = true
			end

			break
		end
	end
end

function slot0._flyEffectTarget(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	for slot13, slot14 in ipairs(slot0._actEffectMOs_list) do
		if not uv0[slot14.effectType] and slot0._act_entity_finished and not slot0._act_entity_finished[slot14.targetId] then
			slot15 = true
		end

		if slot0._onlyActOnToId and slot14.targetId ~= slot0._fightStepMO.toId then
			slot15 = false
		end

		slot16 = FightHelper.getEntity(slot14.targetId)

		if slot0._actSide and slot16 and slot0._actSide ~= slot16:getSide() then
			slot15 = false
		end

		if slot15 then
			if slot16 then
				slot18, slot19, slot20 = slot7 or FightHelper.getEntityWorldBottomPos(slot16, slot8)

				slot0:_addFlyEffect(slot1, slot2, slot3, slot18 + (slot16:isMySide() and -slot4 or slot4), slot19 + slot5, slot20 + slot6)

				if slot0._act_entity_finished then
					slot0._act_entity_finished[slot16.id] = true
				end
			else
				logNormal("fly effect to defender fail, entity not exist: " .. slot14.targetId)
			end
		end
	end
end

function slot0._addFlyEffect(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._attacker.effect:addGlobalEffect(slot0._effectName):setWorldPos(slot1, slot2, slot3)

	slot0._flyParamDict = slot0._flyParamDict or {}
	slot0._flyParamDict[slot7.uniqueId] = {
		startX = slot1,
		startY = slot2,
		startZ = slot3,
		endX = slot4,
		endY = slot5,
		endZ = slot6
	}
	slot0._attackEffectWrapList = slot0._attackEffectWrapList or {}

	table.insert(slot0._attackEffectWrapList, slot7)
	FightRenderOrderMgr.instance:onAddEffectWrap(slot0._attacker.id, slot7)
end

function slot0._startFly(slot0)
	if not slot0._attackEffectWrapList then
		return
	end

	for slot4, slot5 in ipairs(slot0._attackEffectWrapList) do
		if slot0._flyParamDict[slot5.uniqueId] then
			slot5:setWorldPos(slot6.startX, slot6.startY, slot6.startZ)

			if slot0._parabolaHeight then
				slot0:_setParabolaMove(slot5, slot7, slot8, slot9, slot6.endX, slot6.endY, slot6.endZ)
			elseif not string.nilorempty(slot0._bezierParam) then
				slot0:_setBezierMove(slot5, slot7, slot8, slot9, slot10, slot11, slot12)
			elseif not string.nilorempty(slot0._curveParam) then
				slot0:_setCurveMove(slot5, slot7, slot8, slot9, slot10, slot11, slot12)
			else
				slot0:_setEaseMove(slot5, slot7, slot8, slot9, slot10, slot11, slot12)
			end
		end
	end
end

function slot0._setEaseMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot0._withRotation == 1 then
		slot0:_calcRotation(slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	end

	slot8 = MonoHelper.addLuaComOnceToGo(slot1.containerGO, UnitMoverEase)

	MonoHelper.addLuaComOnceToGo(slot1.containerGO, UnitMoverHandler)
	slot8:setEaseType(EaseType.Str2Type(slot0._easeFunc))
	slot8:simpleMove(slot2, slot3, slot4, slot5, slot6, slot7, slot0._duration)

	if slot0._previousFrame > 0 or slot0._afterFrame > 0 then
		slot8:setGetTimeFunction(slot0.getTimeFunction, slot0)
	end

	slot0._mover = slot8
end

function slot0._setParabolaMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	MonoHelper.addLuaComOnceToGo(slot1.containerGO, UnitMoverHandler)
	MonoHelper.addLuaComOnceToGo(slot1.containerGO, UnitMoverParabola):simpleMove(slot2, slot3, slot4, slot5, slot6, slot7, slot0._duration, slot0._parabolaHeight)

	if slot0._withRotation == 1 then
		slot8:registerCallback(UnitMoveEvent.PosChanged, slot0._onPosChange, slot0)

		slot0._moverParamDict = slot0._moverParamDict or {}
		slot0._moverParamDict[slot8] = {
			mover = slot8,
			effectWrap = slot1,
			startX = slot2,
			startY = slot3,
			startZ = slot4
		}
	end

	if slot0._previousFrame > 0 or slot0._afterFrame > 0 then
		slot8:setGetFrameFunction(slot0.getFrameFunction, slot0)
	end

	slot0._mover = slot8
end

function slot0._setBezierMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot0._withRotation == 1 then
		slot0:_calcRotation(slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	end

	MonoHelper.addLuaComOnceToGo(slot1.containerGO, UnitMoverHandler)
	MonoHelper.addLuaComOnceToGo(slot1.containerGO, UnitMoverBezier):setBezierParam(slot0._bezierParam)

	if not string.nilorempty(slot0._easeFunc) then
		slot8:setEaseType(EaseType.Str2Type(slot0._easeFunc))
	else
		slot8:setEaseType(nil)
	end

	slot8:simpleMove(slot2, slot3, slot4, slot5, slot6, slot7, slot0._duration)

	if slot0._withRotation == 1 then
		-- Nothing
	end

	if slot0._alwayForceLookForward then
		slot8:registerCallback(UnitMoveEvent.PosChanged, slot0._onAlwayForceLookForward, slot0)

		slot0._moverParamDict = slot0._moverParamDict or {}
		slot0._moverParamDict[slot8] = {
			mover = slot8,
			effectWrap = slot1,
			startX = slot2,
			startY = slot3,
			startZ = slot4
		}
	end

	if slot0._previousFrame > 0 or slot0._afterFrame > 0 then
		slot8:setGetTimeFunction(slot0.getTimeFunction, slot0)
	end

	slot0._mover = slot8
end

function slot0._setCurveMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot0._withRotation == 1 then
		slot0:_calcRotation(slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	end

	slot8 = MonoHelper.addLuaComOnceToGo(slot1.containerGO, UnitMoverCurve)

	MonoHelper.addLuaComOnceToGo(slot1.containerGO, UnitMoverHandler)
	slot8:setCurveParam(slot0._curveParam)
	slot8:setTCurveParam(slot0._tCurveParam)

	if not string.nilorempty(slot0._easeFunc) then
		slot8:setEaseType(EaseType.Str2Type(slot0._easeFunc))
	else
		slot8:setEaseType(nil)
	end

	slot8:simpleMove(slot2, slot3, slot4, slot5, slot6, slot7, slot0._duration)

	if slot0._withRotation == 1 then
		-- Nothing
	end

	if slot0._alwayForceLookForward then
		slot8:registerCallback(UnitMoveEvent.PosChanged, slot0._onAlwayForceLookForward, slot0)

		slot0._moverParamDict = slot0._moverParamDict or {}
		slot0._moverParamDict[slot8] = {
			mover = slot8,
			effectWrap = slot1,
			startX = slot2,
			startY = slot3,
			startZ = slot4
		}
	end

	if slot0._previousFrame > 0 or slot0._afterFrame > 0 then
		slot8:setGetTimeFunction(slot0.getTimeFunction, slot0)
	end

	slot0._mover = slot8
end

function slot0._onPosChange(slot0, slot1, slot2)
	if slot0._moverParamDict and slot0._moverParamDict[slot1] then
		slot4, slot5, slot6 = slot1:getPos()

		slot0:_calcRotation(slot3.effectWrap, slot3.startX, slot3.startY, slot3.startZ, slot4, slot5, slot6, slot2)

		slot3.startX = slot4
		slot3.startY = slot5
		slot3.startZ = slot6
	end
end

function slot0._onAlwayForceLookForward(slot0, slot1)
	slot0:_onPosChange(slot1, slot0._alwayForceLookForward)
end

function slot0._calcRotation(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot1.containerTr.rotation = Quaternion.LookRotation(Vector3.New(slot5 - slot2, slot6 - slot3, slot7 - slot4), Vector3.up) * Quaternion.AngleAxis(FightHelper.getEffectLookDir(slot0._attacker:getSide()), Vector3.up) * Quaternion.AngleAxis(slot8 or 90, Vector3.up)
end

function slot0.getTimeFunction(slot0)
	if not slot0._attacker then
		return 1000
	end

	if slot0._attacker.skill:getCurFrameFloat() + 1 - slot0._startFrame <= slot0._previousFrame then
		return 0
	end

	if slot0._totalFrame <= 0 then
		return slot0._duration
	end

	return (slot1 - slot0._previousFrame) / slot0._totalFrame * slot0._duration
end

function slot0.getFrameFunction(slot0)
	if not slot0._attacker then
		return 1000, 1, 1
	end

	return slot0._attacker.skill:getCurFrameFloat() + 1 - slot0._startFrame, slot0._previousFrame, slot0._totalFrame
end

function slot0.reset(slot0)
	if slot0._moverParamDict then
		for slot4, slot5 in pairs(slot0._moverParamDict) do
			slot4:unregisterCallback(UnitMoveEvent.PosChanged, slot0._onPosChange, slot0)
		end
	end

	slot0._moverParamDict = nil

	slot0:_removeEffect()
	slot0:_removeMover()
end

function slot0.dispose(slot0)
	slot0:_removeEffect()
	slot0:_removeMover()
end

function slot0._removeMover(slot0)
	if slot0._mover then
		if slot0._mover.setGetTimeFunction then
			slot0._mover:setGetTimeFunction(nil, )
		end

		if slot0._mover.setGetFrameFunction then
			slot0._mover:setGetFrameFunction(nil, )
		end

		slot0._mover = nil
	end
end

function slot0._removeEffect(slot0)
	if slot0._attackEffectWrapList then
		for slot4, slot5 in ipairs(slot0._attackEffectWrapList) do
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._attacker.id, slot5)
			slot0._attacker.effect:removeEffect(slot5)
			MonoHelper.removeLuaComFromGo(slot5.containerGO, UnitMoverEase)
			MonoHelper.removeLuaComFromGo(slot5.containerGO, UnitMoverParabola)
			MonoHelper.removeLuaComFromGo(slot5.containerGO, UnitMoverBezier)
			MonoHelper.removeLuaComFromGo(slot5.containerGO, UnitMoverCurve)
			MonoHelper.removeLuaComFromGo(slot5.containerGO, UnitMoverHandler)
		end

		slot0._attackEffectWrapList = nil
	end

	slot0._flyParamDict = nil
	slot0._attacker = nil
end

return slot0
