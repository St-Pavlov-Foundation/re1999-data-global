-- chunkname: @modules/logic/fight/entity/FightEntityLyTemp.lua

module("modules.logic.fight.entity.FightEntityLyTemp", package.seeall)

local FightEntityLyTemp = class("FightEntityLyTemp", FightEntityTemp)

function FightEntityLyTemp:initComponents()
	self:addComp("spine", UnitSpine)
	self:addComp("spineRenderer", UnitSpineRenderer)
	self:addComp("effect", FightEffectComp)
end

return FightEntityLyTemp
