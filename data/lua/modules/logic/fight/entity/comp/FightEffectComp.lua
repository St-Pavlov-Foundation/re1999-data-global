module("modules.logic.fight.entity.comp.FightEffectComp", package.seeall)

slot0 = class("FightEffectComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._playingEffectDict = {}
	slot0.cache_effect = {}
	slot0._release_by_time = {}
	slot0._serverRelease = {}
	slot0._tokenRelease = {}
	slot0._roundRelease = {}
	slot0._hangEffects = {}
	slot0._followCameraRotation = {}
	slot0._specialEffectClass = {}
end

function slot0.init(slot0, slot1)
	slot0:addEventCb(FightController.instance, FightEvent.InvokeFightWorkEffectType, slot0._onInvokeFightWorkEffectType, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ChangeRound, slot0._onChangeRound, slot0)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)

	slot0.go = slot1

	slot0:_initSpecialEffectClass()
end

function slot0.setActive(slot0, slot1)
	if slot0._playingEffectDict then
		for slot5, slot6 in pairs(slot0._playingEffectDict) do
			slot6:setActive(slot1)
		end
	end
end

function slot0.setTimeScale(slot0, slot1)
	if slot0._playingEffectDict then
		for slot5, slot6 in pairs(slot0._playingEffectDict) do
			slot6:setTimeScale(slot1)
		end
	end
end

function slot0.addPlayingEffectWrap(slot0, slot1)
	if slot0._playingEffectDict then
		slot0._playingEffectDict[slot1.uniqueId] = slot1
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot1 and slot1.unitSpawn == slot0.entity then
		for slot5, slot6 in pairs(slot0.cache_effect) do
			slot6.effectWrap:setHangPointGO(slot0.entity:getHangPoint(slot6.hangPoint))

			if slot6.cache_local_position then
				slot6.effectWrap:setLocalPos(slot6.cache_local_position.x, slot6.cache_local_position.y, slot6.cache_local_position.z)
			end
		end

		slot0.cache_effect = {}
	end
end

function slot0.addHangEffect(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot9 = FightEffectPool.getEffect(FightHelper.getEffectUrlWithLod(slot1), slot3 or slot0.entity:getSide(), slot0._onEffectLoaded, slot0, slot0.entity:getHangPoint(slot2, slot6))
	slot0._playingEffectDict[slot9.uniqueId] = slot9

	FightAudioMgr.instance:onDirectPlayAudio(AudioEffectMgr.instance:playAudioByEffectPath(slot7))

	if slot0.entity.spine and not slot0.entity.spine:getSpineGO() then
		slot0.cache_effect[slot9.uniqueId] = {
			effectWrap = slot9,
			hangPoint = slot2,
			cache_local_position = slot5
		}
	end

	if slot4 then
		slot0:_releaseEffectByTime(slot9, slot4)
	end

	slot0._hangEffects[slot9.uniqueId] = {
		effectWrap = slot9,
		hangPoint = slot2
	}

	return slot9
end

function slot0.addGlobalEffect(slot0, slot1, slot2, slot3)
	slot5 = FightEffectPool.getEffect(FightHelper.getEffectUrlWithLod(slot1), slot2 or slot0.entity:getSide(), slot0._onEffectLoaded, slot0)
	slot0._playingEffectDict[slot5.uniqueId] = slot5

	FightEffectPool.returnEffectToPoolContainer(slot5)
	FightAudioMgr.instance:onDirectPlayAudio(AudioEffectMgr.instance:playAudioByEffectPath(slot4))

	if slot3 then
		slot0:_releaseEffectByTime(slot5, slot3)
	end

	return slot5
end

function slot0.getEffectWrap(slot0, slot1)
	for slot6, slot7 in pairs(slot0._playingEffectDict) do
		if slot7.path == FightHelper.getEffectUrlWithLod(slot1) then
			return slot7
		end
	end
end

function slot0._releaseEffectByTime(slot0, slot1, slot2)
	slot0._release_by_time[slot1.uniqueId] = slot1
	slot3 = slot0.entity.id

	TaskDispatcher.runDelay(function ()
		uv0._release_by_time[uv1.uniqueId] = nil

		FightRenderOrderMgr.instance:onRemoveEffectWrap(uv2, uv1)
		uv0:removeEffect(uv1)
	end, slot0, slot2)
end

function slot0._onEffectLoaded(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	if FightHelper.getEffectLabel(slot1.effectGO, 0) and #slot3 >= 1 and slot0.entity:getMO() and FightConfig.instance:getSkinCO(slot4.skin) and slot5.flipX and slot5.flipX == 1 then
		transformhelper.setLocalScale(slot1.containerTr, -1, 1, 1)
	end

	slot0:refreshEffectLabel1(slot1)
	FightController.instance:dispatchEvent(FightEvent.EntityEffectLoaded, slot0.entity.id, slot1)
end

function slot0.refreshEffectLabel1(slot0, slot1)
	if FightHelper.getEffectLabel(slot1.effectGO, 1) and #slot2 >= 1 and slot0.entity:getMO() then
		for slot7, slot8 in ipairs(slot2) do
			slot8.standPosX, slot10, slot11, slot12 = FightHelper.getEntityStandPos(slot3)
			slot8.label = 1

			if slot0._followCameraRotation then
				slot0._followCameraRotation[slot1.uniqueId] = true
			end
		end
	end
end

function slot0.refreshAllEffectLabel1(slot0)
	if slot0._playingEffectDict then
		for slot4, slot5 in pairs(slot0._playingEffectDict) do
			if slot0._followCameraRotation and slot0._followCameraRotation[slot5.uniqueId] then
				slot0:revertFollowCameraEffectLabel1(slot5)
				slot0:refreshEffectLabel1(slot5)
			end
		end
	end
end

function slot0.revertFollowCameraEffectLabel1(slot0, slot1)
	if FightHelper.getEffectLabel(slot1.effectGO, -1) and #slot2 >= 1 then
		for slot6, slot7 in ipairs(slot2) do
			slot7.label = 1
		end
	end
end

function slot0.removeEffect(slot0, slot1)
	if slot0._release_by_time[slot1.uniqueId] then
		return
	end

	if slot0._followCameraRotation then
		slot0:revertFollowCameraEffectLabel1(slot1)

		slot0._followCameraRotation[slot1.uniqueId] = nil
	end

	if slot0._playingEffectDict and slot0._playingEffectDict[slot1.uniqueId] then
		slot0._playingEffectDict[slot1.uniqueId] = nil
	end

	FightEffectPool.returnEffectToPoolContainer(slot1)
	FightEffectPool.returnEffect(slot1)

	if slot0.cache_effect then
		slot0.cache_effect[slot1.uniqueId] = nil
	end

	if slot0._hangEffects then
		slot0._hangEffects[slot1.uniqueId] = nil
	end

	slot0:_checkDisableEffectLabel(slot1)
end

function slot0._checkDisableEffectLabel(slot0, slot1)
	if slot0._effectWrap4EffectLabel == slot1 then
		slot0._effectWrap4EffectLabel = nil

		if slot0.entity.spine and slot0.entity.spine:getPPEffectMask() then
			slot2.partMat = nil

			slot2:SetPassEnable(slot0.entity.spineRenderer:getReplaceMat(), "useMulShadow", false)
		end
	end
end

function slot0.removeEffectByEffectName(slot0, slot1)
	for slot5, slot6 in pairs(slot0._playingEffectDict) do
		if slot6.path == FightHelper.getEffectUrlWithLod(slot1) then
			slot0:removeEffect(slot6)

			return
		end
	end
end

function slot0.addServerRelease(slot0, slot1, slot2)
	slot0._serverRelease[slot1] = slot0._serverRelease[slot1] or {}

	table.insert(slot0._serverRelease[slot1], slot2)
end

function slot0._onInvokeFightWorkEffectType(slot0, slot1)
	if slot0._serverRelease[slot1] then
		for slot5, slot6 in ipairs(slot0._serverRelease[slot1]) do
			slot0:removeEffect(slot6)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0.entity.id, slot6)
		end

		slot0._serverRelease[slot1] = nil
	end
end

function slot0.addTokenRelease(slot0, slot1, slot2)
	slot0._tokenRelease[slot1] = slot0._tokenRelease[slot1] or {}

	table.insert(slot0._tokenRelease[slot1], slot2)
end

function slot0._onInvokeTokenRelease(slot0, slot1)
	if slot0._tokenRelease[slot1] then
		for slot5, slot6 in ipairs(slot0._tokenRelease[slot1]) do
			slot0:removeEffect(slot6)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0.entity.id, slot6)
		end

		slot0._tokenRelease[slot1] = nil
	end
end

function slot0.addRoundRelease(slot0, slot1, slot2)
	slot0._roundRelease[slot3] = slot0._roundRelease[slot1 + FightModel.instance:getCurRoundId()] or {}

	table.insert(slot0._roundRelease[slot3], slot2)
end

function slot0._onChangeRound(slot0)
	if slot0._roundRelease[FightModel.instance:getCurRoundId()] then
		for slot5, slot6 in ipairs(slot0._roundRelease[slot1]) do
			slot0:removeEffect(slot6)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0.entity.id, slot6)
		end

		slot0._roundRelease[slot1] = nil
	end
end

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3)
	if slot1:getMO() and slot4:isUniqueSkill(slot2) and slot1.id ~= slot0.entity.id then
		for slot8, slot9 in pairs(slot0._tokenRelease) do
			for slot13, slot14 in ipairs(slot9) do
				slot14:setActive(false, "FightEffectTokenRelease" .. slot3.stepUid)
			end
		end
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot1:getMO() and slot4:isUniqueSkill(slot2) and slot1.id ~= slot0.entity.id then
		for slot8, slot9 in pairs(slot0._tokenRelease) do
			for slot13, slot14 in ipairs(slot9) do
				slot14:setActive(true, "FightEffectTokenRelease" .. slot3.stepUid)
			end
		end
	end
end

function slot0._initSpecialEffectClass(slot0)
	if isTypeOf(slot0.entity, FightEntitySub) then
		return
	end

	if slot0.entity:getMO() then
		if slot0.entity:isEnemySide() and lua_fight_monster_use_character_effect.configDict[slot0.entity:getMO().modelId] and _G["FightEntitySpecialEffect" .. slot1.characterId] then
			slot0:_registSpecialClass(_G[slot2])
		end

		if _G["FightEntitySpecialEffect" .. slot0.entity:getMO().modelId] then
			slot0:_registSpecialClass(_G[slot1])
		end

		slot0:_registSpecialClass(FightEntityCustomSpecialEffect)

		if BossRushController.instance:isInBossRushFight() then
			slot3 = FightModel.instance:getCurMonsterGroupId() and lua_monster_group.configDict[slot2]
			slot4 = slot3 and slot3.bossId

			if slot4 and FightHelper.isBossId(slot4, slot0.entity:getMO().modelId) then
				slot0:_registSpecialClass(FightEntitySpecialEffectBossRush)
			end
		end

		slot0:_registSkinEffect()
	end

	if _G["FightSceneSpecialEffect" .. slot0.entity.id] then
		slot0:_registSpecialClass(_G[slot1])
	end
end

function slot0._registSpecialClass(slot0, slot1)
	table.insert(slot0._specialEffectClass, slot1.New(slot0.entity))
end

function slot0.showSpecialEffects(slot0)
	if slot0._specialEffectClass then
		for slot4, slot5 in ipairs(slot0._specialEffectClass) do
			if slot5.showSpecialEffects then
				slot5:showSpecialEffects()
			end

			if slot5.setEffectActive then
				slot5:setEffectActive(true)
			end
		end
	end
end

function slot0.hideSpecialEffects(slot0)
	for slot4, slot5 in ipairs(slot0._specialEffectClass) do
		if slot5.hideSpecialEffects then
			slot5:hideSpecialEffects()
		end

		if slot5.setEffectActive then
			slot5:setEffectActive(false)
		end
	end
end

function slot0.beforeDestroy(slot0)
	for slot4, slot5 in ipairs(slot0._specialEffectClass) do
		if slot5.disposeSelf then
			slot5:disposeSelf()
		end
	end

	slot0._specialEffectClass = nil
	slot4 = slot0._onSpineLoaded
	slot5 = slot0

	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot4, slot5)
	slot0:_dealTimeEffect()

	for slot4, slot5 in pairs(slot0._playingEffectDict) do
		slot0:removeEffect(slot5)
	end
end

function slot0._dealTimeEffect(slot0)
	slot1 = slot0._release_by_time

	if FightEffectPool.getPoolContainerGO() and slot2.transform then
		for slot7, slot8 in pairs(slot1) do
			if not gohelper.isNil(slot8.containerGO) then
				slot8.containerGO.transform:SetParent(slot3, true)
			end
		end
	end
end

function slot0.getHangEffect(slot0)
	return slot0._hangEffects
end

function slot0.onDestroy(slot0)
	slot0._playingEffectDict = nil
	slot0.cache_effect = nil
	slot0.destroyed = true
end

function slot0.isDestroyed(slot0)
	return slot0.destroyed
end

slot1 = {
	[307303.0] = 307301,
	[307302.0] = 307301
}

function slot0._registSkinEffect(slot0)
	if _G["FightEntitySpecialSkinEffect" .. (uv0[slot0.entity:getMO().skin] or slot0.entity:getMO().skin)] then
		slot0:_registSpecialClass(slot2)
	end
end

return slot0
