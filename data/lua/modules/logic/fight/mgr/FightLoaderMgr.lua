-- chunkname: @modules/logic/fight/mgr/FightLoaderMgr.lua

module("modules.logic.fight.mgr.FightLoaderMgr", package.seeall)

local FightLoaderMgr = class("FightLoaderMgr", FightBaseClass)

function FightLoaderMgr:onConstructor()
	self.loader = self:addComponent(FightLoaderComponent)
end

function FightLoaderMgr:onDestructor()
	return
end

return FightLoaderMgr
