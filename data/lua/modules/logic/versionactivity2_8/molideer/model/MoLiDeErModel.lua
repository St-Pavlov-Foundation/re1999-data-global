module("modules.logic.versionactivity2_8.molideer.model.MoLiDeErModel", package.seeall)

local var_0_0 = class("MoLiDeErModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:init()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:init()
end

function var_0_0.init(arg_3_0)
	arg_3_0._curActId = VersionActivity2_8Enum.ActivityId.MoLiDeEr
	arg_3_0._curEpisodeConfig = nil
	arg_3_0._curEpisodeId = nil
	arg_3_0._actInfoDic = {}
end

function var_0_0.onGetActInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.activityId
	local var_4_1 = VersionActivity2_8Enum.ActivityId.MoLiDeEr
	local var_4_2

	if not arg_4_0._actInfoDic[var_4_1] then
		var_4_2 = {}
		arg_4_0._actInfoDic[var_4_1] = var_4_2
	else
		var_4_2 = arg_4_0._actInfoDic[var_4_1]

		tabletool.clear(var_4_2)
	end

	local var_4_3 = arg_4_1.episodeRecords

	if not var_4_3 or #var_4_3 <= 0 then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_3) do
		local var_4_4

		if MoLiDeErConfig.instance:getEpisodeConfig(var_4_1, iter_4_1.episodeId) == nil then
			logError("episodeConfig not exist id: " .. iter_4_1.episodeId)
		elseif var_4_2[iter_4_1.episodeId] then
			logError("episodeId has exist id: " .. iter_4_1.episodeId)
		else
			local var_4_5 = MoLiDeErInfoMo.New()

			var_4_5:init(var_4_1, iter_4_1.episodeId, iter_4_1.isUnlock, iter_4_1.passCount, iter_4_1.passStar, iter_4_1.haveProgress)

			var_4_2[iter_4_1.episodeId] = var_4_5
		end
	end
end

function var_0_0.onEpisodeRecordsPush(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	if not arg_5_0._actInfoDic[arg_5_1] then
		var_5_0 = {}
		arg_5_0._actInfoDic[arg_5_1] = var_5_0
	else
		var_5_0 = arg_5_0._actInfoDic[arg_5_1]
	end

	if not arg_5_2 or #arg_5_2 <= 0 then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_1

		if MoLiDeErConfig.instance:getEpisodeConfig(arg_5_1, iter_5_1.episodeId) == nil then
			logError("episodeConfig not exist id: " .. iter_5_1.episodeId)
		elseif var_5_0[iter_5_1.episodeId] then
			var_5_1 = var_5_0[iter_5_1.episodeId]
		else
			var_5_1 = MoLiDeErInfoMo.New()
		end

		var_5_1:init(arg_5_1, iter_5_1.episodeId, iter_5_1.isUnlock, iter_5_1.passCount, iter_5_1.passStar, iter_5_1.haveProgress)

		var_5_0[iter_5_1.episodeId] = var_5_1
	end
end

function var_0_0.isEpisodeFinish(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0:getEpisodeInfoMo(arg_6_1, arg_6_2)

	if not var_6_0 then
		return false
	end

	if arg_6_3 then
		return var_6_0.passCount == 1
	end

	return var_6_0.passCount > 0
end

function var_0_0.haveEpisodeProgress(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getEpisodeInfoMo(arg_7_1, arg_7_2)

	if not var_7_0 then
		return false
	end

	return var_7_0:isInProgress()
end

function var_0_0.getEpisodeInfoMo(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._actInfoDic[arg_8_1] then
		return nil
	end

	return arg_8_0._actInfoDic[arg_8_1][arg_8_2]
end

function var_0_0.setCurEpisodeData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0._curActId = arg_9_1
	arg_9_0._curEpisodeId = arg_9_2

	if arg_9_3 == nil then
		arg_9_3 = MoLiDeErConfig.instance:getEpisodeConfig(arg_9_1, arg_9_2)
	end

	arg_9_0._curEpisodeConfig = arg_9_3
end

function var_0_0.getCurEpisode(arg_10_0)
	return arg_10_0._curEpisodeConfig
end

function var_0_0.getCurEpisodeId(arg_11_0)
	return arg_11_0._curEpisodeId
end

function var_0_0.getCurActId(arg_12_0)
	return arg_12_0._curActId
end

function var_0_0.getCurEpisodeInfo(arg_13_0)
	return arg_13_0:getEpisodeInfoMo(arg_13_0._curActId, arg_13_0._curEpisodeId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
