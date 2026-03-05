-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameFloorMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameFloorMO", package.seeall)

local ArcadeGameFloorMO = class("ArcadeGameFloorMO", ArcadeGameBaseUnitMO)

function ArcadeGameFloorMO:onCtor()
	self._curCdRound = 0
	self._config = ArcadeConfig.instance:getSkillFloorCfg(self.id, true)
	self._entityType = ArcadeGameEnum.EntityType.Floor

	if self._config and self._config.skill then
		self._skillSetMO:addSkillById(self._config.skill)
	end
end

function ArcadeGameFloorMO:getCfg()
	return self._config
end

function ArcadeGameFloorMO:getSize()
	return 1, 1
end

function ArcadeGameFloorMO:getRes()
	local cfg = self:getCfg()

	if cfg and not string.nilorempty(cfg.resPath) then
		return ResUrl.getArcadeSceneRes(cfg.resPath)
	end

	return nil
end

function ArcadeGameFloorMO:getCdRound()
	return self._curCdRound
end

function ArcadeGameFloorMO:setCdRound(round)
	self._curCdRound = tonumber(round)

	if not self._curCdRound or self._curCdRound < 1 then
		self._curCdRound = 0
	end
end

function ArcadeGameFloorMO:getLimitRound()
	return self._config and self._config.limitRound or -1
end

return ArcadeGameFloorMO
