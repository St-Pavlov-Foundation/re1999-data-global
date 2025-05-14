module("modules.logic.tower.model.TowerTimeLimitLevelModel", package.seeall)

local var_0_0 = class("TowerTimeLimitLevelModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()

	arg_1_0.entranceDifficultyMap = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.curSelectEntrance = 0
end

function var_0_0.cleanData(arg_3_0)
	arg_3_0:reInit()
end

function var_0_0.initDifficultyMulti(arg_4_0)
	arg_4_0.difficultyMultiMap = {}

	local var_4_0 = {
		TowerEnum.ConstId.TimeLimitEasyMulti,
		TowerEnum.ConstId.TimeLimitNormalMulti,
		TowerEnum.ConstId.TimeLimitHardMulti
	}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_1 = TowerConfig.instance:getTowerConstConfig(iter_4_1)

		arg_4_0.difficultyMultiMap[iter_4_0] = var_4_1
	end
end

function var_0_0.getDifficultyMulti(arg_5_0, arg_5_1)
	return arg_5_0.difficultyMultiMap[arg_5_1]
end

function var_0_0.setCurSelectEntrance(arg_6_0, arg_6_1)
	arg_6_0.curSelectEntrance = arg_6_1
end

function var_0_0.getCurOpenTimeLimitTower(arg_7_0)
	local var_7_0 = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Limited) or {}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1.status == TowerEnum.TowerStatus.Open then
			return iter_7_1
		end
	end
end

function var_0_0.getEntranceBossUsedMap(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, arg_8_1)

	for iter_8_0 = 1, 3 do
		local var_8_2 = TowerConfig.instance:getTowerLimitedTimeCoList(arg_8_1, iter_8_0)[1].layerId
		local var_8_3 = var_8_1:getLayerSubEpisodeList(var_8_2)

		var_8_0[iter_8_0] = var_8_3 and var_8_3[1].assistBossId or 0
	end

	return var_8_0
end

function var_0_0.localSaveKey(arg_9_0)
	return TowerEnum.LocalPrefsKey.LastEntranceDifficulty
end

function var_0_0.initEntranceDifficulty(arg_10_0, arg_10_1)
	for iter_10_0 = 1, 3 do
		arg_10_0.entranceDifficultyMap[iter_10_0] = arg_10_0:getLastEntranceDifficulty(iter_10_0, arg_10_1)
	end
end

function var_0_0.getEntranceDifficulty(arg_11_0, arg_11_1)
	return arg_11_0.entranceDifficultyMap[arg_11_1]
end

function var_0_0.setEntranceDifficulty(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.entranceDifficultyMap[arg_12_1] = arg_12_2
end

function var_0_0.getLastEntranceDifficulty(arg_13_0, arg_13_1, arg_13_2)
	return TowerModel.instance:getLocalPrefsState(arg_13_0:localSaveKey(), arg_13_1, arg_13_2, TowerEnum.Difficulty.Easy)
end

function var_0_0.saveLastEntranceDifficulty(arg_14_0, arg_14_1)
	for iter_14_0 = 1, 3 do
		local var_14_0 = arg_14_0.entranceDifficultyMap[iter_14_0]

		TowerModel.instance:setLocalPrefsState(arg_14_0:localSaveKey(), iter_14_0, arg_14_1, var_14_0)
	end
end

function var_0_0.getHistoryHighScore(arg_15_0)
	local var_15_0 = arg_15_0:getCurOpenTimeLimitTower()

	if not var_15_0 then
		return 0
	end

	local var_15_1 = var_15_0 and var_15_0.towerId or 1

	return TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, var_15_1):getHistoryHighScore()
end

var_0_0.instance = var_0_0.New()

return var_0_0
