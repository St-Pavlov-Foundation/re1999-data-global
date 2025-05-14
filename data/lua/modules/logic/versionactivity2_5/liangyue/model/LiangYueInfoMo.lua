module("modules.logic.versionactivity2_5.liangyue.model.LiangYueInfoMo", package.seeall)

local var_0_0 = pureTable("LiangYueInfoMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.actId = arg_1_1
	arg_1_0.episodeId = arg_1_2
	arg_1_0.isFinish = arg_1_3
	arg_1_0.puzzle = arg_1_4

	local var_1_0 = LiangYueConfig.instance:getEpisodeConfigByActAndId(arg_1_1, arg_1_2)

	if var_1_0 == nil then
		logError("config is nil" .. arg_1_2)

		return
	end

	arg_1_0.config = var_1_0
	arg_1_0.preEpisodeId = var_1_0.preEpisodeId
end

function var_0_0.updateMO(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.isFinish = arg_2_1
	arg_2_0.puzzle = arg_2_2
end

return var_0_0
