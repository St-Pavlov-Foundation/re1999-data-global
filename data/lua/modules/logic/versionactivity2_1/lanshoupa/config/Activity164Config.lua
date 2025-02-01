module("modules.logic.versionactivity2_1.lanshoupa.config.Activity164Config", package.seeall)

slot0 = class("Activity164Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._act164Episode = nil
	slot0._act164Task = nil
	slot0._episodeListDict = {}
	slot0._chapterIdListDict = {}
	slot0._chapterEpisodeListDict = {}
	slot0._bubbleListDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity164_episode",
		"activity164_task",
		"activity164_story",
		"activity164_tips",
		"activity164_bubble"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity164_episode" then
		slot0._act164Episode = slot2

		slot0:_initEpisodeList()
	elseif slot1 == "activity164_task" then
		slot0._act164Task = slot2
	elseif slot1 == "activity164_story" then
		slot0._act164Story = slot2
	elseif slot1 == "activity164_tips" then
		slot0._act164Tips = slot2
	elseif slot1 == "activity164_bubble" then
		slot0._act164Bubble = slot2
	end
end

function slot0._initEpisodeList(slot0)
	for slot4, slot5 in pairs(slot0._act164Episode.configDict) do
		slot0._episodeListDict[slot4] = slot0._episodeListDict[slot4] or {}

		for slot9, slot10 in pairs(slot5) do
			table.insert(slot0._episodeListDict[slot4], slot10)
		end

		table.sort(slot0._episodeListDict[slot4], uv0.sortEpisode)
	end
end

function slot0.getTaskByActId(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._act164Task.configList) do
		if slot7.activityId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getEpisodeCo(slot0, slot1, slot2)
	if slot0._act164Episode.configDict[slot1] then
		return slot0._act164Episode.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getEpisodeIndex(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0._episodeListDict[slot1]) do
		if slot8.id == slot2 then
			return slot7
		end
	end
end

function slot0.getEpisodeCoDict(slot0, slot1)
	return slot0._act164Episode.configDict[slot1]
end

function slot0.getEpisodeCoList(slot0, slot1)
	return slot0._episodeListDict[slot1]
end

function slot0.getTipsCo(slot0, slot1, slot2)
	if slot0._act164Tips.configDict[slot1] then
		return slot0._act164Tips.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getBubbleCo(slot0, slot1, slot2)
	if slot0._act164Bubble.configDict[slot1] then
		return slot0._act164Bubble.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getBubbleCoByGroup(slot0, slot1, slot2)
	return slot0._act164Bubble.configDict[slot1][slot2]
end

function slot0._initBubbleConfig(slot0)
	for slot4, slot5 in pairs(slot0._act164Bubble.configDict) do
		slot0._bubbleListDict[slot4] = slot5

		for slot9, slot10 in ipairs(slot5) do
			slot0._bubbleListDict[slot4][slot9] = slot0._bubbleListDict[slot4][slot9] or {}

			table.insert(slot0._bubbleListDict[slot4][slot9], slot10)
		end
	end
end

function slot0.sortEpisode(slot0, slot1)
	if slot0.id ~= slot1.id then
		return slot0.id < slot1.id
	end
end

function slot0.getStoryList(slot0, slot1, slot2)
	return lua_activity164_story.configDict[slot1] and slot3[slot2]
end

function slot0.getTaskList(slot0)
	if slot0._task_list then
		return slot0._task_list
	end

	slot0._task_list = {}

	for slot4, slot5 in pairs(lua_activity164_task.configDict) do
		if Activity164Model.instance:getCurActivityID() == slot5.activityId then
			table.insert(slot0._task_list, slot5)
		end
	end

	return slot0._task_list
end

slot0.instance = slot0.New()

return slot0
