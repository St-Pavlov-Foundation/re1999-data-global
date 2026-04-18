-- chunkname: @modules/logic/partygame/view/carddrop/entity/CardDropEntityCompBase.lua

module("modules.logic.partygame.view.carddrop.entity.CardDropEntityCompBase", package.seeall)

local CardDropEntityCompBase = class("CardDropEntityCompBase", UserDataDispose)

function CardDropEntityCompBase:init(uid, entity)
	CardDropEntityCompBase.super.__onInit(self)

	self.uid = uid
	self.entity = entity
end

function CardDropEntityCompBase:destroy()
	CardDropEntityCompBase.super.__onDispose()
end

return CardDropEntityCompBase
