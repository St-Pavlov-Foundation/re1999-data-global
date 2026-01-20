-- chunkname: @modules/logic/turnback/config/TurnbackConfig.lua

module("modules.logic.turnback.config.TurnbackConfig", package.seeall)

local TurnbackConfig = class("TurnbackConfig", BaseConfig)

function TurnbackConfig:ctor()
	self._turnbackConfig = nil
	self._turnbackSigninConfig = nil
	self._turnbackTaskConfig = nil
	self._turnbackSubModuleConfig = nil
	self._turnbackTaskBonusConfig = nil
	self._turnbackRecommendConfig = nil
end

function TurnbackConfig:reqConfigNames()
	return {
		"turnback",
		"turnback_sign_in",
		"turnback_task",
		"turnback_submodule",
		"turnback_task_bonus",
		"turnback_recommend",
		"turnback_drop",
		"turnback_daily_bonus"
	}
end

function TurnbackConfig:onConfigLoaded(configName, configTable)
	if configName == "turnback" then
		self:initTurnbackConfig(configTable)
	elseif configName == "turnback_sign_in" then
		self._turnbackSigninConfig = configTable
	elseif configName == "turnback_task" then
		self._turnbackTaskConfig = configTable
	elseif configName == "turnback_submodule" then
		self._turnbackSubModuleConfig = configTable
	elseif configName == "turnback_task_bonus" then
		self._turnbackTaskBonusConfig = configTable
	elseif configName == "turnback_recommend" then
		self._turnbackRecommendConfig = configTable
	elseif configName == "turnback_drop" then
		self._turnbackDropConfig = configTable
	elseif configName == "turnback_daily_bonus" then
		self._turnbackDailyBonusConfig = configTable
	end
end

function TurnbackConfig:initTurnbackConfig(configTable)
	self._turnbackConfig = configTable
	self.turnBackAdditionChapterId = {}

	for turnBackId, cfg in pairs(configTable.configDict) do
		local chapterIdDic = {}
		local additionChapterIds = string.splitToNumber(cfg.additionChapterIds, "#")

		for _, chapterId in ipairs(additionChapterIds) do
			chapterIdDic[chapterId] = true
		end

		self.turnBackAdditionChapterId[turnBackId] = chapterIdDic
	end
end

function TurnbackConfig:isTurnBackAdditionToChapter(turnBackId, chapterId)
	local result = false

	if turnBackId and chapterId and self.turnBackAdditionChapterId and self.turnBackAdditionChapterId[turnBackId] then
		result = self.turnBackAdditionChapterId[turnBackId][chapterId]
	end

	return result
end

function TurnbackConfig:getTurnbackCo(id)
	return self._turnbackConfig.configDict[id]
end

function TurnbackConfig:getTurnbackSignInCo(id)
	return self._turnbackSigninConfig.configDict[id]
end

function TurnbackConfig:getTurnbackSignInDayCo(id, day)
	return self._turnbackSigninConfig.configDict[id][day]
end

function TurnbackConfig:getTurnbackTaskCo(id)
	return self._turnbackTaskConfig.configDict[id]
end

function TurnbackConfig:getTurnbackSubModuleCo(id)
	return self._turnbackSubModuleConfig.configDict[id]
end

function TurnbackConfig:getAllTurnbackTaskBonusCo(turnbackId)
	return self._turnbackTaskBonusConfig.configDict[turnbackId]
end

function TurnbackConfig:getTurnbackTaskBonusCo(turnbackId, id)
	return self._turnbackTaskBonusConfig.configDict[turnbackId][id]
end

function TurnbackConfig:getTurnbackLastBounsPoint(turnbackId)
	local list = self._turnbackTaskBonusConfig.configDict[turnbackId]

	if list then
		return list[#list].needPoint
	end

	return 0
end

function TurnbackConfig:getAllTurnbackTaskBonusCoCount(turnbackId)
	return #self._turnbackTaskBonusConfig.configList[turnbackId]
end

function TurnbackConfig:getTurnbackDailyBonusConfig(turnbackId, day)
	return self._turnbackDailyBonusConfig.configDict[turnbackId][day]
end

function TurnbackConfig:getAllTurnbackSubModules(turnbackid)
	local turnbackConfig = self:getTurnbackCo(turnbackid)
	local subViewTab = string.splitToNumber(turnbackConfig.subModuleIds, "#")

	return subViewTab
end

function TurnbackConfig:getTurnbackSubViewCo(turnbackid, subId)
	local subViewTab = self:getAllTurnbackSubModules(turnbackid)
	local subViewCo

	for _, subViewId in ipairs(subViewTab) do
		if subViewId == subId then
			subViewCo = self:getTurnbackSubModuleCo(subViewId)

			break
		end
	end

	return subViewCo
end

function TurnbackConfig:getAdditionTotalCount(turnbackid)
	local result = 0
	local turnbackConfig = self:getTurnbackCo(turnbackid)

	if turnbackConfig then
		local additionTab = string.splitToNumber(turnbackConfig.additionType, "#")

		result = additionTab[2] or 0
	end

	return result
end

function TurnbackConfig:getAdditionRate(turnbackid)
	local result = 0
	local turnbackConfig = self:getTurnbackCo(turnbackid)

	if turnbackConfig then
		result = turnbackConfig.additionRate
	end

	return result
end

function TurnbackConfig:getAdditionDurationDays(turnbackid)
	local result = 0
	local turnbackConfig = self:getTurnbackCo(turnbackid)

	if turnbackConfig then
		result = turnbackConfig.additionDurationDays
	end

	return result
end

function TurnbackConfig:getOnlineDurationDays(turnbackid)
	local result = 0
	local turnbackConfig = self:getTurnbackCo(turnbackid)

	if turnbackConfig then
		result = turnbackConfig.onlineDurationDays
	end

	return result
end

function TurnbackConfig:getTaskItemBonusPoint(turnbackId, taskId)
	local bonusPointItemType, bonusPointItemId = self:getBonusPointCo(turnbackId)
	local taskConfig = self:getTurnbackTaskCo(taskId)
	local taskBonusItemTab = string.split(taskConfig.bonus, "|")

	for _, item in ipairs(taskBonusItemTab) do
		local itemCoTab = string.split(item, "#")

		if tonumber(itemCoTab[1]) == bonusPointItemType and tonumber(itemCoTab[2]) == bonusPointItemId then
			return tonumber(itemCoTab[3]) or 0
		end
	end
end

function TurnbackConfig:getBonusPointCo(turnbackId)
	local turnbackConfig = self:getTurnbackCo(turnbackId)
	local bonusPointItemCo = string.split(turnbackConfig.bonusPointMaterial, "#")
	local bonusPointItemType = tonumber(bonusPointItemCo[1])
	local bonusPointItemId = tonumber(bonusPointItemCo[2])

	return bonusPointItemType, bonusPointItemId
end

function TurnbackConfig:getAllRecommendCo(turnbackId)
	return self._turnbackRecommendConfig.configDict[turnbackId]
end

function TurnbackConfig:getAllRecommendList(turnbackId)
	local allConfigList = self._turnbackRecommendConfig.configList
	local configList = {}

	for id, config in ipairs(allConfigList) do
		if config.turnbackId == turnbackId then
			table.insert(configList, config)
		end
	end

	return configList
end

function TurnbackConfig:getRecommendCo(turnbackId, id)
	return self._turnbackRecommendConfig.configDict[turnbackId][id]
end

function TurnbackConfig:getSearchTaskCoList(turnbackId)
	local list = {}

	for index, value in ipairs(self._turnbackTaskConfig.configList) do
		if value.listenerType == "TodayOnlineSeconds" and value.turnbackId == turnbackId then
			table.insert(list, value)
		end
	end

	return list
end

function TurnbackConfig:getDropCoList()
	return self._turnbackDropConfig.configList
end

function TurnbackConfig:getDropCoById(id)
	return self._turnbackDropConfig.configDict[id]
end

function TurnbackConfig:getDropCoCount()
	return #self._turnbackDropConfig.configList
end

TurnbackConfig.instance = TurnbackConfig.New()

return TurnbackConfig
