module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.Activity201MaLiAnNaEpisodeMo", package.seeall)

local var_0_0 = class("Activity201MaLiAnNaEpisodeMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.episodeId = 0
	arg_1_0.isFinished = false
	arg_1_0.unlockBranchIds = nil
	arg_1_0.progress = ""
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.episodeId = arg_2_1.episodeId
	arg_2_0.isFinished = arg_2_1.isFinished
	arg_2_0.unlockBranchIds = arg_2_1.unlockBranchIds
	arg_2_0.progress = arg_2_1.progress
	arg_2_0._actId = VersionActivity3_0Enum.ActivityId.MaLiAnNa
end

function var_0_0.update(arg_3_0, arg_3_1)
	arg_3_0.episodeId = arg_3_1.episodeId
	arg_3_0.isFinished = arg_3_1.isFinished
	arg_3_0.status = arg_3_1.status
	arg_3_0.progress = arg_3_1.progress
end

function var_0_0.checkFinishGame(arg_4_0)
	return arg_4_0.progress and arg_4_0.progress == "1"
end

function var_0_0.isGame(arg_5_0)
	local var_5_0 = Activity201MaLiAnNaConfig:getEpisodeCo(arg_5_0._actId, arg_5_0.episodeId)

	return var_5_0 and var_5_0.gameId ~= 0
end

return var_0_0
