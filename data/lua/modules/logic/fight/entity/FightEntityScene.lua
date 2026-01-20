-- chunkname: @modules/logic/fight/entity/FightEntityScene.lua

module("modules.logic.fight.entity.FightEntityScene", package.seeall)

local FightEntityScene = class("FightEntityScene", BaseFightEntity)

FightEntityScene.MySideId = "0"
FightEntityScene.EnemySideId = "-99999"

function FightEntityScene:getTag()
	return SceneTag.UnitNpc
end

function FightEntityScene:init(go)
	FightEntityScene.super.init(self, go)
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntityScene:initComponents()
	self:addComp("skill", FightSkillComp)
	self:addComp("effect", FightEffectComp)
	self:addComp("buff", FightBuffComp)
end

function FightEntityScene:getSide()
	if self.id == FightEntityScene.MySideId then
		return FightEnum.EntitySide.MySide
	elseif self.id == FightEntityScene.EnemySideId then
		return FightEnum.EntitySide.EnemySide
	else
		return FightEnum.EntitySide.BothSide
	end
end

return FightEntityScene
