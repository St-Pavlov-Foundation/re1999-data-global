-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/ArcadeGameBombEntity.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.ArcadeGameBombEntity", package.seeall)

local ArcadeGameBombEntity = class("ArcadeGameBombEntity", ArcadeGameBaseEntity)

function ArcadeGameBombEntity:getMO()
	return ArcadeGameModel.instance:getMOWithType(ArcadeGameEnum.EntityType.Bomb, self.uid)
end

return ArcadeGameBombEntity
