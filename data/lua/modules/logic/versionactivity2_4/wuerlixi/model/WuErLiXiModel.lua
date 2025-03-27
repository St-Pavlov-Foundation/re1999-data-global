module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiModel", package.seeall)

slot0 = class("WuErLiXiModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._episodeInfos = {}
	slot0._curEpisodeIndex = 0
end

function slot0.initInfos(slot0, slot1)
	slot0._episodeInfos = {}

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._episodeInfos[slot6.episodeId] then
			slot0._episodeInfos[slot6.episodeId] = WuErLiXiEpisodeMo.New()

			slot0._episodeInfos[slot6.episodeId]:init(slot6)
		else
			slot0._episodeInfos[slot6.episodeId]:update(slot6)
		end
	end
end

function slot0.updateEpisodeInfo(slot0, slot1)
	slot0._episodeInfos[slot1.episodeId]:update(slot1)
end

function slot0.updateInfos(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not slot0._episodeInfos[slot6.episodeId] then
			slot0._episodeInfos[slot6.episodeId] = WuErLiXiEpisodeMo.New()

			slot0._episodeInfos[slot6.episodeId]:init(slot6)
		else
			slot0._episodeInfos[slot6.episodeId]:update(slot6)
		end
	end
end

function slot0.updateEpisodeGameString(slot0, slot1, slot2)
	slot0._episodeInfos[slot1]:updateGameString(slot2)
end

function slot0.getCurGameProcess(slot0, slot1)
	return slot0._episodeInfos[slot1].gameString
end

function slot0.getEpisodeStatus(slot0, slot1)
	return slot0._episodeInfos[slot1].status
end

function slot0.setCurEpisodeIndex(slot0, slot1)
	slot0._curEpisodeIndex = slot1
end

function slot0.getCurEpisodeIndex(slot0)
	return slot0._curEpisodeIndex or 0
end

function slot0.isEpisodeUnlock(slot0, slot1)
	return slot0._episodeInfos[slot1]
end

function slot0.isEpisodePass(slot0, slot1)
	if not slot0._episodeInfos[slot1] then
		return false
	end

	return slot0._episodeInfos[slot1].isFinished
end

function slot0.getNewFinishEpisode(slot0)
	return slot0._newFinishEpisode or 0
end

function slot0.setNewFinishEpisode(slot0, slot1)
	slot0._newFinishEpisode = slot1
end

function slot0.clearFinishEpisode(slot0)
	slot0._newFinishEpisode = 0
end

slot0.instance = slot0.New()

return slot0
