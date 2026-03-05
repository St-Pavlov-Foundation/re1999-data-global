-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/ArcadeGameGoodsEntity.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.ArcadeGameGoodsEntity", package.seeall)

local ArcadeGameGoodsEntity = class("ArcadeGameGoodsEntity", ArcadeGameBaseInteractiveEntity)

function ArcadeGameGoodsEntity:getMO()
	return ArcadeGameModel.instance:getMOWithType(ArcadeGameEnum.EntityType.Goods, self.uid)
end

return ArcadeGameGoodsEntity
