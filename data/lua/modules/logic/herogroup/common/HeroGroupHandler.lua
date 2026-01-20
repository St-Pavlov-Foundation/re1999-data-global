-- chunkname: @modules/logic/herogroup/common/HeroGroupHandler.lua

module("modules.logic.herogroup.common.HeroGroupHandler", package.seeall)

local HeroGroupHandler = class("HeroGroupHandler")

HeroGroupHandler.EpisodeTypeDict = {
	[DungeonEnum.EpisodeType.TowerPermanent] = 1,
	[DungeonEnum.EpisodeType.TowerBoss] = 1,
	[DungeonEnum.EpisodeType.TowerLimited] = 1,
	[DungeonEnum.EpisodeType.TowerBossTeach] = 1,
	[DungeonEnum.EpisodeType.TowerDeep] = 1,
	[DungeonEnum.EpisodeType.Act183] = 1,
	[DungeonEnum.EpisodeType.Survival] = 1,
	[DungeonEnum.EpisodeType.Shelter] = 1
}

function HeroGroupHandler.checkIsEpisodeType(episodeType)
	local isEpisodeType = HeroGroupHandler.EpisodeTypeDict[episodeType] ~= nil

	return isEpisodeType
end

function HeroGroupHandler.checkIsEpisodeTypeByEpisodeId(episodeId)
	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episdoeConfig.type

	return HeroGroupHandler.checkIsEpisodeType(episodeType)
end

function HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(episodeId)
	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episdoeConfig then
		return false
	end

	local episodeType = episdoeConfig.type

	return episodeType == DungeonEnum.EpisodeType.TowerPermanent or episodeType == DungeonEnum.EpisodeType.TowerBoss or episodeType == DungeonEnum.EpisodeType.TowerLimited or episodeType == DungeonEnum.EpisodeType.TowerDeep
end

function HeroGroupHandler.getTowerBossSnapShot(episodeId)
	local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.TowerBoss
	local towerId = TowerConfig.instance:getBossTowerIdByEpisodeId(episodeId)
	local snapshotSubId = towerId

	return heroGroupSnapshotType, {
		snapshotSubId
	}
end

function HeroGroupHandler.getTowerPermanentSnapShot(episodeId)
	local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit
	local snapshotSubIds = {
		1,
		2,
		3,
		4
	}

	return heroGroupSnapshotType, snapshotSubIds
end

function HeroGroupHandler.getFiveHeroSnapShot(episodeId)
	local heroGroupSnapshotType = ModuleEnum.HeroGroupSnapshotType.FiveHero
	local snapshotSubIds = {
		1,
		2,
		3,
		4,
		5
	}

	return heroGroupSnapshotType, snapshotSubIds
end

function HeroGroupHandler.getAct183SnapShot(episodeId)
	local snapshotType = Act183Helper.getEpisodeSnapShotType(episodeId)

	return snapshotType, {
		1
	}
end

function HeroGroupHandler.getShelterSnapShot()
	return ModuleEnum.HeroGroupSnapshotType.Shelter, {
		1,
		2,
		3
	}
end

function HeroGroupHandler.getSurvivalSnapShot()
	return ModuleEnum.HeroGroupSnapshotType.Survival, {
		1
	}
end

HeroGroupHandler.getSnapShotHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = HeroGroupHandler.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.TowerBoss] = HeroGroupHandler.getTowerBossSnapShot,
	[DungeonEnum.EpisodeType.TowerLimited] = HeroGroupHandler.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.TowerDeep] = HeroGroupHandler.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.Act183] = HeroGroupHandler.getAct183SnapShot,
	[DungeonEnum.EpisodeType.Shelter] = HeroGroupHandler.getShelterSnapShot,
	[DungeonEnum.EpisodeType.Survival] = HeroGroupHandler.getSurvivalSnapShot
}

function HeroGroupHandler.getSnapShot(episodeId)
	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episdoeConfig.type
	local func = HeroGroupHandler.getSnapShotHandleFunc[episodeType]

	if func then
		return func(episodeId)
	end

	if DungeonController.checkEpisodeFiveHero(episodeId) then
		return HeroGroupHandler.getFiveHeroSnapShot(episodeId)
	end
end

function HeroGroupHandler.getTowerTrialHeros(episodeId)
	local curSeasonId = TowerModel.instance:getTrialHeroSeason()
	local trialConfig = TowerConfig.instance:getHeroTrialConfig(curSeasonId)

	return trialConfig and trialConfig.heroIds
end

HeroGroupHandler.getTrialHerosHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = HeroGroupHandler.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerBoss] = HeroGroupHandler.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerLimited] = HeroGroupHandler.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerDeep] = HeroGroupHandler.getTowerTrialHeros
}

function HeroGroupHandler.getTrialHeros(episodeId)
	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episdoeConfig then
		return ""
	end

	local episodeType = episdoeConfig.type
	local func = HeroGroupHandler.getTrialHerosHandleFunc[episodeType]

	if func then
		return func(episodeId)
	else
		local battleId = HeroGroupModel.instance.battleId
		local battleCO = battleId and lua_battle.configDict[battleId]

		return battleCO.trialHeros
	end
end

function HeroGroupHandler.setTowerHeroListData(episodeId, groupMO)
	groupMO = groupMO or HeroGroupSnapshotModel.instance:getCurGroup()

	if groupMO then
		for index, heroId in ipairs(groupMO.heroList) do
			if tonumber(heroId) < 0 then
				local trialHeroId = -tonumber(heroId)
				local heroMO = HeroGroupTrialModel.instance:getById(heroId)

				if heroMO then
					trialHeroId = heroMO.trialCo.id
				end

				local haveTrialHero = TowerModel.instance:getTrialHeroSeason() > 0
				local heroTrialConfig = TowerConfig.instance:getHeroTrialConfig(TowerModel.instance:getTrialHeroSeason())
				local trialHeroList = haveTrialHero and string.splitToNumber(heroTrialConfig.heroIds, "|") or {}
				local isHeroOnline = haveTrialHero and tabletool.indexOf(trialHeroList, trialHeroId) and tonumber(trialHeroId) > 0
				local trialCo = isHeroOnline and lua_hero_trial.configDict[trialHeroId][0] or {}
				local trialHeroUid = isHeroOnline and tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776) or "0"

				groupMO.heroList[index] = trialHeroUid

				if isHeroOnline then
					if not groupMO.trialDict then
						groupMO.trialDict = {}
					end

					if not groupMO.trialDict[index] then
						groupMO.trialDict[index] = {}
					end

					groupMO.trialDict[index][1] = trialCo.id
				end
			end
		end
	end
end

HeroGroupHandler.getHeroListDataHandlerFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = HeroGroupHandler.setTowerHeroListData,
	[DungeonEnum.EpisodeType.TowerBoss] = HeroGroupHandler.setTowerHeroListData,
	[DungeonEnum.EpisodeType.TowerLimited] = HeroGroupHandler.setTowerHeroListData,
	[DungeonEnum.EpisodeType.TowerDeep] = HeroGroupHandler.setTowerHeroListData
}

function HeroGroupHandler.hanldeHeroListData(episodeId)
	if not episodeId then
		return
	end

	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episdoeConfig.type
	local func = HeroGroupHandler.getHeroListDataHandlerFunc[episodeType]

	if func then
		return func(episodeId)
	end
end

return HeroGroupHandler
