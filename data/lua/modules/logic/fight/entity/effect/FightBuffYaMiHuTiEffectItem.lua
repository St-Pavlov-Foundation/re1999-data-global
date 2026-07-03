-- chunkname: @modules/logic/fight/entity/effect/FightBuffYaMiHuTiEffectItem.lua

module("modules.logic.fight.entity.effect.FightBuffYaMiHuTiEffectItem", package.seeall)

local FightBuffYaMiHuTiEffectItem = class("FightBuffYaMiHuTiEffectItem", FightBaseClass)

function FightBuffYaMiHuTiEffectItem:onConstructor(entity, buffData, actInfo)
	self.entity = entity
	self.entityData = entity.entityData
	self.config = lua_fight_ya_mi_hu_ti_effect.configDict[self.entityData.skin]
	self.entityId = entity.id
	self.buffData = buffData
	self.actInfo = actInfo
	self.skillCount = 0

	self:showEffect()
	self:com_registMsg(FightMsgId.OnRemoveYaMiShield, self.onRemoveYaMiShield)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self.onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChanged)
	self:com_registMsg(FightMsgId.SetYaMiShieldEffectVisible, self.onSetYaMiShieldEffectVisible)
	self:com_registFightEvent(FightEvent.SetMagicCircleVisible, self.onSetMagicCircleVisible)
end

function FightBuffYaMiHuTiEffectItem:onStageChanged()
	self.skillCount = 0
end

function FightBuffYaMiHuTiEffectItem:showEffect(buffData, actInfo)
	local config = self.config
	local effect = config.effect

	if string.nilorempty(effect) then
		return
	end

	local pos = config.pos
	local posX = pos[1] or 0

	if config.reverseX == 1 then
		local entityMO = FightDataHelper.entityMgr:getById(self.entityId)

		if entityMO and entityMO:isEnemySide() then
			posX = -posX
		end
	end

	local posY = pos[2] or 0
	local posZ = pos[3] or 0
	local effectWrap = self.entity.effect:addGlobalEffect(effect)

	self.effectWrap = effectWrap

	effectWrap:setLocalPos(posX, posY, posZ)

	self.posX = posX
	self.posY = posY
	self.posZ = posZ
end

function FightBuffYaMiHuTiEffectItem:onSetYaMiShieldEffectVisible(visible)
	if self.effectWrap then
		self.effectWrap:setActive(visible, "onSetYaMiShieldEffectVisible")
	end
end

function FightBuffYaMiHuTiEffectItem:onSetMagicCircleVisible(visible, key)
	if self.effectWrap then
		self.effectWrap:setActive(visible, key)
	end
end

function FightBuffYaMiHuTiEffectItem:onSkillPlayStart()
	self.skillCount = self.skillCount + 1

	if self.skillCount >= 1 and self.effectWrap then
		self.effectWrap:setActive(false, "FightBuffYaMiHuTiEffectItem")
	end
end

function FightBuffYaMiHuTiEffectItem:onSkillPlayFinish()
	self.skillCount = self.skillCount - 1

	if self.skillCount <= 0 and self.effectWrap then
		self.effectWrap:setActive(true, "FightBuffYaMiHuTiEffectItem")
	end
end

function FightBuffYaMiHuTiEffectItem:onRemoveYaMiShield(buffData, actInfo)
	if buffData ~= self.buffData then
		return
	end

	self.entity.effect:removeEffect(self.effectWrap)

	self.effectWrap = nil

	local config = self.config
	local effect = config.delEffect

	if string.nilorempty(effect) then
		return
	end

	local pos = config.pos
	local posX = pos[1] or 0

	if config.reverseX == 1 then
		local entityMO = FightDataHelper.entityMgr:getById(self.entity.id)

		if entityMO and entityMO:isEnemySide() then
			posX = -posX
		end
	end

	local posY = pos[2] or 0
	local posZ = pos[3] or 0
	local effectWrap = self.entity.effect:addGlobalEffect(effect)

	effectWrap:setLocalPos(posX, posY, posZ)
	self:com_registTimer(self.removeDelEffect, config.delTime, {
		effectWrap = effectWrap,
		config = config
	})
	AudioMgr.instance:trigger(config.audio)
end

function FightBuffYaMiHuTiEffectItem:removeDelEffect(tab)
	local effectWrap = tab.effectWrap
	local config = tab.config

	self.entity.effect:removeEffect(effectWrap)
	AudioMgr.instance:trigger(config.delAudio)
	self:disposeSelf()
end

return FightBuffYaMiHuTiEffectItem
