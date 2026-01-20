-- chunkname: @modules/logic/fight/entity/comp/FightSkinCustomComp.lua

module("modules.logic.fight.entity.comp.FightSkinCustomComp", package.seeall)

local FightSkinCustomComp = class("FightSkinCustomComp", LuaCompBase)

FightSkinCustomComp.SkinId2CustomComp = {
	[308603] = FightSkinLuXi_308603CustomComp,
	[630305] = FightSkinSM_630305CustomComp
}

function FightSkinCustomComp:ctor(entity)
	self.entity = entity
end

function FightSkinCustomComp:init(go)
	self.go = go

	local entityMo = self.entity:getMO()
	local compCls = FightSkinCustomComp.SkinId2CustomComp[entityMo.skin]

	if compCls then
		self.customComp = compCls.New(self.entity)

		self.customComp:init(go)
	end
end

function FightSkinCustomComp:addEventListeners()
	if self.customComp then
		self.customComp:addEventListeners()
	end
end

function FightSkinCustomComp:removeEventListeners()
	if self.customComp then
		self.customComp:removeEventListeners()
	end
end

function FightSkinCustomComp:getCustomComp()
	return self.customComp
end

function FightSkinCustomComp:onDestroy()
	if self.customComp then
		self.customComp:onDestroy()

		self.customComp = nil
	end
end

return FightSkinCustomComp
