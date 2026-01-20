-- chunkname: @modules/logic/fight/entity/FightEntityTemp.lua

module("modules.logic.fight.entity.FightEntityTemp", package.seeall)

local FightEntityTemp = class("FightEntityTemp", BaseFightEntity)

function FightEntityTemp:getTag()
	return SceneTag.UnitNpc
end

function FightEntityTemp:init(go)
	FightEntityTemp.super.init(self, go)
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntityTemp:initComponents()
	self:addComp("spine", UnitSpine)
	self:addComp("spineRenderer", UnitSpineRenderer)
	self:addComp("mover", UnitMoverEase)
	self:addComp("parabolaMover", UnitMoverParabola)
	self:addComp("bezierMover", UnitMoverBezier)
	self:addComp("curveMover", UnitMoverCurve)
	self:addComp("moveHandler", UnitMoverHandler)
	self:addComp("effect", FightEffectComp)
	self:addComp("variantHeart", FightVariantHeartComp)
	self:addComp("entityVisible", FightEntityVisibleComp)
end

function FightEntityTemp:setSide(side)
	self._tempSide = side
end

function FightEntityTemp:getSide()
	return self._tempSide
end

function FightEntityTemp:loadSpine(spineName, callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj

	local spinePath = ResUrl.getSpineFightPrefab(spineName)

	self.spine:setResPath(spinePath, self._onSpineLoaded, self)
end

function FightEntityTemp:loadSpineBySkin(skinCO, callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj

	local spinePath = ResUrl.getSpineFightPrefabBySkin(skinCO)

	self.spine:setResPath(spinePath, self._onSpineLoaded, self)
end

function FightEntityTemp:loadSpineBySpinePath(spinePath, callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj

	self.spine:setResPath(spinePath, self._onSpineLoaded, self)
end

return FightEntityTemp
