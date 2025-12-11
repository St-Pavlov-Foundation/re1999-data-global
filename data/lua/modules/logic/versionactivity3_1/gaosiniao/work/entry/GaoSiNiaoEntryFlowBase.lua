module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoEntryFlowBase", package.seeall)

local var_0_0 = class("GaoSiNiaoEntryFlowBase", GaoSiNiaoFlowSequence_Base)

function var_0_0.start(arg_1_0, arg_1_1)
	arg_1_0:reset()
	assert(arg_1_1 and arg_1_1 > 0)

	arg_1_0._episodeId = arg_1_1

	var_0_0.super.start(arg_1_0)
end

function var_0_0.episodeId(arg_2_0)
	return arg_2_0._episodeId
end

function var_0_0.preStoryId(arg_3_0)
	return GaoSiNiaoConfig.instance:getPreStoryId(arg_3_0._episodeId)
end

function var_0_0.postStoryId(arg_4_0)
	return GaoSiNiaoConfig.instance:getPostStoryId(arg_4_0._episodeId)
end

function var_0_0.gameId(arg_5_0)
	return GaoSiNiaoConfig.instance:getEpisodeCO_gameId(arg_5_0._episodeId)
end

return var_0_0
