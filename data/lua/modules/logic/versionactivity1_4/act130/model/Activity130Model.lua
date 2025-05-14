module("modules.logic.versionactivity1_4.act130.model.Activity130Model", package.seeall)

local var_0_0 = class("Activity130Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curEpisodeId = 0
	arg_2_0._interactInfos = {}
	arg_2_0._collectRewardSates = {}
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	arg_3_0:initInfo(arg_3_1)
end

function var_0_0.setInfos(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = Activity130LevelInfoMo.New()

		var_4_0:init(iter_4_1)

		arg_4_0._interactInfos[iter_4_1.episodeId] = var_4_0
	end
end

function var_0_0.resetInfos(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_0 = Activity130LevelInfoMo.New()

		var_5_0:init(iter_5_1)

		arg_5_0._interactInfos[iter_5_1.episodeId] = var_5_0
	end
end

function var_0_0.updateInfos(arg_6_0, arg_6_1)
	if arg_6_0._interactInfos[arg_6_1.episodeId] then
		arg_6_0._interactInfos[arg_6_1.episodeId]:updateInfo(arg_6_1)
	else
		local var_6_0 = Activity130LevelInfoMo.New()

		var_6_0:init(arg_6_1)

		arg_6_0._interactInfos[arg_6_1.episodeId] = var_6_0
	end
end

function var_0_0.updateProgress(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._interactInfos and arg_7_0._interactInfos[arg_7_1] then
		arg_7_0._interactInfos[arg_7_1].progress = arg_7_2 < Activity130Enum.ProgressType.Finished and arg_7_2 or Activity130Enum.ProgressType.Finished

		return
	end

	logError("请求了不存在的关卡进度!")
end

function var_0_0.getInfos(arg_8_0)
	return arg_8_0._interactInfos
end

function var_0_0.getInfo(arg_9_0, arg_9_1)
	if not arg_9_0._interactInfos then
		return {}
	end

	return arg_9_0._interactInfos[arg_9_1]
end

function var_0_0.isEpisodeFinished(arg_10_0, arg_10_1)
	if not arg_10_0._interactInfos or not arg_10_0._interactInfos[arg_10_1] then
		return false
	end

	return arg_10_0._interactInfos[arg_10_1].progress == Activity130Enum.ProgressType.Finished
end

function var_0_0.getEpisodeState(arg_11_0, arg_11_1)
	if not arg_11_0._interactInfos or not arg_11_0._interactInfos[arg_11_1] then
		return 0
	end

	return arg_11_0._interactInfos[arg_11_1].state
end

function var_0_0.getEpisodeProgress(arg_12_0, arg_12_1)
	if not arg_12_0._interactInfos or not arg_12_0._interactInfos[arg_12_1] then
		return Activity130Enum.ProgressType.BeforeStory
	end

	return arg_12_0._interactInfos[arg_12_1].progress
end

function var_0_0.getEpisodeElements(arg_13_0, arg_13_1)
	if not arg_13_0._interactInfos or not arg_13_0._interactInfos[arg_13_1] then
		return {}
	end

	return arg_13_0._interactInfos[arg_13_1].act130Elements
end

function var_0_0.getEpisodeCurSceneIndex(arg_14_0, arg_14_1)
	local var_14_0 = 1
	local var_14_1 = arg_14_0:getInfo(arg_14_1)

	for iter_14_0, iter_14_1 in ipairs(var_14_1.act130Elements) do
		if iter_14_1.isFinish and iter_14_1.typeList[iter_14_1.index] == Activity130Enum.ElementType.ChangeScene then
			var_14_0 = tonumber(string.split(iter_14_1.config.param, "#")[iter_14_1.index])
		end
	end

	return var_14_0
end

function var_0_0.getCurMapId(arg_15_0)
	return arg_15_0:getCurMapConfig().mapId
end

function var_0_0.getCurMapConfig(arg_16_0)
	local var_16_0 = VersionActivity1_4Enum.ActivityId.Role37

	return (Activity130Config.instance:getActivity130EpisodeCo(var_16_0, arg_16_0._curEpisodeId))
end

function var_0_0.isEpisodeUnlock(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getInfo(arg_17_1)

	return var_17_0 and next(var_17_0)
end

function var_0_0.getCurMapInfo(arg_18_0)
	return arg_18_0:getInfo(arg_18_0._curEpisodeId)
end

function var_0_0.getCurMapElementInfo(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getCurMapInfo()

	for iter_19_0, iter_19_1 in pairs(var_19_0.act130Elements) do
		if iter_19_1.elementId == arg_19_1 then
			return iter_19_1
		end
	end
end

function var_0_0.setCurEpisodeId(arg_20_0, arg_20_1)
	arg_20_0._curEpisodeId = arg_20_1
end

function var_0_0.getCurEpisodeId(arg_21_0)
	return arg_21_0._curEpisodeId or 0
end

function var_0_0.getEpisodeOperGroupId(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getInfo(arg_22_1)
	local var_22_1 = 0

	for iter_22_0, iter_22_1 in ipairs(var_22_0.act130Elements) do
		for iter_22_2, iter_22_3 in ipairs(iter_22_1.typeList) do
			if iter_22_3 == Activity130Enum.ElementType.SetValue and iter_22_2 <= iter_22_1.index then
				local var_22_2 = string.split(iter_22_1.config.param, "#")[iter_22_2]

				var_22_1 = tonumber(string.splitToNumber(var_22_2, "_")[1])
			end
		end
	end

	return var_22_1
end

function var_0_0.getEpisodeDecryptId(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getInfo(arg_23_1)
	local var_23_1 = 0
	local var_23_2 = false

	for iter_23_0, iter_23_1 in ipairs(var_23_0.act130Elements) do
		for iter_23_2, iter_23_3 in ipairs(iter_23_1.typeList) do
			if iter_23_3 == Activity130Enum.ElementType.UnlockDecrypt then
				if iter_23_2 <= iter_23_1.index then
					var_23_1 = tonumber(string.split(iter_23_1.config.param, "#")[iter_23_2])
					var_23_2 = true
				elseif iter_23_2 == iter_23_1.index + 1 and var_23_1 == 0 then
					var_23_1 = tonumber(string.split(iter_23_1.config.param, "#")[iter_23_2])
				end
			end
		end
	end

	return var_23_1, var_23_2
end

function var_0_0.getEpisodeTaskTip(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getInfo(arg_24_1)
	local var_24_1 = var_24_0.tipsElementId
	local var_24_2 = 0
	local var_24_3 = 0
	local var_24_4 = 0

	for iter_24_0, iter_24_1 in ipairs(var_24_0.act130Elements) do
		if iter_24_1.elementId == var_24_1 or var_24_1 == 0 then
			for iter_24_2, iter_24_3 in ipairs(iter_24_1.typeList) do
				if iter_24_3 == Activity130Enum.ElementType.TaskTip and iter_24_2 <= iter_24_1.index then
					local var_24_5 = string.split(iter_24_1.config.param, "#")[iter_24_2]
					local var_24_6 = string.splitToNumber(var_24_5, "_")

					var_24_2 = var_24_6[1]
					var_24_3 = var_24_6[2]
				end
			end
		end
	end

	return var_24_2, var_24_3
end

function var_0_0.getCollects(arg_25_0, arg_25_1)
	local var_25_0 = {}
	local var_25_1 = arg_25_0:getCurEpisodeId()
	local var_25_2 = arg_25_0:getEpisodeOperGroupId(var_25_1)

	if var_25_2 == 0 then
		return var_25_0
	end

	local var_25_3 = VersionActivity1_4Enum.ActivityId.Role37
	local var_25_4 = Activity130Config.instance:getActivity130OperateGroupCos(var_25_3, var_25_2)

	for iter_25_0, iter_25_1 in pairs(var_25_4) do
		if arg_25_0:isCollectUnlock(var_25_1, iter_25_1.operType) then
			table.insert(var_25_0, iter_25_1.operType)
		end
	end

	return var_25_0
end

function var_0_0.isCollectUnlock(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:getInfo(arg_26_1)

	for iter_26_0, iter_26_1 in ipairs(var_26_0.act130Elements) do
		for iter_26_2, iter_26_3 in ipairs(iter_26_1.typeList) do
			if iter_26_3 == Activity130Enum.ElementType.SetValue and iter_26_2 <= iter_26_1.index then
				local var_26_1 = string.split(iter_26_1.config.param, "#")[iter_26_2]

				if arg_26_2 == tonumber(string.splitToNumber(var_26_1, "_")[2]) then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.getDecryptIdByGroupId(arg_27_0, arg_27_1)
	local var_27_0 = VersionActivity1_4Enum.ActivityId.Role37
	local var_27_1 = Activity130Config.instance:getActivity130DecryptCos(var_27_0)

	for iter_27_0, iter_27_1 in pairs(var_27_1) do
		if iter_27_1.operGroupId == arg_27_1 then
			return iter_27_1.puzzleId
		end
	end

	return 0
end

function var_0_0.getElementInfoByDecryptId(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0

	var_28_0 = arg_28_2 and arg_28_2 or arg_28_0:getCurEpisodeId()

	local var_28_1 = arg_28_0:getInfo(arg_28_2)

	for iter_28_0, iter_28_1 in pairs(var_28_1.act130Elements) do
		for iter_28_2, iter_28_3 in pairs(iter_28_1.typeList) do
			if iter_28_3 == Activity130Enum.ElementType.UnlockDecrypt then
				return iter_28_1
			end
		end
	end
end

function var_0_0.getMaxEpisode(arg_29_0)
	local var_29_0 = VersionActivity1_4Enum.ActivityId.Role37
	local var_29_1 = Activity130Config.instance:getActivity130EpisodeCos(var_29_0)
	local var_29_2 = 0

	for iter_29_0, iter_29_1 in pairs(var_29_1) do
		var_29_2 = var_29_2 > iter_29_1.episodeId and var_29_2 or iter_29_1.episodeId
	end

	return var_29_2
end

function var_0_0.getMaxUnlockEpisode(arg_30_0)
	local var_30_0 = arg_30_0:getCurEpisodeId()

	for iter_30_0, iter_30_1 in pairs(arg_30_0._interactInfos) do
		var_30_0 = var_30_0 > iter_30_1.episodeId and var_30_0 or iter_30_1.episodeId
	end

	return var_30_0
end

function var_0_0.getTotalEpisodeCount(arg_31_0)
	local var_31_0 = VersionActivity1_4Enum.ActivityId.Role37

	return #Activity130Config.instance:getActivity130EpisodeCos(var_31_0)
end

function var_0_0.setNewFinishEpisode(arg_32_0, arg_32_1)
	arg_32_0._newFinishEpisode = arg_32_1
end

function var_0_0.getNewFinishEpisode(arg_33_0)
	return arg_33_0._newFinishEpisode or -1
end

function var_0_0.getNewUnlockEpisode(arg_34_0)
	return arg_34_0._newUnlockEpisode or -1
end

function var_0_0.setNewUnlockEpisode(arg_35_0, arg_35_1)
	arg_35_0._newUnlockEpisode = arg_35_1
end

function var_0_0.setNewCollect(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0._collectRewardSates[arg_36_1] = arg_36_2
end

function var_0_0.getNewCollectState(arg_37_0, arg_37_1)
	return arg_37_0._collectRewardSates[arg_37_1]
end

function var_0_0.getGameChallengeNum(arg_38_0, arg_38_1)
	return arg_38_0:getInfo(arg_38_1).challengeNum
end

function var_0_0.updateChallengeNum(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0:getInfo(arg_39_1)

	if var_39_0 and var_39_0.updateChallengeNum then
		var_39_0:updateChallengeNum(arg_39_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
