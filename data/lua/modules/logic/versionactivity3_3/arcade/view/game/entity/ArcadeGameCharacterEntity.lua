-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/ArcadeGameCharacterEntity.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.ArcadeGameCharacterEntity", package.seeall)

local ArcadeGameCharacterEntity = class("ArcadeGameCharacterEntity", ArcadeGameBaseEntity)

function ArcadeGameCharacterEntity:getMO()
	return ArcadeGameModel.instance:getCharacterMO()
end

function ArcadeGameCharacterEntity:refreshDirection()
	local mo = self:getMO()

	if not mo then
		return
	end

	local entityDirection = mo:getDirection(true)

	transformhelper.setLocalRotation(self.transScale, 0, entityDirection == ArcadeEnum.Direction.Right and 180 or 0, 0)
end

return ArcadeGameCharacterEntity
