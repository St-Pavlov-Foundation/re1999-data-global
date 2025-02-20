module("modules.logic.fight.entity.comp.skill.FightTLEventCreateSpine", package.seeall)

slot0 = class("FightTLEventCreateSpine")

function slot0.ctor(slot0)
	slot0._spineGO = nil
end

function slot0.getSkinSpineName(slot0, slot1)
	if string.nilorempty(slot0) or slot1 == 0 then
		return slot0
	end

	slot2 = string.split(slot0, "#")
	slot3 = slot2[1]

	if not (slot2[2] and slot2[2] == "1") then
		return slot3
	end

	if string.find(slot3, "%[") then
		slot3 = string.gsub(slot3, "%[%d-%]", slot1)
	end

	if lua_skin.configDict[slot1] and not string.nilorempty(slot5.spine) then
		slot7 = string.split(slot3, "_")
		slot7[1] = string.split(slot5.spine, "_")[1]

		return table.concat(slot7, "_")
	end

	return slot3
end

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._paramsArr = slot3
	slot0._attacker = FightHelper.getEntity(slot1.fromId)
	slot4 = string.split(slot3[1], "#")
	slot6 = slot0._attacker:getMO() and slot5:getSpineSkinCO()
	slot0._skinId = slot6 and slot6.id or 0
	slot7 = slot6 and uv0.getSkinSpineName(slot3[1], slot0._skinId) or slot3[1]
	slot8 = slot3[2]

	if not string.nilorempty(slot3[3]) then
		slot9 = string.splitToNumber(slot3[3], ",")[1] or 0
		slot10 = slot12[2] or 0
		slot11 = slot12[3] or 0
	end

	slot12 = tonumber(slot3[4]) or -1
	slot13 = tonumber(slot3[5]) or 1
	slot14 = slot1.stepUid .. "_" .. (string.nilorempty(slot3[6]) and slot7 or slot3[6])
	slot15 = tonumber(slot3[7]) or 1
	slot16 = tonumber(slot3[8]) or 0

	if not slot0._attacker:isMySide() and slot3[9] ~= "4" then
		slot9 = -slot9
	end

	slot17 = slot0:_getHangPointGO(slot1, slot15)
	slot18 = 0
	slot18 = slot12 == -1 and (FightRenderOrderMgr.instance:getOrder(slot1.fromId) or 0) / FightEnum.OrderRegion * FightEnum.OrderRegion + 1 or slot12 == -2 and (FightRenderOrderMgr.instance:getOrder(slot1.toId) or 0) / FightEnum.OrderRegion * FightEnum.OrderRegion + (tonumber(slot3[13]) or 0) or slot12 * FightEnum.OrderRegion
	slot19 = {}

	if slot3[10] == "1" then
		slot19 = FightHelper.getDefenders(slot1, true)
	else
		table.insert(slot19, FightHelper.getEntity(slot1.toId))
	end

	slot0._spineEntityList = {}

	for slot24 = 1, slot3[10] == "1" and #slot19 or 1 do
		slot25 = slot19[slot24]
		slot26 = 0
		slot27 = 0
		slot28 = 0

		if slot3[9] == "1" then
			if slot15 == 1 then
				slot26, slot27, slot28 = transformhelper.getLocalPos(slot0._attacker.go.transform)
			else
				slot26, slot27, slot28 = transformhelper.getPos(slot0._attacker.go.transform)
			end
		elseif slot3[9] == "2" and slot25 then
			if slot15 == 1 then
				slot26, slot27, slot28 = transformhelper.getLocalPos(slot25.go.transform)
			else
				slot26, slot27, slot28 = transformhelper.getPos(slot25.go.transform)
			end
		end

		slot0:_createSpine(slot7, slot3[10] == "1" and slot14 .. "_multi_" .. slot24 or slot14, slot16, slot13, slot9 + slot26, slot10 + slot27, slot11 + slot28, slot17, slot18, slot8)
	end

	slot0:_setupEntityLookAt(slot3[11])
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_clear()
end

function slot0._setupEntityLookAt(slot0, slot1)
	if slot1 and slot1 == "1" then
		TaskDispatcher.runRepeat(slot0._onTickLookAtCamera, slot0, 0.01)
	end
end

function slot0._onTickLookAtCamera(slot0)
	for slot5, slot6 in ipairs(slot0._spineEntityList) do
		GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:adjustSpineLookRotation(slot6)
	end
end

function slot0._createSpine(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10)
	slot13 = GameSceneMgr.instance:getCurScene().entityMgr:buildTempSpineByName(slot1, slot2, slot0._attacker:getSide(), slot3 == 1)

	slot13.variantHeart:setEntity(slot0._attacker)
	slot13:setScale(slot4)

	if slot8 then
		gohelper.addChild(slot8, slot13.go)
	end

	if slot0._paramsArr[7] == "3" or slot0._paramsArr[7] == "4" then
		transformhelper.setPos(slot13.go.transform, slot5, slot6, slot7)
	else
		transformhelper.setLocalPos(slot13.go.transform, slot5, slot6, slot7)
	end

	slot13:setRenderOrder(slot9)

	if not string.nilorempty(slot10) then
		slot13.spine:play(slot10)

		if slot0._attacker and slot0._attacker.skill and slot0._attacker.skill:sameSkillPlaying() and not string.nilorempty(slot0._paramsArr[12]) then
			slot13.spine._skeletonAnim:Jump2Time(tonumber(slot0._paramsArr[12]))
		end
	end

	if slot0._paramsArr[14] == "1" then
		FightController.instance:dispatchEvent(FightEvent.EntrustTempEntity, slot13)
	end

	if not string.nilorempty(slot0._paramsArr[15]) then
		GameSceneMgr.instance:getCurScene().entityMgr:removeUnitData(slot13:getTag(), slot13.id)
		FightMsgMgr.sendMsg(FightMsgId.SetBossEvolution, slot13, tonumber(slot0._paramsArr[15]))
		FightController.instance:dispatchEvent(FightEvent.SetBossEvolution, slot13, tonumber(slot0._paramsArr[15]))
	end

	table.insert(slot0._spineEntityList, slot13)
end

function slot0._getHangPointGO(slot0, slot1, slot2)
	if slot2 == 2 then
		return CameraMgr.instance:getCameraTraceGO()
	elseif slot2 == 3 then
		return FightHelper.getEntity(slot1.fromId) and slot3.go
	elseif slot2 == 4 then
		return FightHelper.getEntity(slot1.toId) and slot3.go
	end
end

function slot0.reset(slot0)
	slot0:_clear()
end

function slot0.dispose(slot0)
	slot0:_clear()
end

function slot0._clear(slot0)
	TaskDispatcher.cancelTask(slot0._onTickLookAtCamera, slot0)

	if slot0._spineEntityList then
		for slot4, slot5 in ipairs(slot0._spineEntityList) do
			slot6 = GameSceneMgr.instance:getCurScene().entityMgr
			slot7 = true

			if slot0._paramsArr[14] == "1" then
				slot7 = false
			end

			if not string.nilorempty(slot0._paramsArr[15]) then
				slot7 = false
			end

			if slot7 then
				slot6:removeUnit(slot5:getTag(), slot5.id)
			end

			slot5 = nil
		end
	end

	slot0._spineEntityList = nil
end

return slot0
