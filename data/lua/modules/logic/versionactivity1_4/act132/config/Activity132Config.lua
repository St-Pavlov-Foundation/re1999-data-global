module("modules.logic.versionactivity1_4.act132.config.Activity132Config", package.seeall)

slot0 = class("Activity132Config", BaseConfig)

function slot0.ctor(slot0)
	slot0.clueDict = {}
	slot0.collectDict = {}
	slot0.contentDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity132_clue",
		"activity132_collect",
		"activity132_content"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("on%sConfigLoaded", slot1)] then
		slot4(slot0, slot1, slot2)
	end
end

function slot0.onactivity132_clueConfigLoaded(slot0, slot1, slot2)
	slot0.clueDict = slot2.configDict
end

function slot0.onactivity132_collectConfigLoaded(slot0, slot1, slot2)
	slot0.collectDict = slot2.configDict
end

function slot0.onactivity132_contentConfigLoaded(slot0, slot1, slot2)
	slot0.contentDict = slot2.configDict
end

function slot0.getCollectConfig(slot0, slot1, slot2)
	if not (slot0.collectDict[slot1] and slot3[slot2]) then
		logError(string.format("can not find collect! activityId:%s collectId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getClueConfig(slot0, slot1, slot2)
	if not (slot0.clueDict[slot1] and slot3[slot2]) then
		logError(string.format("can not find clue config! activityId:%s clueId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getContentConfig(slot0, slot1, slot2)
	if not (slot0.contentDict[slot1] and slot3[slot2]) then
		logError(string.format("can not find content config! activityId:%s contentId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getCollectDict(slot0, slot1)
	return slot0.collectDict[slot1]
end

slot0.instance = slot0.New()

return slot0
