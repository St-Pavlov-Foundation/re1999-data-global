module("modules.logic.versionactivity1_3.armpipe.model.Activity124Model", package.seeall)

local var_0_0 = class("Activity124Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._episodeInfoDict = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._episodeInfoDict = {}
end

function var_0_0.getCurActivityID(arg_3_0)
	return arg_3_0._curActivityId
end

function var_0_0.onReceiveGetAct120InfoReply(arg_4_0, arg_4_1)
	arg_4_0._curActivityId = arg_4_1.activityId
	arg_4_0._episodeInfoDict[arg_4_1.activityId] = {}

	arg_4_0:_updateEpisodeInfo(arg_4_0._curActivityId, arg_4_1.act124Episodes)
end

function var_0_0.onReceiveFinishAct124EpisodeReply(arg_5_0, arg_5_1)
	arg_5_0:_updateEpisodeInfo(arg_5_1.activityId, arg_5_1.updateAct124Episodes)
end

function var_0_0.onReceiveReceiveAct124RewardReply(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.activityId
	local var_6_1 = arg_6_1.episodeId
	local var_6_2 = arg_6_0:getEpisodeData(var_6_0, var_6_1)

	if var_6_2 then
		var_6_2.state = ArmPuzzlePipeEnum.EpisodeState.Received
	end
end

function var_0_0._updateEpisodeInfo(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._episodeInfoDict[arg_7_1]

	if not var_7_0 then
		var_7_0 = {}
		arg_7_0._episodeInfoDict[arg_7_1] = var_7_0
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		local var_7_1 = iter_7_1.id

		var_7_0[var_7_1] = var_7_0[var_7_1] or {}
		var_7_0[var_7_1].id = iter_7_1.id
		var_7_0[var_7_1].state = iter_7_1.state
	end
end

function var_0_0.getEpisodeData(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0._episodeInfoDict[arg_8_1] and arg_8_0._episodeInfoDict[arg_8_1][arg_8_2]
end

function var_0_0.isEpisodeOpenById(arg_9_0, arg_9_1, arg_9_2)
	return (ArmPuzzleHelper.isOpenDay(arg_9_2))
end

function var_0_0.isEpisodeClear(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getEpisodeData(arg_10_1, arg_10_2)

	if var_10_0 then
		return var_10_0.state == ArmPuzzlePipeEnum.EpisodeState.Finish or var_10_0.state == ArmPuzzlePipeEnum.EpisodeState.Received
	end

	return false
end

function var_0_0.isHasReard(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getEpisodeData(arg_11_1, arg_11_2)

	if var_11_0 then
		return var_11_0.state == ArmPuzzlePipeEnum.EpisodeState.Finish
	end

	return false
end

function var_0_0.isReceived(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getEpisodeData(arg_12_1, arg_12_2)

	if var_12_0 then
		return var_12_0.state == ArmPuzzlePipeEnum.EpisodeState.Received
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
