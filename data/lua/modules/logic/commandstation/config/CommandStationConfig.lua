-- chunkname: @modules/logic/commandstation/config/CommandStationConfig.lua

module("modules.logic.commandstation.config.CommandStationConfig", package.seeall)

local CommandStationConfig = class("CommandStationConfig", BaseConfig)

function CommandStationConfig:reqConfigNames()
	return {
		"copost_character_event",
		"copost_version",
		"copost_time_axis",
		"copost_time_point",
		"copost_time_point_event",
		"copost_event",
		"copost_event_text",
		"copost_version_task",
		"copost_catch_task",
		"copost_bonus",
		"copost_npc",
		"copost_npc_text",
		"copost_password_paper",
		"copost_character",
		"copost_const",
		"copost_scene",
		"copost_decoration",
		"copost_decoration_coordinates"
	}
end

function CommandStationConfig:onInit()
	return
end

function CommandStationConfig:onConfigLoaded(configName, configTable)
	if configName == "copost_version" then
		self:_initVersion()
	elseif configName == "copost_time_axis" then
		self:_initTimeAxis()
	elseif configName == "copost_time_point" then
		self:_initTimePoint()
	elseif configName == "copost_time_point_event" then
		self:_initTimePointEvent()
	elseif configName == "copost_event" then
		self:_initEvent()
	elseif configName == "copost_character_event" then
		self:_initCharacterEvent()
	elseif configName == "copost_event_text" then
		self:_initEventText()
	elseif configName == "copost_version_task" then
		self:_initVersionTask()
	elseif configName == "copost_catch_task" then
		self:_initCatchTask()
	elseif configName == "copost_bonus" then
		self:_initBonus()
	elseif configName == "copost_npc" then
		self:_initNpc()
	elseif configName == "copost_npc_text" then
		self:_initNpcText()
	elseif configName == "copost_password_paper" then
		self:_initPasswordPaper()
	end
end

function CommandStationConfig:_initVersion()
	local len = #lua_copost_version.configList
	local config = lua_copost_version.configList[len]

	self._maxVersionId = config.versionId
end

function CommandStationConfig:_initTimeAxis()
	self:_initVersionTimeline()
	self:_initTimeGroup()
end

function CommandStationConfig:_initVersionTimeline()
	self._verionTimeline = {}
	self._timePointSceneMap = {}

	local allVersion = {}

	for i, v in ipairs(lua_copost_time_axis.configList) do
		self._verionTimeline[v.versionId] = self._verionTimeline[v.versionId] or {}

		table.insert(self._verionTimeline[v.versionId], v)

		allVersion[v.id] = allVersion[v.id] or {}

		local list = allVersion[v.id]

		for _, timeId in ipairs(v.timeId) do
			table.insert(list, timeId)

			self._timePointSceneMap[timeId] = v.sceneId
		end
	end

	local allVersionList = {}

	for k, v in pairs(allVersion) do
		table.insert(allVersionList, {
			id = k,
			timeId = v
		})
	end

	self._verionTimeline[CommandStationEnum.AllVersion] = allVersionList

	for k, v in pairs(self._verionTimeline) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
end

function CommandStationConfig:_initTimeGroup()
	self._timeGroup = {}

	for i, v in ipairs(lua_copost_time_axis.configList) do
		for _, timeId in ipairs(v.timeId) do
			self._timeGroup[timeId] = v
		end
	end
end

function CommandStationConfig:_initTimePoint()
	return
end

function CommandStationConfig:_initTimePointEvent()
	self._episodeIdTimeIdMap = {}
	self._characterEventTime = {}
	self._characterTimeGroup = {}

	local characterTimeGroup = {}

	for i, v in ipairs(lua_copost_time_point_event.configList) do
		if not self._episodeIdTimeIdMap[v.fightId] then
			self._episodeIdTimeIdMap[v.fightId] = v.id
		end

		for _, characterEventId in ipairs(v.chaEventId) do
			self._characterEventTime[characterEventId] = v

			local characterEventConfig = lua_copost_character_event.configDict[characterEventId]

			if characterEventConfig then
				characterTimeGroup[characterEventConfig.chaId] = characterTimeGroup[characterEventConfig.chaId] or {}

				local timeGroup = self._timeGroup[v.id]

				if timeGroup then
					local list = characterTimeGroup[characterEventConfig.chaId]

					if not tabletool.indexOf(list, timeGroup) then
						table.insert(list, timeGroup)
					end
				else
					logError(string.format("CommandStationConfig _initTimePointEvent timeId %d not exist in copost_time_axis", characterEventConfig.id))
				end
			else
				logError(string.format("CommandStationConfig _initTimePointEvent characterEventId %d not exist", characterEventId))
			end
		end
	end

	for k, v in pairs(characterTimeGroup) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	for chaId, list in pairs(characterTimeGroup) do
		self._characterTimeGroup[chaId] = {}

		for i, v in pairs(list) do
			local timeIdList = {}

			for _, timeId in ipairs(v.timeId) do
				local characterEventList = self:getCharacterEventList(timeId)

				for _, characterEventId in ipairs(characterEventList) do
					if self._characterEventMap[characterEventId] == chaId then
						table.insert(timeIdList, timeId)
					end
				end
			end

			self._characterTimeGroup[chaId][i] = {
				versionId = v.versionId,
				id = v.id,
				timeId = timeIdList
			}
		end
	end
end

function CommandStationConfig:_initEvent()
	return
end

function CommandStationConfig:_initCharacterEvent()
	self._characterEventMap = {}

	for i, v in ipairs(lua_copost_character_event.configList) do
		self._characterEventMap[v.id] = v.chaId
	end
end

function CommandStationConfig:_initEventText()
	return
end

function CommandStationConfig:_initVersionTask()
	return
end

function CommandStationConfig:_initCatchTask()
	return
end

function CommandStationConfig:_initBonus()
	self._taskBonusList = {}

	for i, v in ipairs(lua_copost_bonus.configList) do
		table.insert(self._taskBonusList, v)
	end

	table.sort(self._taskBonusList, SortUtil.tableKeyLower({
		"versionId",
		"pointNum"
	}))
end

function CommandStationConfig:_initNpc()
	self._dialogueList = {}

	for i, v in ipairs(lua_copost_npc.configList) do
		self._dialogueList[v.condition] = v
	end
end

function CommandStationConfig:_initNpcText()
	return
end

function CommandStationConfig:_initPasswordPaper()
	self._paperList = {}

	for i, v in ipairs(lua_copost_password_paper.configList) do
		table.insert(self._paperList, v)
	end

	table.sort(self._paperList, SortUtil.keyLower("versionId"))
end

function CommandStationConfig:getMaxVersionId()
	return self._maxVersionId
end

function CommandStationConfig:getSceneConfig(id)
	local config = lua_copost_scene.configDict[id]

	if not config then
		logError(string.format("场景配置表不存在，id:%d", id))

		return nil
	end

	return config
end

function CommandStationConfig:getTimeIdByEpisodeId(id)
	return self._episodeIdTimeIdMap[id]
end

function CommandStationConfig:getTimeGroupByEpisodeId(id)
	local timePoint = self:getTimeIdByEpisodeId(id)

	return timePoint and self._timeGroup[timePoint]
end

function CommandStationConfig:getConstConfig(id)
	local config = lua_copost_const.configDict[id]

	if not config then
		logError("lua_copost_const config not found id:" .. id)
	end

	return config
end

function CommandStationConfig:getDialogByType(type)
	return self._dialogueList[type]
end

function CommandStationConfig:getRandomDialogTextId(type)
	local dialogue = self._dialogueList[type]
	local textId = dialogue.textId
	local weight = dialogue.weight
	local totalWeight = 0

	for i, v in ipairs(weight) do
		totalWeight = totalWeight + v
	end

	local randomWeight = math.random(1, totalWeight)
	local tempWeight = 0

	for i, v in ipairs(weight) do
		tempWeight = tempWeight + v

		if randomWeight <= tempWeight then
			return textId[i]
		end
	end
end

function CommandStationConfig:getCharacterIdByEventId(eventId)
	return self._characterEventMap[eventId]
end

function CommandStationConfig:getVersionList()
	return lua_copost_version.configList
end

function CommandStationConfig:getVersionIndex(versionId)
	for i, v in ipairs(lua_copost_version.configList) do
		if v.versionId == versionId then
			return i
		end
	end

	return 1
end

function CommandStationConfig:getVersionTimeline(versionId)
	local list = self._verionTimeline[versionId]

	if not list then
		logError(string.format("CommandStationConfig getVersionTimeline not list versionId:%s", versionId))

		return {}
	end

	return list
end

function CommandStationConfig:getTimeGroupByTimeId(timeId)
	return self._timeGroup[timeId]
end

function CommandStationConfig:getTimeGroupByCharacterId(id)
	return self._characterTimeGroup[id]
end

function CommandStationConfig:getTimeGroupByCharacterEventId(id)
	local timeConfig = self._characterEventTime[id]

	return timeConfig and self:getTimeGroupByTimeId(timeConfig.id)
end

function CommandStationConfig:getCharacterEventList(timeId)
	local timePointConfig = lua_copost_time_point_event.configDict[timeId]

	if not timePointConfig then
		logError(string.format("CommandStationConfig getCharacterEventList not timePointConfig timeId:%s", timeId))

		return {}
	end

	return timePointConfig.chaEventId
end

function CommandStationConfig:getTimePointEpisodeId(timeId)
	local timePointConfig = lua_copost_time_point_event.configDict[timeId]

	if not timePointConfig then
		logError(string.format("CommandStationConfig getTimePointEpisodeId not timePointConfig timeId:%s", timeId))

		return nil
	end

	return timePointConfig.fightId
end

function CommandStationConfig:getEventList(timeId, filteredEventId, eventKey)
	local timePointConfig = lua_copost_time_point_event.configDict[timeId]

	if not timePointConfig then
		logError(string.format("CommandStationConfig getEventList not timePointConfig timeId:%s", timeId))

		return {}
	end

	local list = timePointConfig[eventKey or CommandStationEnum.EventCategoryKey.Normal]

	if filteredEventId then
		local index = tabletool.indexOf(list, filteredEventId)

		if index == -1 then
			logError(string.format("CommandStationConfig getEventList not filteredEventId timeId:%s filteredEventId:%s", timeId, filteredEventId))

			return {}
		end

		local filteredEventConfig = lua_copost_event.configDict[filteredEventId]

		if not filteredEventConfig then
			logError(string.format("CommandStationConfig getEventList not filteredEventConfig timeId:%s filteredEventId:%s", timeId, filteredEventId))

			return {}
		end

		local result = {}

		for i, v in ipairs(list) do
			local config = lua_copost_event.configDict[v]

			if config and config.eventType == filteredEventConfig.eventType then
				table.insert(result, v)
			end
		end

		return result
	end

	return list
end

function CommandStationConfig:getTimePointName(timeId)
	local config = lua_copost_time_point.configDict[timeId]

	if not config then
		logError(string.format("CommandStationConfig getTimePointName not config timeId:%s", timeId))

		return ""
	end

	return config.time
end

function CommandStationConfig:getCurVersionId()
	if not self._curVersionId then
		self._curVersionId = CommonConfig.instance:getConstNum(CommandStationEnum.ConstId_CurVersion)
	end

	return self._curVersionId
end

function CommandStationConfig:getPaperItemId()
	if not self._paperItemId then
		self._paperItemId = CommonConfig.instance:getConstNum(CommandStationEnum.ConstId_PaperItemId)
	end

	return self._paperItemId
end

function CommandStationConfig:getCurTotalPaperCount(versionId)
	local num = 0
	local curVersionId = versionId or self:getCurVersionId()

	for i, v in ipairs(self._paperList) do
		if curVersionId >= v.versionId then
			num = num + v.allNum
		else
			break
		end
	end

	return num
end

function CommandStationConfig:getPaperList()
	local list = {}
	local curVersionId = self:getCurVersionId()

	for i, v in ipairs(self._paperList) do
		if curVersionId >= v.versionId then
			table.insert(list, v)
		end
	end

	return list
end

function CommandStationConfig:getCurPaperCount()
	local itemId = self:getPaperItemId()

	return ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, itemId)
end

function CommandStationConfig:getTotalTaskRewards()
	local list = {}
	local itemCounts = {}
	local curVersionId = self:getCurVersionId()

	for _, v in ipairs(self._taskBonusList) do
		if curVersionId >= v.versionId then
			table.insert(list, v)
			table.insert(itemCounts, #GameUtil.splitString2(v.bonus))
		else
			break
		end
	end

	return list, itemCounts
end

CommandStationConfig.instance = CommandStationConfig.New()

return CommandStationConfig
