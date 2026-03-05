-- chunkname: @modules/logic/versionactivity220/config/Activity220Config.lua

module("modules.logic.versionactivity220.config.Activity220Config", package.seeall)

local Activity220Config = class("Activity220Config", BaseConfig)

function Activity220Config:ctor()
	self.activityTaskList = {}
end

function Activity220Config:reqConfigNames()
	return {
		"activity220_const",
		"activity220_episode",
		"activity220_task"
	}
end

function Activity220Config:onConfigLoaded(configName, configTable)
	if configName == "activity220_const" then
		self._constConfig = configTable
	elseif configName == "activity220_episode" then
		self._episodeConfig = configTable
	elseif configName == "activity220_task" then
		self._taskConfig = configTable

		self:buildTaskData()
	end
end

function Activity220Config:getConstConfigValue(activityId, id, isString)
	local config = self._constConfig.configDict[activityId] and self._constConfig.configDict[activityId][id]

	if config then
		return isString and config.value2 or tonumber(config.value)
	else
		logError("活动id: " .. activityId .. " 的常量id: " .. id .. " 配置不存在，请检查！")
	end
end

function Activity220Config:getConstValue(activityId, id)
	local config = self._constConfig.configDict[activityId] and self._constConfig.configDict[activityId][id]

	return config.value
end

function Activity220Config:getConstValue2(activityId, id)
	local config = self._constConfig.configDict[activityId] and self._constConfig.configDict[activityId][id]

	return config.value2
end

function Activity220Config:getEpisodeConfig(activityId, episodeId)
	return self._episodeConfig.configDict[activityId] and self._episodeConfig.configDict[activityId][episodeId]
end

function Activity220Config:getAllEpisodeConfigMap(activityId)
	return self._episodeConfig.configDict[activityId]
end

function Activity220Config:getEpisodeConfigList(activityId)
	if not self._episodesMap then
		self._episodesMap = {}

		for _, v in ipairs(lua_activity220_episode.configList) do
			if not self._episodesMap[v.activityId] then
				self._episodesMap[v.activityId] = {}
			end

			table.insert(self._episodesMap[v.activityId], v)
		end
	end

	return self._episodesMap[activityId] or {}
end

function Activity220Config:getEpisodeIndex(activityId, episodeId)
	local colist = self:getEpisodeConfigList(activityId)

	for index, co in ipairs(colist) do
		if co.episodeId == episodeId then
			return index
		end
	end
end

function Activity220Config:buildTaskData()
	self.activityTaskList = {}

	for _, config in ipairs(self._taskConfig.configList) do
		if not self.activityTaskList[config.activityId] then
			self.activityTaskList[config.activityId] = {}
		end

		table.insert(self.activityTaskList[config.activityId], config)
	end
end

function Activity220Config:getTaskConfig(taskId)
	return self._taskConfig.configDict[taskId]
end

function Activity220Config:getAllActivityTaskConfigList(activityId)
	return self.activityTaskList[activityId] or {}
end

Activity220Config.instance = Activity220Config.New()

return Activity220Config
