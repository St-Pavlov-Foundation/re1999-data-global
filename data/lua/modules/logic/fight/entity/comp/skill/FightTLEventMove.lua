module("modules.logic.fight.entity.comp.skill.FightTLEventMove", package.seeall)

slot0 = class("FightTLEventMove")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot2 = slot2 * FightModel.instance:getSpeed()
	slot0._paramsArr = slot3
	slot4 = slot3[1]
	slot5 = tonumber(slot3[2]) or 0
	slot6 = tonumber(slot3[3]) or 0
	slot7 = GameUtil.splitString2(slot3[4], true, "#", ",")
	slot8 = slot3[5]

	if slot3[6] == "1" then
		slot2 = 0
	end

	if #uv0._getMoveEntitys(slot1, slot4) > 0 then
		slot11 = false

		if slot4 == "2" or slot4 == "4" then
			for slot15, slot16 in ipairs(slot10) do
				if slot16:getMO() and FightConfig.instance:getSkinCO(slot17.skin) and slot18.canHide == 1 then
					slot11 = true
				end
			end
		end

		if slot11 then
			slot0._combinative_entitys = {}
			slot0._combinative_pos_offsets = {}
			slot14 = slot10[1]
			slot15 = slot14

			for slot15, slot16 in ipairs(FightHelper.getSideEntitys(slot14.getSide(slot15))) do
				if slot16:getMO() then
					if FightConfig.instance:getSkinCO(slot17.skin) and slot18.mainBody == 1 then
						slot0._follow_entity = slot16
					else
						table.insert(slot0._combinative_entitys, slot16)
					end
				end
			end

			if not slot0._follow_entity then
				slot0._follow_entity = FightHelper.getEntity(slot1.toId)

				tabletool.removeValue(slot0._combinative_entitys, slot0._follow_entity)
			end

			slot12, slot13, slot14 = FightHelper.getEntityStandPos(slot0._follow_entity:getMO())

			for slot19, slot20 in ipairs(slot0._combinative_entitys) do
				slot21, slot22, slot23 = FightHelper.getEntityStandPos(slot20:getMO())

				table.insert(slot0._combinative_pos_offsets, Vector3.New(slot21, slot22, slot23) - Vector3.New(slot12, slot13, slot14))
			end

			slot10 = {
				slot0._follow_entity
			}

			TaskDispatcher.runRepeat(slot0._setCombinativeEntitysPos, slot0, 0.0001)
		end
	end

	if #slot10 > 1 then
		table.sort(slot10, function (slot0, slot1)
			if slot0:getSide() ~= slot1:getSide() then
				return slot0:isMySide()
			end

			slot3 = slot1:getMO()

			if slot0:getMO() and slot3 and slot2.position ~= slot3.position then
				return slot2.position < slot3.position
			end

			return tonumber(slot1.id) < tonumber(slot0.id)
		end)
	end

	slot11 = nil

	if not string.nilorempty(slot0._paramsArr[8]) and #slot10 == 1 then
		slot12 = slot10[1]

		if #FightStrUtil.instance:getSplitCache(slot0._paramsArr[8], "|") > 1 then
			slot14 = false

			for slot18 = 2, #slot13 do
				slot19 = FightStrUtil.instance:getSplitCache(slot13[slot18], "_")

				if slot12:getMO() and slot20.skin == tonumber(slot19[1]) then
					slot11 = FightStrUtil.instance:getSplitToNumberCache(slot19[2], ",")
					slot14 = true

					break
				end
			end

			if not slot14 then
				slot11 = FightStrUtil.instance:getSplitToNumberCache(slot13[1], ",")
			end
		else
			slot11 = FightStrUtil.instance:getSplitToNumberCache(slot0._paramsArr[8], ",")
		end
	end

	for slot15, slot16 in ipairs(slot10) do
		if not gohelper.isNil(slot16.go) then
			slot17, slot18, slot19 = transformhelper.getPos(slot16.go.transform)
			slot20, slot21, slot22 = slot0:_getEndPosXYZ(slot1, slot16, slot7, slot4, slot5, slot15)

			if slot11 then
				slot20 = slot11[1] and (slot16:isMySide() and slot11[1] or -slot11[1]) or 0
				slot21 = slot11[2] or 0
				slot22 = slot11[3] or 0
			end

			uv0._setupEntityMove(slot16, slot17, slot18, slot19, slot20, slot21, slot22, slot2, slot6, slot8)
		end
	end
end

function slot0._getEndPosXYZ(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = FightHelper.getEntity(slot1.fromId)
	slot8 = FightHelper.getEntity(slot1.toId)
	slot9 = slot3[1]

	if slot4 == "3" or slot4 == "4" then
		slot9 = slot3[slot2:getMO().position]
	elseif slot4 == "2" then
		slot9 = slot3[slot6]
	end

	slot10 = slot9 and slot9[1] or 0
	slot11 = slot9 and slot9[2] or 0
	slot12 = slot9 and slot9[3] or 0
	slot13 = 0
	slot14 = 0
	slot15 = 0

	if slot5 == 3 then
		if slot2:getMO() then
			slot13, slot14, slot15 = FightHelper.getEntityStandPos(slot16)
		else
			slot15 = 0
			slot14 = 0
			slot13 = 0
		end
	elseif slot5 == 1 or slot5 == 2 then
		if slot5 == 1 and slot7 or slot8 then
			slot13, slot14, slot15 = FightHelper.getProcessEntityStancePos(slot16:getMO())
			slot13 = slot16:isMySide() and slot13 - slot10 or slot13 + slot10
			slot14 = slot14 + slot11
			slot15 = slot15 + slot12
		else
			logNormal("targetEntity not exist: " .. (slot5 == 1 and slot1.fromId or slot1.toId))
		end
	elseif slot5 == 0 then
		slot13 = tonumber(slot4) and slot2:isMySide() and slot13 - slot10 or slot13 + slot10
		slot14 = slot11
		slot15 = slot12
	elseif slot5 == 4 then
		slot13 = slot10
		slot14 = slot11
		slot15 = slot12
	elseif slot5 == 5 then
		slot16 = nil

		if #FightStrUtil.instance:getSplitCache(slot0._paramsArr[7], "|") > 1 then
			slot18 = false

			for slot22 = 2, #slot17 do
				slot23 = FightStrUtil.instance:getSplitCache(slot17[slot22], "_")

				if slot2:getMO() and slot24.skin == tonumber(slot23[1]) then
					slot16 = FightStrUtil.instance:getSplitToNumberCache(slot23[2], ",")
					slot18 = true

					break
				end
			end

			if not slot18 then
				slot16 = FightStrUtil.instance:getSplitToNumberCache(slot17[1], ",")
			end
		else
			slot16 = FightStrUtil.instance:getSplitToNumberCache(slot0._paramsArr[7], ",")
		end

		slot18, slot19, slot20 = transformhelper.getPos(slot2.go.transform)
		slot13 = slot18 + (slot16[1] and (slot2:isMySide() and slot16[1] or -slot16[1]) or 0)
		slot14 = slot19 + (slot16[2] or 0)
		slot15 = slot20 + (slot16[3] or 0)
	end

	return slot13, slot14, slot15
end

function slot0._getMoveEntitys(slot0, slot1)
	slot4 = FightHelper.getEntity(slot0.toId)

	if slot1 == "1" then
		table.insert({}, FightHelper.getEntity(slot0.fromId))
	elseif slot1 == "2" then
		slot5 = {}

		for slot9, slot10 in ipairs(slot0.actEffectMOs) do
			if not FightHelper.getEntity(slot10.targetId) and slot10.effectType ~= FightEnum.EffectType.INDICATORCHANGE then
				-- Nothing
			end

			slot12 = false

			if slot11 and (slot11.id == FightEntityScene.MySideId or slot11.id == FightEntityScene.EnemySideId) then
				slot12 = true
			end

			if not slot12 and slot11 and slot11:getSide() ~= slot3:getSide() and not slot5[slot10.targetId] then
				table.insert(slot2, slot11)

				slot5[slot10.targetId] = true
			end
		end
	elseif slot1 == "3" then
		slot2 = FightHelper.getSideEntitys(slot3:getSide(), false)
	elseif slot1 == "4" then
		if slot4 then
			slot2 = FightHelper.getSideEntitys(slot4:getSide(), false)
		end
	elseif slot1 == "5" then
		tabletool.addValues(slot2, FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false))
		tabletool.addValues(slot2, FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false))
	elseif slot1 == "6" then
		if slot4 then
			table.insert(slot2, slot4)
		end
	else
		table.insert(slot2, GameSceneMgr.instance:getCurScene().entityMgr:getUnit(SceneTag.UnitNpc, slot0.stepUid .. "_" .. slot1))
	end

	return slot2
end

function slot0._setupEntityMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	if slot8 > 0 then
		slot0.parabolaMover:simpleMove(slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	else
		if slot9 and slot0.mover.setEaseType then
			slot0.mover:setEaseType(EaseType.Str2Type(slot9))
		end

		slot0.mover:simpleMove(slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	end
end

function slot0._setCombinativeEntitysPos(slot0)
	if slot0._combinative_entitys then
		slot1 = nil

		for slot5, slot6 in ipairs(slot0._combinative_entitys) do
			if FightHelper.getEntity(slot6.id) then
				if not gohelper.isNil(slot7.go) and not gohelper.isNil(slot0._follow_entity.go) then
					slot7.go.transform.position = slot0._follow_entity.go.transform.position + slot0._combinative_pos_offsets[slot5] * slot7:getScale()
				end
			end
		end
	end
end

function slot0.handleSkillEventEnd(slot0)
	TaskDispatcher.cancelTask(slot0._setCombinativeEntitysPos, slot0)
end

function slot0.reset(slot0)
	slot0._combinative_entitys = nil
end

return slot0
