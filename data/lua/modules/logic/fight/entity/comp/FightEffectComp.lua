-- chunkname: @modules/logic/fight/entity/comp/FightEffectComp.lua

module("modules.logic.fight.entity.comp.FightEffectComp", package.seeall)

local FightEffectComp = class("FightEffectComp", LuaCompBase)

function FightEffectComp:ctor(entity)
	self.entity = entity
	self.entityId = entity.id
	self._playingEffectDict = {}
	self.cache_effect = {}
	self._release_by_time = {}
	self._serverRelease = {}
	self._tokenRelease = {}
	self._roundRelease = {}
	self._hangEffects = {}
	self._followCameraRotation = {}
	self._specialEffectClass = {}
end

function FightEffectComp:init(go)
	self:addEventCb(FightController.instance, FightEvent.InvokeFightWorkEffectType, self._onInvokeFightWorkEffectType, self)
	self:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	self:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	self:addEventCb(FightController.instance, FightEvent.ChangeRound, self._onChangeRound, self)
	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)

	self.go = go

	self:_initSpecialEffectClass()
end

function FightEffectComp:setActive(isActive)
	if self._playingEffectDict then
		for _, effectWrap in pairs(self._playingEffectDict) do
			effectWrap:setActive(isActive)
		end
	end
end

function FightEffectComp:setTimeScale(timeScale)
	if self._playingEffectDict then
		for _, effectWrap in pairs(self._playingEffectDict) do
			effectWrap:setTimeScale(timeScale)
		end
	end
end

function FightEffectComp:addPlayingEffectWrap(effectWrap)
	if self._playingEffectDict then
		self._playingEffectDict[effectWrap.uniqueId] = effectWrap
	end
end

function FightEffectComp:_onSpineLoaded(tar_spine)
	if tar_spine and tar_spine.unitSpawn == self.entity then
		for k, v in pairs(self.cache_effect) do
			local hangPointGO = self.entity:getHangPoint(v.hangPoint)

			v.effectWrap:setHangPointGO(hangPointGO)

			if v.cache_local_position then
				v.effectWrap:setLocalPos(v.cache_local_position.x, v.cache_local_position.y, v.cache_local_position.z)
			end
		end

		self.cache_effect = {}
	end
end

function FightEffectComp:playingEffect(uniqueId)
	return self._playingEffectDict and self._playingEffectDict[uniqueId]
end

function FightEffectComp:addHangEffect(effectName, hangPoint, side, release_time, cache_local_position, noProcess)
	local effectFullPath = FightHelper.getEffectUrlWithLod(effectName)
	local hangPointGO = self.entity:getHangPoint(hangPoint, noProcess)
	local effectWrap = FightEffectPool.getEffect(effectFullPath, side or self.entity:getSide(), self._onEffectLoaded, self, hangPointGO)

	self._playingEffectDict[effectWrap.uniqueId] = effectWrap

	local audioId = AudioEffectMgr.instance:playAudioByEffectPath(effectFullPath)

	FightAudioMgr.instance:onDirectPlayAudio(audioId)

	if self.entity.spine and not self.entity.spine:getSpineGO() then
		self.cache_effect[effectWrap.uniqueId] = {
			effectWrap = effectWrap,
			hangPoint = hangPoint,
			cache_local_position = cache_local_position
		}
	end

	if release_time then
		self:_releaseEffectByTime(effectWrap, release_time)
	end

	self._hangEffects[effectWrap.uniqueId] = {
		effectWrap = effectWrap,
		hangPoint = hangPoint
	}

	return effectWrap
end

function FightEffectComp:addGlobalEffect(effectName, side, release_time)
	local effectFullPath = FightHelper.getEffectUrlWithLod(effectName)
	local effectWrap = FightEffectPool.getEffect(effectFullPath, side or self.entity:getSide(), self._onEffectLoaded, self)

	self._playingEffectDict[effectWrap.uniqueId] = effectWrap

	FightEffectPool.returnEffectToPoolContainer(effectWrap)

	local audioId = AudioEffectMgr.instance:playAudioByEffectPath(effectFullPath)

	FightAudioMgr.instance:onDirectPlayAudio(audioId)

	if release_time then
		self:_releaseEffectByTime(effectWrap, release_time)
	end

	return effectWrap
end

function FightEffectComp:getEffectWrap(effectName)
	local effectFullPath = FightHelper.getEffectUrlWithLod(effectName)

	for _, effectWrap in pairs(self._playingEffectDict) do
		if effectWrap.path == effectFullPath then
			return effectWrap
		end
	end
end

function FightEffectComp:_releaseEffectByTime(effectWrap, release_time)
	self._release_by_time[effectWrap.uniqueId] = effectWrap

	local entity_id = self.entity.id

	TaskDispatcher.runDelay(function()
		self._release_by_time[effectWrap.uniqueId] = nil

		FightRenderOrderMgr.instance:onRemoveEffectWrap(entity_id, effectWrap)
		self:removeEffect(effectWrap)
	end, self, release_time)
end

function FightEffectComp:_onEffectLoaded(effectWrap, success)
	if not success then
		return
	end

	local effectLabelComps = FightHelper.getEffectLabel(effectWrap.effectGO, 0)

	if effectLabelComps and #effectLabelComps >= 1 then
		local entityMO = self.entity:getMO()

		if entityMO then
			local skinCO = FightConfig.instance:getSkinCO(entityMO.skin)

			if skinCO and skinCO.flipX and skinCO.flipX == 1 then
				transformhelper.setLocalScale(effectWrap.containerTr, -1, 1, 1)
			end
		end
	end

	self:refreshEffectLabel1(effectWrap)
	FightController.instance:dispatchEvent(FightEvent.EntityEffectLoaded, self.entity.id, effectWrap)
end

function FightEffectComp:refreshEffectLabel1(effectWrap)
	local effectLabelComps2 = FightHelper.getEffectLabel(effectWrap.effectGO, 1)

	if effectLabelComps2 and #effectLabelComps2 >= 1 then
		local entityMO = self.entity:getMO()

		if entityMO then
			for _, effectLabel in ipairs(effectLabelComps2) do
				local x, y, z, scale = FightHelper.getEntityStandPos(entityMO)

				effectLabel.standPosX = x
				effectLabel.label = 1

				if self._followCameraRotation then
					self._followCameraRotation[effectWrap.uniqueId] = true
				end
			end
		end
	end
end

function FightEffectComp:refreshAllEffectLabel1()
	if self._playingEffectDict then
		for _, effectWrap in pairs(self._playingEffectDict) do
			if self._followCameraRotation and self._followCameraRotation[effectWrap.uniqueId] then
				self:revertFollowCameraEffectLabel1(effectWrap)
				self:refreshEffectLabel1(effectWrap)
			end
		end
	end
end

function FightEffectComp:revertFollowCameraEffectLabel1(effectWrap)
	local effectLabelComps2 = FightHelper.getEffectLabel(effectWrap.effectGO, -1)

	if effectLabelComps2 and #effectLabelComps2 >= 1 then
		for i, effectLabel in ipairs(effectLabelComps2) do
			effectLabel.label = 1
		end
	end
end

function FightEffectComp:removeEffect(effectWrap)
	if self._release_by_time[effectWrap.uniqueId] then
		return
	end

	if self._followCameraRotation then
		self:revertFollowCameraEffectLabel1(effectWrap)

		self._followCameraRotation[effectWrap.uniqueId] = nil
	end

	if self._playingEffectDict and self._playingEffectDict[effectWrap.uniqueId] then
		self._playingEffectDict[effectWrap.uniqueId] = nil
	end

	FightEffectPool.returnEffectToPoolContainer(effectWrap)
	FightEffectPool.returnEffect(effectWrap)

	if self.cache_effect then
		self.cache_effect[effectWrap.uniqueId] = nil
	end

	if self._hangEffects then
		self._hangEffects[effectWrap.uniqueId] = nil
	end

	self:_checkDisableEffectLabel(effectWrap)
end

function FightEffectComp:_checkDisableEffectLabel(effectWrap)
	if self._effectWrap4EffectLabel == effectWrap then
		self._effectWrap4EffectLabel = nil

		local ppEffectMask = self.entity.spine and self.entity.spine:getPPEffectMask()

		if ppEffectMask then
			ppEffectMask.partMat = nil

			ppEffectMask:SetPassEnable(self.entity.spineRenderer:getReplaceMat(), "useMulShadow", false)
		end
	end
end

function FightEffectComp:removeEffectByEffectName(effectName)
	effectName = FightHelper.getEffectUrlWithLod(effectName)

	for k, v in pairs(self._playingEffectDict) do
		if v.path == effectName then
			self:removeEffect(v)

			return
		end
	end
end

function FightEffectComp:addServerRelease(effectType, effectWrap)
	self._serverRelease[effectType] = self._serverRelease[effectType] or {}

	table.insert(self._serverRelease[effectType], effectWrap)
end

function FightEffectComp:_onInvokeFightWorkEffectType(effectType)
	if self._serverRelease[effectType] then
		for i, effectWrap in ipairs(self._serverRelease[effectType]) do
			self:removeEffect(effectWrap)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, effectWrap)
		end

		self._serverRelease[effectType] = nil
	end
end

function FightEffectComp:addTokenRelease(token, effectWrap)
	self._tokenRelease[token] = self._tokenRelease[token] or {}

	table.insert(self._tokenRelease[token], effectWrap)
end

function FightEffectComp:_onInvokeTokenRelease(token)
	if self._tokenRelease[token] then
		for i, effectWrap in ipairs(self._tokenRelease[token]) do
			self:removeEffect(effectWrap)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, effectWrap)
		end

		self._tokenRelease[token] = nil
	end
end

function FightEffectComp:addRoundRelease(roundOffset, effectWrap)
	local releaseRound = roundOffset + FightModel.instance:getCurRoundId()

	self._roundRelease[releaseRound] = self._roundRelease[releaseRound] or {}

	table.insert(self._roundRelease[releaseRound], effectWrap)
end

function FightEffectComp:_onChangeRound()
	local curRound = FightModel.instance:getCurRoundId()

	if self._roundRelease[curRound] then
		for i, effectWrap in ipairs(self._roundRelease[curRound]) do
			self:removeEffect(effectWrap)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, effectWrap)
		end

		self._roundRelease[curRound] = nil
	end
end

function FightEffectComp:_onSkillPlayStart(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and entity.id ~= self.entity.id then
		for k, list in pairs(self._tokenRelease) do
			for index, effect in ipairs(list) do
				effect:setActive(false, "FightEffectTokenRelease" .. fightStepData.stepUid)
			end
		end
	end
end

function FightEffectComp:_onSkillPlayFinish(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and entity.id ~= self.entity.id then
		for k, list in pairs(self._tokenRelease) do
			for index, effect in ipairs(list) do
				effect:setActive(true, "FightEffectTokenRelease" .. fightStepData.stepUid)
			end
		end
	end
end

function FightEffectComp:_initSpecialEffectClass()
	if isTypeOf(self.entity, FightEntitySub) then
		return
	end

	if self.entity:getMO() then
		if self.entity:isEnemySide() then
			local config = lua_fight_monster_use_character_effect.configDict[self.entity:getMO().modelId]

			if config then
				local className = "FightEntitySpecialEffect" .. config.characterId

				if _G[className] then
					self:_registSpecialClass(_G[className])
				end
			end
		end

		local specialClassName = "FightEntitySpecialEffect" .. self.entity:getMO().modelId

		if _G[specialClassName] then
			self:_registSpecialClass(_G[specialClassName])
		end

		self:_registSpecialClass(FightEntityCustomSpecialEffect)

		if BossRushController.instance:isInBossRushFight() then
			local monsterGroupId = FightModel.instance:getCurMonsterGroupId()
			local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
			local bossIds = monsterGroupCO and monsterGroupCO.bossId
			local isBoss = bossIds and FightHelper.isBossId(bossIds, self.entity:getMO().modelId)

			if isBoss then
				self:_registSpecialClass(FightEntitySpecialEffectBossRush)
			end
		end

		self:_registSkinEffect()
	end

	local sceneSpecialEffect = "FightSceneSpecialEffect" .. self.entity.id

	if _G[sceneSpecialEffect] then
		self:_registSpecialClass(_G[sceneSpecialEffect])
	end
end

function FightEffectComp:_registSpecialClass(class)
	table.insert(self._specialEffectClass, class.New(self.entity))
end

function FightEffectComp:showSpecialEffects()
	if self._specialEffectClass then
		for _, special in ipairs(self._specialEffectClass) do
			if special.showSpecialEffects then
				special:showSpecialEffects()
			end

			if special.setEffectActive then
				special:setEffectActive(true)
			end
		end
	end
end

function FightEffectComp:hideSpecialEffects()
	for _, special in ipairs(self._specialEffectClass) do
		if special.hideSpecialEffects then
			special:hideSpecialEffects()
		end

		if special.setEffectActive then
			special:setEffectActive(false)
		end
	end
end

function FightEffectComp:beforeDestroy()
	for i, v in ipairs(self._specialEffectClass) do
		if v.disposeSelf then
			v:disposeSelf()
		end
	end

	self._specialEffectClass = nil

	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	self:_dealTimeEffect()

	for _, effectWrap in pairs(self._playingEffectDict) do
		self:removeEffect(effectWrap)
	end
end

function FightEffectComp:_dealTimeEffect()
	local tab = self._release_by_time
	local containerGO = FightEffectPool.getPoolContainerGO()
	local transform = containerGO and containerGO.transform

	if transform then
		for k, effectWrap in pairs(tab) do
			if not gohelper.isNil(effectWrap.containerGO) then
				effectWrap.containerGO.transform:SetParent(transform, true)
			end
		end
	end
end

function FightEffectComp:getHangEffect()
	return self._hangEffects
end

function FightEffectComp:onDestroy()
	self._playingEffectDict = nil
	self.cache_effect = nil
	self.destroyed = true
end

function FightEffectComp:isDestroyed()
	return self.destroyed
end

local skin2skin = {
	[307303] = 307301,
	[307302] = 307301
}

function FightEffectComp:_registSkinEffect()
	local skinId = skin2skin[self.entity:getMO().skin] or self.entity:getMO().skin
	local skinClass = _G["FightEntitySpecialSkinEffect" .. skinId]

	if skinClass then
		self:_registSpecialClass(skinClass)
	end
end

function FightEffectComp:_onBuffUpdate(entityId, effectType, buffId, buffUid, effectConfig, buffData)
	self:handleCommonBuffEffect(entityId, effectType, buffId, buffUid, effectConfig, buffData)
end

function FightEffectComp:handleCommonBuffEffect(entityId, effectType, buffId, buffUid, effectConfig, buffData)
	if entityId ~= self.entityId then
		return
	end

	if effectType ~= FightEnum.EffectType.BUFFADD then
		return
	end

	local co = fight_common_buff_effect_2_skin.configDict[buffId]

	if not co then
		return
	end

	local skinId = self.entity:getMO().originSkin

	co = co[skinId] or co[0]

	if not co then
		return
	end

	local releaseTime = co.duration

	if releaseTime <= 0 then
		releaseTime = 2
	end

	local effectWrap = self:addHangEffect(co.effectPath, co.effectHang, nil, releaseTime / FightModel.instance:getSpeed())

	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, effectWrap)
	effectWrap:setLocalPos(0, 0, 0)

	local audioId = co.audio

	if audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

return FightEffectComp
