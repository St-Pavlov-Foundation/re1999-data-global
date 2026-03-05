-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/ArcadeGameMonsterEntity.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.ArcadeGameMonsterEntity", package.seeall)

local ArcadeGameMonsterEntity = class("ArcadeGameMonsterEntity", ArcadeGameBaseEntity)

function ArcadeGameMonsterEntity:getMO()
	return ArcadeGameModel.instance:getMOWithType(ArcadeGameEnum.EntityType.Monster, self.uid)
end

return ArcadeGameMonsterEntity
