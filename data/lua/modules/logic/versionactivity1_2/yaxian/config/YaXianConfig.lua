module("modules.logic.versionactivity1_2.yaxian.config.YaXianConfig", package.seeall)

slot0 = class("YaXianConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0.chapterConfig = nil
	slot0.chapterId2EpisodeList = nil
	slot0.mapConfig = nil
	slot0.interactObjectConfig = nil
	slot0.episodeConfig = nil
	slot0.skillConfig = nil
	slot0.toothConfig = nil
	slot0.toothUnlockEpisodeIdDict = {}
	slot0.toothUnlockSkillIdDict = {}
	slot0.toothUnlockHeroTemplateDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity115_chapter",
		"activity115_episode",
		"activity115_map",
		"activity115_interact_object",
		"activity115_tooth",
		"activity115_bonus",
		"activity115_skill"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity115_chapter" then
		slot0.chapterConfig = slot2
	elseif slot1 == "activity115_episode" then
		slot0.episodeConfig = slot2

		slot0:initEpisode()
	elseif slot1 == "activity115_map" then
		slot0.mapConfig = slot2
	elseif slot1 == "activity115_interact_object" then
		slot0.interactObjectConfig = slot2
	elseif slot1 == "activity115_skill" then
		slot0.skillConfig = slot2
	elseif slot1 == "activity115_tooth" then
		slot0.toothConfig = slot2
	end
end

function slot0.initEpisode(slot0)
	slot0.chapterId2EpisodeList = {}

	for slot4, slot5 in ipairs(slot0.episodeConfig.configList) do
		if not slot0.chapterId2EpisodeList[slot5.chapterId] then
			slot0.chapterId2EpisodeList[slot5.chapterId] = {}
		end

		table.insert(slot0.chapterId2EpisodeList[slot5.chapterId], slot5)

		if slot5.tooth ~= 0 then
			slot0.toothUnlockEpisodeIdDict[slot5.tooth] = slot5.id

			if slot5.unlockSkill ~= 0 then
				slot0.toothUnlockSkillIdDict[slot5.tooth] = slot5.unlockSkill
			end

			if slot5.trialTemplate ~= 0 then
				slot0.toothUnlockHeroTemplateDict[slot5.tooth] = slot5.trialTemplate
			end
		end
	end

	for slot4, slot5 in ipairs(slot0.chapterId2EpisodeList) do
		table.sort(slot5, function (slot0, slot1)
			return slot0.id < slot1.id
		end)
	end
end

function slot0.getChapterConfigList(slot0)
	return slot0.chapterConfig.configList
end

function slot0.getChapterConfig(slot0, slot1)
	return slot0.chapterConfig.configDict[YaXianEnum.ActivityId][slot1]
end

function slot0.getMapConfig(slot0, slot1, slot2)
	if slot0.mapConfig.configDict[slot1] then
		return slot0.mapConfig.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getEpisodeConfig(slot0, slot1, slot2)
	if slot0.episodeConfig.configDict[slot1] then
		return slot0.episodeConfig.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getPreEpisodeConfig(slot0, slot1, slot2)
	return slot0:getEpisodeConfig(slot1, slot2 - 1)
end

function slot0.getEpisodeCanFinishInteractCount(slot0, slot1)
	if not slot1 then
		return 0
	end

	slot0.episodeCanFinishInteractCountDict = slot0.episodeCanFinishInteractCountDict or {}

	if slot0.episodeCanFinishInteractCountDict[slot1.mapId] then
		return slot0.episodeCanFinishInteractCountDict[slot1.mapId]
	end

	if not slot0:getMapConfig(slot1.activityId, slot1.mapId) then
		slot0.episodeCanFinishInteractCountDict[slot1.mapId] = 0

		return 0
	end

	for slot8, slot9 in ipairs(cjson.decode(slot2.objects)) do
		if slot0:checkInteractCanFinish(slot0:getInteractObjectCo(slot9.actId, slot9.id)) then
			slot4 = 0 + 1
		end
	end

	slot0.episodeCanFinishInteractCountDict[slot1.mapId] = slot4

	return slot4
end

function slot0.checkInteractCanFinish(slot0, slot1)
	return slot1 and slot1.interactType == YaXianGameEnum.InteractType.Enemy
end

function slot0.getConditionList(slot0, slot1)
	if not slot1 then
		return {}
	end

	slot2 = GameUtil.splitString2(slot1.extStarCondition, true, "|", "#") or {}

	table.insert(slot2, {
		YaXianGameEnum.ConditionType.PassEpisode
	})

	return slot2
end

function slot0.getInteractObjectCo(slot0, slot1, slot2)
	if slot0.interactObjectConfig.configDict[slot1] then
		return slot0.interactObjectConfig.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getSkillConfig(slot0, slot1, slot2)
	if slot0.skillConfig.configDict[slot1] then
		return slot0.skillConfig.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getThroughSkillDistance(slot0)
	if not slot0.throughSkillDistance then
		slot0.throughSkillDistance = slot0:getSkillConfig(YaXianEnum.ActivityId, YaXianGameEnum.SkillId.ThroughWall) and tonumber(slot1.param)
	end

	return slot0.throughSkillDistance
end

function slot0.getToothConfig(slot0, slot1)
	return slot0.toothConfig.configDict[YaXianEnum.ActivityId][slot1]
end

function slot0.getToothUnlockEpisode(slot0, slot1)
	return slot0.toothUnlockEpisodeIdDict and slot0.toothUnlockEpisodeIdDict[slot1]
end

function slot0.getToothUnlockSkill(slot0, slot1)
	return slot0.toothUnlockSkillIdDict and slot0.toothUnlockSkillIdDict[slot1]
end

function slot0.getToothUnlockHeroTemplate(slot0, slot1)
	return slot0.toothUnlockHeroTemplateDict and slot0.toothUnlockHeroTemplateDict[slot1]
end

function slot0.getMaxBonusScore(slot0)
	if not slot0.maxBonusScore then
		slot0.maxBonusScore = 0

		for slot4, slot5 in ipairs(lua_activity115_bonus.configList) do
			if slot0.maxBonusScore < slot5.needScore then
				slot0.maxBonusScore = slot5.needScore
			end
		end
	end

	return slot0.maxBonusScore
end

slot0.instance = slot0.New()

return slot0
