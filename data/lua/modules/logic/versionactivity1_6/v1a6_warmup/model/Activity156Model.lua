module("modules.logic.versionactivity1_6.v1a6_warmup.model.Activity156Model", package.seeall)

local var_0_0 = class("Activity156Model", BaseModel)

var_0_0.EpisodeUnFinishState = 0
var_0_0.EpisodeFinishedState = 1

function var_0_0.onInit(arg_1_0)
	arg_1_0._actInfo = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._actInfo = nil
end

function var_0_0.setActivityInfo(arg_3_0, arg_3_1)
	arg_3_0._actInfo = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if iter_3_1.id and iter_3_1.state then
			arg_3_0._actInfo[iter_3_1.id] = iter_3_1.state
		end
	end
end

function var_0_0.setLocalIsPlay(arg_4_0, arg_4_1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayinfo().userId .. PlayerPrefsKey.VersionActivity1_6WarmUpView .. arg_4_1, arg_4_1)
end

function var_0_0.checkLocalIsPlay(arg_5_0, arg_5_1)
	local var_5_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayinfo().userId .. PlayerPrefsKey.VersionActivity1_6WarmUpView .. arg_5_1, "")

	if string.nilorempty(var_5_0) then
		return false
	end

	return true
end

function var_0_0.isEpisodeFinishedButUnReceive(arg_6_0, arg_6_1)
	return arg_6_0._actInfo and arg_6_0._actInfo[arg_6_1] == var_0_0.EpisodeFinishedState
end

function var_0_0.isEpisodeFinished(arg_7_0, arg_7_1)
	return arg_7_0:isEpisodeFinishedButUnReceive(arg_7_1) or arg_7_0:isEpisodeHasReceivedReward(arg_7_1)
end

function var_0_0.isEpisodeHasReceivedReward(arg_8_0, arg_8_1)
	return arg_8_0._actInfo and arg_8_0._actInfo[arg_8_1] == var_0_0.EpisodeFinishedState
end

function var_0_0.setCurSelectedEpisode(arg_9_0, arg_9_1)
	arg_9_0._curSelectedEpisodeId = arg_9_1
end

function var_0_0.getCurSelectedEpisode(arg_10_0)
	return arg_10_0._curSelectedEpisodeId
end

function var_0_0.cleanCurSelectedEpisode(arg_11_0)
	arg_11_0._curSelectedEpisodeId = nil
end

function var_0_0.setIsPlayingMusicId(arg_12_0, arg_12_1)
	arg_12_0._isPlayingMusicId = arg_12_1
end

function var_0_0.checkIsPlayingMusicId(arg_13_0, arg_13_1)
	if arg_13_0._isPlayingMusicId == arg_13_1 then
		return true
	end

	return false
end

function var_0_0.cleanIsPlayingMusicId(arg_14_0)
	arg_14_0._isPlayingMusicId = nil
end

function var_0_0.isEpisodeUnLock(arg_15_0, arg_15_1)
	local var_15_0 = Activity156Config.instance:getPreEpisodeConfig(arg_15_1)
	local var_15_1 = true

	if var_15_0 then
		var_15_1 = arg_15_0:isEpisodeFinished(var_15_0.id)
	end

	return var_15_1 and arg_15_0._actInfo and arg_15_0._actInfo[arg_15_1] ~= nil
end

function var_0_0.isOpen(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = false
	local var_16_1 = ActivityModel.instance:getActMO(arg_16_1)
	local var_16_2 = Activity156Config.instance:getEpisodeOpenDay(arg_16_2)

	if var_16_1 and var_16_2 then
		local var_16_3 = var_16_1:getRealStartTimeStamp() + (var_16_2 - 1) * TimeUtil.OneDaySecond
		local var_16_4 = ServerTime.now()

		if var_16_3 < ServerTime.now() then
			var_16_0 = true
		end
	end

	return var_16_0
end

function var_0_0.reallyOpen(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:isEpisodeUnLock(arg_17_2)
	local var_17_1 = arg_17_0:isOpen(arg_17_1, arg_17_2)

	return var_17_0 and var_17_1
end

function var_0_0.getLastEpisode(arg_18_0)
	if arg_18_0._actInfo then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._actInfo) do
			if arg_18_0:reallyOpen(ActivityEnum.Activity.Activity1_6WarmUp, iter_18_0) then
				if iter_18_1 == var_0_0.EpisodeUnFinishState then
					return iter_18_0
				end
			else
				return iter_18_0 - 1
			end
		end

		return #arg_18_0._actInfo
	end
end

function var_0_0.getActivityInfo(arg_19_0)
	return arg_19_0._actInfo
end

function var_0_0.isAllEpisodeFinish(arg_20_0)
	if arg_20_0._actInfo then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._actInfo) do
			if tonumber(iter_20_1) == 0 then
				return false
			end
		end

		return true
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
