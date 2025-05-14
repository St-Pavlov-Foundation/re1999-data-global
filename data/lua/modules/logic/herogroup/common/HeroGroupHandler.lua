module("modules.logic.herogroup.common.HeroGroupHandler", package.seeall)

local var_0_0 = class("HeroGroupHandler")

var_0_0.EpisodeTypeDict = {
	[DungeonEnum.EpisodeType.TowerPermanent] = 1,
	[DungeonEnum.EpisodeType.TowerBoss] = 1,
	[DungeonEnum.EpisodeType.TowerLimited] = 1,
	[DungeonEnum.EpisodeType.Act183] = 1
}

function var_0_0.checkIsEpisodeType(arg_1_0)
	return var_0_0.EpisodeTypeDict[arg_1_0] ~= nil
end

function var_0_0.checkIsEpisodeTypeByEpisodeId(arg_2_0)
	local var_2_0 = DungeonConfig.instance:getEpisodeCO(arg_2_0).type

	return var_0_0.checkIsEpisodeType(var_2_0)
end

function var_0_0.getTowerBossSnapShot(arg_3_0)
	local var_3_0 = ModuleEnum.HeroGroupSnapshotType.TowerBoss
	local var_3_1 = TowerConfig.instance:getBossTowerIdByEpisodeId(arg_3_0)

	return var_3_0, {
		var_3_1
	}
end

function var_0_0.getTowerPermanentSnapShot(arg_4_0)
	local var_4_0 = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit
	local var_4_1 = {
		1,
		2,
		3,
		4
	}

	return var_4_0, var_4_1
end

function var_0_0.getAct183SnapShot(arg_5_0)
	local var_5_0 = Act183Helper.getEpisodeType(arg_5_0)

	if var_5_0 == Act183Enum.EpisodeType.Sub then
		return ModuleEnum.HeroGroupSnapshotType.Act183Normal, {
			1
		}
	elseif var_5_0 == Act183Enum.EpisodeType.Boss then
		return ModuleEnum.HeroGroupSnapshotType.Act183Boss, {
			1
		}
	else
		logError(string.format("获取编队快照id失败 episodeId = %s", arg_5_0))
	end
end

var_0_0.getSnapShotHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = var_0_0.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.TowerBoss] = var_0_0.getTowerBossSnapShot,
	[DungeonEnum.EpisodeType.TowerLimited] = var_0_0.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.Act183] = var_0_0.getAct183SnapShot
}

function var_0_0.getSnapShot(arg_6_0)
	local var_6_0 = DungeonConfig.instance:getEpisodeCO(arg_6_0).type
	local var_6_1 = var_0_0.getSnapShotHandleFunc[var_6_0]

	if var_6_1 then
		return var_6_1(arg_6_0)
	end
end

return var_0_0
