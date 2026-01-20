-- chunkname: @modules/logic/fight/entity/FightEntityVorpalith.lua

module("modules.logic.fight.entity.FightEntityVorpalith", package.seeall)

local FightEntityVorpalith = class("FightEntityVorpalith", BaseFightEntity)

function FightEntityVorpalith:getTag()
	return SceneTag.UnitNpc
end

function FightEntityVorpalith:init(go)
	FightEntityVorpalith.super.init(self, go)
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntityVorpalith:initComponents()
	self:addComp("skill", FightSkillComp)
	self:addComp("effect", FightEffectComp)
	self:addComp("buff", FightBuffComp)
	self:addComp("vorpalithEventMgr", FightVorpalithEventMgrComp)
end

return FightEntityVorpalith
