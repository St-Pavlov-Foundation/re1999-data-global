-- chunkname: @modules/logic/fight/mgr/FightBuffTypeId2EffectMgr.lua

module("modules.logic.fight.mgr.FightBuffTypeId2EffectMgr", package.seeall)

local FightBuffTypeId2EffectMgr = class("FightBuffTypeId2EffectMgr", FightBaseClass)

function FightBuffTypeId2EffectMgr:onConstructor()
	self.effectDic = {}
	self.refCounter = {}
	self.posDic = {}

	self:com_registFightEvent(FightEvent.AddEntityBuff, self._onAddEntityBuff)
	self:com_registFightEvent(FightEvent.RemoveEntityBuff, self._onRemoveEntityBuff)
	self:com_registFightEvent(FightEvent.OnFightReconnectLastWork, self._onFightReconnectLastWork)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.OnRoundSequenceFinish, self._onOnRoundSequenceFinish)
	self:com_registFightEvent(FightEvent.SetBuffTypeIdSceneEffect, self._onSetBuffTypeIdSceneEffect)
end

function FightBuffTypeId2EffectMgr:_isValid(buffId)
	local buffConfig = lua_skill_buff.configDict[buffId]

	if not buffConfig then
		return
	end

	local buffTypeId = buffConfig.typeId

	if not lua_fight_buff_type_id_2_scene_effect.configDict[buffTypeId] then
		return
	end

	return true, buffConfig
end

function FightBuffTypeId2EffectMgr:_onAddEntityBuff(entityId, buffMO)
	local valid, buffConfig = self:_isValid(buffMO.buffId)

	if not valid then
		return
	end

	self:addBuff(entityId, buffConfig.typeId)
end

function FightBuffTypeId2EffectMgr:_onRemoveEntityBuff(entityId, buffMO)
	local valid, buffConfig = self:_isValid(buffMO.buffId)

	if not valid then
		return
	end

	self:deleteBuff(buffConfig.typeId)

	local config = lua_fight_buff_type_id_2_scene_effect.configDict[buffConfig.typeId]

	if config then
		local counter = self.refCounter[buffConfig.typeId] or 0

		if counter == 0 then
			local effect = config.delEffect
			local pos = config.pos
			local posX = pos[1] or 0

			if config.reverseX == 1 then
				local entityMO = FightDataHelper.entityMgr:getById(entityId)

				if entityMO and entityMO:isEnemySide() then
					posX = -posX
				end
			end

			local posY = pos[2] or 0
			local posZ = pos[3] or 0
			local vertin = FightHelper.getEntity(FightEntityScene.MySideId)

			if vertin then
				local effectWrap = vertin.effect:addGlobalEffect(effect)

				effectWrap:setLocalPos(posX, posY, posZ)
				self:com_registTimer(self.removeDelEffect, config.delTime, effectWrap)
			end
		end
	end
end

function FightBuffTypeId2EffectMgr:removeDelEffect(effectWrap)
	local vertin = FightHelper.getEntity(FightEntityScene.MySideId)

	if not vertin then
		return
	end

	vertin.effect:removeEffect(effectWrap)
end

function FightBuffTypeId2EffectMgr:addBuff(entityId, buffTypeId)
	local counter = self.refCounter[buffTypeId] or 0

	counter = counter + 1
	self.refCounter[buffTypeId] = counter

	if counter == 1 then
		self:addEffect(entityId, buffTypeId)
	end
end

function FightBuffTypeId2EffectMgr:deleteBuff(buffTypeId)
	local counter = self.refCounter[buffTypeId] or 0

	counter = counter - 1
	self.refCounter[buffTypeId] = counter

	if counter <= 0 then
		self:releaseEffect(buffTypeId)
	end
end

function FightBuffTypeId2EffectMgr:addEffect(entityId, buffTypeId)
	local vertin = FightHelper.getEntity(FightEntityScene.MySideId)

	if not vertin then
		return
	end

	local config = lua_fight_buff_type_id_2_scene_effect.configDict[buffTypeId]

	if not config then
		return
	end

	local effect = config.effect
	local pos = config.pos
	local posX = pos[1] or 0

	if config.reverseX == 1 then
		local entityMO = FightDataHelper.entityMgr:getById(entityId)

		if entityMO and entityMO:isEnemySide() then
			posX = -posX
		end
	end

	local posY = pos[2] or 0
	local posZ = pos[3] or 0
	local effectWrap = vertin.effect:addGlobalEffect(effect)

	effectWrap:setLocalPos(posX, posY, posZ)

	self.posDic[buffTypeId] = {
		posX,
		posY,
		posZ
	}
	self.effectDic[buffTypeId] = effectWrap
end

function FightBuffTypeId2EffectMgr:releaseEffect(buffTypeId)
	local effectWrap = self.effectDic[buffTypeId]

	if not effectWrap then
		return
	end

	local vertin = FightHelper.getEntity(FightEntityScene.MySideId)

	if not vertin then
		return
	end

	vertin.effect:removeEffect(effectWrap)

	self.effectDic[buffTypeId] = nil
end

function FightBuffTypeId2EffectMgr:_onFightReconnectLastWork()
	local entityDic = FightDataHelper.entityMgr:getAllEntityData()

	for uid, entityData in pairs(entityDic) do
		local buffDic = entityData:getBuffDic()

		for buffUid, buff in pairs(buffDic) do
			self:_onAddEntityBuff(uid, buff)
		end
	end
end

function FightBuffTypeId2EffectMgr:_onSkillPlayStart(entity, curSkillId)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) then
		self:_hideEffect()
	end
end

function FightBuffTypeId2EffectMgr:_onSkillPlayFinish(entity, curSkillId)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) then
		self:_showEffect()
	end
end

function FightBuffTypeId2EffectMgr:_onSetBuffTypeIdSceneEffect(visible)
	for k, effectWrap in pairs(self.effectDic) do
		local pos = self.posDic[k]
		local posX = visible and pos[1] or 9999
		local posY = visible and pos[2] or 9999
		local posZ = visible and pos[3] or 9999

		effectWrap:setLocalPos(posX, posY, posZ)
	end
end

function FightBuffTypeId2EffectMgr:_hideEffect()
	for k, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(false, "FightBuffTypeId2EffectMgr")
	end
end

function FightBuffTypeId2EffectMgr:_showEffect()
	for k, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(true, "FightBuffTypeId2EffectMgr")
	end
end

function FightBuffTypeId2EffectMgr:_onOnRoundSequenceFinish()
	if tabletool.len(self.refCounter) <= 0 then
		return
	end

	local refTab = {}
	local entityDic = FightDataHelper.entityMgr:getAllEntityData()

	for uid, entityData in pairs(entityDic) do
		local buffDic = entityData:getBuffDic()

		for buffUid, buff in pairs(buffDic) do
			local buffConfig = lua_skill_buff.configDict[buff.buffId]

			if buffConfig and lua_fight_buff_type_id_2_scene_effect.configDict[buffConfig.typeId] then
				local counter = refTab[buffConfig.typeId] or 0

				counter = counter + 1
				refTab[buffConfig.typeId] = counter
			end
		end
	end

	if FightDataUtil.findDiff(self.refCounter, refTab) then
		self:releaseAllEffect()

		self.refCounter = {}

		self:_onFightReconnectLastWork()
	end
end

function FightBuffTypeId2EffectMgr:releaseAllEffect()
	for buffTypeId, effectWrap in pairs(self.effectDic) do
		self:releaseEffect(buffTypeId)
	end
end

function FightBuffTypeId2EffectMgr:onDestructor()
	return
end

return FightBuffTypeId2EffectMgr
