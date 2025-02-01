module("modules.logic.seasonver.common.SeasonHeroGroupHandler", package.seeall)

slot0 = class("SeasonHeroGroupHandler")
slot0.SeasonEpisodeTypeList = {
	DungeonEnum.EpisodeType.Season,
	DungeonEnum.EpisodeType.SeasonRetail,
	DungeonEnum.EpisodeType.SeasonSpecial,
	DungeonEnum.EpisodeType.SeasonTrial,
	DungeonEnum.EpisodeType.Season123,
	DungeonEnum.EpisodeType.Season123Retail,
	DungeonEnum.EpisodeType.Season166Base,
	DungeonEnum.EpisodeType.Season166Train,
	DungeonEnum.EpisodeType.Season166Teach
}
slot0.SeasonTypeList = {
	ModuleEnum.HeroGroupType.Season,
	ModuleEnum.HeroGroupType.Season123,
	ModuleEnum.HeroGroupType.Season123Retail,
	ModuleEnum.HeroGroupType.Season166Base,
	ModuleEnum.HeroGroupType.Season166Train,
	ModuleEnum.HeroGroupType.Season166Teach
}

function slot0.checkIsSeasonEpisodeType(slot0)
	return tabletool.indexOf(uv0.SeasonEpisodeTypeList, slot0)
end

function slot0.checkIsSeasonTypeByEpisodeId(slot0)
	return uv0.checkIsSeasonEpisodeType(DungeonConfig.instance:getEpisodeCO(slot0).type)
end

function slot0.checkIsSeasonHeroGroupType(slot0)
	return tabletool.indexOf(uv0.SeasonTypeList, slot0)
end

function slot0.setSeasonSnapShot(slot0)
	slot1 = ModuleEnum.HeroGroupSnapshotType.Season
	slot2 = 0
	slot3, slot4 = nil

	if slot0.extendData then
		slot2 = slot0.extendData.groupIndex
		slot3 = slot0.extendData.heroGroup
	end

	return slot1, slot2, slot3, slot4
end

function slot0.setSeason123SnapShot(slot0)
	slot1 = ModuleEnum.HeroGroupSnapshotType.Season123
	slot2 = 0
	slot3, slot4 = nil

	if slot0.extendData then
		slot2 = slot0.extendData.groupIndex
		slot3 = slot0.extendData.heroGroup
	end

	if slot3 then
		slot4 = Season123HeroGroupUtils.getAllHeroActivity123Equips(slot3)
	end

	return slot1, slot2, slot3, slot4
end

function slot0.setSeason123RetailSnapShot(slot0)
	slot1 = ModuleEnum.HeroGroupSnapshotType.Season123Retail
	slot2 = 1
	slot3, slot4 = nil

	if slot0.extendData then
		slot3 = slot0.extendData.heroGroup
	end

	return slot1, slot2, slot3, slot4
end

function slot0.setSeason166BaseSpotSnapShot(slot0)
	slot1 = ModuleEnum.HeroGroupSnapshotType.Season166Base
	slot2 = 0
	slot3, slot4 = nil

	if slot0.extendData then
		slot3 = slot0.extendData.heroGroup
		slot2 = slot0.extendData.snapshotSubId or 1
	end

	return slot1, slot2, slot3, slot4
end

function slot0.setSeason166TrainSpotSnapShot(slot0)
	slot1 = ModuleEnum.HeroGroupSnapshotType.Season166Train
	slot2 = 1
	slot3, slot4 = nil

	if slot0.extendData then
		slot3 = slot0.extendData.heroGroup
	end

	return slot1, slot2, slot3, slot4
end

slot0.setSeasonSnapShotHandleFunc = {
	[ModuleEnum.HeroGroupType.Season] = slot0.setSeasonSnapShot,
	[ModuleEnum.HeroGroupType.Season123] = slot0.setSeason123SnapShot,
	[ModuleEnum.HeroGroupType.Season123Retail] = slot0.setSeason123RetailSnapShot,
	[ModuleEnum.HeroGroupType.Season166Base] = slot0.setSeason166BaseSpotSnapShot,
	[ModuleEnum.HeroGroupType.Season166Train] = slot0.setSeason166TrainSpotSnapShot
}

function slot0.buildSeason(slot0)
	Activity104Model.instance:buildHeroGroup(slot0.isReConnect)

	return ModuleEnum.HeroGroupType.Season
end

function slot0.buildSeason123(slot0)
	Season123HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season123
end

function slot0.buildSeason123Retail(slot0)
	Season123HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season123Retail
end

function slot0.buildSeason166BaseSpot(slot0)
	Season166HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season166Base
end

function slot0.buildSeason166Train(slot0)
	Season166HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season166Train
end

function slot0.buildSeason166Teach(slot0)
	Season166HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season166Teach
end

slot0.buildSeasonHandleFunc = {
	[DungeonEnum.EpisodeType.Season] = slot0.buildSeason,
	[DungeonEnum.EpisodeType.SeasonRetail] = slot0.buildSeason,
	[DungeonEnum.EpisodeType.SeasonSpecial] = slot0.buildSeason,
	[DungeonEnum.EpisodeType.SeasonTrial] = slot0.buildSeason,
	[DungeonEnum.EpisodeType.Season123] = slot0.buildSeason123,
	[DungeonEnum.EpisodeType.Season123Retail] = slot0.buildSeason123Retail,
	[DungeonEnum.EpisodeType.Season166Base] = slot0.buildSeason166BaseSpot,
	[DungeonEnum.EpisodeType.Season166Train] = slot0.buildSeason166Train,
	[DungeonEnum.EpisodeType.Season166Teach] = slot0.buildSeason166Teach
}

function slot0.getSeasonHeroGroupMO()
	return Activity104Model.instance:getSnapshotHeroGroupBySubId()
end

function slot0.getSeason123HeroGroupMO()
	return Season123HeroGroupModel.instance:getCurrentHeroGroup()
end

function slot0.getSeason166HeroGroupMO()
	if Season166HeroGroupModel.instance:isHaveTrialCo() then
		return Season166HeroGroupModel.instance:getTrailHeroGroupList()
	else
		return Season166HeroGroupModel.instance:getCurrentHeroGroup()
	end
end

slot0.getSeasonCurrentHeroGroupMO = {
	[ModuleEnum.HeroGroupType.Season] = slot0.getSeasonHeroGroupMO,
	[ModuleEnum.HeroGroupType.Season123] = slot0.getSeason123HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season123Retail] = slot0.getSeason123HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season166Base] = slot0.getSeason166HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season166Train] = slot0.getSeason166HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season166Teach] = slot0.getSeason166HeroGroupMO
}
slot0.NeedGetHeroCardSeason = {
	[ModuleEnum.HeroGroupType.Season] = true,
	[ModuleEnum.HeroGroupType.Season123] = true
}
slot0.NormalSeason = {
	[ModuleEnum.HeroGroupType.Season123Retail] = true
}
slot0.NormalSeason166 = {
	[ModuleEnum.HeroGroupType.Season166Base] = true,
	[ModuleEnum.HeroGroupType.Season166Train] = true
}

function slot0.setHeroGroupSnapshot(slot0, slot1, slot2, slot3, slot4)
	if uv0.NeedGetHeroCardSeason[slot1] then
		HeroGroupModel.instance:setHeroGroupSnapshot(slot1, slot2, true, {
			groupIndex = slot0.groupId,
			heroGroup = slot0
		}, slot3, slot4)

		return
	end

	if uv0.NormalSeason[slot1] then
		HeroGroupModel.instance:setHeroGroupSnapshot(slot1, slot2, true, nil, slot3, slot4)
	end

	if uv0.NormalSeason166[slot1] then
		if not Season166Model.instance:getBattleContext() then
			return
		end

		slot5.snapshotSubId = slot6.baseId or 1
		slot5.heroGroup = slot0

		Season166HeroGroupModel.instance:setHeroGroupSnapshot(slot1, slot2, true, slot5, slot3, slot4)
	end
end

return slot0
