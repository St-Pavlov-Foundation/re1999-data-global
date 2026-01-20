-- chunkname: @modules/logic/fight/entity/FightEntityASFD.lua

module("modules.logic.fight.entity.FightEntityASFD", package.seeall)

local FightEntityASFD = class("FightEntityASFD", BaseFightEntity)

function FightEntityASFD:getTag()
	return SceneTag.UnitNpc
end

function FightEntityASFD:init(go)
	FightEntityASFD.super.init(self, go)
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntityASFD:initComponents()
	self:addComp("effect", FightEffectComp)
end

return FightEntityASFD
