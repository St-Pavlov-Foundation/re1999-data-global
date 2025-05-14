module("modules.logic.versionactivity1_2.yaxian.config.YaXianConfig", package.seeall)

local var_0_0 = class("YaXianConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.chapterConfig = nil
	arg_1_0.chapterId2EpisodeList = nil
	arg_1_0.mapConfig = nil
	arg_1_0.interactObjectConfig = nil
	arg_1_0.episodeConfig = nil
	arg_1_0.skillConfig = nil
	arg_1_0.toothConfig = nil
	arg_1_0.toothUnlockEpisodeIdDict = {}
	arg_1_0.toothUnlockSkillIdDict = {}
	arg_1_0.toothUnlockHeroTemplateDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
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

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity115_chapter" then
		arg_3_0.chapterConfig = arg_3_2
	elseif arg_3_1 == "activity115_episode" then
		arg_3_0.episodeConfig = arg_3_2

		arg_3_0:initEpisode()
	elseif arg_3_1 == "activity115_map" then
		arg_3_0.mapConfig = arg_3_2
	elseif arg_3_1 == "activity115_interact_object" then
		arg_3_0.interactObjectConfig = arg_3_2
	elseif arg_3_1 == "activity115_skill" then
		arg_3_0.skillConfig = arg_3_2
	elseif arg_3_1 == "activity115_tooth" then
		arg_3_0.toothConfig = arg_3_2
	end
end

function var_0_0.initEpisode(arg_4_0)
	arg_4_0.chapterId2EpisodeList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.episodeConfig.configList) do
		if not arg_4_0.chapterId2EpisodeList[iter_4_1.chapterId] then
			arg_4_0.chapterId2EpisodeList[iter_4_1.chapterId] = {}
		end

		table.insert(arg_4_0.chapterId2EpisodeList[iter_4_1.chapterId], iter_4_1)

		if iter_4_1.tooth ~= 0 then
			arg_4_0.toothUnlockEpisodeIdDict[iter_4_1.tooth] = iter_4_1.id

			if iter_4_1.unlockSkill ~= 0 then
				arg_4_0.toothUnlockSkillIdDict[iter_4_1.tooth] = iter_4_1.unlockSkill
			end

			if iter_4_1.trialTemplate ~= 0 then
				arg_4_0.toothUnlockHeroTemplateDict[iter_4_1.tooth] = iter_4_1.trialTemplate
			end
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.chapterId2EpisodeList) do
		table.sort(iter_4_3, function(arg_5_0, arg_5_1)
			return arg_5_0.id < arg_5_1.id
		end)
	end
end

function var_0_0.getChapterConfigList(arg_6_0)
	return arg_6_0.chapterConfig.configList
end

function var_0_0.getChapterConfig(arg_7_0, arg_7_1)
	return arg_7_0.chapterConfig.configDict[YaXianEnum.ActivityId][arg_7_1]
end

function var_0_0.getMapConfig(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.mapConfig.configDict[arg_8_1] then
		return arg_8_0.mapConfig.configDict[arg_8_1][arg_8_2]
	end

	return nil
end

function var_0_0.getEpisodeConfig(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.episodeConfig.configDict[arg_9_1] then
		return arg_9_0.episodeConfig.configDict[arg_9_1][arg_9_2]
	end

	return nil
end

function var_0_0.getPreEpisodeConfig(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0:getEpisodeConfig(arg_10_1, arg_10_2 - 1)
end

function var_0_0.getEpisodeCanFinishInteractCount(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return 0
	end

	arg_11_0.episodeCanFinishInteractCountDict = arg_11_0.episodeCanFinishInteractCountDict or {}

	if arg_11_0.episodeCanFinishInteractCountDict[arg_11_1.mapId] then
		return arg_11_0.episodeCanFinishInteractCountDict[arg_11_1.mapId]
	end

	local var_11_0 = arg_11_0:getMapConfig(arg_11_1.activityId, arg_11_1.mapId)

	if not var_11_0 then
		arg_11_0.episodeCanFinishInteractCountDict[arg_11_1.mapId] = 0

		return 0
	end

	local var_11_1 = cjson.decode(var_11_0.objects)
	local var_11_2 = 0

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		if arg_11_0:checkInteractCanFinish(arg_11_0:getInteractObjectCo(iter_11_1.actId, iter_11_1.id)) then
			var_11_2 = var_11_2 + 1
		end
	end

	arg_11_0.episodeCanFinishInteractCountDict[arg_11_1.mapId] = var_11_2

	return var_11_2
end

function var_0_0.checkInteractCanFinish(arg_12_0, arg_12_1)
	return arg_12_1 and arg_12_1.interactType == YaXianGameEnum.InteractType.Enemy
end

function var_0_0.getConditionList(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return {}
	end

	local var_13_0 = GameUtil.splitString2(arg_13_1.extStarCondition, true, "|", "#") or {}

	table.insert(var_13_0, {
		YaXianGameEnum.ConditionType.PassEpisode
	})

	return var_13_0
end

function var_0_0.getInteractObjectCo(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.interactObjectConfig.configDict[arg_14_1] then
		return arg_14_0.interactObjectConfig.configDict[arg_14_1][arg_14_2]
	end

	return nil
end

function var_0_0.getSkillConfig(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.skillConfig.configDict[arg_15_1] then
		return arg_15_0.skillConfig.configDict[arg_15_1][arg_15_2]
	end

	return nil
end

function var_0_0.getThroughSkillDistance(arg_16_0)
	if not arg_16_0.throughSkillDistance then
		local var_16_0 = arg_16_0:getSkillConfig(YaXianEnum.ActivityId, YaXianGameEnum.SkillId.ThroughWall)

		arg_16_0.throughSkillDistance = var_16_0 and tonumber(var_16_0.param)
	end

	return arg_16_0.throughSkillDistance
end

function var_0_0.getToothConfig(arg_17_0, arg_17_1)
	return arg_17_0.toothConfig.configDict[YaXianEnum.ActivityId][arg_17_1]
end

function var_0_0.getToothUnlockEpisode(arg_18_0, arg_18_1)
	return arg_18_0.toothUnlockEpisodeIdDict and arg_18_0.toothUnlockEpisodeIdDict[arg_18_1]
end

function var_0_0.getToothUnlockSkill(arg_19_0, arg_19_1)
	return arg_19_0.toothUnlockSkillIdDict and arg_19_0.toothUnlockSkillIdDict[arg_19_1]
end

function var_0_0.getToothUnlockHeroTemplate(arg_20_0, arg_20_1)
	return arg_20_0.toothUnlockHeroTemplateDict and arg_20_0.toothUnlockHeroTemplateDict[arg_20_1]
end

function var_0_0.getMaxBonusScore(arg_21_0)
	if not arg_21_0.maxBonusScore then
		arg_21_0.maxBonusScore = 0

		for iter_21_0, iter_21_1 in ipairs(lua_activity115_bonus.configList) do
			if iter_21_1.needScore > arg_21_0.maxBonusScore then
				arg_21_0.maxBonusScore = iter_21_1.needScore
			end
		end
	end

	return arg_21_0.maxBonusScore
end

var_0_0.instance = var_0_0.New()

return var_0_0
