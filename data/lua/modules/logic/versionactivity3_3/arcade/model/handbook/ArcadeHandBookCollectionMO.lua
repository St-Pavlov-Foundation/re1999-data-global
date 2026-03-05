-- chunkname: @modules/logic/versionactivity3_3/arcade/model/handbook/ArcadeHandBookCollectionMO.lua

module("modules.logic.versionactivity3_3.arcade.model.handbook.ArcadeHandBookCollectionMO", package.seeall)

local ArcadeHandBookCollectionMO = class("ArcadeHandBookCollectionMO")

function ArcadeHandBookCollectionMO:ctor(id)
	self.id = id
	self.co = ArcadeConfig.instance:getCollectionCfg(id)

	if not self.co then
		logError("未找到收藏品配置：id=" .. id)
	end

	local type = self.co and self.co.type
	local isJewelry = type and type == ArcadeEnum.CollectionType.Jewelry

	self.type = isJewelry and ArcadeEnum.EffectType.Collection or ArcadeEnum.EffectType.Weapon
end

function ArcadeHandBookCollectionMO:getName()
	return self.co and self.co.name or ""
end

function ArcadeHandBookCollectionMO:getDesc()
	local desc = self.co.describe

	if not string.nilorempty(desc) then
		desc = ArcadeConfig.instance:getCollectionDesc(self.co.id, true)
	end

	return desc or ""
end

function ArcadeHandBookCollectionMO:getIcon()
	return self.co and self.co.icon
end

function ArcadeHandBookCollectionMO:getCount()
	local mo = ArcadeHandBookModel.instance:getMoByTypeId(ArcadeEnum.HandBookType.Item, self.id)

	return mo and mo:getCount() or 1
end

return ArcadeHandBookCollectionMO
