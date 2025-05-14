module("modules.logic.versionactivity2_4.music.model.Act179EpisodeMO", package.seeall)

local var_0_0 = pureTable("Act179EpisodeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.episodeId = arg_1_1.episodeId
	arg_1_0.isFinished = arg_1_1.isFinished
	arg_1_0.highScore = arg_1_1.highScore
	arg_1_0.config = Activity179Config.instance:getEpisodeConfig(arg_1_0.episodeId)
end

return var_0_0
