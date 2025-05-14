module("modules.logic.versionactivity1_5.act146.model.Activity146Model", package.seeall)

local var_0_0 = class("Activity146Model", BaseModel)

var_0_0.EpisodeUnFinishState = 0
var_0_0.EpisodeFinishedState = 1
var_0_0.EpisodeHasReceiveState = 2

function var_0_0.onInit(arg_1_0)
	arg_1_0._actInfo = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._actInfo = nil
end

function var_0_0.setActivityInfo(arg_3_0, arg_3_1)
	arg_3_0._actInfo = {}

	if arg_3_1 then
		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			if iter_3_1.id and iter_3_1.state then
				arg_3_0._actInfo[iter_3_1.id] = iter_3_1.state
			end
		end
	end
end

function var_0_0.isEpisodeUnLockAndUnFinish(arg_4_0, arg_4_1)
	return arg_4_0._actInfo and arg_4_0._actInfo[arg_4_1] == var_0_0.EpisodeUnFinishState
end

function var_0_0.isEpisodeFinishedButUnReceive(arg_5_0, arg_5_1)
	return arg_5_0._actInfo and arg_5_0._actInfo[arg_5_1] == var_0_0.EpisodeFinishedState
end

function var_0_0.isEpisodeFinished(arg_6_0, arg_6_1)
	return arg_6_0:isEpisodeFinishedButUnReceive(arg_6_1) or arg_6_0:isEpisodeHasReceivedReward(arg_6_1)
end

function var_0_0.isEpisodeHasReceivedReward(arg_7_0, arg_7_1)
	return arg_7_0._actInfo and arg_7_0._actInfo[arg_7_1] == var_0_0.EpisodeHasReceiveState
end

function var_0_0.isEpisodeUnLock(arg_8_0, arg_8_1)
	local var_8_0 = Activity146Config.instance:getPreEpisodeConfig(ActivityEnum.Activity.Activity1_5WarmUp, arg_8_1)
	local var_8_1 = true

	if var_8_0 then
		var_8_1 = arg_8_0:isEpisodeFinished(var_8_0.id)
	end

	return var_8_1 and arg_8_0._actInfo and arg_8_0._actInfo[arg_8_1] ~= nil
end

function var_0_0.isHasEpisodeCanReceiveReward(arg_9_0)
	local var_9_0 = Activity146Config.instance:getAllEpisodeConfigs(ActivityEnum.Activity.Activity1_5WarmUp)

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if arg_9_0:isEpisodeFinishedButUnReceive(iter_9_1.id) then
			return true
		end
	end

	return false
end

function var_0_0.getActivityInfo(arg_10_0)
	return arg_10_0._actInfo
end

function var_0_0.isAllEpisodeFinish(arg_11_0)
	if arg_11_0._actInfo then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._actInfo) do
			if tonumber(iter_11_1) == var_0_0.EpisodeUnFinishState then
				return false
			end
		end

		return true
	end

	return false
end

function var_0_0.setCurSelectedEpisode(arg_12_0, arg_12_1)
	arg_12_0._curSelectedEpisodeId = arg_12_1
end

function var_0_0.getCurSelectedEpisode(arg_13_0)
	return arg_13_0._curSelectedEpisodeId
end

function var_0_0.markHasEnterEpisode(arg_14_0, arg_14_1)
	if not arg_14_0._hasEnterEpisodeDict then
		arg_14_0:decodeHasEnterEpisodeData()
	end

	local var_14_0 = false

	if not arg_14_0._hasEnterEpisodeDict[arg_14_1] then
		arg_14_0._hasEnterEpisodeDict[arg_14_1] = true

		table.insert(arg_14_0._hasEnterEpisodeList, arg_14_1)

		var_14_0 = true
	end

	if var_14_0 then
		arg_14_0:flushHasEnterEpisodes()
	end
end

function var_0_0.flushHasEnterEpisodes(arg_15_0)
	if arg_15_0._hasEnterEpisodeList then
		PlayerPrefsHelper.setString(arg_15_0:getLocalKey(), cjson.encode(arg_15_0._hasEnterEpisodeList))
	end
end

function var_0_0.isEpisodeFirstEnter(arg_16_0, arg_16_1)
	if not arg_16_0._hasEnterEpisodeDict then
		arg_16_0:decodeHasEnterEpisodeData()
	end

	return not arg_16_0._hasEnterEpisodeDict[arg_16_1]
end

function var_0_0.decodeHasEnterEpisodeData(arg_17_0)
	local var_17_0 = arg_17_0:getLocalKey()
	local var_17_1

	if not string.nilorempty(var_17_0) then
		var_17_1 = PlayerPrefsHelper.getString(var_17_0, "")
	end

	arg_17_0._hasEnterEpisodeDict = {}

	if not string.nilorempty(var_17_1) then
		arg_17_0._hasEnterEpisodeList = cjson.decode(var_17_1)

		for iter_17_0, iter_17_1 in pairs(arg_17_0._hasEnterEpisodeList) do
			arg_17_0._hasEnterEpisodeDict[iter_17_1] = true
		end
	else
		arg_17_0._hasEnterEpisodeList = {}
	end
end

function var_0_0.getLocalKey(arg_18_0)
	return PlayerPrefsKey.Version1_5_Act146HasEnterEpisodeKey .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
