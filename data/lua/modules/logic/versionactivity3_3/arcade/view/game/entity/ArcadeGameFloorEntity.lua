-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/ArcadeGameFloorEntity.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.ArcadeGameFloorEntity", package.seeall)

local ArcadeGameFloorEntity = class("ArcadeGameFloorEntity", ArcadeGameBaseEntity)

function ArcadeGameFloorEntity:getMO()
	return ArcadeGameModel.instance:getMOWithType(ArcadeGameEnum.EntityType.Floor, self.uid)
end

return ArcadeGameFloorEntity
