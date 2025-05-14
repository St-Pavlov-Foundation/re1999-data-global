module("modules.logic.versionactivity1_4.act131.model.Activity131Model", package.seeall)

local var_0_0 = class("Activity131Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curEpisodeId = 0
	arg_2_0._interactInfos = {}
	arg_2_0.curMaplogDic = {}
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	arg_3_0:initInfo(arg_3_1)
end

function var_0_0.setInfos(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = Activity131LevelInfoMo.New()

		var_4_0:init(iter_4_1)

		arg_4_0._interactInfos[iter_4_1.episodeId] = var_4_0
	end
end

function var_0_0.resetInfos(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_0 = Activity131LevelInfoMo.New()

		var_5_0:init(iter_5_1)

		arg_5_0._interactInfos[iter_5_1.episodeId] = var_5_0
	end
end

function var_0_0.updateInfos(arg_6_0, arg_6_1)
	if arg_6_0._interactInfos[arg_6_1.episodeId] then
		arg_6_0._interactInfos[arg_6_1.episodeId]:updateInfo(arg_6_1)
	else
		local var_6_0 = Activity131LevelInfoMo.New()

		var_6_0:init(arg_6_1)

		arg_6_0._interactInfos[arg_6_1.episodeId] = var_6_0
	end
end

function var_0_0.updateProgress(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._interactInfos and arg_7_0._interactInfos[arg_7_1] then
		arg_7_0._interactInfos[arg_7_1].progress = arg_7_2 < Activity131Enum.ProgressType.Finished and arg_7_2 or Activity131Enum.ProgressType.Finished

		return
	end

	logError("请求了不存在的关卡进度!")
end

function var_0_0.refreshLogDics(arg_8_0)
	local var_8_0 = arg_8_0:getCurMapInfo()
	local var_8_1 = 0

	if var_8_0 then
		arg_8_0.curMaplogDic = {}

		for iter_8_0, iter_8_1 in ipairs(var_8_0.act131Elements) do
			local var_8_2 = iter_8_1.index

			if var_8_2 ~= 0 then
				for iter_8_2 = 1, var_8_2 do
					local var_8_3 = iter_8_1.typeList[iter_8_2]
					local var_8_4 = iter_8_1.paramList[iter_8_2]

					if var_8_3 == Activity131Enum.ElementType.LogStart then
						var_8_1 = var_8_4

						if not arg_8_0.curMaplogDic[var_8_1] then
							arg_8_0.curMaplogDic[var_8_1] = {}
						end
					elseif var_8_3 == Activity131Enum.ElementType.Dialog then
						if var_8_1 ~= 0 and arg_8_0.curMaplogDic[var_8_1] then
							local var_8_5 = Activity131Config.instance:getActivity131DialogGroup(tonumber(var_8_4))

							for iter_8_3, iter_8_4 in pairs(var_8_5) do
								table.insert(arg_8_0.curMaplogDic[var_8_1], iter_8_4)
							end
						end
					elseif var_8_3 == Activity131Enum.ElementType.LogEnd then
						if arg_8_0.curMaplogDic[var_8_1] then
							table.sort(arg_8_0.curMaplogDic[var_8_1], function(arg_9_0, arg_9_1)
								if arg_9_0.id ~= arg_9_1.id then
									return arg_9_0.id < arg_9_1.id
								else
									return arg_9_0.stepId < arg_9_1.stepId
								end
							end)
						end

						var_8_1 = 0
					end
				end
			end
		end
	end
end

function var_0_0.getLogCategortList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.curMaplogDic) do
		table.insert(var_10_0, {
			logType = iter_10_0
		})
	end

	return var_10_0
end

function var_0_0.getInfos(arg_11_0)
	return arg_11_0._interactInfos
end

function var_0_0.getInfo(arg_12_0, arg_12_1)
	if not arg_12_0._interactInfos then
		return {}
	end

	return arg_12_0._interactInfos[arg_12_1]
end

function var_0_0.isEpisodeFinished(arg_13_0, arg_13_1)
	if not arg_13_0._interactInfos or not arg_13_0._interactInfos[arg_13_1] then
		return false
	end

	return arg_13_0._interactInfos[arg_13_1].progress == Activity131Enum.ProgressType.Finished
end

function var_0_0.getEpisodeProgress(arg_14_0, arg_14_1)
	if not arg_14_0._interactInfos or not arg_14_0._interactInfos[arg_14_1] then
		return Activity131Enum.ProgressType.BeforeStory
	end

	return arg_14_0._interactInfos[arg_14_1].progress
end

function var_0_0.getEpisodeElements(arg_15_0, arg_15_1)
	if not arg_15_0._interactInfos or not arg_15_0._interactInfos[arg_15_1] then
		return {}
	end

	return arg_15_0._interactInfos[arg_15_1].act131Elements
end

function var_0_0.getEpisodeCurSceneIndex(arg_16_0, arg_16_1)
	local var_16_0 = 1
	local var_16_1 = arg_16_0:getInfo(arg_16_1)

	for iter_16_0, iter_16_1 in ipairs(var_16_1.act131Elements) do
		if iter_16_1.isFinish and iter_16_1.typeList[iter_16_1.index] == Activity131Enum.ElementType.ChangeScene then
			var_16_0 = tonumber(string.split(iter_16_1.config.param, "#")[iter_16_1.index])
		end
	end

	return var_16_0
end

function var_0_0.getCurMapId(arg_17_0)
	return arg_17_0:getCurMapConfig().mapId
end

function var_0_0.getCurMapConfig(arg_18_0)
	local var_18_0 = VersionActivity1_4Enum.ActivityId.Role6

	return (Activity131Config.instance:getActivity131EpisodeCo(var_18_0, arg_18_0._curEpisodeId))
end

function var_0_0.isEpisodeUnlock(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getInfo(arg_19_1)

	return var_19_0 and next(var_19_0)
end

function var_0_0.getEpisodeState(arg_20_0, arg_20_1)
	if not arg_20_0._interactInfos or not arg_20_0._interactInfos[arg_20_1] then
		return 0
	end

	return arg_20_0._interactInfos[arg_20_1].state
end

function var_0_0.getCurMapInfo(arg_21_0)
	return arg_21_0:getInfo(arg_21_0._curEpisodeId)
end

function var_0_0.getCurMapElementInfo(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getCurMapInfo()

	for iter_22_0, iter_22_1 in pairs(var_22_0.act131Elements) do
		if iter_22_1.elementId == arg_22_1 then
			return iter_22_1
		end
	end
end

function var_0_0.setCurEpisodeId(arg_23_0, arg_23_1)
	arg_23_0._curEpisodeId = arg_23_1
end

function var_0_0.getCurEpisodeId(arg_24_0)
	return arg_24_0._curEpisodeId
end

function var_0_0.getEpisodeTaskTip(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getInfo(arg_25_1)
	local var_25_1 = 0
	local var_25_2 = 0
	local var_25_3 = 0

	for iter_25_0, iter_25_1 in ipairs(var_25_0.act131Elements) do
		for iter_25_2, iter_25_3 in ipairs(iter_25_1.typeList) do
			if iter_25_3 == Activity131Enum.ElementType.TaskTip and iter_25_2 <= iter_25_1.index then
				local var_25_4 = string.split(iter_25_1.config.param, "#")[iter_25_2]
				local var_25_5 = string.splitToNumber(var_25_4, "_")

				if var_25_3 < iter_25_1.elementId then
					var_25_3 = iter_25_1.elementId
					var_25_1 = var_25_5[1]
					var_25_2 = var_25_5[2]
				end
			end
		end
	end

	return var_25_1, var_25_2
end

function var_0_0.getMaxEpisode(arg_26_0)
	local var_26_0 = VersionActivity1_4Enum.ActivityId.Role6
	local var_26_1 = Activity131Config.instance:getActivity131EpisodeCos(var_26_0)
	local var_26_2 = 0

	for iter_26_0, iter_26_1 in pairs(var_26_1) do
		var_26_2 = var_26_2 > iter_26_1.episodeId and var_26_2 or iter_26_1.episodeId
	end

	return var_26_2
end

function var_0_0.getMaxUnlockEpisode(arg_27_0)
	local var_27_0 = arg_27_0:getCurEpisodeId()

	for iter_27_0, iter_27_1 in pairs(arg_27_0._interactInfos) do
		var_27_0 = var_27_0 > iter_27_1.episodeId and var_27_0 or iter_27_1.episodeId
	end

	return var_27_0
end

function var_0_0.setNewFinishEpisode(arg_28_0, arg_28_1)
	arg_28_0._newFinishEpisode = arg_28_1
end

function var_0_0.getNewFinishEpisode(arg_29_0)
	return arg_29_0._newFinishEpisode or -1
end

function var_0_0.getNewUnlockEpisode(arg_30_0)
	return arg_30_0._newUnlockEpisode or -1
end

function var_0_0.setNewUnlockEpisode(arg_31_0, arg_31_1)
	arg_31_0._newUnlockEpisode = arg_31_1
end

function var_0_0.setSelectLogType(arg_32_0, arg_32_1)
	arg_32_0.curSelectLogType = arg_32_1

	Activity131Controller.instance:dispatchEvent(Activity131Event.SelectCategory)
end

function var_0_0.getSelectLogType(arg_33_0)
	return arg_33_0.curSelectLogType
end

function var_0_0.getLog(arg_34_0)
	if arg_34_0.curSelectLogType and arg_34_0.curSelectLogType ~= 0 then
		return arg_34_0.curMaplogDic and arg_34_0.curMaplogDic[arg_34_0.curSelectLogType] or {}
	end

	return {}
end

function var_0_0.getTotalEpisodeCount(arg_35_0)
	local var_35_0 = VersionActivity1_4Enum.ActivityId.Role6

	return #Activity131Config.instance:getActivity131EpisodeCos(var_35_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
