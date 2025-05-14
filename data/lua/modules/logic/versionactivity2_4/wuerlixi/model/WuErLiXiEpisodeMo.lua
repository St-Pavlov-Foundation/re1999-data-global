module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiEpisodeMo", package.seeall)

local var_0_0 = class("WuErLiXiEpisodeMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.episodeId = 0
	arg_1_0.isFinished = false
	arg_1_0.status = WuErLiXiEnum.EpisodeStatus.BeforeStory
	arg_1_0.gameString = ""
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.episodeId = arg_2_1.episodeId
	arg_2_0.isFinished = arg_2_1.isFinished
	arg_2_0.status = arg_2_1.status
	arg_2_0.gameString = arg_2_1.gameString
end

function var_0_0.update(arg_3_0, arg_3_1)
	arg_3_0.episodeId = arg_3_1.episodeId
	arg_3_0.isFinished = arg_3_1.isFinished
	arg_3_0.status = arg_3_1.status
	arg_3_0.gameString = arg_3_1.gameString
end

function var_0_0.updateGameString(arg_4_0, arg_4_1)
	arg_4_0.gameString = arg_4_1
end

return var_0_0
