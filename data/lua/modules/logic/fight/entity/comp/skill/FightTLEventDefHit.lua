module("modules.logic.fight.entity.comp.skill.FightTLEventDefHit", package.seeall)

slot0 = class("FightTLEventDefHit")
slot1 = {}
slot0.directCharacterHitEffectType = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true
}
slot0.originHitEffectType = {
	[FightEnum.EffectType.ORIGINDAMAGE] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true
}
slot3 = {
	[FightEnum.EffectType.ADDITIONALDAMAGE] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true
}

function slot0.setContext(slot0, slot1)
	slot0._context = slot1
end

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._paramsArr = slot3
	slot0._fightStepMO = slot1
	slot0._duration = slot2
	slot0._attacker = FightHelper.getEntity(slot1.fromId)
	slot0._defeAction = slot3[1]
	slot0._critAction = not string.nilorempty(slot3[2]) and slot3[2] or slot3[1]
	slot0._missAction = slot3[3]
	slot0._hasRatio = not string.nilorempty(slot3[4])
	slot0._ratio = tonumber(slot3[4]) or 0
	slot0._audioId = tonumber(slot3[5]) or 0
	slot0._isLastHit = slot3[6] == "1"
	slot4 = FightStrUtil.instance:getSplitToNumberCache(slot3[7], "#")
	slot5 = FightStrUtil.instance:getSplitToNumberCache(slot3[8], "#")
	slot6 = slot3[9]

	if not string.nilorempty(slot3[10]) then
		slot7 = FightStrUtil.instance:getSplitToNumberCache(slot3[10], "#")
		slot0._act_on_index_entity = slot7[2]
		slot0._act_on_entity_count = slot7[1]
	else
		slot0._act_on_index_entity = nil
		slot0._act_on_entity_count = nil
	end

	slot7 = slot3[11]
	slot0._floatTotalIndex = nil
	slot0._floatFixedPosArr = nil

	if not string.nilorempty(slot0._paramsArr[12]) then
		slot0._floatFixedPosArr = FightStrUtil.instance:getSplitString2Cache(slot0._paramsArr[12], true)
	end

	slot0._skinId2OffetPos = nil

	if not string.nilorempty(slot0._paramsArr[13]) then
		slot0._skinId2OffetPos = {}

		for slot12, slot13 in ipairs(FightStrUtil.instance:getSplitCache(slot0._paramsArr[13], "|")) do
			slot14 = FightStrUtil.instance:getSplitCache(slot13, "#")
			slot16 = FightStrUtil.instance:getSplitToNumberCache(slot14[2], ",")
			slot0._skinId2OffetPos[tonumber(slot14[1])] = {
				slot16[1],
				slot16[2]
			}
		end
	end

	slot0._forcePlayHitForOrigin = slot0._paramsArr[14] == "1"

	slot0:_buildSkillEffect(slot4, slot5, slot6)

	slot0._floatParams = {}
	slot0._defenders = {}
	slot0._hitActionDefenders = {}
	slot8 = {}

	slot0:_preProcessShieldData(slot1, slot0._fightStepMO.actEffectMOs)

	for slot12, slot13 in ipairs((not slot0._act_on_index_entity or slot0:_directCharacterDataFilter()) and slot0._fightStepMO.actEffectMOs) do
		if not slot0:needFilter(slot13) then
			slot14 = slot13.effectType
			slot15 = FightHelper.getEntity(slot13.targetId)

			if uv0.directCharacterHitEffectType[slot13.effectType] then
				if slot15 then
					table.insert(slot0._defenders, slot15)

					if slot13.effectType == FightEnum.EffectType.SHIELDDEL then
						FightWorkEffectShieldDel.New(slot1, slot13):start()
					elseif slot13.configEffect == FightEnum.DirectDamageType then
						slot0:_playDefHit(slot15, slot13)
					elseif slot7 ~= tostring(slot13.configEffect) then
						slot0:_playDefHit(slot15, slot13)
					end
				else
					logNormal("defender hit fail, entity not exist: " .. slot13.targetId)
				end
			end

			if slot0._isLastHit and uv1[slot13.effectType] and slot15 then
				slot0:_playDefHit(slot15, slot13)
			end

			if slot0._isLastHit and (slot14 == FightEnum.EffectType.GUARDCHANGE or slot14 == FightEnum.EffectType.GUARDBREAK) then
				slot0._guardEffectList = slot0._guardEffectList or {}
				slot16 = FightStepBuilder.ActEffectWorkCls[slot14].New(slot0._fightStepMO, slot13)

				slot16:start()
				table.insert(slot0._guardEffectList, slot16)
			end

			if slot0._isLastHit and uv2[slot13.effectType] and slot15 then
				slot0:_playDefHit(slot15, slot13)
			end
		end
	end

	if slot0._ratio > 0 then
		slot0:_statisticAndFloat()
	end

	slot0:_playSkillBuff(slot8)
	slot0:_playSkillBehavior()
	slot0:_trySetKillTimeScale(slot1, slot3)
end

slot4 = {
	[FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE] = true,
	[FightEnum.EffectType.DEADLYPOISONORIGINCRIT] = true
}

function slot0.needFilter(slot0, slot1)
	if not slot1 then
		return false
	end

	if slot1.effectType == FightEnum.EffectType.SHIELD and uv0[slot1.configEffect] then
		return true
	end
end

function slot0.handleSkillEventEnd(slot0)
	if slot0._defenders and #slot0._defenders > 0 then
		slot0:_onDelayActionFinish()
	end
end

function slot0._preProcessShieldData(slot0, slot1, slot2)
	if slot1.hasProcessShield then
		return
	end

	slot1.hasProcessShield = true
	slot3 = {}

	for slot7, slot8 in ipairs(slot2) do
		if slot8.effectType == FightEnum.EffectType.SHIELD and FightHelper.getEntity(slot8.targetId) then
			if not slot3[slot8.targetId] then
				slot3[slot8.targetId] = slot9:getMO() and slot11.shieldValue or 0
			end

			slot8.diffValue = math.abs(slot8.effectNum - slot10)
			slot8.sign = slot10 < slot8.effectNum and 1 or -1

			if slot2[slot7 + 1] and slot11.effectType == FightEnum.EffectType.SHIELDBROCKEN then
				slot11 = slot2[slot7 + 2]
			end

			if slot11 and slot11.targetId == slot8.targetId and uv0[slot11.effectType] then
				slot8.isShieldOriginDamage = true
				slot11.shieldOriginEffectNum = slot11.effectNum + slot8.diffValue
			end

			if slot8.configEffect == FightEnum.EffectType.ADDITIONALDAMAGE or slot8.configEffect == FightEnum.EffectType.ADDITIONALDAMAGECRIT then
				slot8.isShieldAdditionalDamage = true
				slot11.shieldAdditionalEffectNum = slot11.effectNum + slot8.diffValue
			end

			slot3[slot8.targetId] = slot8.effectNum
		end

		if slot8.effectType == FightEnum.EffectType.SHIELDDEL then
			slot3[slot8.targetId] = 0
		end

		if slot8.effectType == FightEnum.EffectType.SHIELDVALUECHANGE then
			slot3[slot8.targetId] = slot8.effectNum
		end
	end
end

function slot0._buildSkillEffect(slot0, slot1, slot2, slot3)
	slot0._buffIdDict = {}
	slot0._behaviorTypeDict = {}

	if string.nilorempty(slot3) then
		for slot7, slot8 in ipairs(slot1) do
			slot0._buffIdDict[slot8] = true
		end

		for slot7, slot8 in ipairs(slot2) do
			slot0._behaviorTypeDict[slot8] = true
		end
	else
		for slot8, slot9 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot3, "#")) do
			if lua_skill_effect.configDict[slot9] then
				for slot14 = 1, FightEnum.MaxBehavior do
					slot16 = FightStrUtil.instance:getSplitToNumberCache(slot10["behavior" .. slot14], "#")

					if slot16 and #slot16 > 0 and slot16[1] == 1 then
						slot0._buffIdDict[slot16[2]] = true
					end

					if slot16 and #slot16 > 0 then
						slot0._behaviorTypeDict[slot17] = true
					end
				end
			else
				logError("技能调用效果不存在" .. slot9)
			end
		end
	end
end

function slot0._playDefHit(slot0, slot1, slot2)
	FightDataHelper.playEffectData(slot2)

	slot4 = slot1:getMO()
	slot5 = slot0._attacker:getMO() and slot3:getCO()
	slot6 = slot4 and slot4:getCO()
	slot7 = slot5 and slot5.career or 0
	slot8 = slot6 and slot6.career or 0

	if FightModel.instance:getVersion() >= 2 and slot3 and slot4 then
		slot7 = slot3.career
		slot8 = slot4.career
	end

	slot10 = FightConfig.instance:getRestrain(slot7, slot8) or 1000

	if slot3 and FightBuffHelper.restrainAll(slot3.id) then
		slot10 = 1100
	end

	if slot0._attacker.buff and slot11:haveBuffId(72540006) then
		slot10 = (slot8 == 1 or slot8 == 2 or slot8 == 3 or slot8 == 4) and 1100 or 1000
	end

	slot12 = nil

	if slot0._floatFixedPosArr then
		slot0._floatTotalIndex = slot0._floatTotalIndex and slot0._floatTotalIndex + 1 or 1
		slot12 = slot0._floatFixedPosArr[slot0._floatTotalIndex] or slot0._floatFixedPosArr[#slot0._floatFixedPosArr]
	end

	if slot2.effectType == FightEnum.EffectType.DAMAGE then
		slot13 = slot0:_calcNum(slot2.clientId, slot2.targetId, slot2.effectNum, slot0._ratio)

		if slot1.nameUI then
			slot1.nameUI:addHp(-slot13)
		end

		table.insert(slot0._floatParams, {
			slot2.targetId,
			slot10 == 1000 and FightEnum.FloatType.damage or slot10 > 1000 and FightEnum.FloatType.restrain or FightEnum.FloatType.berestrain,
			slot1:isMySide() and -slot13 or slot13
		})

		if slot13 ~= 0 then
			slot0:_checkPlayAction(slot1, slot0._defeAction, slot2)
		end

		slot0:_playHitAudio(slot1, false)
		slot0:_playHitVoice(slot1)
		slot0:_playDefRestrain(slot1, slot10)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, -slot13)
		FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, slot0._fightStepMO, slot2, slot1, slot15, slot0._isLastHit, slot12)
	elseif slot2.effectType == FightEnum.EffectType.CRIT then
		slot13 = slot0:_calcNum(slot2.clientId, slot2.targetId, slot2.effectNum, slot0._ratio)

		if slot1.nameUI then
			slot1.nameUI:addHp(-slot13)
		end

		table.insert(slot0._floatParams, {
			slot2.targetId,
			slot10 == 1000 and FightEnum.FloatType.crit_damage or slot10 > 1000 and FightEnum.FloatType.crit_restrain or FightEnum.FloatType.crit_berestrain,
			slot1:isMySide() and -slot13 or slot13
		})

		if slot13 ~= 0 then
			slot0:_checkPlayAction(slot1, slot0._critAction, slot2)
		end

		slot0:_playHitAudio(slot1, true)
		slot0:_playHitVoice(slot1)
		slot0:_playDefRestrain(slot1, slot10)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, -slot13)
		FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, slot0._fightStepMO, slot2, slot1, slot15, slot0._isLastHit, slot12)
	elseif slot2.effectType == FightEnum.EffectType.MISS then
		if slot0._ratio > 0 then
			slot0:_checkPlayAction(slot1, slot0._missAction, slot2)
			FightFloatMgr.instance:float(slot2.targetId, FightEnum.FloatType.buff, luaLang("fight_float_miss"), FightEnum.BuffFloatEffectType.Good)
		end
	elseif slot2.effectType == FightEnum.EffectType.SHIELD then
		slot13 = slot4.shieldValue
		slot14 = slot0:_calcNum(slot2.clientId, slot2.targetId, slot2.diffValue or 0, slot0._ratio)
		slot15 = slot1:isMySide() and -slot14 or slot14

		if slot1.nameUI then
			slot1.nameUI:setShield(slot1.nameUI._curShield + slot14 * slot2.sign)
		end

		if slot2.sign == -1 then
			if not slot2.isShieldOriginDamage and not slot2.isShieldAdditionalDamage then
				table.insert(slot0._floatParams, {
					slot2.targetId,
					slot10 == 1000 and FightEnum.FloatType.shield_damage or slot10 > 1000 and FightEnum.FloatType.shield_restrain or FightEnum.FloatType.shield_berestrain,
					slot15
				})
			end

			slot16 = true

			if not FightHelper.checkShieldHit(slot2) then
				slot16 = false
			end

			if slot2.effectNum1 == FightEnum.EffectType.ORIGINDAMAGE and not slot0._forcePlayHitForOrigin then
				slot16 = false
			end

			if slot2.effectNum1 == FightEnum.EffectType.ORIGINCRIT and not slot0._forcePlayHitForOrigin then
				slot16 = false
			end

			if slot14 ~= 0 and slot16 then
				slot0:_checkPlayAction(slot1, slot0._defeAction, slot2)
			end

			if slot16 then
				slot0:_playHitAudio(slot1, false)
				slot0:_playHitVoice(slot1)
				slot0:_playDefRestrain(slot1, slot10)
			end
		end

		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, slot1, slot14 * slot2.sign)
		FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, slot0._fightStepMO, slot2, slot1, slot15, slot0._isLastHit, slot12)
	elseif uv0[slot2.effectType] then
		slot14 = slot2.effectType == FightEnum.EffectType.ORIGINCRIT

		if slot2.effectNum > 0 and slot1.nameUI then
			slot1.nameUI:addHp(-slot13)
		end

		if not slot2.shieldOriginEffectNum then
			if slot13 > 0 then
				table.insert(slot0._floatParams, {
					slot2.targetId,
					slot14 and FightEnum.FloatType.crit_damage_origin or FightEnum.FloatType.damage_origin,
					slot1:isMySide() and -slot13 or slot13
				})
			end
		else
			table.insert(slot0._floatParams, {
				slot2.targetId,
				slot15,
				slot1:isMySide() and -slot2.shieldOriginEffectNum or slot2.shieldOriginEffectNum
			})
		end

		if slot13 > 0 then
			FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, -slot13)
			FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, slot0._fightStepMO, slot2, slot1, slot16, slot0._isLastHit, slot12)
		end

		if slot0._forcePlayHitForOrigin then
			slot0:_checkPlayAction(slot1, slot0._defeAction, slot2)
			slot0:_playHitAudio(slot1, false)
			slot0:_playHitVoice(slot1)
			slot0:_playDefRestrain(slot1, slot10)
		end
	elseif uv1[slot2.effectType] then
		slot14 = slot2.effectType == FightEnum.EffectType.ADDITIONALDAMAGECRIT

		if slot2.effectNum > 0 and slot1.nameUI then
			slot1.nameUI:addHp(-slot13)
		end

		if not slot2.shieldAdditionalEffectNum then
			if slot13 > 0 then
				table.insert(slot0._floatParams, {
					slot2.targetId,
					slot14 and FightEnum.FloatType.crit_additional_damage or FightEnum.FloatType.additional_damage,
					slot1:isMySide() and -slot13 or slot13
				})
			end
		else
			table.insert(slot0._floatParams, {
				slot2.targetId,
				slot15,
				slot1:isMySide() and -slot2.shieldAdditionalEffectNum or slot2.shieldAdditionalEffectNum
			})
		end

		if slot13 > 0 then
			FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, -slot13)
			FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, slot0._fightStepMO, slot2, slot1, slot16, slot0._isLastHit, slot12)
		end
	end

	FightDataHelper.playEffectData(slot2)
end

function slot0._statisticAndFloat(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._floatParams) do
		slot8 = slot6[2]
		slot9 = slot6[3]

		if not slot1[slot6[1]] then
			slot1[slot7] = {
				list = {}
			}
		end

		if not slot10[slot8] then
			slot11 = {
				floatType = slot8,
				num = slot9
			}

			table.insert(slot10.list, slot11)

			slot10[slot8] = slot11
		else
			slot11 = slot10[slot8]
			slot11.num = slot11.num + slot9
		end
	end

	slot2 = 1

	for slot6, slot7 in pairs(slot1) do
		slot8 = {}

		for slot12, slot13 in pairs(slot7) do
			if slot13.num and slot14 ~= 0 then
				slot15 = slot12

				if slot12 == FightEnum.FloatType.shield_damage then
					slot15 = slot7[FightEnum.FloatType.damage] and FightEnum.FloatType.damage or FightEnum.FloatType.crit_damage
				elseif slot12 == FightEnum.FloatType.shield_restrain then
					slot15 = slot7[FightEnum.FloatType.restrain] and FightEnum.FloatType.restrain or FightEnum.FloatType.crit_restrain
				elseif slot12 == FightEnum.FloatType.shield_berestrain then
					slot15 = slot7[FightEnum.FloatType.berestrain] and FightEnum.FloatType.berestrain or FightEnum.FloatType.crit_berestrain
				end

				if slot15 ~= slot12 then
					slot7[slot12] = 0
					slot13.num = 0

					if slot7[slot15] then
						slot16 = slot7[slot15]
						slot16.num = slot16.num + slot14
					elseif not slot8[slot15] then
						slot16 = {
							floatType = slot15,
							num = slot14
						}

						table.insert(slot7.list, slot16)

						slot8[slot15] = slot16
					else
						slot16 = slot8[slot15]
						slot16.num = slot16.num + slot14
					end
				end
			end
		end

		table.sort(slot7.list, uv0._sortByFloatType)

		for slot12, slot13 in pairs(slot7.list) do
			slot14 = slot13.floatType

			if slot13.num ~= 0 then
				slot16 = nil

				if slot0._floatFixedPosArr then
					slot16 = {}

					if slot2 >= #slot0._floatFixedPosArr then
						slot2 = #slot0._floatFixedPosArr
					end

					slot16.pos_x = slot0._floatFixedPosArr[slot2][1]
					slot16.pos_y = slot0._floatFixedPosArr[slot2][2]
					slot2 = slot2 + 1
				end

				slot17 = FightHelper.getEntity(slot6)

				if slot0._skinId2OffetPos and slot17:getMO() and slot0._skinId2OffetPos[slot18.skin] then
					slot16 = slot16 or {}
					slot16.offset_x = slot19[1]
					slot16.offset_y = slot19[2]
				end

				FightFloatMgr.instance:float(slot6, slot14, slot15, slot16)
				FightController.instance:dispatchEvent(FightEvent.OnDamageTotal, slot0._fightStepMO, slot17, slot15, slot0._isLastHit)
			end
		end
	end
end

slot5 = {
	[FightEnum.FloatType.additional_damage] = 10,
	[FightEnum.FloatType.crit_additional_damage] = 11,
	[FightEnum.FloatType.damage_origin] = 12,
	[FightEnum.FloatType.crit_damage_origin] = 13
}

function slot0._sortByFloatType(slot0, slot1)
	if (uv0[slot0.floatType] or 100) ~= (uv0[slot1.floatType] or 100) then
		return slot3 < slot2
	end

	return slot1.num < slot0.num
end

function slot0._playHitAudio(slot0, slot1, slot2)
	if slot0._audioId > 0 then
		FightAudioMgr.instance:playHit(slot0._audioId, slot1:getMO().skin, slot2)
	elseif slot0._ratio > 0 and slot0._fightStepMO.atkAudioId and slot0._fightStepMO.atkAudioId > 0 then
		FightAudioMgr.instance:playHitByAtkAudioId(slot0._fightStepMO.atkAudioId, slot1:getMO().skin, slot2)
	end
end

function slot0._playHitVoice(slot0, slot1)
	if slot0._isLastHit then
		slot3 = GameConfig:GetCurVoiceShortcut()
		slot5 = slot1:getMO() and slot4.modelId

		if slot1:isMySide() and slot5 then
			slot6, slot7, slot8 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot5)

			if not string.nilorempty(LangSettings.shortcutTab[slot6]) and not slot8 then
				slot3 = slot9
			end
		end

		FightAudioMgr.instance:playHitVoice(slot5, slot3)
	end
end

function slot0._playDefRestrain(slot0, slot1, slot2)
end

function slot0._calcNum(slot0, slot1, slot2, slot3, slot4)
	if slot0._hasRatio then
		slot0._context.floatNum = slot0._context.floatNum or {}
		slot0._context.floatNum[slot2] = slot0._context.floatNum[slot2] or {}
		slot0._context.floatNum[slot2][slot1] = slot0._context.floatNum[slot2][slot1] or {}
		slot6 = slot0._context.floatNum[slot2][slot1].ratio or 0
		slot7 = slot5.total or 0
		slot9 = math.floor((slot4 + slot6 < 1 and slot8 or 1) * slot3 + 0.5) - slot7
		slot5.ratio = slot4 + slot6
		slot5.total = slot7 + slot9

		return slot9
	else
		return 0
	end
end

function slot0._checkPlayAction(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot2) then
		return
	end

	slot4 = slot1.spine:getAnimState()
	slot5 = nil

	for slot9, slot10 in ipairs(slot0._fightStepMO.actEffectMOs) do
		if slot10.effectType == FightEnum.EffectType.DEAD and slot10.targetId == slot1.id then
			slot5 = true
		end
	end

	if slot0._isLastHit then
		if slot5 and slot0._fightStepMO.actId == slot1.deadBySkillId and slot0:_canPlayDead(slot3) then
			if slot1:getSide() ~= slot0._attacker:getSide() then
				FightController.instance:dispatchEvent(FightEvent.OnSkillLastHit, slot1.id, slot0._fightStepMO)
			end
		elseif slot4 ~= SpineAnimState.freeze then
			slot0:_playAction(slot1, slot2)
		end
	elseif slot5 and slot0._fightStepMO.actId == slot1.deadBySkillId then
		if slot4 ~= SpineAnimState.freeze and slot4 ~= SpineAnimState.die then
			slot0:_playAction(slot1, slot2)
		end
	elseif slot4 ~= SpineAnimState.freeze then
		slot0:_playAction(slot1, slot2)
	end
end

function slot0._playAction(slot0, slot1, slot2)
	if slot1.buff:haveBuffId(2112031) then
		return
	end

	slot2 = FightHelper.processEntityActionName(slot1, slot2, slot0._fightStepMO)

	slot1.spine:play(slot2, false, true, true)
	slot1.spine:addAnimEventCallback(slot0._onAnimEvent, slot0, {
		slot1,
		slot2
	})
	table.insert(slot0._hitActionDefenders, slot1)

	uv0[slot1.id] = (uv0[slot1.id] or 0) + 1
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot4[1]

	if slot2 == SpineAnimEvent.ActionComplete and slot1 == slot4[2] then
		slot5.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		slot5:resetAnimState()
	end
end

function slot0._onDelayActionFinish(slot0)
	if slot0._hitActionDefenders then
		for slot4, slot5 in ipairs(slot0._hitActionDefenders) do
			slot5.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)

			uv0[slot5.id] = (uv0[slot5.id] or 1) - 1

			if uv0[slot5.id] == 0 then
				slot5:resetAnimState()
			end
		end

		slot0._hitActionDefenders = nil
	end
end

function slot0.onSkillEnd(slot0)
	slot0:_onDelayActionFinish()

	if slot0._guardEffectList then
		for slot4, slot5 in ipairs(slot0._guardEffectList) do
			slot5:disposeSelf()
		end

		slot0._guardEffectList = nil
	end
end

function slot0._playSkillBuff(slot0, slot1)
	if GameUtil.tabletool_dictIsEmpty(slot0._buffIdDict) then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		if FightHelper.getEntity(slot6.targetId) and FightEnum.BuffEffectType[slot6.effectType] and slot0._buffIdDict and slot0._buffIdDict[slot6.buff.buffId] then
			FightSkillBuffMgr.instance:playSkillBuff(slot0._fightStepMO, slot6)
		end
	end
end

function slot0._playSkillBehavior(slot0)
	if not slot0._behaviorTypeDict then
		return
	end

	FightSkillBehaviorMgr.instance:playSkillBehavior(slot0._fightStepMO, slot0._behaviorTypeDict, true)
end

function slot0._trySetKillTimeScale(slot0, slot1, slot2)
	slot0._context.hitCount = (slot0._context.hitCount or 0) + 1

	if not (slot2[7] == "1") then
		return
	end

	if not FightHelper.getEntity(slot1.fromId):getMO() then
		return
	end

	if slot5.side ~= FightEnum.EntitySide.MySide or not slot5:isCharacter() then
		return
	end

	if not FightConfig:isUniqueSkill(slot1.actId, slot5.modelId) then
		return
	end

	slot7 = false

	for slot11, slot12 in ipairs(slot0._fightStepMO.actEffectMOs) do
		if slot12.effectType == FightEnum.EffectType.DEAD then
			slot7 = true

			break
		end
	end

	if not slot7 then
		return
	end

	if slot0._context.hitCount and slot0._context.hitCount > 1 then
		TaskDispatcher.runDelay(slot0._revertKillTimeScale, slot0, 0.2)
	else
		TaskDispatcher.runDelay(slot0._revertKillTimeScale, slot0, 0.2)
	end
end

function slot0._directCharacterDataFilter(slot0)
	slot1 = {}
	slot2 = {
		[slot6] = slot7
	}

	for slot6, slot7 in pairs(uv0.directCharacterHitEffectType) do
		-- Nothing
	end

	for slot6, slot7 in pairs(uv1) do
		slot2[slot6] = slot7
	end

	for slot6, slot7 in pairs(uv2) do
		slot2[slot6] = slot7
	end

	slot3 = FightHelper.filterActEffect(slot0._fightStepMO.actEffectMOs, slot2)
	slot4, slot5 = LuaUtil.float2Fraction(slot0._ratio)
	slot6 = #slot3
	slot7, slot8 = nil

	if slot3[slot0._act_on_index_entity] then
		slot8 = slot3[slot0._act_on_index_entity][1].targetId
		slot7 = slot0._act_on_index_entity
	elseif slot6 > 0 then
		slot8 = slot3[slot6][1].targetId
		slot7 = slot6
	end

	if slot0._act_on_entity_count ~= slot6 and slot7 == slot6 then
		slot4, slot5 = LuaUtil.divisionOperation2Fraction(slot0._ratio, slot0._act_on_entity_count - slot6 + 1)
		slot0._ratio = slot0._ratio / (slot0._act_on_entity_count - slot6 + 1)
	end

	for slot12, slot13 in ipairs(slot0._fightStepMO.actEffectMOs) do
		if slot13.targetId == slot8 then
			table.insert(slot1, slot13)
		end
	end

	for slot12 = #slot1, 1, -1 do
		if not slot1[slot12] then
			logError("找不到数据")
		end

		if slot0:_detectInvokeActEffect(slot13.clientId, slot13.targetId, slot4, slot5) then
			-- Nothing
		elseif not uv0.directCharacterHitEffectType[slot13.effectType] then
			table.remove(slot1, slot12)
		end
	end

	return slot1
end

function slot0._detectInvokeActEffect(slot0, slot1, slot2, slot3, slot4)
	if slot0._hasRatio then
		if not slot0._context.ratio_fraction then
			slot0._context.ratio_fraction = {}
		end

		if not slot0._context.ratio_fraction[slot2] then
			slot0._context.ratio_fraction[slot2] = slot0._context.ratio_fraction[slot2] or {}
		end

		if not slot0._context.ratio_fraction[slot2][slot1] then
			slot0._context.ratio_fraction[slot2][slot1] = slot0._context.ratio_fraction[slot2][slot1] or {}
			slot0._context.ratio_fraction[slot2][slot1].numerator = 0
			slot0._context.ratio_fraction[slot2][slot1].denominator = 1
		end

		slot5, slot6 = LuaUtil.fractionAddition(slot0._context.ratio_fraction[slot2][slot1].numerator, slot0._context.ratio_fraction[slot2][slot1].denominator, slot3, slot4)
		slot0._context.ratio_fraction[slot2][slot1].numerator = slot5
		slot0._context.ratio_fraction[slot2][slot1].denominator = slot6

		return slot6 <= slot5
	end

	return true
end

function slot0._canPlayDead(slot0, slot1)
	if slot0._context.ratio_fraction and slot0._context.ratio_fraction[slot1.targetId] and slot0._context.ratio_fraction[slot1.targetId][slot1.clientId] then
		return slot0._context.ratio_fraction[slot1.targetId][slot1.clientId].denominator <= slot0._context.ratio_fraction[slot1.targetId][slot1.clientId].numerator
	end

	return true
end

function slot0._revertKillTimeScale(slot0)
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.FightKillEnemy, 1)
end

function slot0.reset(slot0)
	slot0:_revertKillTimeScale()
	TaskDispatcher.cancelTask(slot0._revertKillTimeScale, slot0)

	slot0._defenders = nil
	slot0._attacker = nil
end

function slot0.dispose(slot0)
	slot0:_revertKillTimeScale()
	TaskDispatcher.cancelTask(slot0._revertKillTimeScale, slot0)

	slot0._defenders = nil
	slot0._attacker = nil
end

return slot0
