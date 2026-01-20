-- chunkname: @modules/logic/tower/model/TowerEpisodeMo.lua

module("modules.logic.tower.model.TowerEpisodeMo", package.seeall)

local TowerEpisodeMo = pureTable("TowerEpisodeMo")

function TowerEpisodeMo:init(towerType, config)
	self.towerType = towerType

	self:initEpisode(config)
end

function TowerEpisodeMo:initEpisode(config)
	self.episodeList = {}
	self.preEpisodeDict = {}
	self.normalEpisodeCountDict = {}
	self.configDict = config.configDict

	local towerId

	for _, episode in pairs(config.configList) do
		towerId = episode.towerId

		local preEpisodeDict = self.preEpisodeDict[towerId]

		if not preEpisodeDict then
			preEpisodeDict = {}
			self.preEpisodeDict[towerId] = preEpisodeDict
		end

		preEpisodeDict[episode.preLayerId] = episode.layerId
	end

	local episodeConfig, nextEpisode, episodes

	for towerId, dict in pairs(self.preEpisodeDict) do
		local episodeList = self.episodeList[towerId]

		if not episodeList then
			episodeList = {}
			self.episodeList[towerId] = episodeList
		end

		nextEpisode = dict[0]
		episodes = self:getEpisodeDict(towerId)

		while nextEpisode ~= nil do
			episodeConfig = episodes[nextEpisode]

			if episodeConfig.openRound > 0 and self.normalEpisodeCountDict[towerId] == nil then
				self.normalEpisodeCountDict[towerId] = #episodeList
			end

			table.insert(episodeList, nextEpisode)

			nextEpisode = dict[nextEpisode]
		end

		if self.normalEpisodeCountDict[towerId] == nil then
			self.normalEpisodeCountDict[towerId] = #episodeList
		end
	end
end

function TowerEpisodeMo:getEpisodeList(towerId)
	return self.episodeList[towerId]
end

function TowerEpisodeMo:getEpisodeDict(towerId)
	return self.configDict[towerId]
end

function TowerEpisodeMo:getEpisodeConfig(towerId, layer)
	local dict = self:getEpisodeDict(towerId)
	local config = dict and dict[layer]

	if config == nil and layer ~= 0 then
		logError(string.format("episode config is nil, towerType:%s,towerId:%s,layer:%s", self.towerType, towerId, layer))
	end

	return config
end

function TowerEpisodeMo:getNextEpisodeLayer(towerId, layer)
	local dict = self.preEpisodeDict[towerId]

	return dict and dict[layer]
end

function TowerEpisodeMo:getEpisodeIndex(towerId, layerId, realIndex)
	local config = self:getEpisodeConfig(towerId, layerId)

	if not config then
		return 0
	end

	local isSp = config.openRound > 0
	local list = self:getEpisodeList(towerId)
	local index = tabletool.indexOf(list, layerId)

	if not realIndex then
		local begin = isSp and self.normalEpisodeCountDict[towerId] or 0

		index = index - begin
	end

	return index
end

function TowerEpisodeMo:getSpEpisodes(towerId)
	local list = {}
	local begin = self.normalEpisodeCountDict[towerId]

	if begin then
		local episodeList = self:getEpisodeList(towerId)

		for i = begin + 1, #episodeList do
			table.insert(list, episodeList[i])
		end
	end

	return list
end

function TowerEpisodeMo:getLayerCount(towerId, isSp)
	local count = self.normalEpisodeCountDict[towerId] or 0

	if isSp then
		local episodeList = self:getEpisodeList(towerId)

		count = #episodeList - count
	end

	return count
end

function TowerEpisodeMo:isPassAllUnlockLayers(towerId)
	local towerInfo = TowerModel.instance:getTowerInfoById(self.towerType, towerId)
	local passLayerId = towerInfo and towerInfo.passLayerId or 0
	local nextLayerId = self:getNextEpisodeLayer(towerId, passLayerId)

	if not nextLayerId then
		return true
	end

	local layerConfig = self:getEpisodeConfig(towerId, nextLayerId)

	if not layerConfig then
		return true
	end

	local isSp = layerConfig.openRound > 0

	if not isSp then
		return false
	end

	return not towerInfo:isSpLayerOpen(nextLayerId)
end

return TowerEpisodeMo
