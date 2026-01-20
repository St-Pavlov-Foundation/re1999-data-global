-- chunkname: @modules/logic/rouge2/map/model/mapmodel/Rouge2_PathSelectMapModel.lua

module("modules.logic.rouge2.map.model.mapmodel.Rouge2_PathSelectMapModel", package.seeall)

local Rouge2_PathSelectMapModel = class("Rouge2_PathSelectMapModel")

function Rouge2_PathSelectMapModel:initMap(middleLayerInfo)
	self.layerId = middleLayerInfo.layerId
	self.layerCo = lua_rouge2_layer.configDict[self.layerId]
	self.middleLayerId = middleLayerInfo.middleLayerId
	self.middleLayerCo = lua_rouge2_middle_layer.configDict[self.middleLayerId]
	self.nextLayerWeatherMap = GameUtil.rpcInfosToMap(middleLayerInfo.nextLayerWeatherInfo, Rouge2_NextLayerWeatherInfoMO, "_layerId")

	self:initPieceInfo(middleLayerInfo.pieceInfo)
	self:initNextLayerList()
	self:initPathSelectCo()
end

function Rouge2_PathSelectMapModel:initPieceInfo(pieceInfoList)
	self.pieceDict = {}
	self.pieceList = {}

	for _, pieceInfo in ipairs(pieceInfoList) do
		local pieceMo = Rouge2_PieceInfoMO.New()

		pieceMo:init(pieceInfo)

		self.pieceDict[pieceMo.index] = pieceMo

		table.insert(self.pieceList, pieceMo)
	end
end

function Rouge2_PathSelectMapModel:initPathSelectCo()
	local pathSelectList = Rouge2_MapConfig.instance:getPathSelectList(self.middleLayerId)

	if #pathSelectList == 1 then
		self.pathSelectId = pathSelectList[1]
		self.pathSelectCo = lua_rouge2_path_select.configDict[self.pathSelectId]

		if not self.pathSelectCo then
			logError("kong " .. self.pathSelectId)
		end

		return
	end

	for index, layerId in ipairs(self.allLayerList) do
		if self.selectLayerId == layerId then
			self.pathSelectId = pathSelectList[index]
			self.pathSelectCo = lua_rouge2_path_select.configDict[self.pathSelectId]

			if not self.pathSelectCo then
				logError("kong " .. self.pathSelectId)
			end

			return
		end
	end

	logError("路线选择层 一个可以选择的路线都没找到, 间隙层id : " .. tostring(self.middleLayerId))
end

function Rouge2_PathSelectMapModel:updateMapInfo(layerInfo)
	return
end

function Rouge2_PathSelectMapModel:updateSimpleMapInfo(layerInfo)
	self:updateMapInfo(layerInfo)
end

function Rouge2_PathSelectMapModel:initNextLayerList()
	local nextLayerList = Rouge2_MapConfig.instance:getNextLayerList(self.middleLayerId)

	if not nextLayerList then
		self.nextLayerList = nil
		self.selectLayerId = nil

		return
	end

	self.nextLayerList = {}
	self.allLayerList = {}

	for _, layerId in ipairs(nextLayerList) do
		local layerCo = lua_rouge2_layer.configDict[layerId]

		if not layerCo then
			logError("layerId = " .. layerId)
		end

		if Rouge2_MapUnlockHelper.checkIsUnlock(layerCo.unlock) then
			self.selectLayerId = layerId

			table.insert(self.nextLayerList, layerId)
		end

		table.insert(self.allLayerList, layerId)
	end
end

function Rouge2_PathSelectMapModel:updateSelectLayerId(layerId)
	if self.selectLayerId == layerId then
		return
	end

	self.selectLayerId = layerId

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectLayerChange, self.selectLayerId)
end

function Rouge2_PathSelectMapModel:getSelectLayerId()
	return self.selectLayerId
end

function Rouge2_PathSelectMapModel:getPieceList()
	return self.pieceList
end

function Rouge2_PathSelectMapModel:getNextLayerList()
	return self.nextLayerList
end

function Rouge2_PathSelectMapModel:getNextLayerWeatherInfoList(layerId)
	local weatherMo = self.nextLayerWeatherMap and self.nextLayerWeatherMap[layerId]

	return weatherMo and weatherMo:getWeatherInfoList()
end

function Rouge2_PathSelectMapModel:getNextLayerWeatherInfoMap(layerId)
	local weatherMo = self.nextLayerWeatherMap and self.nextLayerWeatherMap[layerId]

	return weatherMo and weatherMo:getWeatherInfoMap()
end

function Rouge2_PathSelectMapModel:clear()
	self.layerId = nil
	self.layerCo = nil
	self.middleLayerId = nil
	self.middleCo = nil
	self.pieceDict = nil
	self.pieceList = nil
end

return Rouge2_PathSelectMapModel
