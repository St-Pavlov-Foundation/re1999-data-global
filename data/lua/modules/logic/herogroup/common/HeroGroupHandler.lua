module("modules.logic.herogroup.common.HeroGroupHandler", package.seeall)

slot0 = class("HeroGroupHandler")
slot0.EpisodeTypeDict = {
	[DungeonEnum.EpisodeType.TowerPermanent] = 1,
	[DungeonEnum.EpisodeType.TowerBoss] = 1,
	[DungeonEnum.EpisodeType.TowerLimited] = 1,
	[DungeonEnum.EpisodeType.Act183] = 1
}

function slot0.checkIsEpisodeType(slot0)
	return uv0.EpisodeTypeDict[slot0] ~= nil
end

function slot0.checkIsEpisodeTypeByEpisodeId(slot0)
	return uv0.checkIsEpisodeType(DungeonConfig.instance:getEpisodeCO(slot0).type)
end

function slot0.getTowerBossSnapShot(slot0)
	return ModuleEnum.HeroGroupSnapshotType.TowerBoss, {
		TowerConfig.instance:getBossTowerIdByEpisodeId(slot0)
	}
end

function slot0.getTowerPermanentSnapShot(slot0)
	return ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit, {
		1,
		2,
		3,
		4
	}
end

function slot0.getAct183SnapShot(slot0)
	if Act183Helper.getEpisodeType(slot0) == Act183Enum.EpisodeType.Sub then
		return ModuleEnum.HeroGroupSnapshotType.Act183Normal, {
			1
		}
	elseif slot1 == Act183Enum.EpisodeType.Boss then
		return ModuleEnum.HeroGroupSnapshotType.Act183Boss, {
			1
		}
	else
		logError(string.format("获取编队快照id失败 episodeId = %s", slot0))
	end
end

slot0.getSnapShotHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = slot0.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.TowerBoss] = slot0.getTowerBossSnapShot,
	[DungeonEnum.EpisodeType.TowerLimited] = slot0.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.Act183] = slot0.getAct183SnapShot
}

function slot0.getSnapShot(slot0)
	if uv0.getSnapShotHandleFunc[DungeonConfig.instance:getEpisodeCO(slot0).type] then
		return slot3(slot0)
	end
end

return slot0
