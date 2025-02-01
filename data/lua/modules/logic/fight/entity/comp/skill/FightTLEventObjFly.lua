module("modules.logic.fight.entity.comp.skill.FightTLEventObjFly", package.seeall)

slot0 = class("FightTLEventObjFly")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0.fly_obj = nil
	slot0.entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	slot0.from_entity = slot0.entityMgr:getEntity(slot1.fromId)
	slot0.to_entity = slot0.entityMgr:getEntity(slot1.toId)
	slot0.params_arr = slot3
	slot0._duration = slot2

	if tonumber(slot3[1]) == 1 then
		-- Nothing
	elseif slot4 == 2 and slot0.from_entity and slot0.from_entity:isMySide() then
		slot0.fly_obj = slot0.entityMgr:getEntity(slot1.fromId).spine:getSpineGO()
		slot0._attacker = FightHelper.getEntity(FightEntityScene.MySideId)

		slot0._attacker.skill:_cancelSideRenderOrder()
	end

	if not slot0.fly_obj then
		return
	end

	slot0:calFly(slot1, slot3)
end

function slot0.calFly(slot0, slot1, slot2)
	slot0._fightStepMO = slot1
	slot4 = 0
	slot5 = 0

	if slot2[3] then
		if string.split(slot2[3], ",")[1] then
			slot3 = tonumber(slot6[1]) or 0
		end

		if slot6[2] then
			slot4 = tonumber(slot6[2]) or slot4
		end

		if slot6[3] then
			slot5 = tonumber(slot6[3]) or slot5
		end
	end

	slot7 = 0
	slot8 = 0

	if slot2[4] then
		if string.split(slot2[4], ",")[1] then
			slot6 = tonumber(slot9[1]) or 0
		end

		if slot9[2] then
			slot7 = tonumber(slot9[2]) or slot7
		end

		if slot9[3] then
			slot8 = tonumber(slot9[3]) or slot8
		end
	end

	slot0._easeFunc = slot2[5]
	slot0._y_offset_cruve = slot2[6]
	slot0._x_move_cruve = slot2[7]
	slot0._y_move_cruve = slot2[8]
	slot0._z_move_cruve = slot2[9]
	slot0._withRotation = slot2[10] and tonumber(slot2[10]) or 0

	if slot0.from_entity and not slot0.from_entity:isMySide() then
		slot3 = -slot3
	end

	slot9, slot10, slot11 = transformhelper.getPos(slot0.fly_obj.transform)
	slot12 = slot9 + slot3
	slot13 = slot10 + slot4
	slot14 = slot11 + slot5
	slot15 = string.nilorempty(slot2[2]) and 2 or tonumber(slot2[2])
	slot16, slot17, slot18 = nil

	if slot1.forcePosX then
		slot18 = slot1.forcePosZ
		slot17 = slot1.forcePosY
		slot16 = slot1.forcePosX
	else
		slot16, slot17, slot18 = slot0:calEndPos(slot15, slot6, slot7, slot8)
	end

	slot0._totalFrame = slot0._binder:GetFrameFloatByTime(slot0._duration * FightModel.instance:getSpeed())
	slot0._startFrame = slot0._binder.CurFrameFloat + 1

	slot0:_startFly(slot12, slot13, slot14, slot16, slot17, slot18)
end

function slot0._startFly(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0:_setCurveMove(slot0.fly_obj, slot1, slot2, slot3, slot4, slot5, slot6)
end

function slot0._setCurveMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot0._withRotation == 1 then
		slot0:_calcRotation(slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	end

	slot0.UnitMoverCurve_comp = MonoHelper.getLuaComFromGo(slot1, UnitMoverCurve)
	slot0.UnitMoverHandler_comp = MonoHelper.getLuaComFromGo(slot1, UnitMoverHandler)
	slot8 = MonoHelper.addLuaComOnceToGo(slot1, UnitMoverCurve)
	slot9 = MonoHelper.addLuaComOnceToGo(slot1, UnitMoverHandler)

	slot9:init(slot1)
	slot9:addEventListeners()
	slot8:setXMoveCruve(slot0._x_move_cruve)
	slot8:setYMoveCruve(slot0._y_move_cruve)
	slot8:setZMoveCruve(slot0._z_move_cruve)
	slot8:setCurveParam(slot0._y_offset_cruve)

	if not string.nilorempty(slot0._easeFunc) then
		slot8:setEaseType(EaseType.Str2Type(slot0._easeFunc))
	else
		slot8:setEaseType(nil)
	end

	slot8:simpleMove(slot2, slot3, slot4, slot5, slot6, slot7, slot0._duration)
end

function slot0._onPosChange(slot0, slot1)
	if slot0._moverParamDict and slot0._moverParamDict[slot1] then
		slot3, slot4, slot5 = slot1:getPos()

		slot0:_calcRotation(slot2.target_obj, slot2.startPosX, slot2.startPosY, slot2.startPosZ, slot3, slot4, slot5)

		slot2.startPosX = slot3
		slot2.startPosY = slot4
		slot2.startPosZ = slot5
	end
end

function slot0._calcRotation(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot1.transform.rotation = Quaternion.LookRotation(Vector3.New(slot5 - slot2, slot6 - slot3, slot7 - slot4), Vector3.up) * Quaternion.AngleAxis(FightHelper.getEffectLookDir(slot0.from_entity:getSide()), Vector3.up) * Quaternion.AngleAxis(90, Vector3.up)
end

function slot0.calEndPos(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 1 then
		return slot2, slot3, slot4
	elseif slot1 == 2 then
		return slot0:_flyEffectTarget(slot2, slot3, slot4, FightHelper.getEntityWorldCenterPos)
	elseif slot1 == 3 then
		return slot0:_flyEffectTarget(slot2, slot3, slot4, false)
	else
		return slot0:_flyEffectTarget(slot2, slot3, slot4, FightHelper.getEntityHangPointPos, slot0.params_arr[2])
	end
end

function slot0._flyEffectTarget(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0.to_entity then
		slot7, slot8, slot9 = slot4 or FightHelper.getEntityWorldBottomPos(slot0.to_entity, slot5)

		return slot7 + (slot0.to_entity:isMySide() and -slot1 or slot1), slot8 + slot2, slot9 + slot3
	end

	return slot1, slot2, slot3
end

function slot0.reset(slot0)
	slot0:dispose()
end

function slot0.dispose(slot0)
	if not gohelper.isNil(slot0.fly_obj) then
		if not slot0.UnitMoverHandler_comp then
			MonoHelper.removeLuaComFromGo(slot0.fly_obj, UnitMoverHandler)

			slot0.UnitMoverHandler_comp = nil
		end

		if not slot0.UnitMoverCurve_comp then
			MonoHelper.removeLuaComFromGo(slot0.fly_obj, UnitMoverCurve)

			slot0.UnitMoverCurve_comp = nil
		end
	end
end

return slot0
