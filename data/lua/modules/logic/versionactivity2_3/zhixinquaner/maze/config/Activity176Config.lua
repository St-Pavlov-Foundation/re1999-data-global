module("modules.logic.versionactivity2_3.zhixinquaner.maze.config.Activity176Config", package.seeall)

slot0 = class("Activity176Config", BaseConfig)

function slot0.onInit(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"activity176_bubble",
		"activity176_episode"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot0.getBubbleCo(slot0, slot1, slot2)
	if not lua_activity176_bubble.configDict[slot1] then
		return
	end

	if not slot3[slot2] then
		logError(string.format("纸信圈儿对话配置不存在: activityId = %s, id = %s", slot1, slot2))

		return
	end

	return slot4
end

function slot0.getElementCo(slot0, slot1, slot2)
	if not lua_activity176_episode.configDict[slot1] then
		return
	end

	if slot3[slot2] and slot4.elementId ~= 0 then
		return lua_chapter_map_element.configDict[slot4.elementId]
	end
end

function slot0.hasElementCo(slot0, slot1, slot2)
	return slot0:getElementCo(slot1, slot2) ~= nil
end

function slot0.getEpisodeCoByElementId(slot0, slot1, slot2)
	if not lua_activity176_episode.configDict[slot1] or not slot2 then
		return
	end

	for slot7, slot8 in pairs(slot3) do
		if slot8.elementId == slot2 then
			return slot8
		end
	end
end

slot0.instance = slot0.New()

return slot0
