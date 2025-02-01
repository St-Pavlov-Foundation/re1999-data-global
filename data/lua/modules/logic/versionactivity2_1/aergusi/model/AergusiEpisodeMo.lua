module("modules.logic.versionactivity2_1.aergusi.model.AergusiEpisodeMo", package.seeall)

slot0 = class("AergusiEpisodeMo")

function slot0.ctor(slot0)
	slot0.episodeId = 0
	slot0.passBeforeStory = false
	slot0.passEvidence = false
	slot0.passAfterStory = false
	slot0.episodeState = AergusiEnum.ProgressState.BeforeStory
end

function slot0.init(slot0, slot1)
	slot0.episodeId = slot1.episodeId
	slot0.passBeforeStory = slot1.passBeforeStory
	slot0.passEvidence = slot1.passEvidence
	slot0.passAfterStory = slot1.passAfterStory

	if slot0.passAfterStory then
		slot0.episodeState = AergusiEnum.ProgressState.Finished
	elseif slot0.passEvidence then
		slot0.episodeState = AergusiEnum.ProgressState.AfterStory
	elseif slot0.passBeforeStory then
		slot0.episodeState = AergusiConfig.instance:getEpisodeConfig(nil, slot0.episodeId).evidenceId ~= "" and AergusiEnum.ProgressState.Evidence or AergusiEnum.ProgressState.AfterStory
	end
end

return slot0
