-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffectBuffLayerEnemySkin.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBuffLayerEnemySkin", package.seeall)

local FightEntitySpecialEffectBuffLayerEnemySkin = class("FightEntitySpecialEffectBuffLayerEnemySkin", FightEntitySpecialEffectBase)
local defaultReleaseTime = 3000

function FightEntitySpecialEffectBuffLayerEnemySkin:initClass()
	self._effectWraps = {}
	self._buffId2Config = {}
	self._oldLayer = {}
	self._buffType = {}
	self.playCount = 0
	self.hideWhenPlayTimeline = {}

	self:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, self._onSetBuffEffectVisible, self)
	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, self._onBeforeDeadEffect, self)
	self:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, self._onBeforeEnterStepBehaviour, self)
	self:addEventCb(FightController.instance, FightEvent.SkillEditorRefreshBuff, self._onSkillEditorRefreshBuff, self)
	self:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	self:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self, LuaEventSystem.High)
	self:addEventCb(FightController.instance, FightEvent.BeforePlayTimeline, self.onBeforePlayTimeline, self)
end

function FightEntitySpecialEffectBuffLayerEnemySkin:onBeforePlayTimeline(entityId)
	if self._entity.id == entityId then
		self.playCount = self.playCount + 1

		for i, effectWrap in ipairs(self.hideWhenPlayTimeline) do
			effectWrap:setActive(false, "FightEntitySpecialEffectBuffLayerEnemySkin_onBeforePlayTimeline")
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:afterPlayTimeline()
	self.playCount = self.playCount - 1

	if self.playCount == 0 then
		for i, effectWrap in ipairs(self.hideWhenPlayTimeline) do
			effectWrap:setActive(true, "FightEntitySpecialEffectBuffLayerEnemySkin_afterPlayTimeline")
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onBeforeEnterStepBehaviour()
	local entityMO = self._entity:getMO()

	if entityMO then
		local buffDic = entityMO:getBuffDic()

		for i, v in pairs(buffDic) do
			self:_onBuffUpdate(self._entity.id, FightEnum.EffectType.BUFFADD, v.buffId, v.uid, nil, v)
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onSkillEditorRefreshBuff()
	self:_releaseAllEffect()
	self:_onBeforeEnterStepBehaviour()
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onSetBuffEffectVisible(entityId, state, sign)
	if self._entity.id == entityId and self._effectWraps then
		for buffId, v in pairs(self._effectWraps) do
			for i, effectWrap in pairs(v) do
				effectWrap:setActive(state, sign or "FightEntitySpecialEffectBuffLayerEnemySkin")
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onSkillPlayStart(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and entityMO.id == self._entity.id and FightCardDataHelper.isBigSkill(curSkillId) then
		self:_onSetBuffEffectVisible(entityMO.id, false, "FightEntitySpecialEffectBuffLayerEnemySkin_onSkillPlayStart")
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onSkillPlayFinish(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and entityMO.id == self._entity.id then
		if FightCardDataHelper.isBigSkill(curSkillId) then
			self:_onSetBuffEffectVisible(entityMO.id, true, "FightEntitySpecialEffectBuffLayerEnemySkin_onSkillPlayStart")
		end

		self:afterPlayTimeline()
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin.sortList(item1, item2)
	return item1.layer > item2.layer
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onBuffUpdate(targetId, effectType, buffId, buffUid, configEffect, buffMO)
	if targetId ~= self._entity.id then
		return
	end

	if lua_fight_buff_layer_effect_enemy_skin.configDict[buffId] then
		if effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
			local buffType = self._buffType[buffUid]

			if not buffType then
				return
			end

			if buffType == FightEnum.BuffType.LayerSalveHalo then
				return
			end

			self:_refreshEffect(buffId, nil, 0, effectType)

			return
		end

		if not buffMO then
			return
		end

		self._buffType[buffUid] = buffMO.type

		if buffMO.type == FightEnum.BuffType.LayerSalveHalo then
			return
		end

		local entityData = self._entity:getMO()

		if not entityData then
			return
		end

		local entitySide = entityData.side == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
		local entityList = FightDataHelper.entityMgr:getOriginNormalList(entitySide)
		local have = self:checkRefreshEffect(entityList, buffMO, targetId, effectType)

		if not have then
			entityList = FightDataHelper.entityMgr:getOriginSpList(entitySide)
			have = self:checkRefreshEffect(entityList, buffMO, targetId, effectType)
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:checkRefreshEffect(entityList, buffMO, targetId, effectType)
	local buffId = buffMO.buffId

	for i, entityMO in ipairs(entityList) do
		local config = lua_fight_buff_layer_effect_enemy_skin.configDict[buffId][entityMO.originSkin] or lua_fight_buff_layer_effect_enemy_skin.configDict[buffId][0]

		if config then
			local list = {}

			for k, v in pairs(config) do
				table.insert(list, v)
			end

			table.sort(list, FightEntitySpecialEffectBuffLayerEnemySkin.sortList)

			local layer = buffMO and buffMO.layer or 0
			local buffConfig = lua_skill_buff.configDict[buffId]

			if FightSkillBuffMgr.instance:buffIsStackerBuff(buffConfig) then
				layer = FightSkillBuffMgr.instance:getStackedCount(targetId, buffMO)
			end

			self:_refreshEffect(buffId, list, layer, effectType)

			return true
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_refreshEffect(buffId, list, layer, effectType)
	if not self._effectWraps then
		return
	end

	if not self._effectWraps[buffId] then
		self._effectWraps[buffId] = {}
	end

	local oldLayer = self._oldLayer[buffId] or 0

	self._oldLayer[buffId] = layer

	if (effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT) and layer == 0 then
		local config = self._buffId2Config[buffId]

		if config and not string.nilorempty(config.destroyEffect) then
			local releaseTime = config.releaseDestroyEffectTime > 0 and config.releaseDestroyEffectTime or defaultReleaseTime
			local effectWrap = self._entity.effect:addHangEffect(config.destroyEffect, config.destroyEffectRoot, nil, releaseTime / 1000)

			effectWrap:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)

			if config.destroyEffectAudio > 0 then
				AudioMgr.instance:trigger(config.destroyEffectAudio)
			end
		end

		self:_releaseBuffIdEffect(buffId)

		return
	end

	local config

	for i, v in ipairs(list) do
		if layer >= v.layer then
			config = v

			break
		end
	end

	if not config then
		self:_releaseBuffIdEffect(buffId)

		return
	end

	local keyLayer = config.layer
	local oldConfig = self._buffId2Config[buffId]

	self._buffId2Config[buffId] = config

	local isNew = oldConfig ~= config

	if not self._effectWraps[buffId][keyLayer] and not string.nilorempty(config.loopEffect) then
		local effectWrap = self._entity.effect:addHangEffect(config.loopEffect, config.loopEffectRoot)

		effectWrap:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)

		self._effectWraps[buffId][keyLayer] = effectWrap

		effectWrap:setActive(false)

		if config.hideWhenPlayTimeline == 1 then
			table.insert(self.hideWhenPlayTimeline, effectWrap)
		end
	end

	if isNew then
		self:_hideEffect(buffId)

		if not string.nilorempty(config.createEffect) then
			local releaseTime = config.releaseCreateEffectTime > 0 and config.releaseCreateEffectTime or defaultReleaseTime
			local effectWrap = self._entity.effect:addHangEffect(config.createEffect, config.createEffectRoot, nil, releaseTime / 1000)

			effectWrap:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)

			if config.createAudio > 0 then
				AudioMgr.instance:trigger(config.createAudio)
			end
		end

		if config.delayTimeBeforeLoop > 0 then
			TaskDispatcher.runDelay(function()
				self:_refreshEffectState(buffId)
			end, self, config.delayTimeBeforeLoop / 1000)
		else
			self:_refreshEffectState(buffId)
		end
	else
		if config.loopEffectAudio > 0 then
			AudioMgr.instance:trigger(config.loopEffectAudio)
		end

		self:_refreshEffectState(buffId)

		if effectType == FightEnum.EffectType.BUFFUPDATE and oldLayer < layer then
			if not string.nilorempty(config.addLayerEffect) then
				local releaseTime = config.releaseAddLayerEffectTime > 0 and config.releaseAddLayerEffectTime or defaultReleaseTime
				local effectWrap = self._entity.effect:addHangEffect(config.addLayerEffect, config.addLayerEffectRoot, nil, releaseTime / 1000)

				effectWrap:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)
			end

			if config.addLayerAudio > 0 then
				AudioMgr.instance:trigger(config.addLayerAudio)
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_refreshEffectState(buffId)
	if not self then
		return
	end

	if self._effectWraps then
		local effectDic = self._effectWraps[buffId]

		if effectDic then
			local layer = self._buffId2Config[buffId].layer

			for k, v in pairs(effectDic) do
				v:setActive(layer == k)
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_hideEffect(buffId)
	if self._effectWraps then
		local effectDic = self._effectWraps[buffId]

		if effectDic then
			for k, v in pairs(effectDic) do
				v:setActive(false)
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_releaseAllEffect()
	if self._effectWraps then
		for k, v in pairs(self._effectWraps) do
			self:_releaseBuffIdEffect(k)
		end

		self._effectWraps = nil
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_releaseBuffIdEffect(buffId)
	if self._effectWraps then
		for k, v in pairs(self._effectWraps[buffId]) do
			self:_releaseEffect(v)
		end

		self._effectWraps[buffId] = nil
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_releaseEffect(effectWrap)
	for i, v in ipairs(self.hideWhenPlayTimeline) do
		if v == effectWrap then
			table.remove(self.hideWhenPlayTimeline, i)

			break
		end
	end

	self._entity.effect:removeEffect(effectWrap)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, effectWrap)
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onBeforeDeadEffect(entityId)
	if entityId == self._entity.id then
		self:_releaseAllEffect()
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:releaseSelf()
	self:_releaseAllEffect()
end

return FightEntitySpecialEffectBuffLayerEnemySkin
