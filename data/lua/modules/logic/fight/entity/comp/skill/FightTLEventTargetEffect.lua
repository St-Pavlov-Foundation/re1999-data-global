module("modules.logic.fight.entity.comp.skill.FightTLEventTargetEffect", package.seeall)

slot0 = class("FightTLEventTargetEffect")
slot1 = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.FIGHTSTEP] = true
}

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._fightStepMO = slot1
	slot0._delayReleaseEffect = not string.nilorempty(slot3[8]) and tonumber(slot3[8])

	if slot0._delayReleaseEffect then
		slot0._delayReleaseEffect = slot0._delayReleaseEffect / FightModel.instance:getSpeed()
	end

	if string.nilorempty(slot3[1]) then
		logError("目标特效名称不能为空")

		return
	end

	slot5 = slot3[2]
	slot6 = slot3[3]
	slot8 = 0
	slot9 = 0

	if slot3[4] then
		if string.split(slot3[4], ",")[1] then
			slot7 = tonumber(slot10[1]) or 0
		end

		if slot10[2] then
			slot8 = tonumber(slot10[2]) or slot8
		end

		if slot10[3] then
			slot9 = tonumber(slot10[3]) or slot9
		end
	end

	slot10 = tonumber(slot3[5]) or -1

	if string.nilorempty(slot3[6]) or slot3[6] == "1" then
		if FightHelper.getEntity(slot1.toId) then
			table.insert({}, slot12)
		end
	elseif not string.nilorempty(slot3[9]) then
		slot13 = {
			[slot18] = slot18
		}

		for slot17, slot18 in ipairs(string.splitToNumber(slot3[9], "#")) do
			-- Nothing
		end

		for slot17, slot18 in ipairs(slot1.actEffectMOs) do
			if slot13[slot18.effectType] and FightHelper.getEntity(slot18.targetId) then
				slot20 = FightHelper.getEntity(slot0._fightStepMO.fromId)
				slot21 = false

				if slot3[6] == "2" then
					slot21 = true
				elseif slot3[6] == "3" then
					slot21 = slot19:getSide() == slot20:getSide()
				elseif slot3[6] == "4" then
					slot21 = slot19:getSide() ~= slot20:getSide()
				end

				if slot21 and not tabletool.indexOf(slot11, slot19) then
					table.insert(slot11, slot19)
				end
			end
		end
	else
		for slot15, slot16 in ipairs(slot1.actEffectMOs) do
			slot17 = false

			if slot16.effectType == FightEnum.EffectType.SHIELD and not FightHelper.checkShieldHit(slot18) then
				slot17 = true
			end

			if not slot17 and not uv0[slot16.effectType] and FightHelper.getEntity(slot16.targetId) then
				slot20 = FightHelper.getEntity(slot0._fightStepMO.fromId)
				slot21 = false

				if slot3[6] == "2" then
					slot21 = true
				elseif slot3[6] == "3" then
					slot21 = slot19:getSide() == slot20:getSide()
				elseif slot3[6] == "4" then
					slot21 = slot19:getSide() ~= slot20:getSide()
				end

				if slot21 and not tabletool.indexOf(slot11, slot19) then
					table.insert(slot11, slot19)
				end
			end
		end
	end

	if not string.nilorempty(slot3[7]) then
		for slot17, slot18 in pairs(GameSceneMgr.instance:getCurScene().deadEntityMgr._entityDic) do
			if slot18:getMO() and tabletool.indexOf(string.splitToNumber(slot3[7], "#"), slot19.skin) then
				table.insert({}, slot18)
			end
		end
	end

	if #slot11 > 0 then
		slot0._effectWrapDict = {}

		for slot15, slot16 in ipairs(slot11) do
			slot17 = slot0:_createEffect(slot16, slot4, slot5, slot6, slot7, slot8, slot9)

			slot0:_setRenderOrder(slot16.id, slot17, slot10)

			slot0._effectWrapDict[slot16] = slot17
		end
	end
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_removeEffect()
end

function slot0._createEffect(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot9 = nil

	if not string.nilorempty(slot3) then
		slot1.effect:addHangEffect(slot2, slot3, FightHelper.getEntity(slot0._fightStepMO.fromId):getSide(), slot0._delayReleaseEffect):setLocalPos(slot5, slot6, slot7)
	else
		slot9 = slot1.effect:addGlobalEffect(slot2, slot8:getSide(), slot0._delayReleaseEffect)
		slot10, slot11, slot12 = nil

		if slot4 == "0" then
			slot10, slot11, slot12 = FightHelper.getEntityWorldBottomPos(slot1)
		elseif slot4 == "1" then
			slot10, slot11, slot12 = FightHelper.getEntityWorldCenterPos(slot1)
		elseif slot4 == "2" then
			slot10, slot11, slot12 = FightHelper.getEntityWorldTopPos(slot1)
		elseif slot4 == "3" then
			slot10, slot11, slot12 = FightHelper.getProcessEntitySpinePos(slot1)
		elseif not string.nilorempty(slot4) and slot1:getHangPoint(slot4) then
			slot14 = slot13.transform.position
			slot12 = slot14.z
			slot11 = slot14.y
			slot10 = slot14.x
		else
			slot10, slot11, slot12 = FightHelper.getEntityWorldCenterPos(slot1)
		end

		slot9:setWorldPos(slot10 + (slot1:isMySide() and -slot5 or slot5), slot11 + slot6, slot12 + slot7)
	end

	return slot9
end

function slot0._setRenderOrder(slot0, slot1, slot2, slot3)
	if slot3 == -1 then
		FightRenderOrderMgr.instance:onAddEffectWrap(slot1, slot2)
	else
		FightRenderOrderMgr.instance:setEffectOrder(slot2, slot3)
	end
end

function slot0.reset(slot0)
	slot0:_removeEffect()
end

function slot0.dispose(slot0)
	slot0:_removeEffect()
end

function slot0._removeEffect(slot0)
	if slot0._effectWrapDict and not slot0._delayReleaseEffect then
		for slot4, slot5 in pairs(slot0._effectWrapDict) do
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot4.id, slot5)
			slot4.effect:removeEffect(slot5)
		end
	end

	slot0._effectWrapDict = nil
end

return slot0
