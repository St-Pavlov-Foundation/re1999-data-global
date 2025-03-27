module("modules.logic.fight.entity.comp.skill.FightTLEventEntityVisible", package.seeall)

slot0 = class("FightTLEventEntityVisible")
slot1 = nil
slot2 = {
	[FightEnum.EffectType.DAMAGEFROMABSORB] = true,
	[FightEnum.EffectType.STORAGEINJURY] = true,
	[FightEnum.EffectType.SHIELDVALUECHANGE] = true,
	[FightEnum.EffectType.SHAREHURT] = true
}

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if FightHelper.getEntity(slot1.fromId) and slot4.skill and slot4.skill:sameSkillPlaying() then
		-- Nothing
	elseif uv0 and slot1.stepUid < uv0 then
		return
	end

	uv0 = slot1.stepUid
	uv1.latestStepUid = uv0
	slot8 = tonumber(slot3[3]) or 0.2
	slot11 = GameSceneMgr.instance:getCurScene().entityMgr
	slot12 = slot11:getTagUnitDict(SceneTag.UnitPlayer)
	slot13 = slot11:getTagUnitDict(SceneTag.UnitMonster)
	slot16, slot17 = slot0:_getVisibleList(slot9, FightHelper.getDefenders(slot1, false, uv2), FightHelper.getEntity(slot1.fromId):isMySide() and slot12 or slot13, tonumber(slot3[1]) or 1, slot9:isMySide() and slot13 or slot12, tonumber(slot3[2]) or 1, slot1)

	if not string.nilorempty(slot3[5]) and FightHelper.getEntity(slot1.stepUid .. "_" .. slot3[5]) then
		table.insert(slot17, slot18)
	end

	if not string.nilorempty(slot3[6]) and FightHelper.getEntity(slot1.stepUid .. "_" .. slot3[6]) then
		table.insert(slot16, slot18)
	end

	for slot21, slot22 in ipairs(slot16) do
		FightController.instance:dispatchEvent(FightEvent.SetEntityVisibleByTimeline, slot22, slot1, true, slot8)
	end

	if slot3[4] ~= "1" or not slot5 then
		for slot21, slot22 in ipairs(slot17) do
			if true then
				FightController.instance:dispatchEvent(FightEvent.SetEntityVisibleByTimeline, slot22, slot1, false, slot8)
			end
		end
	end
end

function slot0._getVisibleList(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot8 = {}
	slot9 = {}

	for slot13, slot14 in pairs(slot3) do
		slot15 = nil

		if slot4 == 0 then
			slot15 = true
		elseif slot4 == 1 then
			slot15 = false
		elseif slot4 == 2 then
			slot15 = slot1 ~= slot14
		elseif slot4 == 3 then
			slot15 = slot1 == slot14
		elseif slot4 == 4 then
			slot15 = slot1 ~= slot14 and not tabletool.indexOf(slot2, slot14)
		end

		if slot15 then
			table.insert(slot8, slot14)
		else
			table.insert(slot9, slot14)
		end
	end

	for slot13, slot14 in pairs(slot5) do
		slot15 = nil

		if slot6 == 0 then
			slot15 = true
		elseif slot6 == 1 then
			slot15 = false
		elseif slot6 == 2 then
			if not tabletool.indexOf(slot2, slot14) and slot14:getMO() and FightConfig.instance:getSkinCO(slot16.skin) and slot17.canHide == 1 then
				slot15 = false
			end
		elseif slot6 == 3 then
			slot15 = tabletool.indexOf(slot2, slot14)
		elseif slot6 == 4 then
			slot15 = slot14.id ~= slot7.toId
		end

		if slot15 then
			table.insert(slot8, slot14)
		else
			table.insert(slot9, slot14)
		end
	end

	return slot9, slot8
end

return slot0
