-- chunkname: @modules/logic/fight/entity/FightEntityPlayer.lua

module("modules.logic.fight.entity.FightEntityPlayer", package.seeall)

local FightEntityPlayer = class("FightEntityPlayer", BaseFightEntity)

function FightEntityPlayer:getTag()
	return SceneTag.UnitPlayer
end

function FightEntityPlayer:initComponents()
	FightEntityPlayer.super.initComponents(self)
	self:addComp("readyAttack", FightPlayerReadyAttackComp)
	self:addComp("variantCrayon", FightVariantCrayonComp)
	self:addComp("entityVisible", FightEntityVisibleComp)
	self:addComp("nameUIVisible", FightNameUIVisibleComp)
	self:addComp("variantHeart", FightVariantHeartComp)
	self:addComp("heroCustomComp", FightHeroCustomComp)
end

return FightEntityPlayer
