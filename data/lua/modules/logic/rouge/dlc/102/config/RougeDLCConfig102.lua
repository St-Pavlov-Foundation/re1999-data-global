-- chunkname: @modules/logic/rouge/dlc/102/config/RougeDLCConfig102.lua

module("modules.logic.rouge.dlc.102.config.RougeDLCConfig102", package.seeall)

local RougeDLCConfig102 = class("RougeDLCConfig102", BaseConfig)

function RougeDLCConfig102:reqConfigNames()
	return {
		"rouge_spcollection_desc",
		"rouge_collection_trammels"
	}
end

function RougeDLCConfig102:onConfigLoaded(configName, configTable)
	if configName == "rouge_spcollection_desc" then
		self:onSpCollectionDescConfigLoaded(configTable)
	elseif configName == "rouge_collection_trammels" then
		self._trammelConfigTab = configTable
	end
end

function RougeDLCConfig102:onSpCollectionDescConfigLoaded(configTable)
	self._descTab = configTable
	self._descMap = {}

	for _, descCo in ipairs(configTable.configList) do
		local collectionId = descCo.id
		local descCos = self._descMap and self._descMap[collectionId]

		if not descCos then
			descCos = {}
			self._descMap[collectionId] = descCos
		end

		table.insert(descCos, descCo)
	end

	for _, descCos in pairs(self._descMap) do
		table.sort(descCos, self._spCollectionDescSortFunc)
	end
end

function RougeDLCConfig102._spCollectionDescSortFunc(a, b)
	if a.effectId ~= b.effectId then
		return a.effectId < b.effectId
	end
end

function RougeDLCConfig102:getSpCollectionDescCos(collectionId)
	local descCos = self._descMap and self._descMap[collectionId]

	return descCos
end

function RougeDLCConfig102:getCollectionLevelUpCo(levelupId)
	return self._levelConfigTab and self._levelConfigTab.configDict[levelupId]
end

function RougeDLCConfig102:getAllCollectionTrammelCo()
	return self._trammelConfigTab and self._trammelConfigTab.configList
end

function RougeDLCConfig102:getCollectionOwnerCo(collectionCfgId)
	local collectionCo = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	if not collectionCo then
		return
	end

	local ownerId = collectionCo.ownerId

	if ownerId and ownerId ~= 0 then
		local characterCo = HeroConfig.instance:getHeroCO(ownerId)

		return characterCo
	end
end

RougeDLCConfig102.instance = RougeDLCConfig102.New()

return RougeDLCConfig102
