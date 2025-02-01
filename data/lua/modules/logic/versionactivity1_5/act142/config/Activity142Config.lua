module("modules.logic.versionactivity1_5.act142.config.Activity142Config", package.seeall)

slot0 = class("Activity142Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity142_chapter",
		"activity142_episode",
		"activity142_interact_effect",
		"activity142_interact_object",
		"activity142_collection",
		"activity142_map",
		"activity142_story",
		"activity142_task",
		"activity142_tips"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("%sConfigLoaded", slot1)] then
		slot4(slot0, slot2)
	end
end

function slot1(slot0, slot1)
	return slot0 < slot1
end

function slot2(slot0, slot1)
	return slot0.order < slot1.order
end

function slot0.activity142_episodeConfigLoaded(slot0, slot1)
	slot0._episodeListDict = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.configList) do
		if not slot0._episodeListDict[slot7.activityId] then
			slot0._episodeListDict[slot8] = {}
		end

		if not slot9[slot7.chapterId] then
			slot11 = {}
			slot9[slot10] = slot11

			table.insert(slot2, slot11)
		end

		table.insert(slot11, slot7.id)
	end

	for slot6, slot7 in ipairs(slot2) do
		table.sort(slot7, uv0)
	end
end

function slot0.activity142_mapConfigLoaded(slot0, slot1)
	slot0._groundItemUrDict = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		if slot6 and not string.nilorempty(slot6.groundItems) then
			if not slot0._groundItemUrDict[slot6.activityId] then
				slot0._groundItemUrDict[slot7] = {}
			end

			if not slot8[slot6.id] then
				slot8[slot9] = {}
			end

			for slot15, slot16 in ipairs(string.split(slot6.groundItems, "#") or {}) do
				if not string.nilorempty(slot16) then
					table.insert(slot10, string.format(Va3ChessEnum.SceneResPath.AvatarItemPath, slot16))
				end
			end
		end
	end
end

function slot0.activity142_storyConfigLoaded(slot0, slot1)
	slot0._storyListDict = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.configList) do
		if not slot0._storyListDict[slot7.activityId] then
			slot0._storyListDict[slot8] = {}
		end

		if not slot9[slot7.episodeId] then
			slot10 = {}
			slot9[slot7.episodeId] = slot10

			table.insert(slot2, slot10)
		end

		table.insert(slot10, slot7)
	end

	for slot6, slot7 in ipairs(slot2) do
		table.sort(slot7, uv0)
	end
end

function slot3(slot0, slot1, slot2)
	slot3 = nil

	if lua_activity142_chapter and lua_activity142_chapter.configDict[slot0] then
		slot3 = lua_activity142_chapter.configDict[slot0][slot1]
	end

	if not slot3 and slot2 then
		logError(string.format("Activity142Config:getChapterCfg error, cfg is nil, actId:%s chapterId:%s", slot0, slot1))
	end

	return slot3
end

function slot4(slot0, slot1)
	return slot0 < slot1
end

function slot0.getChapterList(slot0, slot1)
	if not lua_activity142_chapter then
		return {}
	end

	for slot6, slot7 in ipairs(lua_activity142_chapter.configList) do
		if slot7.activityId == slot1 then
			table.insert(slot2, slot7.id)
		end
	end

	table.sort(slot2, uv0)

	return slot2
end

function slot0.getChapterEpisodeIdList(slot0, slot1, slot2)
	if slot0._episodeListDict and slot0._episodeListDict[slot1] then
		slot3 = slot0._episodeListDict[slot1][slot2] or {}
	end

	return slot3
end

slot5 = 2

function slot0.isSPChapter(slot0, slot1)
	slot2 = false

	if slot1 then
		slot2 = uv0 < slot1
	else
		logError("Activity142Config:isSPChapter error chapterId is nil")
	end

	return slot2
end

function slot0.getChapterName(slot0, slot1, slot2)
	if uv0(slot1, slot2, true) then
		return slot3.name
	end
end

function slot0.getChapterCategoryTxtColor(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.txtColor
	end

	return slot3
end

function slot0.getChapterCategoryNormalSP(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.normalSprite
	end

	return slot3
end

function slot0.getChapterCategorySelectSP(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.selectSprite
	end

	return slot3
end

function slot0.getChapterCategoryLockSP(slot0, slot1, slot2)
	slot3 = nil

	if uv0(slot1, slot2, true) then
		slot3 = slot4.lockSprite
	end

	return slot3
end

function slot0.getEpisodeCo(slot0, slot1, slot2, slot3)
	slot4 = nil

	if lua_activity142_episode and lua_activity142_episode.configDict[slot1] then
		slot4 = lua_activity142_episode.configDict[slot1][slot2]
	end

	if not slot4 and slot3 then
		logError(string.format("Activity142Config:getEpisodeCo error, cfg is nil, actId:%s episodeId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getEpisodePreEpisode(slot0, slot1, slot2)
	if slot0:getEpisodeCo(slot1, slot2, true) then
		return slot3.preEpisode
	end
end

function slot0.getEpisodeOrder(slot0, slot1, slot2)
	if slot0:getEpisodeCo(slot1, slot2, true) then
		return slot3.orderId
	end
end

function slot0.getEpisodeName(slot0, slot1, slot2)
	if slot0:getEpisodeCo(slot1, slot2, true) then
		return slot3.name
	end
end

function slot0.getEpisodeExtCondition(slot0, slot1, slot2)
	if slot0:getEpisodeCo(slot1, slot2, true) then
		return slot3.extStarCondition
	end
end

function slot0.getEpisodeMaxStar(slot0, slot1, slot2)
	if not string.nilorempty(slot0:getEpisodeExtCondition(slot1, slot2)) then
		slot3 = Activity142Enum.DEFAULT_STAR_NUM + 1
	end

	return slot3
end

function slot0.getEpisodeOpenDay(slot0, slot1, slot2)
	if slot0:getEpisodeCo(slot1, slot2, true) then
		return slot3.openDay
	end
end

function slot0.getEpisodeNormalSP(slot0, slot1, slot2)
	slot3 = nil

	if slot0:getEpisodeCo(slot1, slot2, true) then
		slot3 = slot4.normalSprite
	end

	return slot3
end

function slot0.getEpisodeLockSP(slot0, slot1, slot2)
	slot3 = nil

	if slot0:getEpisodeCo(slot1, slot2, true) then
		slot3 = slot4.lockSprite
	end

	return slot3
end

function slot0.isStoryEpisode(slot0, slot1, slot2)
	slot3 = true

	if slot0:getEpisodeCo(slot1, slot2, true) then
		slot3 = string.nilorempty(slot4.mapIds)
	end

	return slot3
end

function slot0.getMapCo(slot0, slot1, slot2, slot3)
	slot4 = nil

	if lua_activity142_map and lua_activity142_map.configDict[slot1] then
		slot4 = lua_activity142_map.configDict[slot1][slot2]
	end

	if not slot4 and slot3 then
		logError(string.format("Activity142Config:getMapCo error, cfg is nil, actId:%s mapId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getGroundItemUrlList(slot0, slot1, slot2)
	slot3 = nil

	if slot0._groundItemUrDict and slot0._groundItemUrDict[slot1] and slot0._groundItemUrDict[slot1][slot2] then
		slot3 = slot0._groundItemUrDict[slot1][slot2]
	end

	if not slot3 then
		slot3 = {
			Va3ChessEnum.SceneResPath.GroundItem
		}

		logError(string.format("Activity142Config:getGroundItemUrlList error, can't find groundItemUrls, actId:%s mapId:%s", slot1, slot2))
	end

	return slot3
end

function slot0.getAct142StoryCfg(slot0, slot1, slot2, slot3)
	slot4 = nil

	if lua_activity142_story and lua_activity142_story.configDict[slot1] then
		slot4 = lua_activity142_story.configDict[slot1][slot2]
	end

	if not slot4 and slot3 then
		logError(string.format("Activity142Config:getAct142StoryCfg error, cfg is nil, actId:%s storyId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getEpisodeStoryList(slot0, slot1, slot2)
	if slot0._storyListDict and slot0._storyListDict[slot1] then
		slot3 = slot0._storyListDict[slot1][slot2] or {}
	end

	return slot3
end

function slot0.getCollectionCfg(slot0, slot1, slot2, slot3)
	slot4 = nil

	if lua_activity142_collection and lua_activity142_collection.configDict[slot1] then
		slot4 = lua_activity142_collection.configDict[slot1][slot2]
	end

	if not slot4 and slot3 then
		logError(string.format("Activity142Config:getCollectionCfg error, cfg is nil, actId:%s collectId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getCollectionName(slot0, slot1, slot2)
	slot3 = ""

	if slot0:getCollectionCfg(slot1, slot2, true) then
		slot3 = slot4.name
	end

	return slot3
end

function slot0.getCollectionList(slot0, slot1)
	if not slot1 then
		logError("Activity142Config:getCollectionList error, actId is nil")

		return {}
	end

	for slot6, slot7 in ipairs(lua_activity142_collection.configList) do
		if slot7.activityId == slot1 then
			table.insert(slot2, slot7.id)
		end
	end

	return slot2
end

function slot0.getInteractObjectCo(slot0, slot1, slot2, slot3)
	slot4 = nil

	if lua_activity142_interact_object and lua_activity142_interact_object.configDict[slot1] then
		slot4 = lua_activity142_interact_object.configDict[slot1][slot2]
	end

	if not slot4 and slot3 then
		logError(string.format("Activity142Config:getInteractObjectCo error, cfg is nil, actId:%s interactObjId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getTipsCfg(slot0, slot1, slot2, slot3)
	slot4 = nil

	if lua_activity142_tips and lua_activity142_tips.configDict[slot1] then
		slot4 = lua_activity142_tips.configDict[slot1][slot2]
	end

	if not slot4 and slot3 then
		logError(string.format("Activity142Config:getTipsCfg error, cfg is nil, actId:%s tipId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getTaskByActId(slot0, slot1)
	if not slot1 then
		logError("Activity142Config:getTaskByActId error, actId is nil")

		return {}
	end

	for slot6, slot7 in ipairs(lua_activity142_task.configList) do
		if slot7.activityId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getEffectCo(slot0, slot1, slot2)
	slot3 = nil

	if lua_activity142_interact_effect and lua_activity142_interact_effect.configDict[slot2] then
		slot3 = lua_activity142_interact_effect.configDict[slot2]
	end

	if slot2 ~= 0 and not slot3 then
		logError(string.format("Activity142Config:getEffectCo error, cfg is nil, effectId:%s", slot2))
	end

	return slot3
end

function slot0.getChapterEpisodeId(slot0, slot1)
end

slot0.instance = slot0.New()

return slot0
