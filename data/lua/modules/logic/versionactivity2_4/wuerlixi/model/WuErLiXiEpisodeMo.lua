module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiEpisodeMo", package.seeall)

slot0 = class("WuErLiXiEpisodeMo")

function slot0.ctor(slot0)
	slot0.episodeId = 0
	slot0.isFinished = false
	slot0.status = WuErLiXiEnum.EpisodeStatus.BeforeStory
	slot0.gameString = ""
end

function slot0.init(slot0, slot1)
	slot0.episodeId = slot1.episodeId
	slot0.isFinished = slot1.isFinished
	slot0.status = slot1.status
	slot0.gameString = slot1.gameString
end

function slot0.update(slot0, slot1)
	slot0.episodeId = slot1.episodeId
	slot0.isFinished = slot1.isFinished
	slot0.status = slot1.status
	slot0.gameString = slot1.gameString
end

function slot0.updateGameString(slot0, slot1)
	slot0.gameString = slot1
end

return slot0
