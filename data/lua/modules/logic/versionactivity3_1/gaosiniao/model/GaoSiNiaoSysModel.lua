module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoSysModel", package.seeall)

local var_0_0 = class("GaoSiNiaoSysModel", Activity210Model)

function var_0_0.reInit(arg_1_0)
	var_0_0.super.reInit(arg_1_0)
	arg_1_0:_internal_set_config(GaoSiNiaoConfig.instance)
	arg_1_0:_internal_set_taskType(TaskEnum.TaskType.Activity210)
end

function var_0_0._onReceiveAct210SaveEpisodeProgressReply(arg_2_0, arg_2_1)
	GaoSiNiaoBattleModel.instance:_onReceiveAct210SaveEpisodeProgressReply(arg_2_1)
	GaoSiNiaoController.instance:dispatchEvent(GaoSiNiaoEvent.onReceiveAct210SaveEpisodeProgressReply, arg_2_1)
end

function var_0_0._onReceiveAct210FinishEpisodeReply(arg_3_0, arg_3_1)
	GaoSiNiaoBattleModel.instance:_onReceiveAct210FinishEpisodeReply(arg_3_1)
	GaoSiNiaoController.instance:dispatchEvent(GaoSiNiaoEvent.onReceiveAct210FinishEpisodeReply, arg_3_1)
end

function var_0_0._onReceiveAct210EpisodePush(arg_4_0, arg_4_1)
	GaoSiNiaoController.instance:dispatchEvent(GaoSiNiaoEvent.onReceiveAct210EpisodePush, arg_4_1)
end

function var_0_0.currentEpisodeIdToPlay(arg_5_0, arg_5_1)
	local var_5_0, var_5_1 = arg_5_0:config():getEpisodeCOList()
	local var_5_2 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_3 = iter_5_1.episodeId

		var_5_2 = var_5_3

		if not arg_5_0:_internal_hasPassEpisode(var_5_3, arg_5_1) then
			return var_5_3
		end
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_1) do
		local var_5_4 = iter_5_3.episodeId

		var_5_2 = var_5_4

		if not arg_5_0:_internal_hasPassEpisode(var_5_4, arg_5_1) then
			return var_5_4
		end
	end

	return var_5_2
end

function var_0_0.currentPassedEpisodeId(arg_6_0)
	local var_6_0 = arg_6_0:currentEpisodeIdToPlay()

	if var_6_0 <= 0 then
		return
	end

	if arg_6_0:hasPassLevelAndStory(var_6_0) then
		return var_6_0
	end

	return arg_6_0:config():getPreEpisodeId(var_6_0)
end

function var_0_0.isSpEpisodeOpen(arg_7_0, arg_7_1)
	local var_7_0, var_7_1 = arg_7_0:config():getEpisodeCOList()

	if #var_7_1 <= 0 then
		return false
	end

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = iter_7_1.episodeId

		if arg_7_1 then
			if var_7_2 == arg_7_1 then
				return arg_7_0:isEpisodeOpen(var_7_2)
			end
		elseif arg_7_0:isEpisodeOpen(var_7_2) then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
