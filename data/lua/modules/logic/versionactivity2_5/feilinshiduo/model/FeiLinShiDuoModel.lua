module("modules.logic.versionactivity2_5.feilinshiduo.model.FeiLinShiDuoModel", package.seeall)

slot0 = class("FeiLinShiDuoModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()

	slot0.maxStageCount = 7
end

function slot0.reInit(slot0)
	slot0.episodeFinishMap = {}
	slot0.curEpisodeId = 0
	slot0.newUnlockEpisodeId = 0
	slot0.curFinishEpisodeId = 0
end

function slot0.initEpisodeFinishInfo(slot0, slot1)
	slot0.activityId = slot1.activityId

	for slot5, slot6 in ipairs(slot1.episodes) do
		slot0.episodeFinishMap[slot6.episodeId] = slot6.isFinished
	end
end

function slot0.getEpisodeFinishState(slot0, slot1)
	return slot0.episodeFinishMap[slot1]
end

function slot0.updateEpisodeFinishState(slot0, slot1, slot2)
	slot0.episodeFinishMap[slot1] = slot2
end

function slot0.isUnlock(slot0, slot1, slot2)
	return slot0.episodeFinishMap[slot2] ~= nil and (FeiLinShiDuoConfig.instance:getEpisodeConfig(slot1, slot2).preEpisodeId > 0 and slot0.episodeFinishMap[slot4] or true)
end

function slot0.getFinishStageIndex(slot0)
	slot1 = 0

	for slot5 = 1, slot0.maxStageCount do
		slot7 = true

		for slot11, slot12 in pairs(FeiLinShiDuoConfig.instance:getStageEpisodes(slot5)) do
			if not slot0.episodeFinishMap[slot12.episodeId] then
				slot7 = false

				break
			end
		end

		if slot7 then
			slot1 = slot5
		end
	end

	return slot1
end

function slot0.getCurActId(slot0)
	return slot0.activityId
end

function slot0.getCurEpisodeId(slot0)
	for slot5, slot6 in ipairs(FeiLinShiDuoConfig.instance:getEpisodeConfigList()) do
		slot7 = slot6.preEpisodeId

		if not slot0.episodeFinishMap[slot6.episodeId] and slot7 > 0 then
			if not slot0.episodeFinishMap[slot7] then
				slot0.curEpisodeId = slot7

				return slot0.curEpisodeId
			else
				slot0.curEpisodeId = slot6.episodeId

				return slot0.curEpisodeId
			end
		elseif not slot0.episodeFinishMap[slot6.episodeId] and slot7 == 0 then
			slot0.curEpisodeId = slot6.episodeId

			return slot0.curEpisodeId
		end
	end

	slot0.curEpisodeId = slot1[#slot1].episodeId

	return slot0.curEpisodeId
end

function slot0.getLastEpisodeId(slot0)
	slot1 = FeiLinShiDuoConfig.instance:getNoGameEpisodeList(slot0.activityId)

	return slot1[#slot1].episodeId
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0.curEpisodeId = slot1
end

function slot0.setNewUnlockEpisode(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.episodes) do
		slot0.newUnlockEpisodeId = slot6.episodeId
	end
end

function slot0.getNewUnlockEpisode(slot0, slot1)
	if slot0.newUnlockEpisodeId then
		return FeiLinShiDuoConfig.instance:getEpisodeConfig(slot1, slot0.newUnlockEpisodeId)
	end
end

function slot0.cleanNewUnlockEpisode(slot0)
	slot0.newUnlockEpisodeId = 0
end

function slot0.setCurFinishEpisodeId(slot0, slot1)
	if slot0.episodeFinishMap[slot1] then
		slot0.curFinishEpisodeId = 0
	else
		slot0.curFinishEpisodeId = slot1
	end
end

function slot0.getCurFinishEpisodeId(slot0)
	return slot0.curFinishEpisodeId
end

slot0.instance = slot0.New()

return slot0
