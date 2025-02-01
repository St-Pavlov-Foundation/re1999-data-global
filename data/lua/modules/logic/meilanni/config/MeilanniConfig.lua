module("modules.logic.meilanni.config.MeilanniConfig", package.seeall)

slot0 = class("MeilanniConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity108_map",
		"activity108_episode",
		"activity108_event",
		"activity108_dialog",
		"activity108_grade",
		"activity108_rule",
		"activity108_story",
		"activity108_score"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity108_dialog" then
		slot0:_initDialog()
	elseif slot1 == "activity108_episode" then
		slot0._episodeConfig = slot2

		slot0:_initEpisode()
	elseif slot1 == "activity108_event" then
		slot0:_initEvent()
	elseif slot1 == "activity108_story" then
		slot0:_initStory()
	elseif slot1 == "activity108_grade" then
		slot0:_initGrade()
	elseif slot1 == "activity108_score" then
		-- Nothing
	end
end

function slot0._initEpisode(slot0)
	slot0._mapLastEpisode = {}

	for slot4, slot5 in ipairs(lua_activity108_episode.configList) do
		if (slot0._mapLastEpisode[slot5.mapId] or slot5).id < slot5.id then
			slot6 = slot5
		end

		slot0._mapLastEpisode[slot6.mapId] = slot6
	end
end

function slot0.getLastEpisode(slot0, slot1)
	return slot0._mapLastEpisode[slot1]
end

function slot0.getLastEvent(slot0, slot1)
	return slot0._mapLastEvent[slot1]
end

function slot0._initEvent(slot0)
	slot1 = {
		[slot7.id] = slot7
	}

	for slot5, slot6 in ipairs(lua_activity108_map.configList) do
		if slot0:getLastEpisode(slot6.id) then
			-- Nothing
		end
	end

	slot0._mapLastEvent = {}

	for slot5, slot6 in ipairs(lua_activity108_event.configList) do
		if slot1[slot6.episodeId] then
			slot0._mapLastEvent[slot7.mapId] = slot6
		end
	end
end

function slot0._initStory(slot0)
	slot0._storyList = {}

	for slot4, slot5 in ipairs(lua_activity108_story.configList) do
		slot6 = string.splitToNumber(slot5.params, "#")
		slot10 = slot0._storyList[slot6[1]] or {}
		slot0._storyList[slot7] = slot10

		table.insert(slot10, {
			slot5,
			slot6[2],
			slot6[3]
		})
	end
end

function slot0.getStoryList(slot0, slot1)
	return slot0._storyList[slot1]
end

function slot0._initGrade(slot0)
	slot0._gradleList = {}

	for slot4, slot5 in ipairs(lua_activity108_grade.configList) do
		slot6 = slot0._gradleList[slot5.mapId] or {}

		table.insert(slot6, 1, slot5)

		slot0._gradleList[slot5.mapId] = slot6
	end
end

function slot0.getScoreIndex(slot0, slot1)
	slot1 = math.min(slot1, 100)
	slot2 = #lua_activity108_score.configList

	for slot6, slot7 in ipairs(lua_activity108_score.configList) do
		if slot7.minScore <= slot1 and slot1 <= slot7.maxScore then
			return slot2 - slot6 + 1
		end
	end

	return slot2
end

function slot0.getGradleIndex(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0._gradleList[slot1]) do
		if slot8.score <= slot2 then
			return slot7
		end
	end

	return #slot3
end

function slot0.getGradleList(slot0, slot1)
	return slot0._gradleList[slot1]
end

function slot0._initDialog(slot0)
	slot0._dialogList = {}
	slot1 = nil

	for slot6, slot7 in ipairs(lua_activity108_dialog.configList) do
		if not slot0._dialogList[slot7.id] then
			slot1 = "0"
			slot0._dialogList[slot7.id] = {}
		end

		if slot7.type == "selector" then
			slot8[slot1] = slot8[slot7.param] or {}
			slot8[slot1].type = slot7.type
			slot8[slot1].option_param = slot7.option_param
			slot8[slot1].result = slot7.result
		elseif slot7.type == "selectorend" then
			slot1 = slot2
		elseif slot7.type == "random" then
			slot8[slot9] = slot8[slot7.param] or {}
			slot8[slot9].type = slot7.type
			slot8[slot9].option_param = slot7.option_param

			table.insert(slot8[slot9], slot7)
		elseif slot7.stepId > 0 then
			slot8[slot1] = slot8[slot1] or {}

			table.insert(slot8[slot1], slot7)
		end
	end
end

function slot0.getDialog(slot0, slot1, slot2)
	return slot0._dialogList[slot1] and slot3[slot2]
end

function slot0.getElementConfig(slot0, slot1)
	if not lua_activity108_event.configDict[slot1] then
		logError(string.format("getElementConfig no config id:%s", slot1))
	end

	return slot2
end

function slot0.getEpisodeConfig(slot0, slot1)
	return slot0._episodeConfig.configDict[slot1]
end

function slot0.getEpisodeConfigListByMapId(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._episodeConfig.configList) do
		if slot7.mapId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
