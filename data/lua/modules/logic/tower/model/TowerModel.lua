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

	if var_23_5 then
		var_23_6, var_23_7, var_23_8 = var_23_5:isHeroGroupLock(var_23_2, var_23_4)
		var_23_9, var_23_10 = var_23_5:getBanHeroAndBoss(var_23_2, var_23_3, var_23_4)
	end

	arg_23_0.fightParam.isHeroGroupLock = var_23_6
	arg_23_0.fightParam.heros = var_23_7
	arg_23_0.fightParam.herosDict = {}

	if var_23_7 then
		for iter_23_0 = 1, #var_23_7 do
			arg_23_0.fightParam.herosDict[var_23_7[iter_23_0]] = 1
		end
	end

	arg_23_0.fightParam.assistBoss = var_23_8
	arg_23_0.fightParam.banHeroDict = var_23_9
	arg_23_0.fightParam.banAssistBossDict = var_23_10
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

function var_0_0.resetTowerSubEpisode(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1.towerType
	local var_27_1 = arg_27_1.towerId
	local var_27_2 = arg_27_1.layerInfo
	local var_27_3 = arg_27_0:getTowerInfoById(var_27_0, var_27_1)

	var_27_3:resetLayerInfos(var_27_2)
	var_27_3:resetLayerScore(var_27_2)
	var_27_3:updateHistoryHighScore(arg_27_1.historyHighScore)
end

function var_0_0.getTowerInfoList(arg_28_0, arg_28_1)
	if not arg_28_0.towerInfoMap[arg_28_1] then
		logError("towerInfoMap is Empty")

		return {}
	end

	if not arg_28_0.towerInfoList[arg_28_1] then
		arg_28_0.towerInfoList[arg_28_1] = {}

		for iter_28_0, iter_28_1 in pairs(arg_28_0.towerInfoMap[arg_28_1]) do
			table.insert(arg_28_0.towerInfoList[arg_28_1], iter_28_1)
		end

		table.sort(arg_28_0.towerInfoList[arg_28_1], function(arg_29_0, arg_29_1)
			return arg_29_0.towerId < arg_29_1.towerId
		end)
	end

	return arg_28_0.towerInfoList[arg_28_1]
end

function var_0_0.getLocalPrefsTab(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0:prefabKeyPrefs(arg_30_1, arg_30_2)

	if not arg_30_0.localPrefsDict[var_30_0] then
		local var_30_1 = {}
		local var_30_2 = TowerController.instance:getPlayerPrefs(var_30_0)
		local var_30_3 = GameUtil.splitString2(var_30_2, true)

		if var_30_3 then
			for iter_30_0, iter_30_1 in ipairs(var_30_3) do
				var_30_1[iter_30_1[1]] = iter_30_1[2]
			end
		end

		arg_30_0.localPrefsDict[var_30_0] = var_30_1
	end

	return arg_30_0.localPrefsDict[var_30_0]
end

function var_0_0.getLocalPrefsState(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	return arg_31_0:getLocalPrefsTab(arg_31_1, arg_31_3)[arg_31_2] or arg_31_4
end

function var_0_0.setLocalPrefsState(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	local var_32_0 = arg_32_0:getLocalPrefsTab(arg_32_1, arg_32_3)

	if var_32_0[arg_32_2] == arg_32_4 then
		return
	end

	var_32_0[arg_32_2] = arg_32_4

	local var_32_1 = {}

	for iter_32_0, iter_32_1 in pairs(var_32_0) do
		table.insert(var_32_1, string.format("%s#%s", iter_32_0, iter_32_1))
	end

	local var_32_2 = table.concat(var_32_1, "|")
	local var_32_3 = arg_32_0:prefabKeyPrefs(arg_32_1, arg_32_3)

	TowerController.instance:setPlayerPrefs(var_32_3, var_32_2)
end

function var_0_0.prefabKeyPrefs(arg_33_0, arg_33_1, arg_33_2)
	if string.nilorempty(arg_33_1) then
		return arg_33_1
	end

	local var_33_0 = arg_33_2.type
	local var_33_1 = arg_33_2.towerId
	local var_33_2 = arg_33_2.round

	if arg_33_1 == TowerEnum.LocalPrefsKey.NewBossOpen then
		var_33_2 = 1
	end

	return (string.format("Tower_%s_%s_%s_%s", arg_33_1, var_33_0, var_33_1, var_33_2))
end

function var_0_0.hasNewBossOpen(arg_34_0)
	local var_34_0 = false
	local var_34_1 = var_0_0.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	for iter_34_0, iter_34_1 in ipairs(var_34_1) do
		local var_34_2 = var_0_0.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, iter_34_1.towerId, iter_34_1, TowerEnum.LockKey)
		local var_34_3 = TowerEnum.UnlockKey

		if var_34_2 == TowerEnum.LockKey and var_34_3 == TowerEnum.UnlockKey then
			var_34_0 = true

			break
		end
	end

	return var_34_0
end

function var_0_0.isHeroLocked(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getRecordFightParam().herosDict

	return var_35_0 and var_35_0[arg_35_1] ~= nil
end

function var_0_0.isBossLocked(arg_36_0, arg_36_1)
	return arg_36_0:getRecordFightParam().assistBoss == arg_36_1
end

function var_0_0.isHeroBan(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:getRecordFightParam().banHeroDict

	return var_37_0 and var_37_0[arg_37_1] ~= nil
end

function var_0_0.isBossBan(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:getRecordFightParam().banAssistBossDict

	return var_38_0 and var_38_0[arg_38_1] ~= nil
end

function var_0_0.isLimitTowerBossBan(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if arg_39_1 == TowerEnum.TowerType.Limited then
		local var_39_0 = TowerConfig.instance:getTowerLimitedTimeCo(arg_39_2)

		if var_39_0 then
			local var_39_1 = string.splitToNumber(var_39_0.bossPool, "#")

			for iter_39_0, iter_39_1 in ipairs(var_39_1) do
				if iter_39_1 == arg_39_3 then
					return false
				end
			end
		end

		return true
	end
end

function var_0_0.isInTowerBattle(arg_40_0)
	local var_40_0 = HeroGroupModel.instance.episodeId
	local var_40_1 = var_40_0 and lua_episode.configDict[var_40_0]
	local var_40_2 = var_40_1 and var_40_1.type

	return arg_40_0:isTowerEpisode(var_40_2)
end

function var_0_0.isTowerEpisode(arg_41_0, arg_41_1)
	if not arg_41_0._towerEpisodeTypeDefine then
		arg_41_0._towerEpisodeTypeDefine = {
			[DungeonEnum.EpisodeType.TowerPermanent] = 1,
			[DungeonEnum.EpisodeType.TowerBoss] = 1,
			[DungeonEnum.EpisodeType.TowerLimited] = 1
		}
	end

	return arg_41_0._towerEpisodeTypeDefine[arg_41_1] ~= nil
end

function var_0_0.checkHasOpenStateTower(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0:getTowerOpenList(arg_42_1)

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if iter_42_1.status == TowerEnum.TowerStatus.Open then
			return true
		end
	end

	return false
end

function var_0_0.getFirstUnOpenTowerInfo(arg_43_0, arg_43_1)
	if not arg_43_0:checkHasOpenStateTower(arg_43_1) then
		local var_43_0 = -1
		local var_43_1
		local var_43_2 = arg_43_0:getTowerOpenList(arg_43_1)

		for iter_43_0, iter_43_1 in ipairs(var_43_2) do
			if iter_43_1.status == TowerEnum.TowerStatus.Ready then
				local var_43_3 = iter_43_1.nextTime

				if var_43_0 == -1 or var_43_3 < var_43_0 then
					var_43_0 = var_43_3
					var_43_1 = iter_43_1
				end
			end
		end

		return var_43_1
	end
end

function var_0_0.isBossOpen(arg_44_0, arg_44_1)
	local var_44_0 = TowerConfig.instance:getAssistBossConfig(arg_44_1)

	if not var_44_0 then
		return false
	end

	local var_44_1 = var_44_0.towerId
	local var_44_2 = TowerConfig.instance:getBossTimeTowerConfig(var_44_1, 1)

	if not var_44_2 then
		return false
	end

	local var_44_3 = string.format("%s 5:0:0", var_44_2.startTime)

	return TimeUtil.stringToTimestamp(var_44_3) <= ServerTime.now()
end

var_0_0.instance = var_0_0.New()

return var_0_0
