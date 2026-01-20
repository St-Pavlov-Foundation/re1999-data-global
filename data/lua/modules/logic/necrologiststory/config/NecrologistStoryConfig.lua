-- chunkname: @modules/logic/necrologiststory/config/NecrologistStoryConfig.lua

module("modules.logic.necrologiststory.config.NecrologistStoryConfig", package.seeall)

local NecrologistStoryConfig = class("NecrologistStoryConfig", BaseConfig)

function NecrologistStoryConfig:ctor()
	self._openConfig = nil
	self._opengroupConfig = nil
	self.versionConfigList = {
		NecrologistStoryV3A1Config,
		NecrologistStoryV3A2Config
	}
end

function NecrologistStoryConfig:reqConfigNames()
	local list = {
		"hero_story_plot",
		"hero_story_plot_group",
		"hero_story_introduce",
		"hero_story_task"
	}

	self.configNameLoadedDict = {}

	for index, configClass in ipairs(self.versionConfigList) do
		local configNames = configClass.instance:reqConfigNames()

		for _, configName in ipairs(configNames) do
			table.insert(list, configName)

			self.configNameLoadedDict[configName] = index
		end
	end

	return list
end

function NecrologistStoryConfig:onConfigLoaded(configName, configTable)
	local classIndex = self.configNameLoadedDict[configName]

	if classIndex then
		local configClass = self.versionConfigList[classIndex]

		if configClass then
			configClass.instance:onConfigLoaded(configName, configTable)
		end

		return
	end

	local loadFuncName = string.format("on%sLoaded", configName)
	local func = self[loadFuncName]

	if func then
		func(self, configTable)
	end
end

function NecrologistStoryConfig:onhero_story_plot_groupLoaded(configTable)
	self._heroStoryPlotGroupConfig = configTable
end

function NecrologistStoryConfig:onhero_story_taskLoaded(configTable)
	self._heroStoryTaskConfig = configTable
end

function NecrologistStoryConfig:onhero_story_plotLoaded(configTable)
	self._heroStoryMainConfig = configTable
	self._heroStoryMainDict = {}

	local sectionId
	local defaultId = 0

	for _, co in ipairs(configTable.configList) do
		local group = self._heroStoryMainDict[co.storygroup]

		if not group then
			group = {}
			self._heroStoryMainDict[co.storygroup] = group
			sectionId = defaultId
		end

		if co.type == "selector" then
			sectionId = tonumber(co.param)
		elseif co.type == "selectorend" then
			sectionId = defaultId
		else
			group[sectionId] = group[sectionId] or {}

			table.insert(group[sectionId], co)
		end
	end

	for _, group in pairs(self._heroStoryMainDict) do
		for _, coList in pairs(group) do
			table.sort(coList, SortUtil.keyLower("id"))
		end
	end
end

function NecrologistStoryConfig:onhero_story_introduceLoaded(configTable)
	self._heroStoryIntroduceConfig = configTable
end

function NecrologistStoryConfig:getStoryListByGroupId(groupId)
	local storyGroup = self._heroStoryMainDict[groupId]

	if not storyGroup then
		logError(string.format("storygroup config list is nil, groupId:%s", groupId))
	end

	return storyGroup
end

function NecrologistStoryConfig:getStoryConfig(storyId, notError)
	local co = self._heroStoryMainConfig.configDict[storyId]

	if not co and not notError then
		logError(string.format("story config is nil, storyId:%s", storyId))
	end

	return co
end

function NecrologistStoryConfig:getIntroduceCoByName(name)
	local lang = LangSettings.instance:getCurLang() or -1

	if not self.introduceCoByName then
		self.introduceCoByName = {}
	end

	if not self.introduceCoByName[lang] then
		local tmp = {}

		for i, v in ipairs(self._heroStoryIntroduceConfig.configList) do
			tmp[v.name] = v
		end

		self.introduceCoByName[lang] = tmp
	end

	local co = self.introduceCoByName[lang][name]

	if not co then
		logError(string.format("名词说明 '%s' 不存在!!!", tostring(name)))
	end

	return co
end

function NecrologistStoryConfig:getIntroduceCo(id)
	local co = self._heroStoryIntroduceConfig.configDict[id]

	if not co then
		logError(string.format("IntroduceConfig is nil id:%s", id))
	end

	return co
end

function NecrologistStoryConfig:getTaskCo(id)
	local co = self._heroStoryTaskConfig.configDict[id]

	if not co then
		logError(string.format("TaskConfig is nil id:%s", id))
	end

	return co
end

function NecrologistStoryConfig:getPlotGroupCo(id)
	local co = self._heroStoryPlotGroupConfig.configDict[id]

	if not co then
		logError(string.format("PlotGroupConfig is nil id:%s", id))
	end

	return co
end

function NecrologistStoryConfig:getPlotListByStoryId(storyId)
	if not self._plotListByStoryIdDict then
		self._plotListByStoryIdDict = {}

		for _, co in ipairs(self._heroStoryPlotGroupConfig.configList) do
			if not self._plotListByStoryIdDict[co.storyId] then
				self._plotListByStoryIdDict[co.storyId] = {}
			end

			table.insert(self._plotListByStoryIdDict[co.storyId], co)
		end
	end

	return self._plotListByStoryIdDict[storyId] or {}
end

NecrologistStoryConfig.instance = NecrologistStoryConfig.New()

return NecrologistStoryConfig
