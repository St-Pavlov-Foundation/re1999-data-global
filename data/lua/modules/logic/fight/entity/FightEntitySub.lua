-- chunkname: @modules/logic/fight/entity/FightEntitySub.lua

module("modules.logic.fight.entity.FightEntitySub", package.seeall)

local FightEntitySub = class("FightEntitySub", BaseFightEntity)

FightEntitySub.Online = true

function FightEntitySub:getTag()
	return self:isMySide() and SceneTag.UnitPlayer or SceneTag.UnitMonster
end

function FightEntitySub:ctor(entityId)
	self.isSub = true

	FightEntitySub.super.ctor(self, entityId)
end

function FightEntitySub:initComponents()
	self:addComp("spine", UnitSpine)
	self:addComp("spineRenderer", UnitSpineRenderer)
	self:addComp("entityVisible", FightEntityVisibleComp)
	self:addComp("effect", FightEffectComp)
	self:addComp("variantCrayon", FightVariantCrayonComp)
end

function FightEntitySub:setRenderOrder(order)
	FightEntitySub.super.setRenderOrder(self, order)
end

function FightEntitySub:setAlpha(alpha, duration)
	if self.spineRenderer then
		self.spineRenderer:setAlpha(alpha, duration)
	end
end

function FightEntitySub:loadSpine(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj

	local entityMO = self:getMO()
	local skinCO = FightConfig.instance:getSkinCO(entityMO.skin)
	local spinePath = ResUrl.getSpineFightPrefab(skinCO and skinCO.alternateSpine)

	self.spine:setResPath(spinePath, self._onSpineLoaded, self)
end

function FightEntitySub:_getOrCreateBoxSpine(goName)
	local boxSpineGO = gohelper.findChild(self.go, goName)

	boxSpineGO = boxSpineGO or gohelper.create3d(self.go, goName)

	return boxSpineGO, MonoHelper.addNoUpdateLuaComOnceToGo(boxSpineGO, UnitSpine)
end

function FightEntitySub:_onSpineLoaded(spine)
	if self.spineRenderer then
		self.spineRenderer:setSpine(spine)
	end

	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj, spine, self)
		else
			self._callback(spine, self)
		end
	end

	self._callback = nil
	self._callbackObj = nil
	self.parabolaMover = MonoHelper.addLuaComOnceToGo(self.spine:getSpineGO(), UnitMoverParabola, self)

	MonoHelper.addLuaComOnceToGo(self.spine:getSpineGO(), UnitMoverHandler, self)
end

return FightEntitySub
