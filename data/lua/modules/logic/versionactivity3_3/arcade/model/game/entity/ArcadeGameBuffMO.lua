-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameBuffMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameBuffMO", package.seeall)

local ArcadeGameBuffMO = class("ArcadeGameBuffMO")

function ArcadeGameBuffMO:ctor(buffId, unitMO)
	self.id = buffId
	self.unitMO = unitMO

	self:resetLiveRound()
end

function ArcadeGameBuffMO:getId()
	return self.id
end

function ArcadeGameBuffMO:subLiveRound()
	self._liveRound = math.max(0, (self._liveRound or 0) - 1)
end

function ArcadeGameBuffMO:getRemainLiveRound()
	return self._liveRound or 0
end

function ArcadeGameBuffMO:resetLiveRound()
	self._liveRound = ArcadeConfig.instance:getArcadeBuffRound(self.id)
end

return ArcadeGameBuffMO
