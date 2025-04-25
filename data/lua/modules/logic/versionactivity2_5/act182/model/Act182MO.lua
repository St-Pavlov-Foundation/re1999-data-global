module("modules.logic.versionactivity2_5.act182.model.Act182MO", package.seeall)

slot0 = pureTable("Act182MO")

function slot0.init(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.passEpisodeIds = slot1.passEpisodeIds
	slot0.rank = slot1.rank
	slot0.score = slot1.score
	slot0.gameMoDic = {}

	for slot5, slot6 in ipairs(slot1.gameInfos) do
		slot7 = AutoChessGameMO.New()

		slot7:init(slot6)

		slot0.gameMoDic[slot6.module] = slot7
	end

	slot0.historyInfo = slot1.historyInfo
	slot0.doubleScoreTimes = slot1.doubleScoreTimes
	slot0.gainRewardRank = slot1.gainRewardRank
end

function slot0.update(slot0, slot1)
	if slot1.rank - slot0.rank > 0 then
		slot0.isRankUp = true

		if slot0.historyInfo.maxRank < slot1.rank then
			slot0.newRankUp = true
		end
	end

	slot0.passEpisodeIds = slot1.passEpisodeIds
	slot0.rank = slot1.rank
	slot0.score = slot1.score

	for slot5, slot6 in ipairs(slot1.gameInfos) do
		slot0.gameMoDic[slot6.module]:init(slot6)
	end

	slot0.historyInfo = slot1.historyInfo
	slot0.doubleScoreTimes = slot1.doubleScoreTimes
	slot0.gainRewardRank = slot1.gainRewardRank
end

function slot0.updateMasterIdBox(slot0, slot1, slot2)
	slot3 = slot0.gameMoDic[AutoChessEnum.ModuleId.PVP]

	slot3:updateMasterIdBox(slot1)

	slot3.refreshed = slot2
	slot3.start = true
end

function slot0.isEpisodePass(slot0, slot1)
	if tabletool.indexOf(slot0.passEpisodeIds, slot1) then
		return true
	else
		return false
	end
end

function slot0.isEpisodeUnlock(slot0, slot1)
	if lua_auto_chess_episode.configDict[slot1].preEpisode == 0 then
		return true
	elseif slot0:isEpisodePass(slot3) then
		return true
	end

	return false
end

function slot0.clearRankUpMark(slot0)
	slot0.isRankUp = false
	slot0.newRankUp = false
end

return slot0
