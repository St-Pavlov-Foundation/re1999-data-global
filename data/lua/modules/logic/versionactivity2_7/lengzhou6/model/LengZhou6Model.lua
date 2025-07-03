module("modules.logic.versionactivity2_7.lengzhou6.model.LengZhou6Model", package.seeall)

local var_0_0 = class("LengZhou6Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._actInfoMap = {}
	arg_1_0._actNewestEpisodeDict = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._actInfoMap = {}
	arg_2_0._actNewestEpisodeDict = {}
end

function var_0_0.onGetActInfo(arg_3_0, arg_3_1)
	arg_3_0._activityId = arg_3_1.activityId

	local var_3_0 = arg_3_1.episodes

	if not var_3_0 or #var_3_0 <= 0 then
		return
	end

	if arg_3_0._actInfoMap == nil or tabletool.len(arg_3_0._actInfoMap) == 0 then
		if arg_3_0._actInfoMap == nil then
			arg_3_0._actInfoMap = {}
		end

		local var_3_1 = lua_activity190_episode.configDict[arg_3_0._activityId]

		for iter_3_0, iter_3_1 in pairs(var_3_1) do
			if arg_3_0._actInfoMap[iter_3_0] == nil then
				local var_3_2 = LengZhou6InfoMo.New()

				var_3_2:init(arg_3_0:getCurActId(), iter_3_0, false)

				arg_3_0._actInfoMap[iter_3_0] = var_3_2
			end
		end
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_0) do
		local var_3_3 = iter_3_3.episodeId

		arg_3_0._actInfoMap[var_3_3]:updateInfo(iter_3_3)
	end

	arg_3_0:updateNewestEpisode()
end

function var_0_0.onFinishActInfo(arg_4_0, arg_4_1)
	arg_4_0._activityId = arg_4_1.activityId

	local var_4_0 = arg_4_1.episodeId

	if var_4_0 == nil then
		return
	end

	if arg_4_0._actInfoMap ~= nil then
		local var_4_1 = arg_4_0._actInfoMap[var_4_0]

		if var_4_1 then
			var_4_1:updateIsFinish(true)
			var_4_1:updateProgress(arg_4_1.progress)
		end
	end
end

function var_0_0.onPushActInfo(arg_5_0, arg_5_1)
	arg_5_0._activityId = arg_5_1.activityId

	local var_5_0 = arg_5_1.episodes

	if not var_5_0 or #var_5_0 <= 0 then
		return
	end

	if arg_5_0._actInfoMap == nil or tabletool.len(arg_5_0._actInfoMap) == 0 then
		if arg_5_0._actInfoMap == nil then
			arg_5_0._actInfoMap = {}
		end

		local var_5_1 = lua_activity190_episode.configDict[arg_5_0._activityId]

		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			if arg_5_0._actInfoMap[iter_5_0] == nil then
				local var_5_2 = LengZhou6InfoMo.New()

				var_5_2:init(arg_5_0:getCurActId(), iter_5_0, false)

				arg_5_0._actInfoMap[iter_5_0] = var_5_2
			end
		end
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		local var_5_3 = iter_5_3.episodeId
		local var_5_4 = arg_5_0._actInfoMap[var_5_3].preEpisodeId

		if arg_5_0._actInfoMap[var_5_4] then
			arg_5_0._actInfoMap[var_5_4]:updateIsFinish(true)
		end
	end

	arg_5_0:updateNewestEpisode()
end

function var_0_0.updateNewestEpisode(arg_6_0)
	local var_6_0
	local var_6_1

	for iter_6_0, iter_6_1 in pairs(arg_6_0._actInfoMap) do
		local var_6_2 = arg_6_0:isUnlockEpisode(iter_6_0)
		local var_6_3 = arg_6_0:isFinishedEpisode(iter_6_0)

		if var_6_2 and not var_6_3 then
			var_6_0 = iter_6_0
		end

		if arg_6_0._actInfoMap[iter_6_0]:isEndlessEpisode() then
			var_6_1 = iter_6_0
		end
	end

	local var_6_4 = arg_6_0:getCurActId()

	if var_6_0 == nil then
		arg_6_0._actNewestEpisodeDict[var_6_4] = var_6_1
	else
		arg_6_0._actNewestEpisodeDict[var_6_4] = var_6_0
	end
end

function var_0_0.getAllEpisodeIds(arg_7_0)
	local var_7_0 = lua_activity190_episode.configDict[arg_7_0._activityId]
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		table.insert(var_7_1, iter_7_0)
	end

	table.sort(var_7_1, function(arg_8_0, arg_8_1)
		return arg_8_0 < arg_8_1
	end)

	return var_7_1
end

function var_0_0.getEpisodeInfoMo(arg_9_0, arg_9_1)
	return arg_9_0._actInfoMap[arg_9_1]
end

function var_0_0.getActInfoDic(arg_10_0)
	return arg_10_0._actInfoMap
end

function var_0_0.isEpisodeFinish(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._actInfoMap[arg_11_1]

	if var_11_0 == nil then
		return false
	end

	return var_11_0.isFinish
end

function var_0_0.setCurEpisodeId(arg_12_0, arg_12_1)
	arg_12_0._curEpisodeId = arg_12_1
end

function var_0_0.getCurEpisodeId(arg_13_0)
	return arg_13_0._curEpisodeId
end

function var_0_0.getCurActId(arg_14_0)
	return arg_14_0._activityId
end

function var_0_0.getEpisodeIsEndLess(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.enemyId

	if not string.nilorempty(var_15_0) then
		return var_15_0 == "2"
	end

	return false
end

function var_0_0.getAct190Id(arg_16_0)
	return VersionActivity2_7Enum.ActivityId.LengZhou6
end

function var_0_0.isAct190Open(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getAct190Id()
	local var_17_1
	local var_17_2
	local var_17_3

	if ActivityModel.instance:getActivityInfo()[var_17_0] then
		var_17_1, var_17_2, var_17_3 = ActivityHelper.getActivityStatusAndToast(var_17_0)
	else
		var_17_2 = ToastEnum.ActivityEnd
	end

	if arg_17_1 and var_17_2 then
		GameFacade.showToast(var_17_2, var_17_3)
	end

	return var_17_1 == ActivityEnum.ActivityStatus.Normal
end

function var_0_0.isUnlockEpisode(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._actInfoMap[arg_18_1]

	return var_18_0 ~= nil and var_18_0:unLock()
end

function var_0_0.isFinishedEpisode(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._actInfoMap[arg_19_1]

	return var_19_0 ~= nil and var_19_0.isFinish
end

function var_0_0.getNewestEpisodeId(arg_20_0, arg_20_1)
	return arg_20_0._actNewestEpisodeDict[arg_20_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
