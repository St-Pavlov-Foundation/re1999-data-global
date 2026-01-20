-- chunkname: @modules/logic/fight/entity/comp/FightSkinSpineEffect.lua

module("modules.logic.fight.entity.comp.FightSkinSpineEffect", package.seeall)

local FightSkinSpineEffect = class("FightSkinSpineEffect", LuaCompBase)
local SetSpineAlphaBeforeAddEffect = {
	buff_jjhhy = true
}
local DontHideEffectOnSkillStart = {
	buff_jjhhy = true
}

function FightSkinSpineEffect:ctor(entity)
	self.entity = entity
	self._effectWrapDict = nil
	self._monsterEffect = {}
end

function FightSkinSpineEffect:init(go)
	self._spine = self.entity.spine

	self._spine:registerCallback(UnitSpine.Evt_OnLoaded, self._onLoaded, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
end

function FightSkinSpineEffect:removeEventListeners()
	self._spine:unregisterCallback(UnitSpine.Evt_OnLoaded, self._onLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	TaskDispatcher.cancelTask(self._delayShowSpine, self)
end

function FightSkinSpineEffect:onDestroy()
	self._effectWrapDict = nil
end

function FightSkinSpineEffect:_onSkillPlayStart(entity, skillId, fightStepData)
	if self.entity == entity then
		self:_setMonsterEffectActive(false, self.__cname)
	end
end

function FightSkinSpineEffect:_onSkillPlayFinish(entity, skillId, fightStepData)
	if self.entity == entity then
		self:_setMonsterEffectActive(true, self.__cname)
	end
end

function FightSkinSpineEffect:_setMonsterEffectActive(state, sign)
	for effectName, effectWrap in pairs(self._monsterEffect) do
		if not DontHideEffectOnSkillStart[effectName] then
			effectWrap:setActive(state, sign)
		end
	end
end

function FightSkinSpineEffect:_onLoaded()
	local entityMO = self.entity:getMO()
	local skinCO = FightConfig.instance:getSkinCO(entityMO.skin)

	if not string.nilorempty(skinCO.effect) then
		local effectArr = string.split(skinCO.effect, "#")
		local effectHangPointArr = string.split(skinCO.effectHangPoint, "#")

		for i, v in ipairs(effectArr) do
			self:_addEffect(v, effectHangPointArr[i])
		end

		self:_setSpineAlphaForRoleEffect(effectArr)
	end

	local monsterCO = lua_monster.configDict[entityMO.modelId]

	if monsterCO and not string.nilorempty(monsterCO.effect) then
		local effectArr = string.split(monsterCO.effect, "#")
		local effectHangPointArr = string.split(monsterCO.effectHangPoint, "#")

		for i, v in ipairs(effectArr) do
			self._monsterEffect[v] = self:_addEffect(v, effectHangPointArr[i])
		end

		self:_setSpineAlphaForRoleEffect(effectArr)
	end
end

function FightSkinSpineEffect:_setSpineAlphaForRoleEffect(effectArr)
	for _, effect in ipairs(effectArr) do
		if SetSpineAlphaBeforeAddEffect[effect] then
			self.entity.spineRenderer:setAlpha(0, 0)
			TaskDispatcher.runDelay(self._delayShowSpine, self, 0.1)

			break
		end
	end
end

function FightSkinSpineEffect:_delayShowSpine()
	self.entity.spineRenderer:setAlpha(1)
end

function FightSkinSpineEffect:_addEffect(effect, effectHangPoint)
	local effectWrap = self.entity.effect:addHangEffect(effect, effectHangPoint)

	effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.entity.id, effectWrap)

	self._effectWrapDict = self._effectWrapDict or {}
	self._effectWrapDict[effect] = effectWrap

	return effectWrap
end

function FightSkinSpineEffect:hideEffects(sign)
	if self._effectWrapDict then
		for effectName, effectWrap in pairs(self._effectWrapDict) do
			if not DontHideEffectOnSkillStart[effectName] then
				effectWrap:setActive(false, sign)
			end
		end
	end
end

function FightSkinSpineEffect:showEffects(sign)
	if self._effectWrapDict then
		for effectName, effectWrap in pairs(self._effectWrapDict) do
			if not DontHideEffectOnSkillStart[effectName] then
				effectWrap:setActive(true, sign)
			end
		end
	end
end

return FightSkinSpineEffect
