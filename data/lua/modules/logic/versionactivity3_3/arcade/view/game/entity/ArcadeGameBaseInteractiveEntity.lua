-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/ArcadeGameBaseInteractiveEntity.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.ArcadeGameBaseInteractiveEntity", package.seeall)

local ArcadeGameBaseInteractiveEntity = class("ArcadeGameBaseInteractiveEntity", ArcadeGameBaseEntity)

function ArcadeGameBaseInteractiveEntity:getMO()
	return ArcadeGameModel.instance:getMOWithType(ArcadeGameEnum.EntityType.BaseInteractive, self.uid)
end

return ArcadeGameBaseInteractiveEntity
