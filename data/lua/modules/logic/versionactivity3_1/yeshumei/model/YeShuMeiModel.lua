module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiModel", package.seeall)

local var_0_0 = class("YeShuMeiModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._episodeInfos = {}
	arg_2_0._curEpisodeIndex = 0
	arg_2_0._curEpisode = 0
	arg_2_0._actId = VersionActivity3_1Enum.ActivityId.YeShuMei
end

function var_0_0.initInfos(arg_3_0, arg_3_1)
	arg_3_0._episodeInfos = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if not arg_3_0._episodeInfos[iter_3_1.episodeId] then
			arg_3_0._episodeInfos[iter_3_1.episodeId] = YeShuMeiEpisodeMo.New()

			arg_3_0._episodeInfos[iter_3_1.episodeId]:init(iter_3_1)
		else
			arg_3_0._episodeInfos[iter_3_1.episodeId]:update(iter_3_1)
		end
	end
end

function var_0_0.updateEpisodeInfo(arg_4_0, arg_4_1)
	arg_4_0._episodeInfos[arg_4_1.episodeId]:update(arg_4_1)
end

function var_0_0.updateInfos(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if not arg_5_0._episodeInfos[iter_5_1.episodeId] then
			arg_5_0._episodeInfos[iter_5_1.episodeId] = YeShuMeiEpisodeMo.New()

			arg_5_0._episodeInfos[iter_5_1.episodeId]:init(iter_5_1)
		else
			arg_5_0._episodeInfos[iter_5_1.episodeId]:update(iter_5_1)
		end
	end
end

function var_0_0.updateInfoFinish(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._episodeInfos[arg_6_1]

	if var_6_0 then
		var_6_0.isFinished = true
	end
end

function var_0_0.updateInfoFinishGame(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._episodeInfos[arg_7_1.episodeId]

	if var_7_0 then
		var_7_0.progress = arg_7_1.progress
	end
end

function var_0_0.checkEpisodeFinishGame(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._episodeInfos[arg_8_1]

	if var_8_0 then
		return var_8_0:checkFinishGame()
	end

	return false
end

function var_0_0.getCurGameProgress(arg_9_0, arg_9_1)
	return arg_9_0._episodeInfos[arg_9_1].progress
end

function var_0_0.getEpisodeUnlockBranchIdList(arg_10_0, arg_10_1)
	return arg_10_0._episodeInfos[arg_10_1].unlockBranchIds
end

function var_0_0.setCurEpisode(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._curEpisodeIndex = arg_11_1
	arg_11_0._curEpisode = arg_11_2 and arg_11_2 or arg_11_0._curEpisode
end

function var_0_0.getEpisodeIndex(arg_12_0, arg_12_1)
	local var_12_0 = YeShuMeiConfig.instance:getEpisodeCoList(arg_12_0._actId)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_1.episodeId == arg_12_1 then
			return iter_12_0
		end
	end
end

function var_0_0.getCurEpisodeIndex(arg_13_0)
	return arg_13_0._curEpisodeIndex or 0
end

function var_0_0.getCurEpisode(arg_14_0)
	return arg_14_0._curEpisode
end

function var_0_0.isEpisodeUnlock(arg_15_0, arg_15_1)
	return arg_15_0._episodeInfos[arg_15_1]
end

function var_0_0.isEpisodePass(arg_16_0, arg_16_1)
	if not arg_16_0._episodeInfos[arg_16_1] then
		return false
	end

	return arg_16_0._episodeInfos[arg_16_1].isFinished
end

function var_0_0.checkEpisodeIsGame(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._episodeInfos[arg_17_1]

	if var_17_0 then
		return var_17_0:isGame()
	end

	return true
end

function var_0_0.isAllEpisodeFinish(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0._episodeInfos) do
		if not iter_18_1.isFinished then
			return false
		end
	end

	return true
end

function var_0_0.getNewFinishEpisode(arg_19_0)
	return arg_19_0._newFinishEpisode or 0
end

function var_0_0.setNewFinishEpisode(arg_20_0, arg_20_1)
	arg_20_0._newFinishEpisode = arg_20_1
end

function var_0_0.clearFinishEpisode(arg_21_0)
	arg_21_0._newFinishEpisode = 0
end

function var_0_0.getMaxUnlockEpisodeId(arg_22_0)
	local var_22_0 = YeShuMeiConfig.instance:getEpisodeCoList(arg_22_0._actId)
	local var_22_1 = 0

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		var_22_1 = arg_22_0:isEpisodeUnlock(iter_22_1.episodeId) and math.max(var_22_1, iter_22_1.episodeId) or var_22_1
	end

	return var_22_1
end

function var_0_0.getMaxEpisodeId(arg_23_0)
	local var_23_0 = YeShuMeiConfig.instance:getEpisodeCoList(arg_23_0._actId)
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		var_23_1 = math.max(var_23_1, iter_23_1.episodeId)
	end

	return var_23_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
