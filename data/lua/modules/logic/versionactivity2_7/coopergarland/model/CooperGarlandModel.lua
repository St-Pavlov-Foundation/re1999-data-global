module("modules.logic.versionactivity2_7.coopergarland.model.CooperGarlandModel", package.seeall)

local var_0_0 = class("CooperGarlandModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0._actInfoDic = {}
	arg_3_0._actNewestEpisodeDict = {}
end

function var_0_0.updateAct192Info(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = arg_4_1.activityId
	local var_4_1 = arg_4_1.episodes

	if var_4_1 then
		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			arg_4_0:updateAct192Episode(var_4_0, iter_4_1.episodeId, iter_4_1.isFinished, iter_4_1.progress)
		end
	end

	arg_4_0:updateNewestEpisode(var_4_0)
end

function var_0_0.updateAct192Episode(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if not arg_5_1 or not arg_5_2 then
		return
	end

	local var_5_0 = arg_5_0._actInfoDic[arg_5_1]

	if not var_5_0 then
		var_5_0 = {}
		arg_5_0._actInfoDic[arg_5_1] = var_5_0
	end

	local var_5_1 = var_5_0[arg_5_2]

	if not var_5_1 then
		var_5_1 = {}
		var_5_0[arg_5_2] = var_5_1
	end

	var_5_1.isFinished = arg_5_3
	var_5_1.progress = arg_5_4
end

function var_0_0.updateNewestEpisode(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = CooperGarlandConfig.instance:getEpisodeIdList(arg_6_1, true)

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = arg_6_0:isUnlockEpisode(arg_6_1, iter_6_1)
		local var_6_3 = arg_6_0:isFinishedEpisode(arg_6_1, iter_6_1)

		if var_6_2 and not var_6_3 then
			var_6_0 = iter_6_1
		end
	end

	arg_6_0._actNewestEpisodeDict[arg_6_1] = var_6_0
end

function var_0_0.getAct192Id(arg_7_0)
	return VersionActivity2_7Enum.ActivityId.CooperGarland
end

function var_0_0.isAct192Open(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getAct192Id()
	local var_8_1
	local var_8_2
	local var_8_3

	if ActivityModel.instance:getActivityInfo()[var_8_0] then
		var_8_1, var_8_2, var_8_3 = ActivityHelper.getActivityStatusAndToast(var_8_0)
	else
		var_8_2 = ToastEnum.ActivityEnd
	end

	if arg_8_1 and var_8_2 then
		GameFacade.showToast(var_8_2, var_8_3)
	end

	return var_8_1 == ActivityEnum.ActivityStatus.Normal
end

function var_0_0.getAct192RemainTimeStr(arg_9_0, arg_9_1)
	local var_9_0 = ""
	local var_9_1 = true
	local var_9_2 = arg_9_1 or arg_9_0:getAct192Id()
	local var_9_3 = ActivityModel.instance:getActivityInfo()[var_9_2]

	if var_9_3 then
		local var_9_4 = var_9_3:getRealEndTimeStamp() - ServerTime.now()

		if var_9_4 > 0 then
			var_9_0 = TimeUtil.SecondToActivityTimeFormat(var_9_4)
			var_9_1 = false
		end
	end

	return var_9_0, var_9_1
end

function var_0_0.getEpisodeInfo(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if arg_10_1 and arg_10_2 and arg_10_0._actInfoDic then
		local var_10_1 = arg_10_0._actInfoDic[arg_10_1]

		if var_10_1 then
			var_10_0 = var_10_1[arg_10_2]
		end
	end

	return var_10_0
end

function var_0_0.isUnlockEpisode(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0:getEpisodeInfo(arg_11_1, arg_11_2) ~= nil
end

function var_0_0.isFinishedEpisode(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getEpisodeInfo(arg_12_1, arg_12_2)

	return var_12_0 and var_12_0.isFinished
end

function var_0_0.getEpisodeProgress(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getEpisodeInfo(arg_13_1, arg_13_2)
	local var_13_1 = var_13_0 and var_13_0.progress

	if string.nilorempty(var_13_1) then
		var_13_1 = CooperGarlandEnum.Const.DefaultGameProgress
	end

	return tonumber(var_13_1)
end

function var_0_0.getNewestEpisodeId(arg_14_0, arg_14_1)
	return arg_14_0._actNewestEpisodeDict and arg_14_0._actNewestEpisodeDict[arg_14_1]
end

function var_0_0.isNewestEpisode(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = false

	if arg_15_1 and arg_15_2 then
		var_15_0 = arg_15_2 == arg_15_0:getNewestEpisodeId(arg_15_1)
	end

	return var_15_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
