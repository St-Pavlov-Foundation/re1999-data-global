module("modules.logic.tower.model.TowerModel", package.seeall)

slot0 = class("TowerModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0:clearTowerData()

	slot0.fightParam = {}
	slot0.fightFinishParam = {}
	slot0.localPrefsDict = {}
end

function slot0.clearTowerData(slot0)
	slot0.towerOpenMap = {}
	slot0.towerOpenList = {}
	slot0.towerInfoMap = {}
	slot0.towerInfoList = {}
end

function slot0.onReceiveTowerBattleFinishPush(slot0, slot1)
	slot0.fightFinishParam.towerType = slot1.type
	slot0.fightFinishParam.towerId = slot1.towerId
	slot0.fightFinishParam.layerId = slot1.layerId
	slot0.fightFinishParam.difficulty = slot1.difficulty
	slot0.fightFinishParam.score = slot1.score
	slot0.fightFinishParam.bossLevel = slot1.bossLevel
	slot0.fightFinishParam.teamLevel = slot1.teamLevel
	slot0.fightFinishParam.layer = slot1.layer
	slot0.fightFinishParam.historyHighScore = slot1.historyHighScore
end

function slot0.getFightFinishParam(slot0)
	return slot0.fightFinishParam
end

function slot0.clearFightFinishParam(slot0)
	slot0.fightFinishParam = {}
end

function slot0.onReceiveGetTowerInfoReply(slot0, slot1)
	slot0:clearTowerData()
	TowerAssistBossModel.instance:clear()
	slot0:setTowerOpenInfo(slot1)
	slot0:setTowerInfo(slot1)
	slot0:updateMopUpTimes(slot1.mopUpTimes)

	for slot5 = 1, #slot1.assistBosses do
		TowerAssistBossModel.instance:updateAssistBossInfo(slot1.assistBosses[slot5])
	end

	TowerPermanentModel.instance:InitData()
end

function slot0.setTowerOpenInfo(slot0, slot1)
	if #slot1.towerOpens == 0 then
		logError("towerOpenInfo not exit")

		return
	end

	for slot5, slot6 in ipairs(slot1.towerOpens) do
		slot8 = slot6.towerId
		slot9 = slot6.round

		if not slot0.towerOpenMap[slot6.type] then
			slot0.towerOpenMap[slot7] = {}
		end

		if not slot10[slot8] then
			slot10[slot8] = {}
		end

		if not slot11[slot9] then
			slot12 = TowerOpenMo.New()
			slot11[slot9] = slot12

			slot0:addTowerOpenList(slot7, slot12)
		end

		slot12:updateInfo(slot6)
	end
end

function slot0.addTowerOpenList(slot0, slot1, slot2)
	if not slot0.towerOpenList[slot1] then
		slot0.towerOpenList[slot1] = {}
	end

	table.insert(slot0.towerOpenList[slot1], slot2)
end

function slot0.getTowerOpenList(slot0, slot1)
	return slot0.towerOpenList[slot1] or {}
end

function slot0.getTowerOpenInfoByRound(slot0, slot1, slot2, slot3)
	if not (slot0.towerOpenMap[slot1] and slot4[slot2]) then
		return
	end

	return slot5[slot3]
end

function slot0.getTowerOpenInfo(slot0, slot1, slot2, slot3)
	if slot3 == nil then
		slot3 = TowerEnum.TowerStatus.Open
	end

	if not (slot0.towerOpenMap[slot1] and slot4[slot2]) then
		return
	end

	for slot9, slot10 in pairs(slot5) do
		if slot10.status == slot3 then
			return slot10
		end
	end
end

function slot0.setTowerInfo(slot0, slot1)
	if #slot1.towers == 0 then
		logError("towerInfo not exit")

		return
	end

	for slot5, slot6 in ipairs(slot1.towers) do
		slot8 = slot6.towerId

		if not slot0.towerInfoMap[slot6.type] then
			slot0.towerInfoMap[slot7] = {}
		end

		if not slot9[slot8] then
			slot10 = TowerMo.New()
			slot9[slot8] = slot10

			slot0:addTowerInfoList(slot7, slot10)
		end

		slot0.towerInfoMap[slot7][slot8]:updateInfo(slot6)
	end
end

function slot0.addTowerInfoList(slot0, slot1, slot2)
	if not slot0.towerInfoList[slot1] then
		slot0.towerInfoList[slot1] = {}
	end

	table.insert(slot0.towerInfoList[slot1], slot2)
end

function slot0.getTowerInfoList(slot0, slot1)
	return slot0.towerInfoList[slot1]
end

function slot0.getTowerInfoById(slot0, slot1, slot2)
	if not slot0.towerInfoMap[slot1] then
		return
	end

	return slot0.towerInfoMap[slot1][slot2]
end

function slot0.getTowerListByStatus(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = TowerEnum.TowerStatus.Open
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot0:getTowerOpenList(slot1)) do
		if slot9.status == slot2 then
			table.insert(slot4, slot9)
		end
	end

	return slot4
end

function slot0.getCurPermanentMo(slot0)
	if slot0.towerInfoMap[TowerEnum.TowerType.Normal] then
		return slot0.towerInfoMap[slot1][TowerEnum.PermanentTowerId]
	else
		logError("towerInfoMap is Empty")
	end
end

function slot0.initEpisodes(slot0)
	if slot0.towerEpisodeMap then
		return
	end

	slot0.towerEpisodeMap = {}

	slot0:_initEpisode(TowerEnum.TowerType.Boss, TowerConfig.instance.bossTowerEpisodeConfig)
end

function slot0._initEpisode(slot0, slot1, slot2)
	slot3 = TowerEpisodeMo.New()

	slot3:init(slot1, slot2)

	slot0.towerEpisodeMap[slot1] = slot3
end

function slot0.getEpisodeMoByTowerType(slot0, slot1)
	slot0:initEpisodes()

	return slot0.towerEpisodeMap[slot1]
end

function slot0.setRecordFightParam(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.fightParam.towerType = slot1
	slot0.fightParam.towerId = slot2
	slot0.fightParam.layerId = slot3
	slot0.fightParam.difficulty = slot4
	slot0.fightParam.episodeId = slot5

	slot0:refreshHeroGroupInfo()
end

function slot0.refreshHeroGroupInfo(slot0)
	slot3 = slot0.fightParam.layerId
	slot5 = slot0.fightParam.episodeId
	slot7, slot8, slot9, slot10, slot11 = nil

	if slot0:getTowerInfoById(slot0.fightParam.towerType, slot0.fightParam.towerId) then
		slot7, slot8, slot9 = slot6:isHeroGroupLock(slot3, slot5)
		slot10, slot11 = slot6:getBanHeroAndBoss(slot3, slot0.fightParam.difficulty, slot5)
	end

	slot0.fightParam.isHeroGroupLock = slot7
	slot0.fightParam.heros = slot8
	slot0.fightParam.herosDict = {}

	if slot8 then
		for slot15 = 1, #slot8 do
			slot0.fightParam.herosDict[slot8[slot15]] = 1
		end
	end

	slot0.fightParam.assistBoss = slot9
	slot0.fightParam.banHeroDict = slot10
	slot0.fightParam.banAssistBossDict = slot11
end

function slot0.getRecordFightParam(slot0)
	return slot0.fightParam
end

function slot0.updateMopUpTimes(slot0, slot1)
	slot0.mopUpTimes = slot1
end

function slot0.getMopUpTimes(slot0)
	return slot0.mopUpTimes
end

function slot0.resetTowerSubEpisode(slot0, slot1)
	slot4 = slot1.layerInfo
	slot5 = slot0:getTowerInfoById(slot1.towerType, slot1.towerId)

	slot5:resetLayerInfos(slot4)
	slot5:resetLayerScore(slot4)
	slot5:updateHistoryHighScore(slot1.historyHighScore)
end

function slot0.getTowerInfoList(slot0, slot1)
	if not slot0.towerInfoMap[slot1] then
		logError("towerInfoMap is Empty")

		return {}
	end

	if not slot0.towerInfoList[slot1] then
		slot0.towerInfoList[slot1] = {}

		for slot5, slot6 in pairs(slot0.towerInfoMap[slot1]) do
			table.insert(slot0.towerInfoList[slot1], slot6)
		end

		table.sort(slot0.towerInfoList[slot1], function (slot0, slot1)
			return slot0.towerId < slot1.towerId
		end)
	end

	return slot0.towerInfoList[slot1]
end

function slot0.getLocalPrefsTab(slot0, slot1, slot2)
	if not slot0.localPrefsDict[slot0:prefabKeyPrefs(slot1, slot2)] then
		slot4 = {}

		if GameUtil.splitString2(TowerController.instance:getPlayerPrefs(slot3), true) then
			for slot10, slot11 in ipairs(slot6) do
				slot4[slot11[1]] = slot11[2]
			end
		end

		slot0.localPrefsDict[slot3] = slot4
	end

	return slot0.localPrefsDict[slot3]
end

function slot0.getLocalPrefsState(slot0, slot1, slot2, slot3, slot4)
	return slot0:getLocalPrefsTab(slot1, slot3)[slot2] or slot4
end

function slot0.setLocalPrefsState(slot0, slot1, slot2, slot3, slot4)
	if slot0:getLocalPrefsTab(slot1, slot3)[slot2] == slot4 then
		return
	end

	slot5[slot2] = slot4
	slot6 = {}

	for slot10, slot11 in pairs(slot5) do
		table.insert(slot6, string.format("%s#%s", slot10, slot11))
	end

	TowerController.instance:setPlayerPrefs(slot0:prefabKeyPrefs(slot1, slot3), table.concat(slot6, "|"))
end

function slot0.prefabKeyPrefs(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		return slot1
	end

	slot3 = slot2.type
	slot4 = slot2.towerId
	slot5 = slot2.round

	if slot1 == TowerEnum.LocalPrefsKey.NewBossOpen then
		slot5 = 1
	end

	return string.format("Tower_%s_%s_%s_%s", slot1, slot3, slot4, slot5)
end

function slot0.hasNewBossOpen(slot0)
	slot1 = false

	for slot6, slot7 in ipairs(uv0.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)) do
		if uv0.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, slot7.towerId, slot7, TowerEnum.LockKey) == TowerEnum.LockKey and TowerEnum.UnlockKey == TowerEnum.UnlockKey then
			slot1 = true

			break
		end
	end

	return slot1
end

function slot0.isHeroLocked(slot0, slot1)
	return slot0:getRecordFightParam().herosDict and slot3[slot1] ~= nil
end

function slot0.isBossLocked(slot0, slot1)
	return slot0:getRecordFightParam().assistBoss == slot1
end

function slot0.isHeroBan(slot0, slot1)
	return slot0:getRecordFightParam().banHeroDict and slot3[slot1] ~= nil
end

function slot0.isBossBan(slot0, slot1)
	return slot0:getRecordFightParam().banAssistBossDict and slot3[slot1] ~= nil
end

function slot0.isLimitTowerBossBan(slot0, slot1, slot2, slot3)
	if slot1 == TowerEnum.TowerType.Limited then
		if TowerConfig.instance:getTowerLimitedTimeCo(slot2) then
			for slot9, slot10 in ipairs(string.splitToNumber(slot4.bossPool, "#")) do
				if slot10 == slot3 then
					return false
				end
			end
		end

		return true
	end
end

function slot0.isInTowerBattle(slot0)
	slot2 = HeroGroupModel.instance.episodeId and lua_episode.configDict[slot1]

	return slot0:isTowerEpisode(slot2 and slot2.type)
end

function slot0.isTowerEpisode(slot0, slot1)
	if not slot0._towerEpisodeTypeDefine then
		slot0._towerEpisodeTypeDefine = {
			[DungeonEnum.EpisodeType.TowerPermanent] = 1,
			[DungeonEnum.EpisodeType.TowerBoss] = 1,
			[DungeonEnum.EpisodeType.TowerLimited] = 1
		}
	end

	return slot0._towerEpisodeTypeDefine[slot1] ~= nil
end

function slot0.checkHasOpenStateTower(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getTowerOpenList(slot1)) do
		if slot7.status == TowerEnum.TowerStatus.Open then
			return true
		end
	end

	return false
end

function slot0.getFirstUnOpenTowerInfo(slot0, slot1)
	if not slot0:checkHasOpenStateTower(slot1) then
		slot2 = -1
		slot3 = nil

		for slot8, slot9 in ipairs(slot0:getTowerOpenList(slot1)) do
			if slot9.status == TowerEnum.TowerStatus.Ready then
				slot10 = slot9.nextTime

				if slot2 == -1 or slot10 < slot2 then
					slot2 = slot10
					slot3 = slot9
				end
			end
		end

		return slot3
	end
end

function slot0.isBossOpen(slot0, slot1)
	if not TowerConfig.instance:getAssistBossConfig(slot1) then
		return false
	end

	if not TowerConfig.instance:getBossTimeTowerConfig(slot2.towerId, 1) then
		return false
	end

	return TimeUtil.stringToTimestamp(string.format("%s 5:0:0", slot4.startTime)) <= ServerTime.now()
end

slot0.instance = slot0.New()

return slot0
