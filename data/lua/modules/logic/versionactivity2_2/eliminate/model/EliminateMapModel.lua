module("modules.logic.versionactivity2_2.eliminate.model.EliminateMapModel", package.seeall)

local var_0_0 = class("EliminateMapModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.isPlayingClickAnimation = false
end

function var_0_0.getChapterStatus(arg_3_0, arg_3_1)
	if not arg_3_0:checkChapterIsUnlock(arg_3_1) then
		return EliminateMapEnum.ChapterStatus.Lock
	end

	return EliminateMapEnum.ChapterStatus.Normal
end

function var_0_0.isFirstEpisode(arg_4_0, arg_4_1)
	local var_4_0 = lua_eliminate_episode.configDict[arg_4_1].chapterId

	return EliminateOutsideModel.instance:getChapterList()[var_4_0][1].id == arg_4_1
end

function var_0_0.getEpisodeConfig(arg_5_0, arg_5_1)
	return lua_eliminate_episode.configDict[arg_5_1]
end

function var_0_0.getLastCanFightEpisodeMo(arg_6_0, arg_6_1)
	local var_6_0 = EliminateOutsideModel.instance:getChapterList()[arg_6_1]

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1.star == 0 then
			return iter_6_1
		end
	end

	return var_6_0[#var_6_0]
end

function var_0_0.getEpisodeList(arg_7_0, arg_7_1)
	return EliminateOutsideModel.instance:getChapterList()[arg_7_1]
end

function var_0_0.checkChapterIsUnlock(arg_8_0, arg_8_1)
	local var_8_0 = EliminateOutsideModel.instance:getChapterList()[arg_8_1]

	if not var_8_0 or #var_8_0 == 0 then
		return false
	end

	local var_8_1 = var_8_0[1].config

	return var_8_1.preEpisode == 0 or EliminateOutsideModel.instance:hasPassedEpisode(var_8_1.preEpisode)
end

function var_0_0.getLastCanFightChapterId(arg_9_0)
	local var_9_0
	local var_9_1 = EliminateOutsideModel.instance:getChapterList()

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if arg_9_0:checkChapterIsUnlock(iter_9_0) then
			var_9_0 = iter_9_0
		end
	end

	return var_9_0
end

function var_0_0.getChapterNum()
	return #var_0_0.getChapterConfigList()
end

function var_0_0.getChapterConfigList()
	return EliminateConfig.instance:getNormalChapterList()
end

function var_0_0.setPlayingClickAnimation(arg_12_0, arg_12_1)
	arg_12_0.isPlayingClickAnimation = arg_12_1
end

function var_0_0.checkIsPlayingClickAnimation(arg_13_0)
	return arg_13_0.isPlayingClickAnimation
end

var_0_0.instance = var_0_0.New()

return var_0_0
