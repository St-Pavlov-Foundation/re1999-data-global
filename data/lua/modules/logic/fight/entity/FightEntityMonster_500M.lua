-- chunkname: @modules/logic/fight/entity/FightEntityMonster_500M.lua

module("modules.logic.fight.entity.FightEntityMonster_500M", package.seeall)

local FightEntityMonster_500M = class("FightEntityMonster_500M", FightEntityMonster)

function FightEntityMonster_500M:initComponents()
	self:addComp("spine", FightUnitSpine_500M)
	self:addComp("spineRenderer", UnitSpineRenderer_500M)
	self:addComp("mover", UnitMoverEase)
	self:addComp("parabolaMover", UnitMoverParabola)
	self:addComp("bezierMover", UnitMoverBezier)
	self:addComp("curveMover", UnitMoverCurve)
	self:addComp("moveHandler", UnitMoverHandler)
	self:addComp("skill", FightSkillComp)
	self:addComp("effect", FightEffectComp)
	self:addComp("buff", FightBuffComp)
	self:addComp("skinSpineAction", FightSkinSpineAction)
	self:addComp("skinSpineEffect", FightSkinSpineEffect)
	self:addComp("totalDamage", FightTotalDamageComp)
	self:addComp("uniqueEffect", FightUniqueEffectComp)
	self:addComp("skinCustomComp", FightSkinCustomComp)
	self:addComp("nameUI", FightNameUI)
	self:addComp("variantHeart", FightVariantHeartComp)
	self:addComp("entityVisible", FightEntityVisibleComp)
	self:addComp("nameUIVisible", FightNameUIVisibleComp)
	self:initCompDone()
end

function FightEntityMonster_500M:getSpineClass()
	return FightUnitSpine_500M
end

return FightEntityMonster_500M
