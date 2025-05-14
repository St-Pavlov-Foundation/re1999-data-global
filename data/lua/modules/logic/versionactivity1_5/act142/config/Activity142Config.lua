module("modules.logic.versionactivity1_5.act142.config.Activity142Config", package.seeall)

local var_0_0 = class("Activity142Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
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

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

local function var_0_1(arg_4_0, arg_4_1)
	return arg_4_0 < arg_4_1
end

local function var_0_2(arg_5_0, arg_5_1)
	return arg_5_0.order < arg_5_1.order
end

function var_0_0.activity142_episodeConfigLoaded(arg_6_0, arg_6_1)
	arg_6_0._episodeListDict = {}

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.configList) do
		local var_6_1 = iter_6_1.activityId
		local var_6_2 = arg_6_0._episodeListDict[var_6_1]

		if not var_6_2 then
			var_6_2 = {}
			arg_6_0._episodeListDict[var_6_1] = var_6_2
		end

		local var_6_3 = iter_6_1.chapterId
		local var_6_4 = var_6_2[var_6_3]

		if not var_6_4 then
			var_6_4 = {}
			var_6_2[var_6_3] = var_6_4

			table.insert(var_6_0, var_6_4)
		end

		table.insert(var_6_4, iter_6_1.id)
	end

	for iter_6_2, iter_6_3 in ipairs(var_6_0) do
		table.sort(iter_6_3, var_0_1)
	end
end

function var_0_0.activity142_mapConfigLoaded(arg_7_0, arg_7_1)
	arg_7_0._groundItemUrDict = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.configList) do
		if iter_7_1 and not string.nilorempty(iter_7_1.groundItems) then
			local var_7_0 = iter_7_1.activityId
			local var_7_1 = arg_7_0._groundItemUrDict[var_7_0]

			if not var_7_1 then
				var_7_1 = {}
				arg_7_0._groundItemUrDict[var_7_0] = var_7_1
			end

			local var_7_2 = iter_7_1.id
			local var_7_3 = var_7_1[var_7_2]

			if not var_7_3 then
				var_7_3 = {}
				var_7_1[var_7_2] = var_7_3
			end

			local var_7_4 = string.split(iter_7_1.groundItems, "#") or {}

			for iter_7_2, iter_7_3 in ipairs(var_7_4) do
				if not string.nilorempty(iter_7_3) then
					table.insert(var_7_3, string.format(Va3ChessEnum.SceneResPath.AvatarItemPath, iter_7_3))
				end
			end
		end
	end
end

function var_0_0.activity142_storyConfigLoaded(arg_8_0, arg_8_1)
	arg_8_0._storyListDict = {}

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.configList) do
		local var_8_1 = iter_8_1.activityId
		local var_8_2 = arg_8_0._storyListDict[var_8_1]

		if not var_8_2 then
			var_8_2 = {}
			arg_8_0._storyListDict[var_8_1] = var_8_2
		end

		local var_8_3 = var_8_2[iter_8_1.episodeId]

		if not var_8_3 then
			var_8_3 = {}
			var_8_2[iter_8_1.episodeId] = var_8_3

			table.insert(var_8_0, var_8_3)
		end

		table.insert(var_8_3, iter_8_1)
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_0) do
		table.sort(iter_8_3, var_0_2)
	end
end

local function var_0_3(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if lua_activity142_chapter and lua_activity142_chapter.configDict[arg_9_0] then
		var_9_0 = lua_activity142_chapter.configDict[arg_9_0][arg_9_1]
	end

	if not var_9_0 and arg_9_2 then
		logError(string.format("Activity142Config:getChapterCfg error, cfg is nil, actId:%s chapterId:%s", arg_9_0, arg_9_1))
	end

	return var_9_0
end

local function var_0_4(arg_10_0, arg_10_1)
	return arg_10_0 < arg_10_1
end

function var_0_0.getChapterList(arg_11_0, arg_11_1)
	local var_11_0 = {}

	if not lua_activity142_chapter then
		return var_11_0
	end

	for iter_11_0, iter_11_1 in ipairs(lua_activity142_chapter.configList) do
		if iter_11_1.activityId == arg_11_1 then
			table.insert(var_11_0, iter_11_1.id)
		end
	end

	table.sort(var_11_0, var_0_4)

	return var_11_0
end

function var_0_0.getChapterEpisodeIdList(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	var_12_0 = arg_12_0._episodeListDict and arg_12_0._episodeListDict[arg_12_1] and arg_12_0._episodeListDict[arg_12_1][arg_12_2] or var_12_0

	return var_12_0
end

local var_0_5 = 2

function var_0_0.isSPChapter(arg_13_0, arg_13_1)
	local var_13_0 = false

	if arg_13_1 then
		var_13_0 = arg_13_1 > var_0_5
	else
		logError("Activity142Config:isSPChapter error chapterId is nil")
	end

	return var_13_0
end

function var_0_0.getChapterName(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = var_0_3(arg_14_1, arg_14_2, true)

	if var_14_0 then
		return var_14_0.name
	end
end

function var_0_0.getChapterCategoryTxtColor(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0
	local var_15_1 = var_0_3(arg_15_1, arg_15_2, true)

	if var_15_1 then
		var_15_0 = var_15_1.txtColor
	end

	return var_15_0
end

function var_0_0.getChapterCategoryNormalSP(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0
	local var_16_1 = var_0_3(arg_16_1, arg_16_2, true)

	if var_16_1 then
		var_16_0 = var_16_1.normalSprite
	end

	return var_16_0
end

function var_0_0.getChapterCategorySelectSP(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0
	local var_17_1 = var_0_3(arg_17_1, arg_17_2, true)

	if var_17_1 then
		var_17_0 = var_17_1.selectSprite
	end

	return var_17_0
end

function var_0_0.getChapterCategoryLockSP(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0
	local var_18_1 = var_0_3(arg_18_1, arg_18_2, true)

	if var_18_1 then
		var_18_0 = var_18_1.lockSprite
	end

	return var_18_0
end

function var_0_0.getEpisodeCo(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0

	if lua_activity142_episode and lua_activity142_episode.configDict[arg_19_1] then
		var_19_0 = lua_activity142_episode.configDict[arg_19_1][arg_19_2]
	end

	if not var_19_0 and arg_19_3 then
		logError(string.format("Activity142Config:getEpisodeCo error, cfg is nil, actId:%s episodeId:%s", arg_19_1, arg_19_2))
	end

	return var_19_0
end

function var_0_0.getEpisodePreEpisode(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:getEpisodeCo(arg_20_1, arg_20_2, true)

	if var_20_0 then
		return var_20_0.preEpisode
	end
end

function var_0_0.getEpisodeOrder(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getEpisodeCo(arg_21_1, arg_21_2, true)

	if var_21_0 then
		return var_21_0.orderId
	end
end

function var_0_0.getEpisodeName(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:getEpisodeCo(arg_22_1, arg_22_2, true)

	if var_22_0 then
		return var_22_0.name
	end
end

function var_0_0.getEpisodeExtCondition(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:getEpisodeCo(arg_23_1, arg_23_2, true)

	if var_23_0 then
		return var_23_0.extStarCondition
	end
end

function var_0_0.getEpisodeMaxStar(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = Activity142Enum.DEFAULT_STAR_NUM
	local var_24_1 = arg_24_0:getEpisodeExtCondition(arg_24_1, arg_24_2)

	if not string.nilorempty(var_24_1) then
		var_24_0 = var_24_0 + 1
	end

	return var_24_0
end

function var_0_0.getEpisodeOpenDay(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0:getEpisodeCo(arg_25_1, arg_25_2, true)

	if var_25_0 then
		return var_25_0.openDay
	end
end

function var_0_0.getEpisodeNormalSP(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0
	local var_26_1 = arg_26_0:getEpisodeCo(arg_26_1, arg_26_2, true)

	if var_26_1 then
		var_26_0 = var_26_1.normalSprite
	end

	return var_26_0
end

function var_0_0.getEpisodeLockSP(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0
	local var_27_1 = arg_27_0:getEpisodeCo(arg_27_1, arg_27_2, true)

	if var_27_1 then
		var_27_0 = var_27_1.lockSprite
	end

	return var_27_0
end

function var_0_0.isStoryEpisode(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = true
	local var_28_1 = arg_28_0:getEpisodeCo(arg_28_1, arg_28_2, true)

	if var_28_1 then
		var_28_0 = string.nilorempty(var_28_1.mapIds)
	end

	return var_28_0
end

function var_0_0.getMapCo(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0

	if lua_activity142_map and lua_activity142_map.configDict[arg_29_1] then
		var_29_0 = lua_activity142_map.configDict[arg_29_1][arg_29_2]
	end

	if not var_29_0 and arg_29_3 then
		logError(string.format("Activity142Config:getMapCo error, cfg is nil, actId:%s mapId:%s", arg_29_1, arg_29_2))
	end

	return var_29_0
end

function var_0_0.getGroundItemUrlList(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0

	if arg_30_0._groundItemUrDict and arg_30_0._groundItemUrDict[arg_30_1] and arg_30_0._groundItemUrDict[arg_30_1][arg_30_2] then
		var_30_0 = arg_30_0._groundItemUrDict[arg_30_1][arg_30_2]
	end

	if not var_30_0 then
		var_30_0 = {
			Va3ChessEnum.SceneResPath.GroundItem
		}

		logError(string.format("Activity142Config:getGroundItemUrlList error, can't find groundItemUrls, actId:%s mapId:%s", arg_30_1, arg_30_2))
	end

	return var_30_0
end

function var_0_0.getAct142StoryCfg(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0

	if lua_activity142_story and lua_activity142_story.configDict[arg_31_1] then
		var_31_0 = lua_activity142_story.configDict[arg_31_1][arg_31_2]
	end

	if not var_31_0 and arg_31_3 then
		logError(string.format("Activity142Config:getAct142StoryCfg error, cfg is nil, actId:%s storyId:%s", arg_31_1, arg_31_2))
	end

	return var_31_0
end

function var_0_0.getEpisodeStoryList(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = {}

	var_32_0 = arg_32_0._storyListDict and arg_32_0._storyListDict[arg_32_1] and arg_32_0._storyListDict[arg_32_1][arg_32_2] or var_32_0

	return var_32_0
end

function var_0_0.getCollectionCfg(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0

	if lua_activity142_collection and lua_activity142_collection.configDict[arg_33_1] then
		var_33_0 = lua_activity142_collection.configDict[arg_33_1][arg_33_2]
	end

	if not var_33_0 and arg_33_3 then
		logError(string.format("Activity142Config:getCollectionCfg error, cfg is nil, actId:%s collectId:%s", arg_33_1, arg_33_2))
	end

	return var_33_0
end

function var_0_0.getCollectionName(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = ""
	local var_34_1 = arg_34_0:getCollectionCfg(arg_34_1, arg_34_2, true)

	if var_34_1 then
		var_34_0 = var_34_1.name
	end

	return var_34_0
end

function var_0_0.getCollectionList(arg_35_0, arg_35_1)
	local var_35_0 = {}

	if not arg_35_1 then
		logError("Activity142Config:getCollectionList error, actId is nil")

		return var_35_0
	end

	for iter_35_0, iter_35_1 in ipairs(lua_activity142_collection.configList) do
		if iter_35_1.activityId == arg_35_1 then
			table.insert(var_35_0, iter_35_1.id)
		end
	end

	return var_35_0
end

function var_0_0.getInteractObjectCo(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0

	if lua_activity142_interact_object and lua_activity142_interact_object.configDict[arg_36_1] then
		var_36_0 = lua_activity142_interact_object.configDict[arg_36_1][arg_36_2]
	end

	if not var_36_0 and arg_36_3 then
		logError(string.format("Activity142Config:getInteractObjectCo error, cfg is nil, actId:%s interactObjId:%s", arg_36_1, arg_36_2))
	end

	return var_36_0
end

function var_0_0.getTipsCfg(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0

	if lua_activity142_tips and lua_activity142_tips.configDict[arg_37_1] then
		var_37_0 = lua_activity142_tips.configDict[arg_37_1][arg_37_2]
	end

	if not var_37_0 and arg_37_3 then
		logError(string.format("Activity142Config:getTipsCfg error, cfg is nil, actId:%s tipId:%s", arg_37_1, arg_37_2))
	end

	return var_37_0
end

function var_0_0.getTaskByActId(arg_38_0, arg_38_1)
	local var_38_0 = {}

	if not arg_38_1 then
		logError("Activity142Config:getTaskByActId error, actId is nil")

		return var_38_0
	end

	for iter_38_0, iter_38_1 in ipairs(lua_activity142_task.configList) do
		if iter_38_1.activityId == arg_38_1 then
			table.insert(var_38_0, iter_38_1)
		end
	end

	return var_38_0
end

function var_0_0.getEffectCo(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0

	if lua_activity142_interact_effect and lua_activity142_interact_effect.configDict[arg_39_2] then
		var_39_0 = lua_activity142_interact_effect.configDict[arg_39_2]
	end

	if arg_39_2 ~= 0 and not var_39_0 then
		logError(string.format("Activity142Config:getEffectCo error, cfg is nil, effectId:%s", arg_39_2))
	end

	return var_39_0
end

function var_0_0.getChapterEpisodeId(arg_40_0, arg_40_1)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
