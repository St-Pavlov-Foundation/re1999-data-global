module("modules.logic.fight.model.data.FightFieldDataMgr", package.seeall)

slot0 = FightDataBase("FightFieldDataMgr")

function slot0.ctor(slot0)
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
	slot0.lastChangeHeroUid = slot1.lastChangeHeroUid
	slot0.progress = slot1.progress
	slot0.progressMax = slot1.progressMax
	slot0.param = FightDataHelper.coverData(FightParamData.New(slot1.param), slot0.param)
	slot0.episodeCo = DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
end

function slot0.isDouQuQu(slot0)
	return slot0.fightActType == FightEnum.FightActType.Act174
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

return slot0
