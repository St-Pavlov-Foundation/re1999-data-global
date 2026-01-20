-- chunkname: @modules/logic/rouge/model/RougeCollectionOverListModel.lua

module("modules.logic.rouge.model.RougeCollectionOverListModel", package.seeall)

local RougeCollectionOverListModel = class("RougeCollectionOverListModel", ListScrollModel)

function RougeCollectionOverListModel:onInitData()
	self:onCollectionDataUpdate()
end

function RougeCollectionOverListModel:onCollectionDataUpdate()
	local showCollectionList = {}
	local collectionMap = {}
	local slotAreaCollections = RougeCollectionModel.instance:getSlotAreaCollection()

	if slotAreaCollections then
		for _, collection in ipairs(slotAreaCollections) do
			if not collectionMap[collection.id] then
				collectionMap[collection.id] = true

				table.insert(showCollectionList, collection)
			end
		end
	end

	table.sort(showCollectionList, self.sortFunc)
	self:setList(showCollectionList)
end

function RougeCollectionOverListModel.sortFunc(a, b)
	local aCfg = RougeCollectionConfig.instance:getCollectionCfg(a.cfgId)
	local bCfg = RougeCollectionConfig.instance:getCollectionCfg(b.cfgId)
	local aShowRare = aCfg and aCfg.showRare or 0
	local bShowRare = bCfg and bCfg.showRare or 0

	if aShowRare ~= bShowRare then
		return bShowRare < aShowRare
	end

	local aShapeArea = RougeCollectionConfig.instance:getOriginEditorParam(a.cfgId, RougeEnum.CollectionEditorParamType.Shape)
	local bShapeArea = RougeCollectionConfig.instance:getOriginEditorParam(b.cfgId, RougeEnum.CollectionEditorParamType.Shape)
	local aShapeAreaSize = aShapeArea and #aShapeArea or 0
	local bShapeAreaSize = bShapeArea and #bShapeArea or 0

	if aShapeAreaSize ~= bShapeAreaSize then
		return bShapeAreaSize < aShapeAreaSize
	end

	return a.id < b.id
end

function RougeCollectionOverListModel:isBagEmpty()
	return self:getCount() <= 0
end

RougeCollectionOverListModel.instance = RougeCollectionOverListModel.New()

return RougeCollectionOverListModel
