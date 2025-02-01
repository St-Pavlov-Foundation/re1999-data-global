module("modules.logic.versionactivity1_3.chess.config.Activity122Config", package.seeall)

slot0 = class("Activity122Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._act122Objects = nil
	slot0._act122Map = nil
	slot0._act122Episode = nil
	slot0._act122Task = nil
	slot0._act122StroyCfg = nil
	slot0._act122Tips = nil
	slot0._act122EffectCfg = nil
	slot0._episodeListDict = {}
	slot0._chapterIdListDict = {}
	slot0._chapterEpisodeListDict = {}
	slot0._mapStoryListDict = {}
	slot0._chapterEpisodeListDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity122_map",
		"activity122_interact",
		"activity122_episode",
		"activity122_task",
		"activity122_tips",
		"activity122_interact_effect",
		"activity122_story"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity122_interact" then
		slot0._act122Objects = slot2
	elseif slot1 == "activity122_map" then
		slot0._act122Map = slot2
	elseif slot1 == "activity122_episode" then
		slot0._act122Episode = slot2
	elseif slot1 == "activity122_task" then
		slot0._act122Task = slot2
	elseif slot1 == "activity122_tips" then
		slot0._act122Tips = slot2
	elseif slot1 == "activity122_interact_effect" then
		slot0._act122EffectCfg = slot2
	elseif slot1 == "activity122_story" then
		slot0._act122StroyCfg = slot2
	end
end

function slot0.getTaskByActId(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._act122Task.configList) do
		if slot7.activityId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getInteractObjectCo(slot0, slot1, slot2)
	if slot0._act122Objects.configDict[slot1] then
		return slot0._act122Objects.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getMapCo(slot0, slot1, slot2)
	if slot0._act122Map.configDict[slot1] then
		return slot0._act122Map.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getEpisodeCo(slot0, slot1, slot2)
	if slot0._act122Episode.configDict[slot1] then
		return slot0._act122Episode.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getChapterEpisodeList(slot0, slot1, slot2)
	if slot0._chapterEpisodeListDict[slot1] then
		return slot0._chapterEpisodeListDict[slot1][slot2]
	end

	if not slot0:getEpisodeList(slot1) then
		return nil
	end

	slot0._chapterEpisodeListDict[slot1] = {}
	slot5 = nil

	for slot9, slot10 in ipairs(slot3) do
		if not slot4[slot10.chapterId] then
			slot4[slot10.chapterId] = {}
		end

		table.insert(slot5, slot10)
	end

	return slot4[slot2]
end

function slot0.getEffectCo(slot0, slot1, slot2)
	return slot0._act122EffectCfg and slot0._act122EffectCfg.configDict[slot2]
end

function slot0.getTipsCfg(slot0, slot1, slot2)
	if slot0._act122Tips.configDict[slot1] then
		return slot0._act122Tips.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getChapterEpisodeId(slot0, slot1)
	return Activity1_3ChessEnum.chapterId, Activity1_3ChessEnum.episodeId
end

function slot0.getEpisodeList(slot0, slot1)
	if slot0._episodeListDict[slot1] then
		return slot0._episodeListDict[slot1], slot0._chapterIdListDict[slot1]
	end

	slot0._episodeListDict[slot1] = {}
	slot0._chapterIdListDict[slot1] = {}

	if slot0._act122Episode and slot0._act122Episode.configDict[slot1] then
		for slot7, slot8 in pairs(slot0._act122Episode.configDict[slot1]) do
			slot2[#slot2 + 1] = slot8

			if not tabletool.indexOf(slot3, slot8.chapterId) and slot8.chapterId then
				slot3[#slot3 + 1] = slot8.chapterId
			end
		end

		table.sort(slot2, uv0.sortEpisode)
		table.sort(slot3, uv0.sortChapter)
	end

	return slot2, slot3
end

function slot0.sortEpisode(slot0, slot1)
	if slot0.id ~= slot1.id then
		return slot0.id < slot1.id
	end
end

function slot0.sortChapter(slot0, slot1)
	if slot0 ~= slot1 then
		return slot0 < slot1
	end
end

function slot0.getTaskList(slot0)
	if slot0._task_list then
		return slot0._task_list
	end

	slot0._task_list = {}

	for slot4, slot5 in pairs(lua_activity122_task.configDict) do
		if Activity122Model.instance:getCurActivityID() == slot5.activityId then
			table.insert(slot0._task_list, slot5)
		end
	end

	return slot0._task_list
end

function slot0._createStoryCo(slot0, slot1, slot2, slot3)
	return {
		storyId = slot1,
		typeId = slot3,
		config = slot2
	}
end

function slot0._isChessTipsCfg(slot0, slot1)
	return slot0:getTipsCfg(VersionActivity1_3Enum.ActivityId.Act304, slot1) ~= nil
end

function slot0.getEpisodeStoryList(slot0, slot1, slot2)
	if not slot0._episodeStoryListDict then
		slot0:_initStroyCfg()
	end

	return slot0._episodeStoryListDict[slot1] and slot0._episodeStoryListDict[slot1][slot2]
end

function slot0._initStroyCfg(slot0)
	slot0._episodeStoryListDict = {}
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._act122StroyCfg.configList) do
		if not slot0._episodeStoryListDict[slot6.activityId] then
			slot0._episodeStoryListDict[slot7] = {}
		end

		if not slot8[slot6.episodeId] then
			slot9 = {}
			slot8[slot6.episodeId] = slot9
			slot1[#slot1 + 1] = slot9
		end

		table.insert(slot9, slot6)
	end

	for slot5, slot6 in ipairs(slot1) do
		table.sort(slot6, uv0.sortStory)
	end
end

function slot0.sortStory(slot0, slot1)
	if slot0.order ~= slot1.order then
		return slot0.order < slot1.order
	end
end

slot0.instance = slot0.New()

return slot0
