module("modules.logic.herogroup.common.HeroGroupHandler", package.seeall)

local var_0_0 = class("HeroGroupHandler")

var_0_0.EpisodeTypeDict = {
	[DungeonEnum.EpisodeType.TowerPermanent] = 1,
	[DungeonEnum.EpisodeType.TowerBoss] = 1,
	[DungeonEnum.EpisodeType.TowerLimited] = 1,
	[DungeonEnum.EpisodeType.TowerBossTeach] = 1,
	[DungeonEnum.EpisodeType.Act183] = 1,
	[DungeonEnum.EpisodeType.Survival] = 1,
	[DungeonEnum.EpisodeType.Shelter] = 1
}

function var_0_0.checkIsEpisodeType(arg_1_0)
	return var_0_0.EpisodeTypeDict[arg_1_0] ~= nil
end

function var_0_0.checkIsEpisodeTypeByEpisodeId(arg_2_0)
	local var_2_0 = DungeonConfig.instance:getEpisodeCO(arg_2_0).type

	return var_0_0.checkIsEpisodeType(var_2_0)
end

function var_0_0.checkIsTowerEpisodeByEpisodeId(arg_3_0)
	local var_3_0 = DungeonConfig.instance:getEpisodeCO(arg_3_0)

	if not var_3_0 then
		return false
	end

	local var_3_1 = var_3_0.type

	return var_3_1 == DungeonEnum.EpisodeType.TowerPermanent or var_3_1 == DungeonEnum.EpisodeType.TowerBoss or var_3_1 == DungeonEnum.EpisodeType.TowerLimited
end

function var_0_0.getTowerBossSnapShot(arg_4_0)
	local var_4_0 = ModuleEnum.HeroGroupSnapshotType.TowerBoss
	local var_4_1 = TowerConfig.instance:getBossTowerIdByEpisodeId(arg_4_0)

	return var_4_0, {
		var_4_1
	}
end

function var_0_0.getTowerPermanentSnapShot(arg_5_0)
	local var_5_0 = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit
	local var_5_1 = {
		1,
		2,
		3,
		4
	}

	return var_5_0, var_5_1
end

function var_0_0.getAct183SnapShot(arg_6_0)
	return Act183Helper.getEpisodeSnapShotType(arg_6_0), {
		1
	}
end

function var_0_0.getShelterSnapShot()
	return ModuleEnum.HeroGroupSnapshotType.Shelter, {
		1,
		2,
		3
	}
end

function var_0_0.getSurvivalSnapShot()
	return ModuleEnum.HeroGroupSnapshotType.Survival, {
		1
	}
end

var_0_0.getSnapShotHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = var_0_0.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.TowerBoss] = var_0_0.getTowerBossSnapShot,
	[DungeonEnum.EpisodeType.TowerLimited] = var_0_0.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.Act183] = var_0_0.getAct183SnapShot,
	[DungeonEnum.EpisodeType.Shelter] = var_0_0.getShelterSnapShot,
	[DungeonEnum.EpisodeType.Survival] = var_0_0.getSurvivalSnapShot
}

function var_0_0.getSnapShot(arg_9_0)
	local var_9_0 = DungeonConfig.instance:getEpisodeCO(arg_9_0).type
	local var_9_1 = var_0_0.getSnapShotHandleFunc[var_9_0]

	if var_9_1 then
		return var_9_1(arg_9_0)
	end
end

function var_0_0.getTowerTrialHeros(arg_10_0)
	local var_10_0 = TowerModel.instance:getTrialHeroSeason()
	local var_10_1 = TowerConfig.instance:getHeroTrialConfig(var_10_0)

	return var_10_1 and var_10_1.heroIds
end

var_0_0.getTrialHerosHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = var_0_0.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerBoss] = var_0_0.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerLimited] = var_0_0.getTowerTrialHeros
}

function var_0_0.getTrialHeros(arg_11_0)
	local var_11_0 = DungeonConfig.instance:getEpisodeCO(arg_11_0)

	if not var_11_0 then
		return ""
	end

	local var_11_1 = var_11_0.type
	local var_11_2 = var_0_0.getTrialHerosHandleFunc[var_11_1]

	if var_11_2 then
		return var_11_2(arg_11_0)
	else
		local var_11_3 = HeroGroupModel.instance.battleId

		return (var_11_3 and lua_battle.configDict[var_11_3]).trialHeros
	end
end

function var_0_0.setTowerHeroListData(arg_12_0)
	local var_12_0 = HeroGroupSnapshotModel.instance:getCurGroup()

	if var_12_0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0.heroList) do
			if tonumber(iter_12_1) < 0 then
				local var_12_1 = -tonumber(iter_12_1)
				local var_12_2 = HeroGroupTrialModel.instance:getById(iter_12_1)

				if var_12_2 then
					var_12_1 = var_12_2.trialCo.id
				end

				local var_12_3 = TowerModel.instance:getTrialHeroSeason() > 0
				local var_12_4 = TowerConfig.instance:getHeroTrialConfig(TowerModel.instance:getTrialHeroSeason())
				local var_12_5 = var_12_3 and string.splitToNumber(var_12_4.heroIds, "|") or {}
				local var_12_6 = var_12_3 and tabletool.indexOf(var_12_5, var_12_1) and tonumber(var_12_1) > 0
				local var_12_7 = var_12_6 and lua_hero_trial.configDict[var_12_1][0] or {}
				local var_12_8 = var_12_6 and tostring(tonumber(var_12_7.id .. "." .. var_12_7.trialTemplate) - 1099511627776) or "0"

				var_12_0.heroList[iter_12_0] = var_12_8

				if var_12_6 then
					if not var_12_0.trialDict then
						var_12_0.trialDict = {}
					end

					if not var_12_0.trialDict[iter_12_0] then
						var_12_0.trialDict[iter_12_0] = {}
					end

					var_12_0.trialDict[iter_12_0][1] = var_12_7.id
				end
			end
		end
	end
end

var_0_0.getHeroListDataHandlerFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = var_0_0.setTowerHeroListData,
	[DungeonEnum.EpisodeType.TowerBoss] = var_0_0.setTowerHeroListData,
	[DungeonEnum.EpisodeType.TowerLimited] = var_0_0.setTowerHeroListData
}

function var_0_0.hanldeHeroListData(arg_13_0)
	if not arg_13_0 then
		return
	end

	local var_13_0 = DungeonConfig.instance:getEpisodeCO(arg_13_0).type
	local var_13_1 = var_0_0.getHeroListDataHandlerFunc[var_13_0]

	if var_13_1 then
		return var_13_1(arg_13_0)
	end
end

return var_0_0
