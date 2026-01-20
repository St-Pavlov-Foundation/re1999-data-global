-- chunkname: @modules/logic/fight/entity/comp/FightHeroCustomComp.lua

module("modules.logic.fight.entity.comp.FightHeroCustomComp", package.seeall)

local FightHeroCustomComp = class("FightHeroCustomComp", LuaCompBase)

FightHeroCustomComp.HeroId2CustomComp = {
	[3113] = FightHeroALFComp
}

function FightHeroCustomComp:ctor(entity)
	self.entity = entity
end

function FightHeroCustomComp:init(go)
	self.go = go

	local entityMo = self.entity:getMO()
	local compCls = FightHeroCustomComp.HeroId2CustomComp[entityMo.modelId]

	if compCls then
		self.customComp = compCls.New(self.entity)

		self.customComp:init(go)
	end
end

function FightHeroCustomComp:addEventListeners()
	if self.customComp then
		self.customComp:addEventListeners()
	end
end

function FightHeroCustomComp:removeEventListeners()
	if self.customComp then
		self.customComp:removeEventListeners()
	end
end

function FightHeroCustomComp:getCustomComp()
	return self.customComp
end

function FightHeroCustomComp:onDestroy()
	if self.customComp then
		self.customComp:onDestroy()

		self.customComp = nil
	end
end

return FightHeroCustomComp
