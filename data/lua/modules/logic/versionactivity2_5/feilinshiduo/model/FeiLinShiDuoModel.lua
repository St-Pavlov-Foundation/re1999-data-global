module("modules.logic.versionactivity2_5.feilinshiduo.model.FeiLinShiDuoModel", package.seeall)

local var_0_0 = class("FeiLinShiDuoModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()

	arg_1_0.maxStageCount = 7
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.episodeFinishMap = {}
	arg_2_0.curEpisodeId = 0
	arg_2_0.newUnlockEpisodeId = 0
	arg_2_0.curFinishEpisodeId = 0
end

function var_0_0.initEpisodeFinishInfo(arg_3_0, arg_3_1)
	arg_3_0.activityId = arg_3_1.activityId

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.episodes) do
		arg_3_0.episodeFinishMap[iter_3_1.episodeId] = iter_3_1.isFinished
	end
end

function var_0_0.getEpisodeFinishState(arg_4_0, arg_4_1)
	return arg_4_0.episodeFinishMap[arg_4_1]
end

function var_0_0.updateEpisodeFinishState(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.episodeFinishMap[arg_5_1] = arg_5_2
end

function var_0_0.isUnlock(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = FeiLinShiDuoConfig.instance:getEpisodeConfig(arg_6_1, arg_6_2).preEpisodeId
	local var_6_1 = var_6_0 > 0 and arg_6_0.episodeFinishMap[var_6_0] or true

	return arg_6_0.episodeFinishMap[arg_6_2] ~= nil and var_6_1
end

function var_0_0.getFinishStageIndex(arg_7_0)
	local var_7_0 = 0

	for iter_7_0 = 1, arg_7_0.maxStageCount do
		local var_7_1 = FeiLinShiDuoConfig.instance:getStageEpisodes(iter_7_0)
		local var_7_2 = true

		for iter_7_1, iter_7_2 in pairs(var_7_1) do
			if not arg_7_0.episodeFinishMap[iter_7_2.episodeId] then
				var_7_2 = false

				break
			end
		end

		if var_7_2 then
			var_7_0 = iter_7_0
		end
	end

	return var_7_0
end

function var_0_0.getCurActId(arg_8_0)
	return arg_8_0.activityId
end

function var_0_0.getCurEpisodeId(arg_9_0)
	local var_9_0 = FeiLinShiDuoConfig.instance:getEpisodeConfigList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = iter_9_1.preEpisodeId

		if not arg_9_0.episodeFinishMap[iter_9_1.episodeId] and var_9_1 > 0 then
			if not arg_9_0.episodeFinishMap[var_9_1] then
				arg_9_0.curEpisodeId = var_9_1

				return arg_9_0.curEpisodeId
			else
				arg_9_0.curEpisodeId = iter_9_1.episodeId

				return arg_9_0.curEpisodeId
			end
		elseif not arg_9_0.episodeFinishMap[iter_9_1.episodeId] and var_9_1 == 0 then
			arg_9_0.curEpisodeId = iter_9_1.episodeId

			return arg_9_0.curEpisodeId
		end
	end

	arg_9_0.curEpisodeId = var_9_0[#var_9_0].episodeId

	return arg_9_0.curEpisodeId
end

function var_0_0.getLastEpisodeId(arg_10_0)
	local var_10_0 = FeiLinShiDuoConfig.instance:getNoGameEpisodeList(arg_10_0.activityId)

	return var_10_0[#var_10_0].episodeId
end

function var_0_0.setCurEpisodeId(arg_11_0, arg_11_1)
	arg_11_0.curEpisodeId = arg_11_1
end

function var_0_0.setNewUnlockEpisode(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1.episodes) do
		arg_12_0.newUnlockEpisodeId = iter_12_1.episodeId
	end
end

function var_0_0.getNewUnlockEpisode(arg_13_0, arg_13_1)
	if arg_13_0.newUnlockEpisodeId then
		return (FeiLinShiDuoConfig.instance:getEpisodeConfig(arg_13_1, arg_13_0.newUnlockEpisodeId))
	end
end

function var_0_0.cleanNewUnlockEpisode(arg_14_0)
	arg_14_0.newUnlockEpisodeId = 0
end

function var_0_0.setCurFinishEpisodeId(arg_15_0, arg_15_1)
	if arg_15_0.episodeFinishMap[arg_15_1] then
		arg_15_0.curFinishEpisodeId = 0
	else
		arg_15_0.curFinishEpisodeId = arg_15_1
	end
end

function var_0_0.getCurFinishEpisodeId(arg_16_0)
	return arg_16_0.curFinishEpisodeId
end

var_0_0.instance = var_0_0.New()

return var_0_0
