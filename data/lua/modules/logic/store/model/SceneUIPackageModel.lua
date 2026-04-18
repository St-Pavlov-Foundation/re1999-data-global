-- chunkname: @modules/logic/store/model/SceneUIPackageModel.lua

module("modules.logic.store.model.SceneUIPackageModel", package.seeall)

local SceneUIPackageModel = class("SceneUIPackageModel", BaseModel)

function SceneUIPackageModel:isInSceneUIPackage(itemId)
	if not self._scemeUIPackages then
		self:_initSceneUIPackage()
	end

	for id, package in pairs(self._scemeUIPackages) do
		for _, v in ipairs(package) do
			if v[2] == itemId then
				return true
			end
		end
	end
end

function SceneUIPackageModel:isPackage(goodsId)
	if not self._scemeUIPackages then
		self:_initSceneUIPackage()
	end

	return self._scemeUIPackages[goodsId] ~= nil
end

function SceneUIPackageModel:_initSceneUIPackage()
	self._scemeUIPackages = {}

	for _, co in ipairs(lua_store_decorate.configList) do
		if co.subType == ItemEnum.SubType.SceneUIPackage then
			local storeCo = StoreConfig.instance:getGoodsConfig(co.id)

			if storeCo then
				self._scemeUIPackages[co.id] = GameUtil.splitString2(storeCo.product, true, "|", "#")
			end
		end
	end
end

SceneUIPackageModel.instance = SceneUIPackageModel.New()

return SceneUIPackageModel
