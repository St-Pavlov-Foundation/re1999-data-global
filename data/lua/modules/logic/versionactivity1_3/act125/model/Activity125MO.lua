module("modules.logic.versionactivity1_3.act125.model.Activity125MO", package.seeall)

local var_0_0 = pureTable("Activity125MO")

function var_0_0.ctor(arg_1_0)
	arg_1_0._userId = PlayerModel.instance:getMyUserId()
	arg_1_0._episdoeInfos = {}
	arg_1_0._oldDict = {}
end

function var_0_0.setInfo(arg_2_0, arg_2_1)
	arg_2_0._episdoeInfos = {}
	arg_2_0.id = arg_2_1.activityId

	arg_2_0:initConfig()
	arg_2_0:updateInfo(arg_2_1.act125Episodes)
end

function var_0_0.initConfig(arg_3_0)
	if arg_3_0.config then
		return
	end

	arg_3_0.config = Activity125Config.instance:getAct125Config(arg_3_0.id)
	arg_3_0._episodeList = {}

	if arg_3_0.config then
		for iter_3_0, iter_3_1 in pairs(arg_3_0.config) do
			table.insert(arg_3_0._episodeList, iter_3_1)
		end

		table.sort(arg_3_0._episodeList, SortUtil.keyLower("id"))
	end
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	if arg_4_1 then
		for iter_4_0 = 1, #arg_4_1 do
			local var_4_0 = arg_4_1[iter_4_0]

			arg_4_0._episdoeInfos[var_4_0.id] = var_4_0.state
		end
	end

	local var_4_1 = ActivityConfig.instance:getActivityCo(arg_4_0.id).redDotId

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(var_4_1)] = true
	})
end

function var_0_0.isEpisodeFinished(arg_5_0, arg_5_1)
	return arg_5_0._episdoeInfos and arg_5_0._episdoeInfos[arg_5_1] == 1
end

function var_0_0.getEpisodeConfig(arg_6_0, arg_6_1)
	return arg_6_0.config[arg_6_1]
end

function var_0_0.isEpisodeUnLock(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getEpisodeConfig(arg_7_1).preId
	local var_7_1 = true

	if var_7_0 and var_7_0 > 0 then
		var_7_1 = arg_7_0._episdoeInfos[var_7_0] == 1 or arg_7_0:checkLocalIsPlay(var_7_0) and arg_7_0._episdoeInfos[var_7_0] == 0
	end

	return var_7_1 and arg_7_0._episdoeInfos[arg_7_1] ~= nil
end

function var_0_0.isEpisodeDayOpen(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = false
	local var_8_1 = ActivityModel.instance:getActMO(arg_8_0.id)
	local var_8_2 = arg_8_0:getEpisodeConfig(arg_8_1).openDay
	local var_8_3 = 0
	local var_8_4 = 0

	if var_8_1 and var_8_2 then
		local var_8_5 = var_8_1:getRealStartTimeStamp() + (var_8_2 - 1) * TimeUtil.OneDaySecond
		local var_8_6 = ServerTime.now()

		var_8_4 = var_8_5 - ServerTime.now()

		if var_8_4 < 0 then
			var_8_0 = true
		else
			var_8_3 = math.floor(var_8_4 / TimeUtil.OneDaySecond)
		end
	end

	return var_8_0, var_8_3, var_8_4
end

function var_0_0.isEpisodeReallyOpen(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:isEpisodeUnLock(arg_9_1)
	local var_9_1 = arg_9_0:isEpisodeDayOpen(arg_9_1)
	local var_9_2 = arg_9_0:getEpisodeConfig(arg_9_1)
	local var_9_3 = var_9_2 and var_9_2.preId or nil

	if var_9_3 and var_9_3 > 0 and not arg_9_0:isEpisodeFinished(var_9_3) then
		return false
	end

	return var_9_0 and var_9_1
end

function var_0_0.getLastEpisode(arg_10_0)
	for iter_10_0 = #arg_10_0._episodeList, 1, -1 do
		local var_10_0 = arg_10_0._episodeList[iter_10_0]

		if arg_10_0:isEpisodeReallyOpen(var_10_0.id) then
			return var_10_0.id
		end
	end

	local var_10_1 = arg_10_0._episodeList[1]

	return var_10_1 and var_10_1.id
end

function var_0_0.getFirstRewardEpisode(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._episodeList) do
		if arg_11_0:isEpisodeReallyOpen(iter_11_1.id) then
			if arg_11_0._episdoeInfos[iter_11_1.id] == 0 then
				return iter_11_1.id
			end
		else
			return iter_11_1.preId
		end
	end

	local var_11_0 = arg_11_0._episodeList[#arg_11_0._episodeList]

	return var_11_0 and var_11_0.id
end

function var_0_0.setLocalIsPlay(arg_12_0, arg_12_1)
	local var_12_0 = string.format("%s_%s_%s_%s", PlayerModel.instance:getPlayinfo().userId, PlayerPrefsKey.VersionActivityWarmUpView, arg_12_0.id, arg_12_1)

	PlayerPrefsHelper.setString(var_12_0, 1)
end

function var_0_0.checkLocalIsPlay(arg_13_0, arg_13_1)
	local var_13_0 = string.format("%s_%s_%s_%s", PlayerModel.instance:getPlayinfo().userId, PlayerPrefsKey.VersionActivityWarmUpView, arg_13_0.id, arg_13_1)
	local var_13_1 = PlayerPrefsHelper.getString(var_13_0, "")

	if string.nilorempty(var_13_1) then
		return false
	end

	return true
end

function var_0_0.setOldEpisode(arg_14_0, arg_14_1)
	arg_14_0._oldDict[arg_14_1] = true
end

function var_0_0.checkIsOldEpisode(arg_15_0, arg_15_1)
	return arg_15_0._oldDict[arg_15_1]
end

function var_0_0.getEpisodeCount(arg_16_0)
	return #arg_16_0._episodeList
end

function var_0_0.getEpisodeList(arg_17_0)
	return arg_17_0._episodeList
end

function var_0_0.setSelectEpisodeId(arg_18_0, arg_18_1)
	arg_18_0._selectId = arg_18_1
end

function var_0_0.getSelectEpisodeId(arg_19_0)
	if not arg_19_0._selectId then
		arg_19_0._selectId = arg_19_0:getFirstRewardEpisode()
	end

	return arg_19_0._selectId
end

function var_0_0.isAllEpisodeFinish(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._episodeList) do
		local var_20_0 = arg_20_0._episdoeInfos[iter_20_1.id]

		if not var_20_0 or var_20_0 == 0 then
			return false
		end
	end

	return true
end

function var_0_0.isHasEpisodeCanReceiveReward(arg_21_0, arg_21_1)
	if arg_21_1 then
		return arg_21_0._episdoeInfos[arg_21_1] == 0
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._episodeList) do
		if arg_21_0._episdoeInfos[iter_21_1.id] == 0 then
			return true
		end
	end

	return false
end

function var_0_0.isFirstCheckEpisode(arg_22_0, arg_22_1)
	local var_22_0 = string.format("%s_%s_%s_%s", arg_22_0._userId, PlayerPrefsKey.Activity125FirstCheckEpisode, arg_22_0.id, arg_22_1)

	return PlayerPrefsHelper.getNumber(var_22_0, 0) == 0
end

function var_0_0.setHasCheckEpisode(arg_23_0, arg_23_1)
	local var_23_0 = string.format("%s_%s_%s_%s", arg_23_0._userId, PlayerPrefsKey.Activity125FirstCheckEpisode, arg_23_0.id, arg_23_1)

	if arg_23_0:isFirstCheckEpisode(arg_23_1) then
		PlayerPrefsHelper.setNumber(var_23_0, 1)
	end
end

function var_0_0.hasEpisodeCanCheck(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0._episodeList) do
		local var_24_0 = iter_24_1.id

		if arg_24_0:isEpisodeReallyOpen(var_24_0) and arg_24_0:isFirstCheckEpisode(var_24_0) then
			return true
		end
	end

	return false
end

function var_0_0.hasEpisodeCanGetReward(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0._episodeList) do
		local var_25_0 = arg_25_0._episdoeInfos[iter_25_1.id]
		local var_25_1 = arg_25_0:checkLocalIsPlay(iter_25_1.id)

		if var_25_0 == 0 and var_25_1 then
			return true
		end
	end

	return false
end

function var_0_0.getRLOC(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:isEpisodeFinished(arg_26_1)
	local var_26_1 = arg_26_0:checkLocalIsPlay(arg_26_1)
	local var_26_2 = arg_26_0:checkIsOldEpisode(arg_26_1)
	local var_26_3 = not var_26_0 and var_26_1

	return var_26_0, var_26_1, var_26_2, var_26_3
end

function var_0_0.hasRedDot(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0._episodeList) do
		local var_27_0 = iter_27_1.id

		if arg_27_0:isEpisodeReallyOpen(var_27_0) and arg_27_0:isHasEpisodeCanReceiveReward(var_27_0) then
			return true
		end
	end

	return false
end

return var_0_0
