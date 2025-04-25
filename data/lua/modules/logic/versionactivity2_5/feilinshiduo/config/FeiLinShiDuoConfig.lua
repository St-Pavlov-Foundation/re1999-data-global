module("modules.logic.versionactivity2_5.feilinshiduo.config.FeiLinShiDuoConfig", package.seeall)

slot0 = class("FeiLinShiDuoConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0.taskDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity185_episode",
		"activity185_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity185_episode" then
		slot0._episodeConfig = slot2

		slot0:buildStageMap()
	elseif slot1 == "activity185_task" then
		slot0._taskConfig = slot2
	end
end

function slot0.buildStageMap(slot0)
	slot0.stageMap = {}
	slot1 = 0

	for slot5, slot6 in ipairs(slot0._episodeConfig.configList) do
		if slot1 ~= slot6.stage then
			slot0.stageMap[slot6.stage] = {}
		end

		slot0.stageMap[slot1][slot6.episodeId] = slot6
	end
end

function slot0.getEpisodeConfig(slot0, slot1, slot2)
	if not slot0._episodeConfig.configDict[slot1] and not slot0._episodeConfig.configDict[slot1][slot2] then
		logError(slot1 .. " 活动没有该关卡id信息: " .. slot2)

		return nil
	end

	return slot0._episodeConfig.configDict[slot1][slot2]
end

function slot0.getEpisodeConfigList(slot0)
	return slot0._episodeConfig.configList
end

function slot0.getNoGameEpisodeList(slot0, slot1)
	slot0.noGameEpisodeList = slot0.noGameEpisodeList or {}

	if not slot0.noGameEpisodeList[slot1] then
		slot0.noGameEpisodeList[slot1] = {}

		for slot6, slot7 in ipairs(slot0:getEpisodeConfigList(slot1) or {}) do
			if slot7.storyId > 0 then
				table.insert(slot0.noGameEpisodeList[slot1], slot7)
			end
		end

		table.sort(slot0.noGameEpisodeList, slot0.sortEpisode)
	end

	return slot0.noGameEpisodeList[slot1]
end

function slot0.sortEpisode(slot0, slot1)
	return slot0.stage <= slot1.stage
end

function slot0.getGameEpisode(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getEpisodeConfigList()) do
		if slot7.preEpisodeId == slot1 and slot7.mapId > 0 then
			return slot7
		end
	end

	return nil
end

function slot0.getStageEpisodes(slot0, slot1)
	if not slot0.stageMap[slot1] then
		logError("当前关卡阶段的配置不存在，请检查" .. slot1)

		return {}
	end

	return slot0.stageMap[slot1]
end

function slot0.getTaskConfig(slot0, slot1)
	return slot0._taskConfig.configDict[slot1]
end

function slot0.getTaskByActId(slot0, slot1)
	if not slot0.taskDict[slot1] then
		slot2 = {}

		for slot6, slot7 in ipairs(lua_activity185_task.configList) do
			if slot7.activityId == slot1 then
				table.insert(slot2, slot7)
			end
		end

		slot0.taskDict[slot1] = slot2
	end

	return slot2
end

function slot0.getNextEpisode(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getEpisodeConfigList()) do
		if slot7.preEpisodeId == slot1 then
			return slot7
		end
	end

	return nil
end

slot0.instance = slot0.New()

return slot0
