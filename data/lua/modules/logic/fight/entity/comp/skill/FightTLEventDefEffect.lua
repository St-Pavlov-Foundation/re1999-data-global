module("modules.logic.fight.entity.comp.skill.FightTLEventDefEffect", package.seeall)

slot0 = class("FightTLEventDefEffect")
slot3 = {
	[8] = {
		[FightEnum.EffectType.MISS] = true,
		[FightEnum.EffectType.DAMAGE] = true,
		[FightEnum.EffectType.CRIT] = true,
		[FightEnum.EffectType.SHIELD] = true
	},
	[28] = {
		[FightEnum.EffectType.HEAL] = true,
		[FightEnum.EffectType.HEALCRIT] = true
	}
}

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if slot0.type == uv0 and not FightHelper.detectTimelinePlayEffectCondition(slot1, slot3[8]) then
		return
	end

	slot0._fightStepMO = slot1

	if string.nilorempty(slot3[1]) then
		logError("受击特效名字为空，检查一下技能的timeline：" .. (FightConfig.instance:getSkinSkillTimeline(nil, slot1.actId) or "nil"))

		return
	end

	if not string.nilorempty(slot3[10]) and FightHelper.getEntity(slot0._fightStepMO.fromId):getMO() and slot6.skin then
		for slot12, slot13 in ipairs(string.split(slot3[10], "|")) do
			if tonumber(string.split(slot13, "#")[1]) == slot7 then
				slot4 = slot14[2]

				break
			end
		end
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
	slot0._act_on_index_entity = slot3[6] and tonumber(slot3[6])
	slot11 = slot3[7]
	slot12 = slot0._fightStepMO.actEffectMOs

	if slot0._act_on_index_entity then
		slot12 = FightHelper.dealDirectActEffectData(slot0._fightStepMO.actEffectMOs, slot0._act_on_index_entity, uv1[slot0.type])
	end

	slot13 = uv1[slot0.type]
	slot0._monster_scale_dic = nil

	if lua_skin_monster_scale.configDict[slot1.actId] then
		for slot20, slot21 in ipairs(string.split(slot15.effectName, "#")) do
			if slot21 == slot4 then
				slot14 = {
					[slot27] = slot15.scale
				}

				for slot26, slot27 in ipairs(string.splitToNumber(slot15.monsterId, "#")) do
					-- Nothing
				end

				break
			end
		end
	end

	for slot19, slot20 in ipairs(slot12) do
		if slot13[slot20.effectType] and (slot0.type == uv2 or slot11 ~= tostring(slot20.configEffect)) then
			if FightHelper.getEntity(slot20.targetId) then
				slot22 = true

				if slot0.type == uv0 and not FightHelper.detectTimelinePlayEffectCondition(slot1, slot3[8], slot21) then
					slot22 = false
				end

				if slot20.effectType == FightEnum.EffectType.SHIELD and not FightHelper.checkShieldHit(slot20) then
					slot22 = false
				end

				if slot22 and (not slot0._defenderEffectWrapDict or not slot0._defenderEffectWrapDict[slot21]) then
					if slot14 and slot14[slot21:getMO().skin] then
						slot0._monster_scale_dic = {
							[slot21.id] = slot14[slot21:getMO().skin]
						}
					else
						slot0:_setRenderOrder(slot21.id, slot0:_createHitEffect(slot21, slot4, slot5, slot6, slot7, slot8, slot9), slot10)

						slot0._defenderEffectWrapDict = slot0._defenderEffectWrapDict or {}
						slot0._defenderEffectWrapDict[slot21] = slot23
					end
				end
			else
				logNormal("play defender effect fail, entity not exist: " .. slot20.targetId)
			end
		end
	end

	if slot0._monster_scale_dic then
		slot16 = false
		slot17 = 1

		for slot21, slot22 in pairs(slot0._monster_scale_dic) do
			slot23 = FightHelper.getEntity(slot21)

			slot23:setScale(slot22)

			if slot23:getMO() and FightConfig.instance:getSkinCO(slot24.skin) and slot25.canHide == 1 then
				slot16 = slot23
				slot17 = slot22

				break
			end
		end

		if slot16 then
			FightHelper.refreshCombinativeMonsterScaleAndPos(slot16, slot17)

			slot0._revert_combinative_position = slot16
		end
	end

	if not string.nilorempty(slot3[9]) then
		AudioMgr.instance:trigger(tonumber(slot3[9]))
	end
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_removeEffect()
end

function slot0._createHitEffect(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot9 = nil

	if not string.nilorempty(slot3) then
		slot1.effect:addHangEffect(slot2, slot3, FightHelper.getEntity(slot0._fightStepMO.fromId):getSide()):setLocalPos(slot5, slot6, slot7)
	else
		slot9 = slot1.effect:addGlobalEffect(slot2, slot8:getSide())
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
	if slot0._defenderEffectWrapDict then
		for slot4, slot5 in pairs(slot0._defenderEffectWrapDict) do
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot4.id, slot5)
			slot4.effect:removeEffect(slot5)
		end

		slot0._defenderEffectWrapDict = nil
	end

	if slot0._monster_scale_dic then
		for slot4, slot5 in pairs(slot0._monster_scale_dic) do
			if FightHelper.getEntity(slot4) then
				slot6:setScale(1)
			end
		end

		if slot0._revert_combinative_position then
			FightHelper.refreshCombinativeMonsterScaleAndPos(slot0._revert_combinative_position, 1)
		end
	end

	slot0._revert_combinative_position = nil
	slot0._monster_scale_dic = nil
end

return slot0
