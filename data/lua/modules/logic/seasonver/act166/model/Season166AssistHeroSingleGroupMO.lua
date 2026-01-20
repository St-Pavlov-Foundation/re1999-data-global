-- chunkname: @modules/logic/seasonver/act166/model/Season166AssistHeroSingleGroupMO.lua

module("modules.logic.seasonver.act166.model.Season166AssistHeroSingleGroupMO", package.seeall)

local Season166AssistHeroSingleGroupMO = class("Season166AssistHeroSingleGroupMO", Season166HeroSingleGroupMO)

function Season166AssistHeroSingleGroupMO:ctor()
	self.id = nil
	self.heroUid = nil
	self.heroId = nil
	self._heroMo = nil
end

function Season166AssistHeroSingleGroupMO:init(id, pickAssistHeroMO)
	self.id = id
	self.heroUid = 0
	self._heroMo = pickAssistHeroMO.heroMO
	self.heroId = pickAssistHeroMO and pickAssistHeroMO.heroId or 0
	self.userId = pickAssistHeroMO and pickAssistHeroMO.userId or 0
	self.pickAssistHeroMO = pickAssistHeroMO
	self.isAssist = true
end

function Season166AssistHeroSingleGroupMO:getHeroMO()
	return self._heroMo
end

function Season166AssistHeroSingleGroupMO:isTrial()
	return true
end

return Season166AssistHeroSingleGroupMO
