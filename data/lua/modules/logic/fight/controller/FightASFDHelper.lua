module("modules.logic.fight.controller.FightASFDHelper", package.seeall)

slot0 = _M

function slot0.getMissileTargetId(slot0)
	if not slot0 then
		return
	end

	if slot0.actEffectMOs then
		for slot4, slot5 in ipairs(slot0.actEffectMOs) do
			if uv0.isDamageEffect(slot5.effectType) then
				return slot5.targetId
			end
		end
	end

	return slot0.toId
end

slot0.DamageEffectTypeDict = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGE] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true,
	[FightEnum.EffectType.ORIGINDAMAGE] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true
}

function slot0.isDamageEffect(slot0)
	return slot0 and uv0.DamageEffectTypeDict[slot0]
end

function slot0.getASFDType(slot0)
	return FightEnum.ASFDType.Normal
end

function slot0.hasASFDFissionEffect(slot0)
	if not slot0 then
		return false
	end

	for slot4, slot5 in ipairs(slot0.actEffectMOs) do
		if slot5.effectType == FightEnum.EffectType.EMITTERSPLITNUM and not string.nilorempty(slot5.reserveStr) then
			return cjson.decode(slot6).splitNum and slot7.splitNum > 0
		end
	end

	return false
end

function slot0.mathReplyRule(slot0, slot1)
	if string.nilorempty(slot1.replaceRule) then
		return true
	end

	for slot7, slot8 in ipairs(FightStrUtil.instance:getSplitString2Cache(slot2, true)) do
		if slot8[1] == FightEnum.ASFDReplyRule.HasSkin then
			if not uv0.checkHasSkinRule(slot8, slot0) then
				return false
			end
		elseif slot9 == FightEnum.ASFDReplyRule.HasBuffActId and not uv0.checkHasBuffActIdRule(slot8, slot0) then
			return false
		end
	end

	return true
end

function slot0.checkHasSkinRule(slot0, slot1)
	for slot5 = 2, #slot0 do
		if FightHelper.hasSkinId(slot0[slot5]) then
			return true
		end
	end

	return false
end

function slot0.checkHasBuffActIdRule(slot0, slot1)
	slot2 = slot1 and FightDataHelper.entityMgr:getById(slot1)

	return slot2 and slot2:hasBuffActId(slot0[2])
end

function slot0.getASFDCo(slot0, slot1, slot2)
	if not FightASFDConfig.instance:getUnitList(slot1) then
		return slot2
	end

	for slot7, slot8 in ipairs(slot3) do
		if uv0.mathReplyRule(slot0, slot8) then
			return slot8
		end
	end

	return slot2
end

function slot0.getBornCo(slot0)
	return uv0.getASFDCo(slot0, FightEnum.ASFDUnit.Born, FightASFDConfig.instance.defaultBornCo)
end

function slot0.getEmitterCo(slot0)
	return uv0.getASFDCo(slot0, FightEnum.ASFDUnit.Emitter, FightASFDConfig.instance.defaultEmitterCo)
end

function slot0.getMissileCo(slot0)
	return uv0.getASFDCo(slot0, FightEnum.ASFDUnit.Missile, FightASFDConfig.instance.defaultMissileCo)
end

function slot0.getExplosionCo(slot0)
	return uv0.getASFDCo(slot0, FightEnum.ASFDUnit.Explosion, FightASFDConfig.instance.defaultExplosionCo)
end

function slot0.getEmitterPos(slot0)
	slot1 = FightModel.instance:getFightParam()
	slot4 = lua_fight_asfd_emitter_position.configDict[slot1 and slot1:getScene(FightModel.instance:getCurWaveId() or 1) or 1] or lua_fight_asfd_emitter_position.configDict[1]
	slot5 = slot0 == FightEnum.EntitySide.MySide and slot4.mySidePos or slot4.enemySidePos

	return slot5[1], slot5[2], slot5[3]
end

function slot0.getStartPos(slot0)
	slot1, slot2, slot3 = uv0.getEmitterPos(slot0)
	slot4, slot5 = GameUtil.getRandomPosInCircle(slot1, slot2, FightASFDConfig.instance.randomRadius)
	slot6 = FightASFDConfig.instance.emitterCenterOffset

	return Vector3(slot0 == FightEnum.EntitySide.MySide and slot4 - slot6.x or slot4 + slot6.x, slot5 + slot6.y, slot3)
end

function slot0.getEndPos(slot0)
	if not FightHelper.getEntity(slot0):getHangPoint(FightASFDConfig.instance.hitHangPoint) then
		return Vector3(0, 0, 0)
	end

	return slot2.transform.position
end

function slot0.getRandomValue()
	return math.random(0, 1000) / 1000
end

slot1 = {
	Down = 2,
	Up = 1
}

function slot0.changeRandomArea()
	uv0.randomAreaY = uv0.randomAreaY == uv1.Up and uv1.Down or uv1.Up
end

slot0.forbidSampleYRate = 0.1

function slot0.getRandomPos(slot0, slot1, slot2)
	slot3 = Vector3()
	slot5, slot6 = uv0.getFormatPos(slot0.x, slot1.x, FightASFDConfig.instance.sampleXRate)
	slot3.x = LuaTween.linear(uv0.getRandomValue(), slot5, slot6 - slot5, 1)
	slot3.z = LuaTween.linear(uv0.getRandomValue(), slot0.z, slot1.z - slot0.z, 1)
	slot4 = uv0.getRandomValue()
	slot7 = math.abs(slot1.y - slot0.y)
	slot9 = slot0.y
	slot10 = slot1.y

	if slot2.sampleMinHeight > 0 and slot7 < slot8 then
		slot11 = (slot8 - slot7) / 2

		if slot10 < slot9 then
			slot9 = slot9 + slot11
			slot10 = slot10 - slot11
		else
			slot9 = slot9 - slot11
			slot10 = slot10 + slot11
		end
	end

	slot10, slot12 = uv0.getFormatPos(slot9, slot10, uv0.forbidSampleYRate)

	if uv0.randomAreaY == uv1.Up then
		-- Nothing
	else
		slot9 = slot12
	end

	slot3.y = LuaTween.linear(slot4, slot9, slot10 - slot9, 1)

	return slot3
end

function slot0.getFormatPos(slot0, slot1, slot2)
	slot3 = math.min(1, math.max(0, slot2)) / 2
	slot6 = slot1 - slot0

	return LuaTween.linear(0.5 - slot3, slot0, slot6, 1), LuaTween.linear(0.5 + slot3, slot0, slot6, 1)
end

function slot0.getASFDBornRemoveRes(slot0)
	return slot0.res .. "_end"
end

function slot0.getASFDEmitterRemoveRes(slot0)
	return slot0.res .. "_end"
end

function slot0.getASFDExplosionScale(slot0, slot1, slot2)
	if slot1.scale == 0 then
		slot3 = 1
	end

	if uv0._checkTriggerMustCrit(slot0, slot2) and uv0._checkHasHeroId() then
		return FightASFDConfig.instance.maDiErDaCritScale * slot3
	end

	return slot3
end

slot0.TempEntityMoList = {}

function slot0._checkHasHeroId()
	slot1 = uv0.TempEntityMoList

	tabletool.clear(slot1)

	for slot5, slot6 in ipairs(FightDataHelper.entityMgr:getMyNormalList(slot1)) do
		if slot6:isCharacter() and slot6.modelId == 3041 then
			return true
		end
	end

	return false
end

function slot0._checkTriggerMustCrit(slot0, slot1)
	if not slot0 then
		return false
	end

	if not slot0.actEffectMOs then
		return false
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot7.effectType == FightEnum.EffectType.MUSTCRIT and slot7.reserveId == slot1 then
			return true
		end
	end

	return false
end

return slot0
