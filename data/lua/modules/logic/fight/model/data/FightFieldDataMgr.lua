module("modules.logic.fight.model.data.FightFieldDataMgr", package.seeall)

slot0 = FightDataClass("FightFieldDataMgr")

function slot0.onConstructor(slot0)
	slot0.actPoint = 0
	slot0.moveNum = 0
	slot0.extraMoveAct = 0
	slot0.deckNum = 0
end

function slot0.onStageChanged(slot0)
	slot0.extraMoveAct = 0
end

function slot0.updateData(slot0, slot1)
	slot0.version = slot1.version
	slot0.fightActType = slot1.fightActType or FightEnum.FightActType.Normal
	slot0.curRound = slot1.curRound
	slot0.maxRound = slot1.maxRound
	slot0.isFinish = slot1.isFinish
	slot0.curWave = slot1.curWave
	slot0.battleId = slot1.battleId
	slot0.magicCircle = FightDataHelper.coverData(FightMagicCircleInfoData.New(slot1.magicCircle), slot0.magicCircle)
	slot0.isRecord = slot1.isRecord
	slot0.episodeId = slot1.episodeId
	slot0.episodeCo = DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
	slot0.lastChangeHeroUid = slot1.lastChangeHeroUid
	slot0.progress = slot1.progress
	slot0.progressMax = slot1.progressMax
	slot0.param = FightDataHelper.coverData(FightParamData.New(slot1.param), slot0.param)
	slot0.indicatorDict = slot0:buildIndicators(slot1)
	slot0.playerFinisherInfo = slot0:buildPlayerFinisherInfo(slot1)
	slot0.customData = FightDataHelper.coverData(FightCustomData.New(slot1.customData), slot0.customData)
end

function slot0.buildIndicators(slot0, slot1)
	slot2 = {}

	if slot1:HasField("attacker") then
		for slot6, slot7 in ipairs(slot1.attacker.indicators) do
			slot8 = tonumber(slot7.inticatorId)
			slot2[slot8] = {
				id = slot8,
				num = slot7.num
			}
		end
	end

	return FightDataHelper.coverData(slot2, slot0.indicatorDict)
end

function slot0.buildPlayerFinisherInfo(slot0, slot1)
	slot2 = nil

	if slot1:HasField("attacker") and slot1.attacker:HasField("playerFinisherInfo") then
		slot2 = slot1.attacker.playerFinisherInfo
	end

	return slot0:setPlayerFinisherInfo(slot2)
end

function slot0.setPlayerFinisherInfo(slot0, slot1)
	if slot1 then
		slot3 = slot1

		for slot8, slot9 in ipairs(slot3.skills) do
			table.insert(({
				skills = {},
				roundUseLimit = 0,
				roundUseLimit = slot3.roundUseLimit
			}).skills, {
				skillId = slot9.skillId,
				needPower = slot9.needPower
			})
		end
	end

	return FightDataHelper.coverData(slot2, slot0.playerFinisherInfo)
end

function slot0.getIndicatorNum(slot0, slot1)
	slot2 = slot0.indicatorDict and slot0.indicatorDict[slot1]

	return slot2 and slot2.num or 0
end

function slot0.isDouQuQu(slot0)
	return slot0.fightActType == FightEnum.FightActType.Act174
end

function slot0.isSeason2(slot0)
	return slot0.fightActType == FightEnum.FightActType.Season2
end

function slot0.isDungeonType(slot0, slot1)
	return slot0.episodeCo and slot0.episodeCo.type == slot1
end

function slot0.isPaTa(slot0)
	return slot0:isDungeonType(DungeonEnum.EpisodeType.TowerBoss) or slot0:isDungeonType(DungeonEnum.EpisodeType.TowerLimited) or slot0:isDungeonType(DungeonEnum.EpisodeType.TowerPermanent)
end

function slot0.isTowerLimited(slot0)
	return slot0:isDungeonType(DungeonEnum.EpisodeType.TowerLimited)
end

function slot0.isAct183(slot0)
	return slot0:isDungeonType(DungeonEnum.EpisodeType.Act183)
end

function slot0.dealCardInfoPush(slot0, slot1)
	slot0.actPoint = slot1.actPoint
	slot0.moveNum = slot1.moveNum
	slot0.extraMoveAct = slot1.extraMoveAct
end

function slot0.isUnlimitMoveCard(slot0)
	return slot0.extraMoveAct == -1
end

function slot0.dirSetDeckNum(slot0, slot1)
	slot0.deckNum = slot1
end

function slot0.changeDeckNum(slot0, slot1)
	slot0.deckNum = slot0.deckNum + slot1
end

return slot0
