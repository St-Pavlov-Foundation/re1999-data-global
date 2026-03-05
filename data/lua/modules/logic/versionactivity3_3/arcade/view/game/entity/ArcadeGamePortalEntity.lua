-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/ArcadeGamePortalEntity.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.ArcadeGamePortalEntity", package.seeall)

local ArcadeGamePortalEntity = class("ArcadeGamePortalEntity", ArcadeGameBaseInteractiveEntity)

function ArcadeGamePortalEntity:getMO()
	return ArcadeGameModel.instance:getMOWithType(ArcadeGameEnum.EntityType.Portal, self.uid)
end

return ArcadeGamePortalEntity
