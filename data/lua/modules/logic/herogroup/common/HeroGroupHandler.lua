module("modules.logic.herogroup.common.HeroGroupHandler", package.seeall)

local var_0_0 = class("HeroGroupHandler")

var_0_0.EpisodeTypeDict = {
	[DungeonEnum.EpisodeType.TowerPermanent] = 1,
	[DungeonEnum.EpisodeType.TowerBoss] = 1,
	[DungeonEnum.EpisodeType.TowerLimited] = 1,
	[DungeonEnum.EpisodeType.TowerBossTeach] = 1,
	[DungeonEnum.EpisodeType.Act183] = 1
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

var_0_0.getSnapShotHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = var_0_0.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.TowerBoss] = var_0_0.getTowerBossSnapShot,
	[DungeonEnum.EpisodeType.TowerLimited] = var_0_0.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.Act183] = var_0_0.getAct183SnapShot
}

function var_0_0.getSnapShot(arg_7_0)
	local var_7_0 = DungeonConfig.instance:getEpisodeCO(arg_7_0).type
	local var_7_1 = var_0_0.getSnapShotHandleFunc[var_7_0]

	if var_7_1 then
		return var_7_1(arg_7_0)
	end
end

function var_0_0.getTowerTrialHeros(arg_8_0)
	local var_8_0 = TowerModel.instance:getTrialHeroSeason()
	local var_8_1 = TowerConfig.instance:getHeroTrialConfig(var_8_0)

	return var_8_1 and var_8_1.heroIds
end

var_0_0.getTrialHerosHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = var_0_0.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerBoss] = var_0_0.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerLimited] = var_0_0.getTowerTrialHeros
}

function var_0_0.getTrialHeros(arg_9_0)
	local var_9_0 = DungeonConfig.instance:getEpisodeCO(arg_9_0).type
	local var_9_1 = var_0_0.getTrialHerosHandleFunc[var_9_0]

	if var_9_1 then
		return var_9_1(arg_9_0)
	else
		local var_9_2 = HeroGroupModel.instance.battleId

		return (var_9_2 and lua_battle.configDict[var_9_2]).trialHeros
	end
end

function var_0_0.setTowerHeroListData(arg_10_0)
	local var_10_0 = HeroGroupSnapshotModel.instance:getCurGroup()

	if var_10_0 then
		for iter_10_0, iter_10_1 in ipairs(var_10_0.heroList) do
			if tonumber(iter_10_1) < 0 then
				local var_10_1 = -tonumber(iter_10_1)
				local var_10_2 = HeroGroupTrialModel.instance:getById(iter_10_1)

				if var_10_2 then
					var_10_1 = var_10_2.trialCo.id
				end

				local var_10_3 = TowerModel.instance:getTrialHeroSeason() > 0
				local var_10_4 = TowerConfig.instance:getHeroTrialConfig(TowerModel.instance:getTrialHeroSeason())
				local var_10_5 = var_10_3 and string.splitToNumber(var_10_4.heroIds, "|") or {}
				local var_10_6 = var_10_3 and tabletool.indexOf(var_10_5, var_10_1) and tonumber(var_10_1) > 0
				local var_10_7 = var_10_6 and lua_hero_trial.configDict[var_10_1][0] or {}
				local var_10_8 = var_10_6 and tostring(tonumber(var_10_7.id .. "." .. var_10_7.trialTemplate) - 1099511627776) or "0"

				var_10_0.heroList[iter_10_0] = var_10_8

				if var_10_6 then
					if not var_10_0.trialDict then
						var_10_0.trialDict = {}
					end

					if not var_10_0.trialDict[iter_10_0] then
						var_10_0.trialDict[iter_10_0] = {}
					end

					var_10_0.trialDict[iter_10_0][1] = var_10_7.id
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

function var_0_0.hanldeHeroListData(arg_11_0)
	if not arg_11_0 then
		return
	end

	local var_11_0 = DungeonConfig.instance:getEpisodeCO(arg_11_0).type
	local var_11_1 = var_0_0.getHeroListDataHandlerFunc[var_11_0]

	if var_11_1 then
		return var_11_1(arg_11_0)
	end
end

return var_0_0
