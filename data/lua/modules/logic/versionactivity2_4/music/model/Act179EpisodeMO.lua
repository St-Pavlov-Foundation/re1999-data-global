module("modules.logic.versionactivity2_4.music.model.Act179EpisodeMO", package.seeall)

slot0 = pureTable("Act179EpisodeMO")

function slot0.init(slot0, slot1)
	slot0.episodeId = slot1.episodeId
	slot0.isFinished = slot1.isFinished
	slot0.highScore = slot1.highScore
	slot0.config = Activity179Config.instance:getEpisodeConfig(slot0.episodeId)
end

return slot0
