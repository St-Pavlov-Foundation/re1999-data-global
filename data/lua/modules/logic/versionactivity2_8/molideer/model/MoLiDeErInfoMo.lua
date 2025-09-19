module("modules.logic.versionactivity2_8.molideer.model.MoLiDeErInfoMo", package.seeall)

local var_0_0 = pureTable("MoLiDeErInfoMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.actId = arg_1_1
	arg_1_0.episodeId = arg_1_2
	arg_1_0.isUnlock = arg_1_3
	arg_1_0.passCount = arg_1_4
	arg_1_0.passStar = arg_1_5
	arg_1_0.haveProgress = arg_1_6
	arg_1_0.config = MoLiDeErConfig.instance:getEpisodeConfig(arg_1_1, arg_1_2)
end

function var_0_0.isInProgress(arg_2_0)
	return arg_2_0.haveProgress
end

function var_0_0.isComplete(arg_3_0)
	return arg_3_0.passCount > 0
end

return var_0_0
