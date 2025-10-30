module("modules.logic.fight.entity.comp.FightEffectComp", package.seeall)

local var_0_0 = class("FightEffectComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0.entityId = arg_1_1.id
	arg_1_0._playingEffectDict = {}
	arg_1_0.cache_effect = {}
	arg_1_0._release_by_time = {}
	arg_1_0._serverRelease = {}
	arg_1_0._tokenRelease = {}
	arg_1_0._roundRelease = {}
	arg_1_0._hangEffects = {}
	arg_1_0._followCameraRotation = {}
	arg_1_0._specialEffectClass = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:addEventCb(FightController.instance, FightEvent.InvokeFightWorkEffectType, arg_2_0._onInvokeFightWorkEffectType, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_2_0._onSkillPlayStart, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ChangeRound, arg_2_0._onChangeRound, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_2_0._onSpineLoaded, arg_2_0)

	arg_2_0.go = arg_2_1

	arg_2_0:_initSpecialEffectClass()
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	if arg_3_0._playingEffectDict then
		for iter_3_0, iter_3_1 in pairs(arg_3_0._playingEffectDict) do
			iter_3_1:setActive(arg_3_1)
		end
	end
end

function var_0_0.setTimeScale(arg_4_0, arg_4_1)
	if arg_4_0._playingEffectDict then
		for iter_4_0, iter_4_1 in pairs(arg_4_0._playingEffectDict) do
			iter_4_1:setTimeScale(arg_4_1)
		end
	end
end

function var_0_0.addPlayingEffectWrap(arg_5_0, arg_5_1)
	if arg_5_0._playingEffectDict then
		arg_5_0._playingEffectDict[arg_5_1.uniqueId] = arg_5_1
	end
end

function var_0_0._onSpineLoaded(arg_6_0, arg_6_1)
	if arg_6_1 and arg_6_1.unitSpawn == arg_6_0.entity then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.cache_effect) do
			local var_6_0 = arg_6_0.entity:getHangPoint(iter_6_1.hangPoint)

			iter_6_1.effectWrap:setHangPointGO(var_6_0)

			if iter_6_1.cache_local_position then
				iter_6_1.effectWrap:setLocalPos(iter_6_1.cache_local_position.x, iter_6_1.cache_local_position.y, iter_6_1.cache_local_position.z)
			end
		end

		arg_6_0.cache_effect = {}
	end
end

function var_0_0.playingEffect(arg_7_0, arg_7_1)
	return arg_7_0._playingEffectDict and arg_7_0._playingEffectDict[arg_7_1]
end

function var_0_0.addHangEffect(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	local var_8_0 = FightHelper.getEffectUrlWithLod(arg_8_1)
	local var_8_1 = arg_8_0.entity:getHangPoint(arg_8_2, arg_8_6)
	local var_8_2 = FightEffectPool.getEffect(var_8_0, arg_8_3 or arg_8_0.entity:getSide(), arg_8_0._onEffectLoaded, arg_8_0, var_8_1)

	arg_8_0._playingEffectDict[var_8_2.uniqueId] = var_8_2

	local var_8_3 = AudioEffectMgr.instance:playAudioByEffectPath(var_8_0)

	FightAudioMgr.instance:onDirectPlayAudio(var_8_3)

	if arg_8_0.entity.spine and not arg_8_0.entity.spine:getSpineGO() then
		arg_8_0.cache_effect[var_8_2.uniqueId] = {
			effectWrap = var_8_2,
			hangPoint = arg_8_2,
			cache_local_position = arg_8_5
		}
	end

	if arg_8_4 then
		arg_8_0:_releaseEffectByTime(var_8_2, arg_8_4)
	end

	arg_8_0._hangEffects[var_8_2.uniqueId] = {
		effectWrap = var_8_2,
		hangPoint = arg_8_2
	}

	return var_8_2
end

function var_0_0.addGlobalEffect(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = FightHelper.getEffectUrlWithLod(arg_9_1)
	local var_9_1 = FightEffectPool.getEffect(var_9_0, arg_9_2 or arg_9_0.entity:getSide(), arg_9_0._onEffectLoaded, arg_9_0)

	arg_9_0._playingEffectDict[var_9_1.uniqueId] = var_9_1

	FightEffectPool.returnEffectToPoolContainer(var_9_1)

	local var_9_2 = AudioEffectMgr.instance:playAudioByEffectPath(var_9_0)

	FightAudioMgr.instance:onDirectPlayAudio(var_9_2)

	if arg_9_3 then
		arg_9_0:_releaseEffectByTime(var_9_1, arg_9_3)
	end

	return var_9_1
end

function var_0_0.getEffectWrap(arg_10_0, arg_10_1)
	local var_10_0 = FightHelper.getEffectUrlWithLod(arg_10_1)

	for iter_10_0, iter_10_1 in pairs(arg_10_0._playingEffectDict) do
		if iter_10_1.path == var_10_0 then
			return iter_10_1
		end
	end
end

function var_0_0._releaseEffectByTime(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._release_by_time[arg_11_1.uniqueId] = arg_11_1

	local var_11_0 = arg_11_0.entity.id

	TaskDispatcher.runDelay(function()
		arg_11_0._release_by_time[arg_11_1.uniqueId] = nil

		FightRenderOrderMgr.instance:onRemoveEffectWrap(var_11_0, arg_11_1)
		arg_11_0:removeEffect(arg_11_1)
	end, arg_11_0, arg_11_2)
end

function var_0_0._onEffectLoaded(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_2 then
		return
	end

	local var_13_0 = FightHelper.getEffectLabel(arg_13_1.effectGO, 0)

	if var_13_0 and #var_13_0 >= 1 then
		local var_13_1 = arg_13_0.entity:getMO()

		if var_13_1 then
			local var_13_2 = FightConfig.instance:getSkinCO(var_13_1.skin)

			if var_13_2 and var_13_2.flipX and var_13_2.flipX == 1 then
				transformhelper.setLocalScale(arg_13_1.containerTr, -1, 1, 1)
			end
		end
	end

	arg_13_0:refreshEffectLabel1(arg_13_1)
	FightController.instance:dispatchEvent(FightEvent.EntityEffectLoaded, arg_13_0.entity.id, arg_13_1)
end

function var_0_0.refreshEffectLabel1(arg_14_0, arg_14_1)
	local var_14_0 = FightHelper.getEffectLabel(arg_14_1.effectGO, 1)

	if var_14_0 and #var_14_0 >= 1 then
		local var_14_1 = arg_14_0.entity:getMO()

		if var_14_1 then
			for iter_14_0, iter_14_1 in ipairs(var_14_0) do
				local var_14_2, var_14_3, var_14_4, var_14_5 = FightHelper.getEntityStandPos(var_14_1)

				iter_14_1.standPosX = var_14_2
				iter_14_1.label = 1

				if arg_14_0._followCameraRotation then
					arg_14_0._followCameraRotation[arg_14_1.uniqueId] = true
				end
			end
		end
	end
end

function var_0_0.refreshAllEffectLabel1(arg_15_0)
	if arg_15_0._playingEffectDict then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._playingEffectDict) do
			if arg_15_0._followCameraRotation and arg_15_0._followCameraRotation[iter_15_1.uniqueId] then
				arg_15_0:revertFollowCameraEffectLabel1(iter_15_1)
				arg_15_0:refreshEffectLabel1(iter_15_1)
			end
		end
	end
end

function var_0_0.revertFollowCameraEffectLabel1(arg_16_0, arg_16_1)
	local var_16_0 = FightHelper.getEffectLabel(arg_16_1.effectGO, -1)

	if var_16_0 and #var_16_0 >= 1 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			iter_16_1.label = 1
		end
	end
end

function var_0_0.removeEffect(arg_17_0, arg_17_1)
	if arg_17_0._release_by_time[arg_17_1.uniqueId] then
		return
	end

	if arg_17_0._followCameraRotation then
		arg_17_0:revertFollowCameraEffectLabel1(arg_17_1)

		arg_17_0._followCameraRotation[arg_17_1.uniqueId] = nil
	end

	if arg_17_0._playingEffectDict and arg_17_0._playingEffectDict[arg_17_1.uniqueId] then
		arg_17_0._playingEffectDict[arg_17_1.uniqueId] = nil
	end

	FightEffectPool.returnEffectToPoolContainer(arg_17_1)
	FightEffectPool.returnEffect(arg_17_1)

	if arg_17_0.cache_effect then
		arg_17_0.cache_effect[arg_17_1.uniqueId] = nil
	end

	if arg_17_0._hangEffects then
		arg_17_0._hangEffects[arg_17_1.uniqueId] = nil
	end

	arg_17_0:_checkDisableEffectLabel(arg_17_1)
end

function var_0_0._checkDisableEffectLabel(arg_18_0, arg_18_1)
	if arg_18_0._effectWrap4EffectLabel == arg_18_1 then
		arg_18_0._effectWrap4EffectLabel = nil

		local var_18_0 = arg_18_0.entity.spine and arg_18_0.entity.spine:getPPEffectMask()

		if var_18_0 then
			var_18_0.partMat = nil

			var_18_0:SetPassEnable(arg_18_0.entity.spineRenderer:getReplaceMat(), "useMulShadow", false)
		end
	end
end

function var_0_0.removeEffectByEffectName(arg_19_0, arg_19_1)
	arg_19_1 = FightHelper.getEffectUrlWithLod(arg_19_1)

	for iter_19_0, iter_19_1 in pairs(arg_19_0._playingEffectDict) do
		if iter_19_1.path == arg_19_1 then
			arg_19_0:removeEffect(iter_19_1)

			return
		end
	end
end

function var_0_0.addServerRelease(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._serverRelease[arg_20_1] = arg_20_0._serverRelease[arg_20_1] or {}

	table.insert(arg_20_0._serverRelease[arg_20_1], arg_20_2)
end

function var_0_0._onInvokeFightWorkEffectType(arg_21_0, arg_21_1)
	if arg_21_0._serverRelease[arg_21_1] then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._serverRelease[arg_21_1]) do
			arg_21_0:removeEffect(iter_21_1)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_21_0.entity.id, iter_21_1)
		end

		arg_21_0._serverRelease[arg_21_1] = nil
	end
end

function var_0_0.addTokenRelease(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._tokenRelease[arg_22_1] = arg_22_0._tokenRelease[arg_22_1] or {}

	table.insert(arg_22_0._tokenRelease[arg_22_1], arg_22_2)
end

function var_0_0._onInvokeTokenRelease(arg_23_0, arg_23_1)
	if arg_23_0._tokenRelease[arg_23_1] then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0._tokenRelease[arg_23_1]) do
			arg_23_0:removeEffect(iter_23_1)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_23_0.entity.id, iter_23_1)
		end

		arg_23_0._tokenRelease[arg_23_1] = nil
	end
end

function var_0_0.addRoundRelease(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1 + FightModel.instance:getCurRoundId()

	arg_24_0._roundRelease[var_24_0] = arg_24_0._roundRelease[var_24_0] or {}

	table.insert(arg_24_0._roundRelease[var_24_0], arg_24_2)
end

function var_0_0._onChangeRound(arg_25_0)
	local var_25_0 = FightModel.instance:getCurRoundId()

	if arg_25_0._roundRelease[var_25_0] then
		for iter_25_0, iter_25_1 in ipairs(arg_25_0._roundRelease[var_25_0]) do
			arg_25_0:removeEffect(iter_25_1)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_25_0.entity.id, iter_25_1)
		end

		arg_25_0._roundRelease[var_25_0] = nil
	end
end

function var_0_0._onSkillPlayStart(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if arg_26_1:getMO() and FightCardDataHelper.isBigSkill(arg_26_2) and arg_26_1.id ~= arg_26_0.entity.id then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._tokenRelease) do
			for iter_26_2, iter_26_3 in ipairs(iter_26_1) do
				iter_26_3:setActive(false, "FightEffectTokenRelease" .. arg_26_3.stepUid)
			end
		end
	end
end

function var_0_0._onSkillPlayFinish(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_1:getMO() and FightCardDataHelper.isBigSkill(arg_27_2) and arg_27_1.id ~= arg_27_0.entity.id then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._tokenRelease) do
			for iter_27_2, iter_27_3 in ipairs(iter_27_1) do
				iter_27_3:setActive(true, "FightEffectTokenRelease" .. arg_27_3.stepUid)
			end
		end
	end
end

function var_0_0._initSpecialEffectClass(arg_28_0)
	if isTypeOf(arg_28_0.entity, FightEntitySub) then
		return
	end

	if arg_28_0.entity:getMO() then
		if arg_28_0.entity:isEnemySide() then
			local var_28_0 = lua_fight_monster_use_character_effect.configDict[arg_28_0.entity:getMO().modelId]

			if var_28_0 then
				local var_28_1 = "FightEntitySpecialEffect" .. var_28_0.characterId

				if _G[var_28_1] then
					arg_28_0:_registSpecialClass(_G[var_28_1])
				end
			end
		end

		local var_28_2 = "FightEntitySpecialEffect" .. arg_28_0.entity:getMO().modelId

		if _G[var_28_2] then
			arg_28_0:_registSpecialClass(_G[var_28_2])
		end

		arg_28_0:_registSpecialClass(FightEntityCustomSpecialEffect)

		if BossRushController.instance:isInBossRushFight() then
			local var_28_3 = FightModel.instance:getCurMonsterGroupId()
			local var_28_4 = var_28_3 and lua_monster_group.configDict[var_28_3]
			local var_28_5 = var_28_4 and var_28_4.bossId

			if var_28_5 and FightHelper.isBossId(var_28_5, arg_28_0.entity:getMO().modelId) then
				arg_28_0:_registSpecialClass(FightEntitySpecialEffectBossRush)
			end
		end

		arg_28_0:_registSkinEffect()
	end

	local var_28_6 = "FightSceneSpecialEffect" .. arg_28_0.entity.id

	if _G[var_28_6] then
		arg_28_0:_registSpecialClass(_G[var_28_6])
	end
end

function var_0_0._registSpecialClass(arg_29_0, arg_29_1)
	table.insert(arg_29_0._specialEffectClass, arg_29_1.New(arg_29_0.entity))
end

function var_0_0.showSpecialEffects(arg_30_0)
	if arg_30_0._specialEffectClass then
		for iter_30_0, iter_30_1 in ipairs(arg_30_0._specialEffectClass) do
			if iter_30_1.showSpecialEffects then
				iter_30_1:showSpecialEffects()
			end

			if iter_30_1.setEffectActive then
				iter_30_1:setEffectActive(true)
			end
		end
	end
end

function var_0_0.hideSpecialEffects(arg_31_0)
	for iter_31_0, iter_31_1 in ipairs(arg_31_0._specialEffectClass) do
		if iter_31_1.hideSpecialEffects then
			iter_31_1:hideSpecialEffects()
		end

		if iter_31_1.setEffectActive then
			iter_31_1:setEffectActive(false)
		end
	end
end

function var_0_0.beforeDestroy(arg_32_0)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0._specialEffectClass) do
		if iter_32_1.disposeSelf then
			iter_32_1:disposeSelf()
		end
	end

	arg_32_0._specialEffectClass = nil

	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_32_0._onSpineLoaded, arg_32_0)
	arg_32_0:_dealTimeEffect()

	for iter_32_2, iter_32_3 in pairs(arg_32_0._playingEffectDict) do
		arg_32_0:removeEffect(iter_32_3)
	end
end

function var_0_0._dealTimeEffect(arg_33_0)
	local var_33_0 = arg_33_0._release_by_time
	local var_33_1 = FightEffectPool.getPoolContainerGO()
	local var_33_2 = var_33_1 and var_33_1.transform

	if var_33_2 then
		for iter_33_0, iter_33_1 in pairs(var_33_0) do
			if not gohelper.isNil(iter_33_1.containerGO) then
				iter_33_1.containerGO.transform:SetParent(var_33_2, true)
			end
		end
	end
end

function var_0_0.getHangEffect(arg_34_0)
	return arg_34_0._hangEffects
end

function var_0_0.onDestroy(arg_35_0)
	arg_35_0._playingEffectDict = nil
	arg_35_0.cache_effect = nil
	arg_35_0.destroyed = true
end

function var_0_0.isDestroyed(arg_36_0)
	return arg_36_0.destroyed
end

local var_0_1 = {
	[307303] = 307301,
	[307302] = 307301
}

function var_0_0._registSkinEffect(arg_37_0)
	local var_37_0 = var_0_1[arg_37_0.entity:getMO().skin] or arg_37_0.entity:getMO().skin
	local var_37_1 = _G["FightEntitySpecialSkinEffect" .. var_37_0]

	if var_37_1 then
		arg_37_0:_registSpecialClass(var_37_1)
	end
end

function var_0_0._onBuffUpdate(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4, arg_38_5, arg_38_6)
	arg_38_0:handleCommonBuffEffect(arg_38_1, arg_38_2, arg_38_3, arg_38_4, arg_38_5, arg_38_6)
end

function var_0_0.handleCommonBuffEffect(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5, arg_39_6)
	if arg_39_1 ~= arg_39_0.entityId then
		return
	end

	if arg_39_2 ~= FightEnum.EffectType.BUFFADD then
		return
	end

	local var_39_0 = fight_common_buff_effect_2_skin.configDict[arg_39_3]

	if not var_39_0 then
		return
	end

	var_39_0 = var_39_0[arg_39_0.entity:getMO().originSkin] or var_39_0[0]

	if not var_39_0 then
		return
	end

	local var_39_1 = var_39_0.duration

	if var_39_1 <= 0 then
		var_39_1 = 2
	end

	local var_39_2 = arg_39_0:addHangEffect(var_39_0.effectPath, var_39_0.effectHang, nil, var_39_1 / FightModel.instance:getSpeed())

	FightRenderOrderMgr.instance:onAddEffectWrap(arg_39_0.entityId, var_39_2)
	var_39_2:setLocalPos(0, 0, 0)

	local var_39_3 = var_39_0.audio

	if var_39_3 ~= 0 then
		AudioMgr.instance:trigger(var_39_3)
	end
end

return var_0_0
