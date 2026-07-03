-- chunkname: @modules/logic/abyss/config/AbyssConfig.lua

module("modules.logic.abyss.config.AbyssConfig", package.seeall)

local AbyssConfig = class("AbyssConfig", BaseConfig)

function AbyssConfig:reqConfigNames()
	return {
		"activity229_episode",
		"activity229_task",
		"activity229_const"
	}
end

function AbyssConfig:onInit()
	self:reInit()
end

function AbyssConfig:reInit()
	self._episodeListDic = {}
	self._taskActDic = nil
	self._taskActListDic = nil
	self._episodeMaxStarDic = nil
	self._episodeId2ActIdDic = nil
	self._taskIndexDic = {}
end

function AbyssConfig:onConfigLoaded(configName, configTable)
	if configName == "activity229_episode" then
		self._episodeConfig = configTable
	elseif configName == "activity229_task" then
		self._taskConfig = configTable
	elseif configName == "activity229_const" then
		self._constConfig = configTable
	end
end

function AbyssConfig:getEpisodeConfig(actId, id)
	if not self._episodeConfig then
		return nil
	end

	return self._episodeConfig.configDict[actId] and self._episodeConfig.configDict[actId][id]
end

function AbyssConfig:getTaskConfig(id)
	if not self._taskConfig then
		return nil
	end

	return self._taskConfig.configDict[id]
end

function AbyssConfig:getConstConfig(id)
	if not self._constConfig then
		return nil
	end

	return self._constConfig.configDict[id]
end

function AbyssConfig:getTaskConfigListByActId(actId)
	if not self._taskActDic then
		self._taskActDic = {}
		self._taskActListDic = {}

		for _, config in ipairs(self._taskConfig.configList) do
			local singleDic, singleList

			if not self._taskActDic[config.activityId] then
				singleDic = {}
				singleList = {}
				self._taskActDic[config.activityId] = singleDic
				self._taskActListDic[config.activityId] = singleList
			else
				singleDic = self._taskActDic[config.activityId]
				singleList = self._taskActListDic[config.activityId]
			end

			singleDic[config.id] = config

			table.insert(singleList, config)
		end
	end

	return self._taskActListDic[actId]
end

function AbyssConfig:getStageConfigByActId(actId)
	if not self._episodeConfig then
		return nil
	end

	return self._episodeConfig.configDict[actId]
end

function AbyssConfig:getStageConfigListByActId(actId)
	local episodeDic = self:getStageConfigByActId(actId)

	if not episodeDic then
		return nil
	end

	if not self._episodeListDic[actId] then
		local singleList = {}

		for _, episodeConfig in pairs(episodeDic) do
			table.insert(singleList, episodeConfig)
		end

		table.sort(singleList, AbyssConfig.sortEpisodeId)

		self._episodeListDic[actId] = singleList
	end

	return self._episodeListDic[actId]
end

function AbyssConfig.sortEpisodeId(a, b)
	return a.stage < b.stage
end

function AbyssConfig:getStageMaxStar(actId, stageId)
	if not self._episodeMaxStarDic then
		self._episodeMaxStarDic = {}

		for _, stageConfig in ipairs(self._episodeConfig.configList) do
			local episodeConfig = DungeonConfig.instance:getEpisodeCO(stageConfig.episodeId)

			if episodeConfig then
				local condition = DungeonConfig:getEpisodeAdvancedCondition(episodeConfig.id, episodeConfig.battleId)
				local param = string.split(condition, "|")
				local count = param and #param or 0
				local maxStar = AbyssEnum.MaxTaskStar + count

				if not self._episodeMaxStarDic[actId] then
					self._episodeMaxStarDic[actId] = {}
				end

				self._episodeMaxStarDic[actId][stageConfig.stage] = maxStar
			end
		end
	end

	return self._episodeMaxStarDic[actId] and self._episodeMaxStarDic[actId][stageId]
end

function AbyssConfig:getActIdByEpisodeId(episodeId)
	if not self._episodeId2ActIdDic then
		self._episodeId2ActIdDic = {}

		for _, episodeConfig in ipairs(self._episodeConfig.configList) do
			self._episodeId2ActIdDic[episodeConfig.episodeId] = episodeConfig.activityId
		end
	end

	return self._episodeId2ActIdDic[episodeId]
end

function AbyssConfig:getTaskIndexById(actId, taskId)
	if not self._taskIndexDic[actId] then
		local configList = self:getTaskConfigListByActId(actId)
		local dic = {}

		if configList and next(configList) then
			for index, config in ipairs(configList) do
				dic[config.id] = index
			end
		end

		self._taskIndexDic[actId] = dic
	end

	return self._taskIndexDic[actId][taskId]
end

AbyssConfig.instance = AbyssConfig.New()

return AbyssConfig
