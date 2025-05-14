module("modules.logic.versionactivity1_2.yaxian.model.YaXianModel", package.seeall)

local var_0_0 = class("YaXianModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.actId = nil
	arg_1_0.hasGetBonusIdDict = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.actId = nil
	arg_2_0.hasGetBonusIdDict = nil
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	arg_3_0.actId = arg_3_1.activityId

	arg_3_0:updateGetBonusId(arg_3_1.hasGetBonusIds)
	arg_3_0:updateEpisodeInfo(arg_3_1.episodes)

	if arg_3_1:HasField("map") then
		arg_3_0:updateCurrentMapInfo(arg_3_1.map)
	else
		arg_3_0.currentMapMo = nil
	end
end

function var_0_0.updateCurrentMapInfo(arg_4_0, arg_4_1)
	arg_4_0.currentMapMo = YaXianMapMo.New()

	arg_4_0.currentMapMo:init(arg_4_0.actId, arg_4_1)
end

function var_0_0.getCurrentMapInfo(arg_5_0)
	return arg_5_0.currentMapMo
end

function var_0_0.sortEpisodeMoFunc(arg_6_0, arg_6_1)
	return arg_6_0.id < arg_6_1.id
end

function var_0_0.updateEpisodeInfo(arg_7_0, arg_7_1)
	arg_7_0.episodeList = arg_7_0.episodeList or {}
	arg_7_0.chapterId2EpisodeListDict = arg_7_0.chapterId2EpisodeListDict or {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = arg_7_0:getEpisodeMo(iter_7_1.id)

		if var_7_0 then
			var_7_0:updateData(iter_7_1)
		else
			local var_7_1 = YaXianEpisodeMo.New()

			var_7_1:init(arg_7_0.actId, iter_7_1)
			arg_7_0:addToChapterId2EpisodeListDict(var_7_1)
			table.insert(arg_7_0.episodeList, var_7_1)
		end
	end

	table.sort(arg_7_0.episodeList, var_0_0.sortEpisodeMoFunc)

	for iter_7_2, iter_7_3 in pairs(arg_7_0.chapterId2EpisodeListDict) do
		table.sort(iter_7_3, var_0_0.sortEpisodeMoFunc)
	end

	arg_7_0:updateScore()
	arg_7_0:calculateLastCanFightEpisodeMo()
	arg_7_0:updateTrialMaxTemplateId()
	YaXianController.instance:dispatchEvent(YaXianEvent.OnUpdateEpisodeInfo)
end

function var_0_0.addToChapterId2EpisodeListDict(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.config.chapterId

	if not arg_8_0.chapterId2EpisodeListDict[var_8_0] then
		arg_8_0.chapterId2EpisodeListDict[var_8_0] = {}
	end

	table.insert(arg_8_0.chapterId2EpisodeListDict[var_8_0], arg_8_1)
end

function var_0_0.calculateLastCanFightEpisodeMo(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.episodeList) do
		if iter_9_1.star == 0 then
			arg_9_0.lastCanFightEpisodeMo = iter_9_1

			return
		end
	end

	arg_9_0.lastCanFightEpisodeMo = arg_9_0.episodeList[#arg_9_0.episodeList]
end

function var_0_0.getLastCanFightEpisodeMo(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return arg_10_0.lastCanFightEpisodeMo
	end

	local var_10_0 = arg_10_0.chapterId2EpisodeListDict[arg_10_1]
	local var_10_1

	for iter_10_0 = #var_10_0, 1, -1 do
		local var_10_2 = var_10_0[iter_10_0]

		if var_10_2.star == 0 then
			var_10_1 = var_10_2
		elseif var_10_1 then
			return var_10_1
		else
			return var_10_2
		end
	end

	return var_10_1
end

function var_0_0.getEpisodeMo(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.episodeList) do
		if iter_11_1.id == arg_11_1 then
			return iter_11_1
		end
	end
end

function var_0_0.getEpisodeList(arg_12_0, arg_12_1)
	return arg_12_0.chapterId2EpisodeListDict[arg_12_1]
end

function var_0_0.getChapterFirstEpisodeMo(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getEpisodeList(arg_13_1)

	return var_13_0 and var_13_0[1]
end

function var_0_0.chapterIsUnlock(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getEpisodeList(arg_14_1)

	return var_14_0 and arg_14_0:getLastCanFightEpisodeMo().id >= var_14_0[1].id
end

function var_0_0.getScore(arg_15_0)
	return arg_15_0.score or 0
end

function var_0_0.updateGetBonusId(arg_16_0, arg_16_1)
	arg_16_0.hasGetBonusIdDict = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		arg_16_0.hasGetBonusIdDict[iter_16_1] = true
	end

	YaXianController.instance:dispatchEvent(YaXianEvent.OnUpdateBonus)
end

function var_0_0.hasGetBonus(arg_17_0, arg_17_1)
	return arg_17_0.hasGetBonusIdDict[arg_17_1]
end

function var_0_0.updateScore(arg_18_0)
	arg_18_0.score = 0

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.episodeList) do
		arg_18_0.score = arg_18_0.score + iter_18_1.star
	end
end

function var_0_0.updateTrialMaxTemplateId(arg_19_0)
	arg_19_0.maxTrialTemplateId = 1

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.episodeList) do
		if iter_19_1.star > 0 and iter_19_1.config.trialTemplate > arg_19_0.maxTrialTemplateId then
			arg_19_0.maxTrialTemplateId = iter_19_1.config.trialTemplate
		end
	end
end

function var_0_0.getMaxTrialTemplateId(arg_20_0)
	return arg_20_0.maxTrialTemplateId
end

function var_0_0.getHeroIdAndSkinId(arg_21_0)
	local var_21_0 = lua_hero_trial.configDict[YaXianEnum.HeroTrialId][arg_21_0.maxTrialTemplateId]

	return var_21_0.heroId, var_21_0.skin
end

function var_0_0.hadTooth(arg_22_0, arg_22_1)
	if arg_22_1 == 0 then
		return true
	end

	local var_22_0 = YaXianConfig.instance:getToothUnlockEpisode(arg_22_1)

	if not var_22_0 then
		logError("ya xian tooth unlock episode id not exist")

		return true
	end

	local var_22_1 = arg_22_0:getEpisodeMo(var_22_0)

	if not var_22_1 then
		return false
	end

	return var_22_1.star > 0
end

function var_0_0.getHadToothCount(arg_23_0)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in ipairs(lua_activity115_tooth.configList) do
		if arg_23_0:hadTooth(iter_23_1.id) then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

function var_0_0.isFirstEpisode(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.chapterId2EpisodeListDict) do
		if iter_24_1[1].id == arg_24_1 then
			return true
		end
	end

	return false
end

function var_0_0.setPlayingClickAnimation(arg_25_0, arg_25_1)
	arg_25_0.isPlayingClickAnimation = arg_25_1

	YaXianController.instance:dispatchEvent(YaXianEvent.OnPlayingClickAnimationValueChange)
end

function var_0_0.checkIsPlayingClickAnimation(arg_26_0)
	return arg_26_0.isPlayingClickAnimation
end

var_0_0.instance = var_0_0.New()

return var_0_0
