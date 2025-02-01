module("modules.logic.seasonver.act123.model.Season123StageMO", package.seeall)

slot0 = pureTable("Season123StageMO")

function slot0.init(slot0, slot1)
	slot0.stage = slot1.stage
	slot0.isPass = slot1.isPass == 1
	slot0.episodeMap = slot0.episodeMap or {}
	slot0.minRound = slot1.minRound
	slot0.state = slot1.state or 0

	slot0:updateEpisodes(slot1.act123Episodes)
	slot0:initAssistHeroMO(slot1)
end

function slot0.updateEpisodes(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #slot1 do
		if not slot0.episodeMap[slot1[slot6].layer] then
			slot8 = Season123EpisodeMO.New()
			slot0.episodeMap[slot7.layer] = slot8

			slot8:init(slot7)
		else
			slot8:update(slot7)
		end

		slot2[slot8] = true
	end

	for slot6, slot7 in pairs(slot0.episodeMap) do
		if not slot2[slot7] then
			slot0.episodeMap[slot6] = nil
		end
	end
end

function slot0.initAssistHeroMO(slot0, slot1)
	logNormal("info.assistHeroInfo.heroUid = [" .. tostring(slot1.assistHeroInfo.heroUid) .. "], type = " .. type(slot1.assistHeroInfo.heroUid))

	if slot1.assistHeroInfo and tostring(slot1.assistHeroInfo.heroUid) ~= "0" and slot1.assistHeroInfo.heroId and slot1.assistHeroInfo.heroId ~= 0 then
		slot0._assistMO = Season123AssistHeroMO.New()

		slot0._assistMO:init(slot1.assistHeroInfo)

		slot0._assistHeroMO = Season123HeroUtils.createHeroMOByAssistMO(slot0._assistMO)
	end
end

function slot0.getAssistHeroMO(slot0)
	return slot0._assistHeroMO, slot0._assistMO
end

function slot0.alreadyPass(slot0)
	return slot0.isPass
end

function slot0.isFinishNow(slot0)
	return slot0.state == 2
end

function slot0.isNeverTry(slot0)
	return slot0.state == 0
end

function slot0.updateReduceEpisodeRoundState(slot0, slot1, slot2)
	slot0.reduceState = slot0.reduceState or {}
	slot0.reduceState[slot1] = slot0.episodeMap[slot1] and slot2 or false
end

return slot0
