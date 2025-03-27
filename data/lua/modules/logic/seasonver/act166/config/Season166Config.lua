slot0 = class("Season166Config", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"activity166_const_global",
		"activity166_const",
		"activity166_score",
		"activity166_base",
		"activity166_base_level",
		"activity166_base_target",
		"activity166_train",
		"activity166_teach",
		"activity166_info_analy",
		"activity166_info_bonus",
		"activity166_info",
		"activity166_talent",
		"activity166_talent_style",
		"activity166_word_effect",
		"activity166_word_effect_pos"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity166_const" then
		slot0._constConfig = slot2
	elseif slot1 == "activity166_const_global" then
		slot0._constGlobalConfig = slot2
	elseif slot1 == "activity166_score" then
		slot0._scoreConfig = slot2
	elseif slot1 == "activity166_base" then
		slot0._baseSpotConfig = slot2
		slot0._actId2BaseSpotCoList = {}
	elseif slot1 == "activity166_base_level" then
		slot0._baseSpotLevelConfig = slot2
		slot0._baseLevelCoList = {}
	elseif slot1 == "activity166_base_target" then
		slot0._baseTargetConfig = slot2
		slot0._baseTargetCoList = {}
	elseif slot1 == "activity166_train" then
		slot0._trainConfig = slot2
		slot0._trainCoList = {}
	elseif slot1 == "activity166_teach" then
		slot0._teachConfig = slot2
	elseif slot1 == "activity166_info_analy" then
		slot0._infoAnalyConfig = slot2
	elseif slot1 == "activity166_info_bonus" then
		slot0._infoBonusConfig = slot2
	elseif slot1 == "activity166_info" then
		slot0._infoConfig = slot2
	elseif slot1 == "activity166_word_effect" then
		slot0._wordEffectConfig = slot2

		slot0:buildSeasonWordEffectConfig()
	elseif slot1 == "activity166_word_effect_pos" then
		slot0._wordEffectPosConfig = slot2
	end

	slot0._episodeId2Config = {}
end

function slot0.getSeasonConstGlobalCo(slot0, slot1)
	return slot0._constGlobalConfig.configDict[slot1]
end

function slot0.getSeasonConstCo(slot0, slot1)
	return slot0._constConfig.configDict[slot1]
end

function slot0.getSeasonConstNum(slot0, slot1, slot2)
	if not slot0._constConfig.configDict[slot1] or not slot0._constConfig.configDict[slot1][slot2] then
		return nil
	end

	return slot0._constConfig.configDict[slot1][slot2].value1
end

function slot0.getSeasonConstStr(slot0, slot1, slot2)
	if not slot0._constConfig.configDict[slot1] or not slot0._constConfig.configDict[slot1][slot2] then
		return nil
	end

	return slot0._constConfig.configDict[slot1][slot2].value2
end

function slot0.getSeasonBaseSpotCos(slot0, slot1)
	if not slot0._actId2BaseSpotCoList[slot1] then
		slot0._actId2BaseSpotCoList[slot1] = {}

		if slot0._baseSpotConfig.configDict[slot1] then
			for slot7, slot8 in pairs(slot3) do
				table.insert(slot2, slot8)
			end

			table.sort(slot2, function (slot0, slot1)
				return slot0.baseId < slot1.baseId
			end)
		end
	end

	return slot2
end

function slot0.getSeasonBaseSpotCo(slot0, slot1, slot2)
	return slot0._baseSpotConfig.configDict[slot1][slot2]
end

function slot0.getSeasonBaseLevelCo(slot0, slot1, slot2, slot3)
	if slot0._baseSpotLevelConfig.configDict[slot1] and slot0._baseSpotLevelConfig.configDict[slot1][slot2] then
		return slot0._baseSpotLevelConfig.configDict[slot1][slot2][slot3]
	end
end

function slot0.getSeasonBaseLevelCos(slot0, slot1, slot2)
	if not slot0._baseLevelCoList[slot1] then
		slot0._baseLevelCoList[slot1] = {}
	end

	if not slot3[slot2] then
		slot3[slot2] = {}

		for slot9, slot10 in pairs(slot0._baseSpotLevelConfig.configDict[slot1] and slot0._baseSpotLevelConfig.configDict[slot1][slot2] or {}) do
			table.insert(slot4, slot10)
		end

		table.sort(slot4, function (slot0, slot1)
			return slot0.level < slot1.level
		end)
	end

	return slot0._baseLevelCoList[slot1][slot2]
end

function slot0.getSeasonBaseTargetCo(slot0, slot1, slot2, slot3)
	if slot0._baseTargetConfig.configDict[slot1] and slot0._baseTargetConfig.configDict[slot1][slot2] then
		return slot0._baseTargetConfig.configDict[slot1][slot2][slot3]
	end
end

function slot0.getSeasonBaseTargetCos(slot0, slot1, slot2)
	if not slot0._baseTargetCoList[slot1] then
		slot0._baseTargetCoList[slot1] = {}

		for slot8, slot9 in pairs(slot0._baseTargetConfig.configDict[slot1] and slot0._baseTargetConfig.configDict[slot1][slot2] or {}) do
			table.insert(slot3, slot9)
		end

		table.sort(slot3, function (slot0, slot1)
			return slot0.targetId < slot1.targetId
		end)
	end

	return slot3
end

function slot0.getSeasonTrainCos(slot0, slot1)
	if not slot0._trainCoList[slot1] then
		slot0._trainCoList[slot1] = {}

		if slot0._trainConfig.configDict[slot1] then
			for slot7, slot8 in pairs(slot3) do
				table.insert(slot2, slot8)
			end

			table.sort(slot2, function (slot0, slot1)
				return slot0.trainId < slot1.trainId
			end)
		end
	end

	return slot2
end

function slot0.getSeasonTrainCo(slot0, slot1, slot2)
	return slot0._trainConfig.configDict[slot1] and slot0._trainConfig.configDict[slot1][slot2]
end

function slot0.getSeasonTeachCos(slot0, slot1)
	return slot0._teachConfig.configDict[slot1]
end

function slot0.getAllSeasonTeachCos(slot0)
	return slot0._teachConfig.configList
end

function slot0.getSeasonScoreCo(slot0, slot1, slot2)
	return slot0._scoreConfig.configDict[slot1][slot2]
end

function slot0.getSeasonScoreCos(slot0, slot1)
	return slot0._scoreConfig.configDict[slot1]
end

function slot0.getSeasonInfos(slot0, slot1)
	return slot0._infoConfig.configDict[slot1]
end

function slot0.getSeasonInfoConfig(slot0, slot1, slot2)
	return slot0._infoConfig.configDict[slot1] and slot0._infoConfig.configDict[slot1][slot2]
end

function slot0.getSeasonInfoAnalys(slot0, slot1, slot2)
	return slot0._infoAnalyConfig.configDict[slot1] and slot0._infoAnalyConfig.configDict[slot1][slot2]
end

function slot0.getSeasonInfoBonuss(slot0, slot1)
	return slot0._infoBonusConfig.configDict[slot1]
end

function slot0.buildSeasonWordEffectConfig(slot0)
	slot0.wordEffectConfigMap = slot0.wordEffectConfigMap or {}

	for slot5, slot6 in ipairs(slot0._wordEffectConfig.configList) do
		if not slot0.wordEffectConfigMap[slot6.activityId] then
			slot0.wordEffectConfigMap[slot6.activityId] = {}
		end

		if not slot7[slot6.type] then
			slot7[slot6.type] = {}
		end

		table.insert(slot7[slot6.type], slot6)
	end
end

function slot0.getSeasonWordEffectConfigList(slot0, slot1, slot2)
	return slot0.wordEffectConfigMap[slot1] and slot0.wordEffectConfigMap[slot1][slot2]
end

function slot0.getSeasonWordEffectPosConfig(slot0, slot1, slot2)
	return slot0._wordEffectPosConfig.configDict[slot1] and slot0._wordEffectPosConfig.configDict[slot1][slot2]
end

function slot0.getSeasonConfigByEpisodeId(slot0, slot1)
	slot4 = nil

	if DungeonConfig.instance:getEpisodeCO(slot1).type and slot3 == DungeonEnum.EpisodeType.Season166Base then
		if not slot0._episodeId2Config[slot1] then
			for slot8, slot9 in ipairs(lua_activity166_base.configList) do
				if slot9.episodeId == slot1 then
					slot0._episodeId2Config[slot1] = slot9

					return slot9
				end
			end
		end
	elseif slot3 and slot3 == DungeonEnum.EpisodeType.Season166Train then
		if not slot0._episodeId2Config[slot1] then
			for slot8, slot9 in ipairs(lua_activity166_train.configList) do
				if slot9.episodeId == slot1 then
					slot0._episodeId2Config[slot1] = slot9

					return slot9
				end
			end
		end
	elseif slot3 and slot3 == DungeonEnum.EpisodeType.Season166Teach and not slot0._episodeId2Config[slot1] then
		for slot8, slot9 in ipairs(lua_activity166_teach.configList) do
			if slot9.episodeId == slot1 then
				slot4 = slot9
				slot4.activityId = DungeonConfig.instance:getChapterCO(slot2.chapterId).actId
				slot0._episodeId2Config[slot1] = slot4

				return slot9
			end
		end
	end

	return slot4
end

function slot0.getBaseSpotByTalentId(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._baseSpotConfig.configDict[slot1]) do
		if slot7.talentId == slot2 then
			return slot7
		end
	end

	logError("talentId dont bind base" .. slot2)
end

function slot0.getAdditionScoreByParam(slot0, slot1, slot2)
	return string.splitToNumber(slot1.score, "|")[tabletool.indexOf(string.splitToNumber(slot1.targetParam, "|"), slot2)] or 0
end

slot0.instance = slot0.New()

return slot0
