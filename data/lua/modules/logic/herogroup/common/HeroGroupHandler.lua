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

function var_0_0.getFiveHeroSnapShot(arg_6_0)
	local var_6_0 = ModuleEnum.HeroGroupSnapshotType.FiveHero
	local var_6_1 = {
		1,
		2,
		3,
		4,
		5
	}

	return var_6_0, var_6_1
end

function var_0_0.getAct183SnapShot(arg_7_0)
	return Act183Helper.getEpisodeSnapShotType(arg_7_0), {
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

function var_0_0.getSnapShot(arg_10_0)
	local var_10_0 = DungeonConfig.instance:getEpisodeCO(arg_10_0).type
	local var_10_1 = var_0_0.getSnapShotHandleFunc[var_10_0]

	if var_10_1 then
		return var_10_1(arg_10_0)
	end

	if DungeonController.checkEpisodeFiveHero(arg_10_0) then
		return var_0_0.getFiveHeroSnapShot(arg_10_0)
	end
end

function var_0_0.getTowerTrialHeros(arg_11_0)
	local var_11_0 = TowerModel.instance:getTrialHeroSeason()
	local var_11_1 = TowerConfig.instance:getHeroTrialConfig(var_11_0)

	return var_11_1 and var_11_1.heroIds
end

var_0_0.getTrialHerosHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = var_0_0.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerBoss] = var_0_0.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerLimited] = var_0_0.getTowerTrialHeros
}

function var_0_0.getTrialHeros(arg_12_0)
	local var_12_0 = DungeonConfig.instance:getEpisodeCO(arg_12_0)

	if not var_12_0 then
		return ""
	end

	local var_12_1 = var_12_0.type
	local var_12_2 = var_0_0.getTrialHerosHandleFunc[var_12_1]

	if var_12_2 then
		return var_12_2(arg_12_0)
	else
		local var_12_3 = HeroGroupModel.instance.battleId

		return (var_12_3 and lua_battle.configDict[var_12_3]).trialHeros
	end
end

function var_0_0.setTowerHeroListData(arg_13_0)
	local var_13_0 = HeroGroupSnapshotModel.instance:getCurGroup()

	if var_13_0 then
		for iter_13_0, iter_13_1 in ipairs(var_13_0.heroList) do
			if tonumber(iter_13_1) < 0 then
				local var_13_1 = -tonumber(iter_13_1)
				local var_13_2 = HeroGroupTrialModel.instance:getById(iter_13_1)

				if var_13_2 then
					var_13_1 = var_13_2.trialCo.id
				end

				local var_13_3 = TowerModel.instance:getTrialHeroSeason() > 0
				local var_13_4 = TowerConfig.instance:getHeroTrialConfig(TowerModel.instance:getTrialHeroSeason())
				local var_13_5 = var_13_3 and string.splitToNumber(var_13_4.heroIds, "|") or {}
				local var_13_6 = var_13_3 and tabletool.indexOf(var_13_5, var_13_1) and tonumber(var_13_1) > 0
				local var_13_7 = var_13_6 and lua_hero_trial.configDict[var_13_1][0] or {}
				local var_13_8 = var_13_6 and tostring(tonumber(var_13_7.id .. "." .. var_13_7.trialTemplate) - 1099511627776) or "0"

				var_13_0.heroList[iter_13_0] = var_13_8

				if var_13_6 then
					if not var_13_0.trialDict then
						var_13_0.trialDict = {}
					end

					if not var_13_0.trialDict[iter_13_0] then
						var_13_0.trialDict[iter_13_0] = {}
					end

					var_13_0.trialDict[iter_13_0][1] = var_13_7.id
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

function var_0_0.hanldeHeroListData(arg_14_0)
	if not arg_14_0 then
		return
	end

	local var_14_0 = DungeonConfig.instance:getEpisodeCO(arg_14_0).type
	local var_14_1 = var_0_0.getHeroListDataHandlerFunc[var_14_0]

	if var_14_1 then
		return var_14_1(arg_14_0)
	end
end

return var_0_0
