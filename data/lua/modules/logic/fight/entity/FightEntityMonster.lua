-- chunkname: @modules/logic/fight/entity/FightEntityMonster.lua

module("modules.logic.fight.entity.FightEntityMonster", package.seeall)

local FightEntityMonster = class("FightEntityMonster", BaseFightEntity)

function FightEntityMonster:getTag()
	return SceneTag.UnitMonster
end

function FightEntityMonster:initComponents()
	FightEntityMonster.super.initComponents(self)
	self:addComp("variantHeart", FightVariantHeartComp)
	self:addComp("entityVisible", FightEntityVisibleComp)
	self:addComp("nameUIVisible", FightNameUIVisibleComp)
end

return FightEntityMonster
