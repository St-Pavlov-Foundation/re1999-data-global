module("modules.logic.versionactivity2_1.aergusi.model.AergusiEpisodeMo", package.seeall)

local var_0_0 = class("AergusiEpisodeMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.episodeId = 0
	arg_1_0.passBeforeStory = false
	arg_1_0.passEvidence = false
	arg_1_0.passAfterStory = false
	arg_1_0.episodeState = AergusiEnum.ProgressState.BeforeStory
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.episodeId = arg_2_1.episodeId
	arg_2_0.passBeforeStory = arg_2_1.passBeforeStory
	arg_2_0.passEvidence = arg_2_1.passEvidence
	arg_2_0.passAfterStory = arg_2_1.passAfterStory

	if arg_2_0.passAfterStory then
		arg_2_0.episodeState = AergusiEnum.ProgressState.Finished
	elseif arg_2_0.passEvidence then
		arg_2_0.episodeState = AergusiEnum.ProgressState.AfterStory
	elseif arg_2_0.passBeforeStory then
		arg_2_0.episodeState = AergusiConfig.instance:getEpisodeConfig(nil, arg_2_0.episodeId).evidenceId ~= "" and AergusiEnum.ProgressState.Evidence or AergusiEnum.ProgressState.AfterStory
	end
end

return var_0_0
