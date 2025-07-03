module("modules.logic.tower.model.TowerModel", package.seeall)

local var_0_0 = class("TowerModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearTowerData()

	arg_2_0.fightParam = {}
	arg_2_0.fightFinishParam = {}
	arg_2_0.localPrefsDict = {}
end

function var_0_0.clearTowerData(arg_3_0)
	arg_3_0.towerOpenMap = {}
	arg_3_0.towerOpenList = {}
	arg_3_0.towerInfoMap = {}
	arg_3_0.towerInfoList = {}
	arg_3_0.curTowerType = nil
end

function var_0_0.onReceiveTowerBattleFinishPush(arg_4_0, arg_4_1)
	arg_4_0.fightFinishParam.towerType = arg_4_1.type
	arg_4_0.fightFinishParam.towerId = arg_4_1.towerId
	arg_4_0.fightFinishParam.layerId = arg_4_1.layerId
	arg_4_0.fightFinishParam.difficulty = arg_4_1.difficulty
	arg_4_0.fightFinishParam.score = arg_4_1.score
	arg_4_0.fightFinishParam.bossLevel = arg_4_1.bossLevel
	arg_4_0.fightFinishParam.teamLevel = arg_4_1.teamLevel
	arg_4_0.fightFinishParam.layer = arg_4_1.layer
	arg_4_0.fightFinishParam.historyHighScore = arg_4_1.historyHighScore
end

function var_0_0.getFightFinishParam(arg_5_0)
	return arg_5_0.fightFinishParam
end

function var_0_0.clearFightFinishParam(arg_6_0)
	arg_6_0.fightFinishParam = {}
end

function var_0_0.onReceiveGetTowerInfoReply(arg_7_0, arg_7_1)
	arg_7_0:clearTowerData()
	TowerAssistBossModel.instance:clear()
	arg_7_0:setTowerOpenInfo(arg_7_1)
	arg_7_0:setTowerInfo(arg_7_1)
	arg_7_0:updateMopUpTimes(arg_7_1.mopUpTimes)
	arg_7_0:updateTrialHeroSeason(arg_7_1.trialHeroSeason)

	for iter_7_0 = 1, #arg_7_1.assistBosses do
		TowerAssistBossModel.instance:updateAssistBossInfo(arg_7_1.assistBosses[iter_7_0])
	end

	TowerPermanentModel.instance:InitData()
end

function var_0_0.setTowerOpenInfo(arg_8_0, arg_8_1)
	if #arg_8_1.towerOpens == 0 then
		logError("towerOpenInfo not exit")

		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.towerOpens) do
		local var_8_0 = iter_8_1.type
		local var_8_1 = iter_8_1.towerId
		local var_8_2 = iter_8_1.round
		local var_8_3 = arg_8_0.towerOpenMap[var_8_0]

		if not var_8_3 then
			var_8_3 = {}
			arg_8_0.towerOpenMap[var_8_0] = var_8_3
		end

		local var_8_4 = var_8_3[var_8_1]

		if not var_8_4 then
			var_8_4 = {}
			var_8_3[var_8_1] = var_8_4
		end

		local var_8_5 = var_8_4[var_8_2]

		if not var_8_5 then
			var_8_5 = TowerOpenMo.New()
			var_8_4[var_8_2] = var_8_5

			arg_8_0:addTowerOpenList(var_8_0, var_8_5)
		end

		var_8_5:updateInfo(iter_8_1)
	end
end

function var_0_0.addTowerOpenList(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.towerOpenList[arg_9_1] then
		arg_9_0.towerOpenList[arg_9_1] = {}
	end

	table.insert(arg_9_0.towerOpenList[arg_9_1], arg_9_2)
end

function var_0_0.getTowerOpenList(arg_10_0, arg_10_1)
	return arg_10_0.towerOpenList[arg_10_1] or {}
end

function var_0_0.getTowerOpenInfoByRound(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0.towerOpenMap[arg_11_1]
	local var_11_1 = var_11_0 and var_11_0[arg_11_2]

	if not var_11_1 then
		return
	end

	return var_11_1[arg_11_3]
end

function var_0_0.getTowerOpenInfo(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 == nil then
		arg_12_3 = TowerEnum.TowerStatus.Open
	end

	local var_12_0 = arg_12_0.towerOpenMap[arg_12_1]
	local var_12_1 = var_12_0 and var_12_0[arg_12_2]

	if not var_12_1 then
		return
	end

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		if iter_12_1.status == arg_12_3 then
			return iter_12_1
		end
	end
end

function var_0_0.setTowerInfo(arg_13_0, arg_13_1)
	if #arg_13_1.towers == 0 then
		logError("towerInfo not exit")

		return
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_1.towers) do
		local var_13_0 = iter_13_1.type
		local var_13_1 = iter_13_1.towerId
		local var_13_2 = arg_13_0.towerInfoMap[var_13_0]

		if not var_13_2 then
			var_13_2 = {}
			arg_13_0.towerInfoMap[var_13_0] = var_13_2
		end

		if not var_13_2[var_13_1] then
			local var_13_3 = TowerMo.New()

			var_13_2[var_13_1] = var_13_3

			arg_13_0:addTowerInfoList(var_13_0, var_13_3)
		end

		arg_13_0.towerInfoMap[var_13_0][var_13_1]:updateInfo(iter_13_1)
	end
end

function var_0_0.addTowerInfoList(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0.towerInfoList[arg_14_1] then
		arg_14_0.towerInfoList[arg_14_1] = {}
	end

	table.insert(arg_14_0.towerInfoList[arg_14_1], arg_14_2)
end

function var_0_0.getTowerInfoList(arg_15_0, arg_15_1)
	return arg_15_0.towerInfoList[arg_15_1]
end

function var_0_0.getTowerInfoById(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0.towerInfoMap[arg_16_1] then
		return
	end

	return arg_16_0.towerInfoMap[arg_16_1][arg_16_2]
end

function var_0_0.getTowerListByStatus(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 == nil then
		arg_17_2 = TowerEnum.TowerStatus.Open
	end

	local var_17_0 = arg_17_0:getTowerOpenList(arg_17_1)
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		if iter_17_1.status == arg_17_2 then
			table.insert(var_17_1, iter_17_1)
		end
	end

	return var_17_1
end

function var_0_0.getCurPermanentMo(arg_18_0)
	local var_18_0 = TowerEnum.TowerType.Normal

	if arg_18_0.towerInfoMap[var_18_0] then
		return arg_18_0.towerInfoMap[var_18_0][TowerEnum.PermanentTowerId]
	else
		logError("towerInfoMap is Empty")
	end
end

function var_0_0.initEpisodes(arg_19_0)
	if arg_19_0.towerEpisodeMap then
		return
	end

	arg_19_0.towerEpisodeMap = {}

	arg_19_0:_initEpisode(TowerEnum.TowerType.Boss, TowerConfig.instance.bossTowerEpisodeConfig)
end

function var_0_0._initEpisode(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = TowerEpisodeMo.New()

	var_20_0:init(arg_20_1, arg_20_2)

	arg_20_0.towerEpisodeMap[arg_20_1] = var_20_0
end

function var_0_0.getEpisodeMoByTowerType(arg_21_0, arg_21_1)
	arg_21_0:initEpisodes()

	return arg_21_0.towerEpisodeMap[arg_21_1]
end

function var_0_0.setRecordFightParam(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	arg_22_0.fightParam.towerType = arg_22_1
	arg_22_0.fightParam.towerId = arg_22_2
	arg_22_0.fightParam.layerId = arg_22_3
	arg_22_0.fightParam.difficulty = arg_22_4
	arg_22_0.fightParam.episodeId = arg_22_5

	arg_22_0:refreshHeroGroupInfo()
end

function var_0_0.refreshHeroGroupInfo(arg_23_0)
	local var_23_0 = arg_23_0.fightParam.towerType
	local var_23_1 = arg_23_0.fightParam.towerId
	local var_23_2 = arg_23_0.fightParam.layerId
	local var_23_3 = arg_23_0.fightParam.difficulty
	local var_23_4 = arg_23_0.fightParam.episodeId
	local var_23_5 = arg_23_0:getTowerInfoById(var_23_0, var_23_1)
	local var_23_6
	local var_23_7
	local var_23_8
	local var_23_9
	local var_23_10
	local var_23_11
	local var_23_12
	local var_23_13

	if var_23_5 then
		local var_23_14, var_23_15 = var_23_5:isHeroGroupLock(var_23_2, var_23_4)

		var_23_6 = var_23_14

		if var_23_15 then
			var_23_7 = var_23_15.heroIds
			var_23_8 = var_23_15.assistBossId
			var_23_9 = var_23_15.equipUids
			var_23_13 = var_23_15.trialHeroIds
		end

		var_23_10, var_23_11, var_23_12 = var_23_5:getBanHeroAndBoss(var_23_2, var_23_3, var_23_4)
	end

	arg_23_0.fightParam.isHeroGroupLock = var_23_6
	arg_23_0.fightParam.heros = var_23_7
	arg_23_0.fightParam.equipUids = var_23_9
	arg_23_0.fightParam.trialHeros = var_23_13
	arg_23_0.fightParam.herosDict = {}

	if var_23_7 then
		for iter_23_0 = 1, #var_23_7 do
			arg_23_0.fightParam.herosDict[var_23_7[iter_23_0]] = 1
		end
	end

	arg_23_0.fightParam.assistBoss = var_23_8
	arg_23_0.fightParam.banHeroDict = var_23_10
	arg_23_0.fightParam.banAssistBossDict = var_23_11
	arg_23_0.fightParam.banTrialDict = var_23_12
end

function var_0_0.getRecordFightParam(arg_24_0)
	return arg_24_0.fightParam
end

function var_0_0.updateMopUpTimes(arg_25_0, arg_25_1)
	arg_25_0.mopUpTimes = arg_25_1
end

function var_0_0.getMopUpTimes(arg_26_0)
	return arg_26_0.mopUpTimes
end

function var_0_0.updateTrialHeroSeason(arg_27_0, arg_27_1)
	arg_27_0.trialHeroSeason = arg_27_1
end

function var_0_0.getTrialHeroSeason(arg_28_0)
	return arg_28_0.trialHeroSeason
end

function var_0_0.resetTowerSubEpisode(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.towerType
	local var_29_1 = arg_29_1.towerId
	local var_29_2 = arg_29_1.layerInfo
	local var_29_3 = arg_29_0:getTowerInfoById(var_29_0, var_29_1)

	var_29_3:resetLayerInfos(var_29_2)
	var_29_3:resetLayerScore(var_29_2)
	var_29_3:updateHistoryHighScore(arg_29_1.historyHighScore)
end

function var_0_0.getTowerInfoList(arg_30_0, arg_30_1)
	if not arg_30_0.towerInfoMap[arg_30_1] then
		logError("towerInfoMap is Empty")

		return {}
	end

	if not arg_30_0.towerInfoList[arg_30_1] then
		arg_30_0.towerInfoList[arg_30_1] = {}

		for iter_30_0, iter_30_1 in pairs(arg_30_0.towerInfoMap[arg_30_1]) do
			table.insert(arg_30_0.towerInfoList[arg_30_1], iter_30_1)
		end

		table.sort(arg_30_0.towerInfoList[arg_30_1], function(arg_31_0, arg_31_1)
			return arg_31_0.towerId < arg_31_1.towerId
		end)
	end

	return arg_30_0.towerInfoList[arg_30_1]
end

function var_0_0.getLocalPrefsTab(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:prefabKeyPrefs(arg_32_1, arg_32_2)

	if not arg_32_0.localPrefsDict[var_32_0] then
		local var_32_1 = {}
		local var_32_2 = TowerController.instance:getPlayerPrefs(var_32_0)
		local var_32_3 = GameUtil.splitString2(var_32_2, true)

		if var_32_3 then
			for iter_32_0, iter_32_1 in ipairs(var_32_3) do
				var_32_1[iter_32_1[1]] = iter_32_1[2]
			end
		end

		arg_32_0.localPrefsDict[var_32_0] = var_32_1
	end

	return arg_32_0.localPrefsDict[var_32_0]
end

function var_0_0.getLocalPrefsState(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	return arg_33_0:getLocalPrefsTab(arg_33_1, arg_33_3)[arg_33_2] or arg_33_4
end

function var_0_0.setLocalPrefsState(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = arg_34_0:getLocalPrefsTab(arg_34_1, arg_34_3)

	if var_34_0[arg_34_2] == arg_34_4 then
		return
	end

	var_34_0[arg_34_2] = arg_34_4

	local var_34_1 = {}

	for iter_34_0, iter_34_1 in pairs(var_34_0) do
		table.insert(var_34_1, string.format("%s#%s", iter_34_0, iter_34_1))
	end

	local var_34_2 = table.concat(var_34_1, "|")
	local var_34_3 = arg_34_0:prefabKeyPrefs(arg_34_1, arg_34_3)

	TowerController.instance:setPlayerPrefs(var_34_3, var_34_2)
end

function var_0_0.prefabKeyPrefs(arg_35_0, arg_35_1, arg_35_2)
	if string.nilorempty(arg_35_1) then
		return arg_35_1
	end

	local var_35_0 = arg_35_2.type
	local var_35_1 = arg_35_2.towerId
	local var_35_2 = arg_35_2.round

	if arg_35_1 == TowerEnum.LocalPrefsKey.NewBossOpen then
		var_35_2 = 1
	end

	return (string.format("Tower_%s_%s_%s_%s", arg_35_1, var_35_0, var_35_1, var_35_2))
end

function var_0_0.hasNewBossOpen(arg_36_0)
	local var_36_0 = false
	local var_36_1 = var_0_0.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	for iter_36_0, iter_36_1 in ipairs(var_36_1) do
		local var_36_2 = var_0_0.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, iter_36_1.towerId, iter_36_1, TowerEnum.LockKey)
		local var_36_3 = TowerEnum.UnlockKey

		if var_36_2 == TowerEnum.LockKey and var_36_3 == TowerEnum.UnlockKey then
			var_36_0 = true

			break
		end
	end

	return var_36_0
end

function var_0_0.isHeroLocked(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:getRecordFightParam().herosDict

	return var_37_0 and var_37_0[arg_37_1] ~= nil
end

function var_0_0.isBossLocked(arg_38_0, arg_38_1)
	return arg_38_0:getRecordFightParam().assistBoss == arg_38_1
end

function var_0_0.isHeroBan(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:getRecordFightParam().banHeroDict

	return var_39_0 and var_39_0[arg_39_1] ~= nil
end

function var_0_0.isBossBan(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getRecordFightParam().banAssistBossDict

	return var_40_0 and var_40_0[arg_40_1] ~= nil
end

function var_0_0.isTrialHeroBan(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:getRecordFightParam().banTrialDict

	return var_41_0 and var_41_0[arg_41_1] ~= nil
end

function var_0_0.isLimitTowerBossBan(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	if arg_42_1 == TowerEnum.TowerType.Limited then
		local var_42_0 = TowerConfig.instance:getTowerLimitedTimeCo(arg_42_2)

		if var_42_0 then
			local var_42_1 = string.splitToNumber(var_42_0.bossPool, "#")

			for iter_42_0, iter_42_1 in ipairs(var_42_1) do
				if iter_42_1 == arg_42_3 then
					return false
				end
			end
		end

		return true
	end
end

function var_0_0.isInTowerBattle(arg_43_0)
	local var_43_0 = HeroGroupModel.instance.episodeId
	local var_43_1 = var_43_0 and lua_episode.configDict[var_43_0]
	local var_43_2 = var_43_1 and var_43_1.type

	return arg_43_0:isTowerEpisode(var_43_2)
end

function var_0_0.isTowerEpisode(arg_44_0, arg_44_1)
	if not arg_44_0._towerEpisodeTypeDefine then
		arg_44_0._towerEpisodeTypeDefine = {
			[DungeonEnum.EpisodeType.TowerPermanent] = 1,
			[DungeonEnum.EpisodeType.TowerBoss] = 1,
			[DungeonEnum.EpisodeType.TowerLimited] = 1,
			[DungeonEnum.EpisodeType.TowerBossTeach] = 1
		}
	end

	return arg_44_0._towerEpisodeTypeDefine[arg_44_1] ~= nil
end

function var_0_0.checkHasOpenStateTower(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0:getTowerOpenList(arg_45_1)

	for iter_45_0, iter_45_1 in ipairs(var_45_0) do
		if iter_45_1.status == TowerEnum.TowerStatus.Open then
			return true
		end
	end

	return false
end

function var_0_0.getFirstUnOpenTowerInfo(arg_46_0, arg_46_1)
	if not arg_46_0:checkHasOpenStateTower(arg_46_1) then
		local var_46_0 = -1
		local var_46_1
		local var_46_2 = arg_46_0:getTowerOpenList(arg_46_1)

		for iter_46_0, iter_46_1 in ipairs(var_46_2) do
			if iter_46_1.status == TowerEnum.TowerStatus.Ready then
				local var_46_3 = iter_46_1.nextTime

				if var_46_0 == -1 or var_46_3 < var_46_0 then
					var_46_0 = var_46_3
					var_46_1 = iter_46_1
				end
			end
		end

		return var_46_1
	end
end

function var_0_0.isBossOpen(arg_47_0, arg_47_1)
	local var_47_0 = TowerConfig.instance:getAssistBossConfig(arg_47_1)

	if not var_47_0 then
		return false
	end

	local var_47_1 = var_47_0.towerId
	local var_47_2 = TowerConfig.instance:getBossTimeTowerConfig(var_47_1, 1)

	if not var_47_2 then
		return false
	end

	local var_47_3 = string.format("%s 5:0:0", var_47_2.startTime)

	return TimeUtil.stringToTimestamp(var_47_3) <= ServerTime.now()
end

function var_0_0.setCurTowerType(arg_48_0, arg_48_1)
	arg_48_0.curTowerType = arg_48_1
end

function var_0_0.getCurTowerType(arg_49_0)
	return arg_49_0.curTowerType
end

function var_0_0.cleanTrialData(arg_50_0)
	TowerAssistBossModel.instance:cleanTrialLevel()
	arg_50_0:setCurTowerType(nil)
end

var_0_0.instance = var_0_0.New()

return var_0_0
