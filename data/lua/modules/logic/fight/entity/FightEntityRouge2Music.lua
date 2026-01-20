-- chunkname: @modules/logic/fight/entity/FightEntityRouge2Music.lua

module("modules.logic.fight.entity.FightEntityRouge2Music", package.seeall)

local FightEntityRouge2Music = class("FightEntityRouge2Music", BaseFightEntity)

function FightEntityRouge2Music:getTag()
	return SceneTag.UnitNpc
end

function FightEntityRouge2Music:init(go)
	FightEntityRouge2Music.super.init(self, go)
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntityRouge2Music:initComponents()
	self:addComp("skill", FightSkillComp)
	self:addComp("effect", FightEffectComp)
	self:addComp("buff", FightBuffComp)
end

return FightEntityRouge2Music
