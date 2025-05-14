module("modules.logic.seasonver.common.SeasonHeroGroupHandler", package.seeall)

local var_0_0 = class("SeasonHeroGroupHandler")

var_0_0.SeasonEpisodeTypeList = {
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
var_0_0.SeasonTypeList = {
	ModuleEnum.HeroGroupType.Season,
	ModuleEnum.HeroGroupType.Season123,
	ModuleEnum.HeroGroupType.Season123Retail,
	ModuleEnum.HeroGroupType.Season166Base,
	ModuleEnum.HeroGroupType.Season166Train,
	ModuleEnum.HeroGroupType.Season166Teach
}

function var_0_0.checkIsSeasonEpisodeType(arg_1_0)
	return (tabletool.indexOf(var_0_0.SeasonEpisodeTypeList, arg_1_0))
end

function var_0_0.checkIsSeasonTypeByEpisodeId(arg_2_0)
	local var_2_0 = DungeonConfig.instance:getEpisodeCO(arg_2_0).type

	return var_0_0.checkIsSeasonEpisodeType(var_2_0)
end

function var_0_0.checkIsSeasonHeroGroupType(arg_3_0)
	return (tabletool.indexOf(var_0_0.SeasonTypeList, arg_3_0))
end

function var_0_0.setSeasonSnapShot(arg_4_0)
	local var_4_0 = ModuleEnum.HeroGroupSnapshotType.Season
	local var_4_1 = 0
	local var_4_2
	local var_4_3

	if arg_4_0.extendData then
		var_4_1 = arg_4_0.extendData.groupIndex
		var_4_2 = arg_4_0.extendData.heroGroup
	end

	return var_4_0, var_4_1, var_4_2, var_4_3
end

function var_0_0.setSeason123SnapShot(arg_5_0)
	local var_5_0 = ModuleEnum.HeroGroupSnapshotType.Season123
	local var_5_1 = 0
	local var_5_2
	local var_5_3

	if arg_5_0.extendData then
		var_5_1 = arg_5_0.extendData.groupIndex
		var_5_2 = arg_5_0.extendData.heroGroup
	end

	if var_5_2 then
		var_5_3 = Season123HeroGroupUtils.getAllHeroActivity123Equips(var_5_2)
	end

	return var_5_0, var_5_1, var_5_2, var_5_3
end

function var_0_0.setSeason123RetailSnapShot(arg_6_0)
	local var_6_0 = ModuleEnum.HeroGroupSnapshotType.Season123Retail
	local var_6_1 = 1
	local var_6_2
	local var_6_3

	if arg_6_0.extendData then
		var_6_2 = arg_6_0.extendData.heroGroup
	end

	return var_6_0, var_6_1, var_6_2, var_6_3
end

function var_0_0.setSeason166BaseSpotSnapShot(arg_7_0)
	local var_7_0 = ModuleEnum.HeroGroupSnapshotType.Season166Base
	local var_7_1 = 0
	local var_7_2
	local var_7_3

	if arg_7_0.extendData then
		var_7_2 = arg_7_0.extendData.heroGroup
		var_7_1 = arg_7_0.extendData.snapshotSubId or 1
	end

	return var_7_0, var_7_1, var_7_2, var_7_3
end

function var_0_0.setSeason166TrainSpotSnapShot(arg_8_0)
	local var_8_0 = ModuleEnum.HeroGroupSnapshotType.Season166Train
	local var_8_1 = 1
	local var_8_2
	local var_8_3

	if arg_8_0.extendData then
		var_8_2 = arg_8_0.extendData.heroGroup
	end

	return var_8_0, var_8_1, var_8_2, var_8_3
end

var_0_0.setSeasonSnapShotHandleFunc = {
	[ModuleEnum.HeroGroupType.Season] = var_0_0.setSeasonSnapShot,
	[ModuleEnum.HeroGroupType.Season123] = var_0_0.setSeason123SnapShot,
	[ModuleEnum.HeroGroupType.Season123Retail] = var_0_0.setSeason123RetailSnapShot,
	[ModuleEnum.HeroGroupType.Season166Base] = var_0_0.setSeason166BaseSpotSnapShot,
	[ModuleEnum.HeroGroupType.Season166Train] = var_0_0.setSeason166TrainSpotSnapShot
}

function var_0_0.buildSeason(arg_9_0)
	Activity104Model.instance:buildHeroGroup(arg_9_0.isReConnect)

	return ModuleEnum.HeroGroupType.Season
end

function var_0_0.buildSeason123(arg_10_0)
	Season123HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season123
end

function var_0_0.buildSeason123Retail(arg_11_0)
	Season123HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season123Retail
end

function var_0_0.buildSeason166BaseSpot(arg_12_0)
	Season166HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season166Base
end

function var_0_0.buildSeason166Train(arg_13_0)
	Season166HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season166Train
end

function var_0_0.buildSeason166Teach(arg_14_0)
	Season166HeroGroupModel.instance:buildAidHeroGroup()

	return ModuleEnum.HeroGroupType.Season166Teach
end

var_0_0.buildSeasonHandleFunc = {
	[DungeonEnum.EpisodeType.Season] = var_0_0.buildSeason,
	[DungeonEnum.EpisodeType.SeasonRetail] = var_0_0.buildSeason,
	[DungeonEnum.EpisodeType.SeasonSpecial] = var_0_0.buildSeason,
	[DungeonEnum.EpisodeType.SeasonTrial] = var_0_0.buildSeason,
	[DungeonEnum.EpisodeType.Season123] = var_0_0.buildSeason123,
	[DungeonEnum.EpisodeType.Season123Retail] = var_0_0.buildSeason123Retail,
	[DungeonEnum.EpisodeType.Season166Base] = var_0_0.buildSeason166BaseSpot,
	[DungeonEnum.EpisodeType.Season166Train] = var_0_0.buildSeason166Train,
	[DungeonEnum.EpisodeType.Season166Teach] = var_0_0.buildSeason166Teach
}

function var_0_0.getSeasonHeroGroupMO()
	return Activity104Model.instance:getSnapshotHeroGroupBySubId()
end

function var_0_0.getSeason123HeroGroupMO()
	return Season123HeroGroupModel.instance:getCurrentHeroGroup()
end

function var_0_0.getSeason166HeroGroupMO()
	if Season166HeroGroupModel.instance:isHaveTrialCo() then
		return Season166HeroGroupModel.instance:getTrailHeroGroupList()
	else
		return Season166HeroGroupModel.instance:getCurrentHeroGroup()
	end
end

var_0_0.getSeasonCurrentHeroGroupMO = {
	[ModuleEnum.HeroGroupType.Season] = var_0_0.getSeasonHeroGroupMO,
	[ModuleEnum.HeroGroupType.Season123] = var_0_0.getSeason123HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season123Retail] = var_0_0.getSeason123HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season166Base] = var_0_0.getSeason166HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season166Train] = var_0_0.getSeason166HeroGroupMO,
	[ModuleEnum.HeroGroupType.Season166Teach] = var_0_0.getSeason166HeroGroupMO
}
var_0_0.NeedGetHeroCardSeason = {
	[ModuleEnum.HeroGroupType.Season] = true,
	[ModuleEnum.HeroGroupType.Season123] = true
}
var_0_0.NormalSeason = {
	[ModuleEnum.HeroGroupType.Season123Retail] = true
}
var_0_0.NormalSeason166 = {
	[ModuleEnum.HeroGroupType.Season166Base] = true,
	[ModuleEnum.HeroGroupType.Season166Train] = true
}

function var_0_0.setHeroGroupSnapshot(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = {}

	if var_0_0.NeedGetHeroCardSeason[arg_18_1] then
		var_18_0.groupIndex = arg_18_0.groupId
		var_18_0.heroGroup = arg_18_0

		HeroGroupModel.instance:setHeroGroupSnapshot(arg_18_1, arg_18_2, true, var_18_0, arg_18_3, arg_18_4)

		return
	end

	if var_0_0.NormalSeason[arg_18_1] then
		HeroGroupModel.instance:setHeroGroupSnapshot(arg_18_1, arg_18_2, true, nil, arg_18_3, arg_18_4)
	end

	if var_0_0.NormalSeason166[arg_18_1] then
		local var_18_1 = Season166Model.instance:getBattleContext()

		if not var_18_1 then
			return
		end

		var_18_0.snapshotSubId = var_18_1.baseId or 1
		var_18_0.heroGroup = arg_18_0

		Season166HeroGroupModel.instance:setHeroGroupSnapshot(arg_18_1, arg_18_2, true, var_18_0, arg_18_3, arg_18_4)
	end
end

return var_0_0
