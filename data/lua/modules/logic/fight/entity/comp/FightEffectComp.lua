module("modules.logic.fight.entity.comp.FightEffectComp", package.seeall)

local var_0_0 = class("FightEffectComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
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

function var_0_0.addHangEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	local var_7_0 = FightHelper.getEffectUrlWithLod(arg_7_1)
	local var_7_1 = arg_7_0.entity:getHangPoint(arg_7_2, arg_7_6)
	local var_7_2 = FightEffectPool.getEffect(var_7_0, arg_7_3 or arg_7_0.entity:getSide(), arg_7_0._onEffectLoaded, arg_7_0, var_7_1)

	arg_7_0._playingEffectDict[var_7_2.uniqueId] = var_7_2

	local var_7_3 = AudioEffectMgr.instance:playAudioByEffectPath(var_7_0)

	FightAudioMgr.instance:onDirectPlayAudio(var_7_3)

	if arg_7_0.entity.spine and not arg_7_0.entity.spine:getSpineGO() then
		arg_7_0.cache_effect[var_7_2.uniqueId] = {
			effectWrap = var_7_2,
			hangPoint = arg_7_2,
			cache_local_position = arg_7_5
		}
	end

	if arg_7_4 then
		arg_7_0:_releaseEffectByTime(var_7_2, arg_7_4)
	end

	arg_7_0._hangEffects[var_7_2.uniqueId] = {
		effectWrap = var_7_2,
		hangPoint = arg_7_2
	}

	return var_7_2
end

function var_0_0.addGlobalEffect(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = FightHelper.getEffectUrlWithLod(arg_8_1)
	local var_8_1 = FightEffectPool.getEffect(var_8_0, arg_8_2 or arg_8_0.entity:getSide(), arg_8_0._onEffectLoaded, arg_8_0)

	arg_8_0._playingEffectDict[var_8_1.uniqueId] = var_8_1

	FightEffectPool.returnEffectToPoolContainer(var_8_1)

	local var_8_2 = AudioEffectMgr.instance:playAudioByEffectPath(var_8_0)

	FightAudioMgr.instance:onDirectPlayAudio(var_8_2)

	if arg_8_3 then
		arg_8_0:_releaseEffectByTime(var_8_1, arg_8_3)
	end

	return var_8_1
end

function var_0_0.getEffectWrap(arg_9_0, arg_9_1)
	local var_9_0 = FightHelper.getEffectUrlWithLod(arg_9_1)

	for iter_9_0, iter_9_1 in pairs(arg_9_0._playingEffectDict) do
		if iter_9_1.path == var_9_0 then
			return iter_9_1
		end
	end
end

function var_0_0._releaseEffectByTime(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._release_by_time[arg_10_1.uniqueId] = arg_10_1

	local var_10_0 = arg_10_0.entity.id

	TaskDispatcher.runDelay(function()
		arg_10_0._release_by_time[arg_10_1.uniqueId] = nil

		FightRenderOrderMgr.instance:onRemoveEffectWrap(var_10_0, arg_10_1)
		arg_10_0:removeEffect(arg_10_1)
	end, arg_10_0, arg_10_2)
end

function var_0_0._onEffectLoaded(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_2 then
		return
	end

	local var_12_0 = FightHelper.getEffectLabel(arg_12_1.effectGO, 0)

	if var_12_0 and #var_12_0 >= 1 then
		local var_12_1 = arg_12_0.entity:getMO()

		if var_12_1 then
			local var_12_2 = FightConfig.instance:getSkinCO(var_12_1.skin)

			if var_12_2 and var_12_2.flipX and var_12_2.flipX == 1 then
				transformhelper.setLocalScale(arg_12_1.containerTr, -1, 1, 1)
			end
		end
	end

	arg_12_0:refreshEffectLabel1(arg_12_1)
	FightController.instance:dispatchEvent(FightEvent.EntityEffectLoaded, arg_12_0.entity.id, arg_12_1)
end

function var_0_0.refreshEffectLabel1(arg_13_0, arg_13_1)
	local var_13_0 = FightHelper.getEffectLabel(arg_13_1.effectGO, 1)

	if var_13_0 and #var_13_0 >= 1 then
		local var_13_1 = arg_13_0.entity:getMO()

		if var_13_1 then
			for iter_13_0, iter_13_1 in ipairs(var_13_0) do
				local var_13_2, var_13_3, var_13_4, var_13_5 = FightHelper.getEntityStandPos(var_13_1)

				iter_13_1.standPosX = var_13_2
				iter_13_1.label = 1

				if arg_13_0._followCameraRotation then
					arg_13_0._followCameraRotation[arg_13_1.uniqueId] = true
				end
			end
		end
	end
end

function var_0_0.refreshAllEffectLabel1(arg_14_0)
	if arg_14_0._playingEffectDict then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._playingEffectDict) do
			if arg_14_0._followCameraRotation and arg_14_0._followCameraRotation[iter_14_1.uniqueId] then
				arg_14_0:revertFollowCameraEffectLabel1(iter_14_1)
				arg_14_0:refreshEffectLabel1(iter_14_1)
			end
		end
	end
end

function var_0_0.revertFollowCameraEffectLabel1(arg_15_0, arg_15_1)
	local var_15_0 = FightHelper.getEffectLabel(arg_15_1.effectGO, -1)

	if var_15_0 and #var_15_0 >= 1 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			iter_15_1.label = 1
		end
	end
end

function var_0_0.removeEffect(arg_16_0, arg_16_1)
	if arg_16_0._release_by_time[arg_16_1.uniqueId] then
		return
	end

	if arg_16_0._followCameraRotation then
		arg_16_0:revertFollowCameraEffectLabel1(arg_16_1)

		arg_16_0._followCameraRotation[arg_16_1.uniqueId] = nil
	end

	if arg_16_0._playingEffectDict and arg_16_0._playingEffectDict[arg_16_1.uniqueId] then
		arg_16_0._playingEffectDict[arg_16_1.uniqueId] = nil
	end

	FightEffectPool.returnEffectToPoolContainer(arg_16_1)
	FightEffectPool.returnEffect(arg_16_1)

	if arg_16_0.cache_effect then
		arg_16_0.cache_effect[arg_16_1.uniqueId] = nil
	end

	if arg_16_0._hangEffects then
		arg_16_0._hangEffects[arg_16_1.uniqueId] = nil
	end

	arg_16_0:_checkDisableEffectLabel(arg_16_1)
end

function var_0_0._checkDisableEffectLabel(arg_17_0, arg_17_1)
	if arg_17_0._effectWrap4EffectLabel == arg_17_1 then
		arg_17_0._effectWrap4EffectLabel = nil

		local var_17_0 = arg_17_0.entity.spine and arg_17_0.entity.spine:getPPEffectMask()

		if var_17_0 then
			var_17_0.partMat = nil

			var_17_0:SetPassEnable(arg_17_0.entity.spineRenderer:getReplaceMat(), "useMulShadow", false)
		end
	end
end

function var_0_0.removeEffectByEffectName(arg_18_0, arg_18_1)
	arg_18_1 = FightHelper.getEffectUrlWithLod(arg_18_1)

	for iter_18_0, iter_18_1 in pairs(arg_18_0._playingEffectDict) do
		if iter_18_1.path == arg_18_1 then
			arg_18_0:removeEffect(iter_18_1)

			return
		end
	end
end

function var_0_0.addServerRelease(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._serverRelease[arg_19_1] = arg_19_0._serverRelease[arg_19_1] or {}

	table.insert(arg_19_0._serverRelease[arg_19_1], arg_19_2)
end

function var_0_0._onInvokeFightWorkEffectType(arg_20_0, arg_20_1)
	if arg_20_0._serverRelease[arg_20_1] then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._serverRelease[arg_20_1]) do
			arg_20_0:removeEffect(iter_20_1)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_20_0.entity.id, iter_20_1)
		end

		arg_20_0._serverRelease[arg_20_1] = nil
	end
end

function var_0_0.addTokenRelease(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._tokenRelease[arg_21_1] = arg_21_0._tokenRelease[arg_21_1] or {}

	table.insert(arg_21_0._tokenRelease[arg_21_1], arg_21_2)
end

function var_0_0._onInvokeTokenRelease(arg_22_0, arg_22_1)
	if arg_22_0._tokenRelease[arg_22_1] then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._tokenRelease[arg_22_1]) do
			arg_22_0:removeEffect(iter_22_1)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_22_0.entity.id, iter_22_1)
		end

		arg_22_0._tokenRelease[arg_22_1] = nil
	end
end

function var_0_0.addRoundRelease(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1 + FightModel.instance:getCurRoundId()

	arg_23_0._roundRelease[var_23_0] = arg_23_0._roundRelease[var_23_0] or {}

	table.insert(arg_23_0._roundRelease[var_23_0], arg_23_2)
end

function var_0_0._onChangeRound(arg_24_0)
	local var_24_0 = FightModel.instance:getCurRoundId()

	if arg_24_0._roundRelease[var_24_0] then
		for iter_24_0, iter_24_1 in ipairs(arg_24_0._roundRelease[var_24_0]) do
			arg_24_0:removeEffect(iter_24_1)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_24_0.entity.id, iter_24_1)
		end

		arg_24_0._roundRelease[var_24_0] = nil
	end
end

function var_0_0._onSkillPlayStart(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_1:getMO()

	if var_25_0 and var_25_0:isUniqueSkill(arg_25_2) and arg_25_1.id ~= arg_25_0.entity.id then
		for iter_25_0, iter_25_1 in pairs(arg_25_0._tokenRelease) do
			for iter_25_2, iter_25_3 in ipairs(iter_25_1) do
				iter_25_3:setActive(false, "FightEffectTokenRelease" .. arg_25_3.stepUid)
			end
		end
	end
end

function var_0_0._onSkillPlayFinish(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_1:getMO()

	if var_26_0 and var_26_0:isUniqueSkill(arg_26_2) and arg_26_1.id ~= arg_26_0.entity.id then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._tokenRelease) do
			for iter_26_2, iter_26_3 in ipairs(iter_26_1) do
				iter_26_3:setActive(true, "FightEffectTokenRelease" .. arg_26_3.stepUid)
			end
		end
	end
end

function var_0_0._initSpecialEffectClass(arg_27_0)
	if isTypeOf(arg_27_0.entity, FightEntitySub) then
		return
	end

	if arg_27_0.entity:getMO() then
		if arg_27_0.entity:isEnemySide() then
			local var_27_0 = lua_fight_monster_use_character_effect.configDict[arg_27_0.entity:getMO().modelId]

			if var_27_0 then
				local var_27_1 = "FightEntitySpecialEffect" .. var_27_0.characterId

				if _G[var_27_1] then
					arg_27_0:_registSpecialClass(_G[var_27_1])
				end
			end
		end

		local var_27_2 = "FightEntitySpecialEffect" .. arg_27_0.entity:getMO().modelId

		if _G[var_27_2] then
			arg_27_0:_registSpecialClass(_G[var_27_2])
		end

		arg_27_0:_registSpecialClass(FightEntityCustomSpecialEffect)

		if BossRushController.instance:isInBossRushFight() then
			local var_27_3 = FightModel.instance:getCurMonsterGroupId()
			local var_27_4 = var_27_3 and lua_monster_group.configDict[var_27_3]
			local var_27_5 = var_27_4 and var_27_4.bossId

			if var_27_5 and FightHelper.isBossId(var_27_5, arg_27_0.entity:getMO().modelId) then
				arg_27_0:_registSpecialClass(FightEntitySpecialEffectBossRush)
			end
		end

		arg_27_0:_registSkinEffect()
	end

	local var_27_6 = "FightSceneSpecialEffect" .. arg_27_0.entity.id

	if _G[var_27_6] then
		arg_27_0:_registSpecialClass(_G[var_27_6])
	end
end

function var_0_0._registSpecialClass(arg_28_0, arg_28_1)
	table.insert(arg_28_0._specialEffectClass, arg_28_1.New(arg_28_0.entity))
end

function var_0_0.showSpecialEffects(arg_29_0)
	if arg_29_0._specialEffectClass then
		for iter_29_0, iter_29_1 in ipairs(arg_29_0._specialEffectClass) do
			if iter_29_1.showSpecialEffects then
				iter_29_1:showSpecialEffects()
			end

			if iter_29_1.setEffectActive then
				iter_29_1:setEffectActive(true)
			end
		end
	end
end

function var_0_0.hideSpecialEffects(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0._specialEffectClass) do
		if iter_30_1.hideSpecialEffects then
			iter_30_1:hideSpecialEffects()
		end

		if iter_30_1.setEffectActive then
			iter_30_1:setEffectActive(false)
		end
	end
end

function var_0_0.beforeDestroy(arg_31_0)
	for iter_31_0, iter_31_1 in ipairs(arg_31_0._specialEffectClass) do
		if iter_31_1.disposeSelf then
			iter_31_1:disposeSelf()
		end
	end

	arg_31_0._specialEffectClass = nil

	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_31_0._onSpineLoaded, arg_31_0)
	arg_31_0:_dealTimeEffect()

	for iter_31_2, iter_31_3 in pairs(arg_31_0._playingEffectDict) do
		arg_31_0:removeEffect(iter_31_3)
	end
end

function var_0_0._dealTimeEffect(arg_32_0)
	local var_32_0 = arg_32_0._release_by_time
	local var_32_1 = FightEffectPool.getPoolContainerGO()
	local var_32_2 = var_32_1 and var_32_1.transform

	if var_32_2 then
		for iter_32_0, iter_32_1 in pairs(var_32_0) do
			if not gohelper.isNil(iter_32_1.containerGO) then
				iter_32_1.containerGO.transform:SetParent(var_32_2, true)
			end
		end
	end
end

function var_0_0.getHangEffect(arg_33_0)
	return arg_33_0._hangEffects
end

function var_0_0.onDestroy(arg_34_0)
	arg_34_0._playingEffectDict = nil
	arg_34_0.cache_effect = nil
	arg_34_0.destroyed = true
end

function var_0_0.isDestroyed(arg_35_0)
	return arg_35_0.destroyed
end

local var_0_1 = {
	[307303] = 307301,
	[307302] = 307301
}

function var_0_0._registSkinEffect(arg_36_0)
	local var_36_0 = var_0_1[arg_36_0.entity:getMO().skin] or arg_36_0.entity:getMO().skin
	local var_36_1 = _G["FightEntitySpecialSkinEffect" .. var_36_0]

	if var_36_1 then
		arg_36_0:_registSpecialClass(var_36_1)
	end
end

return var_0_0
