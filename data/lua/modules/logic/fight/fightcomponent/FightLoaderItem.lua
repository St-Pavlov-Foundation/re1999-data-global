-- chunkname: @modules/logic/fight/fightcomponent/FightLoaderItem.lua

module("modules.logic.fight.fightcomponent.FightLoaderItem", package.seeall)

local FightLoaderItem = class("FightLoaderItem", FightBaseClass)

function FightLoaderItem:onConstructor(url, callback, handle, param)
	self.url = url
	self.callback = callback
	self.handle = handle
	self.param = param
end

function FightLoaderItem:startLoad()
	loadAbAsset(self.url, false, self.onLoadCallback, self)
end

function FightLoaderItem:onLoadCallback(assetItem)
	local oldAsstet = self.assetItem

	self.assetItem = assetItem

	local url = assetItem.ResPath
	local success = assetItem.IsLoadSuccess

	assetItem:Retain()

	if oldAsstet then
		oldAsstet:Release()
	end

	if not success then
		logError("资源加载失败,URL:" .. url)
	end

	if not self.handle.IS_DISPOSED and self.callback then
		self.callback(self.handle, success, assetItem, self.param)
	end
end

function FightLoaderItem:onDestructor()
	removeAssetLoadCb(self.url, self.onLoadCallback, self)

	if self.assetItem then
		self.assetItem:Release()
	end
end

return FightLoaderItem
