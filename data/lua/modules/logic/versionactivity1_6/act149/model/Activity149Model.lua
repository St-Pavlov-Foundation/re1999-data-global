module("modules.logic.versionactivity1_6.act149.model.Activity149Model", package.seeall)

slot0 = class("Activity149Model", BaseModel)

function slot0.onInit(slot0)
	slot0._act149MoDict = {}
	slot0._preScore = 0
	slot0._curMaxScore = 0
	slot0._totalScore = 0
	slot0._hasGetBonusIds = {}
end

function slot0.reInit(slot0)
	slot0._act149MoDict = {}
	slot0._curMaxScore = 0
	slot0._totalScore = 0
	slot0._hasGetBonusIds = {}
end

function slot0.onReceiveInfos(slot0, slot1)
	slot0._act149MoDict = {}
	slot0._hasGetBonusIds = {}
	slot0._actId = slot1.activityId
	slot0._preScore = slot0._curMaxScore
	slot0._curMaxScore = slot1.currMaxScore
	slot0._totalScore = slot1.totalScore
	slot3 = slot1.hasGetBonusIds

	for slot7, slot8 in ipairs(slot1.episodeInfos) do
		slot9 = slot8.id
		slot10 = slot8.episodeId
		slot0._act149MoDict[slot9] = Activity149Mo.New(slot9, slot0._actId)
	end

	for slot7, slot8 in ipairs(slot3) do
		slot0._hasGetBonusIds[slot8] = true
	end
end

function slot0.onReceiveScoreInfos(slot0, slot1)
	for slot6, slot7 in ipairs(slot1.hasGetBonusIds) do
		slot0._hasGetBonusIds[slot7] = true
	end
end

function slot0.HasGotHigherScore(slot0)
	return slot0._preScore < slot0._curMaxScore
end

function slot0.applyPreScoreToCurScore(slot0)
	slot0._preScore = slot0._curMaxScore
end

function slot0.setFightScore(slot0, slot1)
	slot0._fightPreScore = slot0:getFightScore()
	slot0._fightCurScore = slot1
end

function slot0.noticeFightScore(slot0, slot1)
	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.DungeonBossFightScoreChange, slot0._fightPreScore, slot1 or slot0._fightCurScore)
end

function slot0.getFightScore(slot0)
	return slot0._fightCurScore or 0
end

function slot0.getPreFightScore(slot0)
	return slot0._fightPreScore
end

function slot0.getAct149MoByOrder(slot0, slot1)
	for slot5, slot6 in pairs(slot0._act149MoDict) do
		if slot1 == slot6.cfg.order then
			return slot6
		end
	end
end

function slot0.getAct149MoByEpisodeId(slot0, slot1)
	for slot5, slot6 in pairs(slot0._act149MoDict) do
		if slot1 == slot6.cfg.episodeId then
			return slot6
		end
	end
end

function slot0.getAct149EpisodeCfgIdByOrder(slot0, slot1)
	if slot1 == VersionActivity1_6DungeonEnum.bossMaxOrder then
		return slot0:getMaxOrderAct149EpisodeCfg(ActivityModel.instance:getActMO(slot0._actId):getOpeningDay())
	else
		return Activity149Config.instance:getAct149EpisodeCfgByOrder(slot1)
	end
end

function slot0.getMaxOrderAct149EpisodeCfg(slot0, slot1)
	return Activity149Config.instance:getAct149EpisodeCfg(slot1 % Activity149Config.instance:getAlternateDay() + VersionActivity1_6DungeonEnum.bossMaxOrder)
end

function slot0.getCurBossEpisodeRemainDay(slot0)
	return 3 - ActivityModel.instance:getActMO(slot0._actId):getOpeningDay() % 3
end

function slot0.isLastBossEpisode(slot0)
	slot1 = ActivityModel.instance:getActMO(slot0._actId)

	return slot1:getRemainDay() < 2 - slot1:getOpeningDay() % 3
end

function slot0.getMaxOrderMo(slot0)
	if not slot0._act149MoDict then
		return nil
	end

	slot2 = 1

	for slot6, slot7 in pairs(slot0._act149MoDict) do
		if 0 < slot7.cfg.order then
			slot1 = slot8
			slot2 = slot6
		end
	end

	return slot0._act149MoDict[slot2], slot1
end

function slot0.getCurMaxScore(slot0)
	return slot0._curMaxScore
end

function slot0.getAleadyGotBonusIds(slot0)
	return slot0._hasGetBonusIds
end

function slot0.getTotalScore(slot0)
	return slot0._totalScore
end

function slot0.getScheduleViewRewardList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(Activity149Config.instance:getBossRewardCfgList()) do
		slot1[#slot1 + 1] = {
			isGot = slot0._hasGetBonusIds[slot7.id],
			rewardCfg = slot7
		}
	end

	return slot1
end

function slot0.checkAbleGetReward(slot0, slot1)
	slot3 = false
	slot4 = 0
	slot5 = 0

	for slot9, slot10 in ipairs(Activity149Config.instance:getBossRewardCfgList()) do
		slot12 = slot10.rewardPointNum

		if slot0._hasGetBonusIds[slot10.id] then
			slot5 = slot9
			slot4 = slot9
		elseif slot12 <= slot1 then
			slot3 = true
			slot4 = slot9
		end
	end

	return slot3, slot5, slot4
end

function slot0.checkEpisodePassedByOrder(slot0, slot1)
	if slot1 == VersionActivity1_6DungeonEnum.bossMaxOrder then
		slot4 = false

		for slot8, slot9 in ipairs(Activity149Config.instance:getAct149EpisodeCfgByOrder(slot1, true)) do
			if DungeonModel.instance:getEpisodeInfo(slot9.episodeId) and slot10.star > 1 then
				slot4 = true

				break
			end
		end

		return slot4
	else
		return DungeonModel.instance:getEpisodeInfo(Activity149Config.instance:getAct149EpisodeCfgByOrder(slot1).episodeId) and slot4.star > 1
	end
end

slot0.instance = slot0.New()

return slot0
