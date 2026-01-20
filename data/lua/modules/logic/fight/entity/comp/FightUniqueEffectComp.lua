-- chunkname: @modules/logic/fight/entity/comp/FightUniqueEffectComp.lua

module("modules.logic.fight.entity.comp.FightUniqueEffectComp", package.seeall)

local FightUniqueEffectComp = class("FightUniqueEffectComp", LuaCompBase)

function FightUniqueEffectComp:ctor(entity)
	self.entity = entity
	self.entityId = self.entity.id
	self.existEffectWrapDict = {}
	self.releaseEffectDict = {}
	self.updateHandle = UpdateBeat:CreateListener(self.update, self)

	UpdateBeat:AddListener(self.updateHandle)
end

function FightUniqueEffectComp:onDestroy()
	for effectName, _ in pairs(self.releaseEffectDict) do
		self:removeEffect(effectName)
	end

	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)
	end
end

function FightUniqueEffectComp:addHangEffect(effectName, hangPoint, side, releaseTime)
	local effectWrap = self.existEffectWrapDict[effectName]

	if effectWrap then
		return effectWrap
	end

	effectWrap = self.entity.effect:addHangEffect(effectName, hangPoint, side)

	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, effectWrap)

	self.existEffectWrapDict[effectName] = effectWrap

	if releaseTime then
		self:releaseEffectAfterTime(effectName, releaseTime)
	end

	return effectWrap
end

function FightUniqueEffectComp:addGlobalEffect(effectName, side, releaseTime)
	if self.existEffectWrapDict[effectName] then
		return
	end

	local effectWrap = self.entity.effect:addGlobalEffect(effectName, side)

	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, effectWrap)

	self.existEffectWrapDict[effectName] = effectWrap

	if releaseTime then
		self:releaseEffectAfterTime(effectName, releaseTime)
	end

	return effectWrap
end

function FightUniqueEffectComp:releaseEffectAfterTime(effectName, releaseTime)
	self.releaseEffectDict[effectName] = Time.realtimeSinceStartup + releaseTime
end

function FightUniqueEffectComp:update()
	local curTime = Time.realtimeSinceStartup

	for effectName, time in pairs(self.releaseEffectDict) do
		if time <= curTime then
			self:removeEffect(effectName)
		end
	end
end

function FightUniqueEffectComp:removeEffect(effectName)
	local effectWrap = self.existEffectWrapDict[effectName]

	if not effectWrap then
		return
	end

	self.existEffectWrapDict[effectName] = nil
	self.releaseEffectDict[effectName] = nil

	FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, effectWrap)
	self.entity.effect:removeEffect(effectWrap)
end

return FightUniqueEffectComp
