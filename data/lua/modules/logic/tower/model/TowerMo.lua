module("modules.logic.tower.model.TowerMo", package.seeall)

local var_0_0 = pureTable("TowerMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.type = arg_2_1.type
	arg_2_0.towerId = arg_2_1.towerId
	arg_2_0.passLayerId = arg_2_1.passLayerId

	arg_2_0:updateLayerInfos(arg_2_1.layerNOs)
	arg_2_0:updateLayerScore(arg_2_1.layerNOs)
	arg_2_0:updateHistoryHighScore(arg_2_1.historyHighScore)
	arg_2_0:updateOpenSpLayer(arg_2_1.openSpLayerIds)
	arg_2_0:updatePassBossTeachIds(arg_2_1.passTeachIds)
end

function var_0_0.updatePassBossTeachIds(arg_3_0, arg_3_1)
	arg_3_0.passBossTeachDict = {}

	if arg_3_1 then
		for iter_3_0 = 1, #arg_3_1 do
			arg_3_0.passBossTeachDict[arg_3_1[iter_3_0]] = 1
		end
	end
end

function var_0_0.isPassBossTeach(arg_4_0, arg_4_1)
	return arg_4_0.passBossTeachDict[arg_4_1] == 1
end

function var_0_0.updateOpenSpLayer(arg_5_0, arg_5_1)
	arg_5_0.openSpLayerDict = {}

	if arg_5_1 then
		for iter_5_0 = 1, #arg_5_1 do
			arg_5_0.openSpLayerDict[arg_5_1[iter_5_0]] = 1
		end
	end
end

function var_0_0.isSpLayerOpen(arg_6_0, arg_6_1)
	return arg_6_0.openSpLayerDict[arg_6_1] ~= nil
end

function var_0_0.hasNewSpLayer(arg_7_0, arg_7_1)
	local var_7_0 = false

	for iter_7_0, iter_7_1 in pairs(arg_7_0.openSpLayerDict) do
		if TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossSpOpen, arg_7_0.towerId, arg_7_1, TowerEnum.LockKey) == TowerEnum.LockKey then
			var_7_0 = true

			break
		end
	end

	return var_7_0
end

function var_0_0.clearSpLayerNewTag(arg_8_0, arg_8_1)
	local var_8_0 = false

	for iter_8_0, iter_8_1 in pairs(arg_8_0.openSpLayerDict) do
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossSpOpen, arg_8_0.towerId, arg_8_1, TowerEnum.UnlockKey)
	end

	return var_8_0
end

function var_0_0.isLayerUnlock(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 == nil then
		arg_9_2 = TowerModel.instance:getEpisodeMoByTowerType(arg_9_0.type)
	end

	if not arg_9_2 then
		return false
	end

	local var_9_0 = arg_9_2:getEpisodeConfig(arg_9_0.towerId, arg_9_1)

	if not var_9_0 then
		return false
	end

	return arg_9_0:isLayerPass(var_9_0.preLayerId, arg_9_2)
end

function var_0_0.isLayerPass(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == nil then
		arg_10_2 = TowerModel.instance:getEpisodeMoByTowerType(arg_10_0.type)
	end

	if not arg_10_2 then
		return false
	end

	return arg_10_2:getEpisodeIndex(arg_10_0.towerId, arg_10_1, true) <= arg_10_2:getEpisodeIndex(arg_10_0.towerId, arg_10_0.passLayerId, true)
end

function var_0_0.updateLayerInfos(arg_11_0, arg_11_1)
	arg_11_0.layerSubEpisodeMap = arg_11_0.layerSubEpisodeMap or {}

	if arg_11_1 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			local var_11_0 = {}

			for iter_11_2 = 1, #iter_11_1.episodeNOs do
				local var_11_1 = TowerSubEpisodeMo.New()

				var_11_1:updateInfo(iter_11_1.episodeNOs[iter_11_2])
				table.insert(var_11_0, var_11_1)
			end

			arg_11_0.layerSubEpisodeMap[iter_11_1.layerId] = var_11_0
		end
	end
end

function var_0_0.resetLayerInfos(arg_12_0, arg_12_1)
	local var_12_0 = {}

	for iter_12_0 = 1, #arg_12_1.episodeNOs do
		local var_12_1 = TowerSubEpisodeMo.New()

		var_12_1:updateInfo(arg_12_1.episodeNOs[iter_12_0])
		table.insert(var_12_0, var_12_1)
	end

	arg_12_0.layerSubEpisodeMap[arg_12_1.layerId] = var_12_0
end

function var_0_0.resetLayerScore(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0.layerScoreMap[arg_13_1.layerId] = arg_13_1.currHighScore
	end
end

function var_0_0.updateHistoryHighScore(arg_14_0, arg_14_1)
	arg_14_0.historyHighScore = arg_14_1
end

function var_0_0.getHistoryHighScore(arg_15_0)
	return arg_15_0.historyHighScore or 0
end

function var_0_0.updateLayerScore(arg_16_0, arg_16_1)
	arg_16_0.layerScoreMap = {}

	if arg_16_1 then
		for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
			arg_16_0.layerScoreMap[iter_16_1.layerId] = iter_16_1.currHighScore
		end
	end
end

function var_0_0.getLayerScore(arg_17_0, arg_17_1)
	return arg_17_0.layerScoreMap[arg_17_1] or 0
end

function var_0_0.getLayerSubEpisodeList(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0.layerSubEpisodeMap[arg_18_1] and not arg_18_2 then
		logError("该层没有子关卡信息：" .. arg_18_1)
	end

	return arg_18_0.layerSubEpisodeMap[arg_18_1]
end

function var_0_0.getSubEpisodeMoByEpisodeId(arg_19_0, arg_19_1)
	arg_19_0.layerSubEpisodeMap = arg_19_0.layerSubEpisodeMap or {}

	for iter_19_0, iter_19_1 in pairs(arg_19_0.layerSubEpisodeMap) do
		for iter_19_2, iter_19_3 in ipairs(iter_19_1) do
			if iter_19_3.episodeId == arg_19_1 then
				return iter_19_3, iter_19_0
			end
		end
	end
end

function var_0_0.getSubEpisodePassCount(arg_20_0, arg_20_1)
	local var_20_0 = 0
	local var_20_1 = arg_20_0:getLayerSubEpisodeList(arg_20_1, true) or {}

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		if iter_20_1.status == TowerEnum.PassEpisodeState.Pass then
			var_20_0 = var_20_0 + 1
		end
	end

	return var_20_0
end

function var_0_0.getTaskGroupId(arg_21_0)
	local var_21_0 = TowerModel.instance:getTowerOpenInfo(arg_21_0.type, arg_21_0.towerId)

	if var_21_0 == nil then
		return
	end

	local var_21_1 = TowerConfig.instance:getBossTimeTowerConfig(arg_21_0.towerId, var_21_0.round)

	return var_21_1 and var_21_1.taskGroupId
end

function var_0_0.getBanHeroAndBoss(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_0.type == TowerEnum.TowerType.Boss then
		return
	end

	local var_22_0 = {}
	local var_22_1 = {}
	local var_22_2 = {}
	local var_22_3 = arg_22_0:getLayerSubEpisodeList(arg_22_1, true)

	if not var_22_3 then
		return var_22_0, var_22_1, var_22_2
	end

	if arg_22_0.type == TowerEnum.TowerType.Normal then
		local var_22_4 = TowerConfig.instance:getPermanentEpisodeCo(arg_22_1)

		if var_22_4 and var_22_4.isElite == 1 then
			for iter_22_0, iter_22_1 in pairs(var_22_3) do
				iter_22_1:getHeros(var_22_0)
				iter_22_1:getAssistBossId(var_22_1)
				iter_22_1:getTrialHeros(var_22_2)
			end
		end
	else
		local var_22_5 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

		if var_22_5 then
			for iter_22_2 = 1, 3 do
				local var_22_6 = TowerConfig.instance:getTowerLimitedTimeCoList(var_22_5.towerId, iter_22_2)

				if var_22_6 then
					for iter_22_3, iter_22_4 in pairs(var_22_6) do
						local var_22_7 = arg_22_0:getLayerSubEpisodeList(iter_22_4.layerId, true)

						if var_22_7 then
							for iter_22_5, iter_22_6 in pairs(var_22_7) do
								iter_22_6:getHeros(var_22_0)
								iter_22_6:getAssistBossId(var_22_1)
								iter_22_6:getTrialHeros(var_22_2)
							end
						end
					end
				end
			end
		end
	end

	return var_22_0, var_22_1, var_22_2
end

function var_0_0.getBanAssistBosss(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getLayerSubEpisodeList(arg_23_1, true)
	local var_23_1 = {}

	if var_23_0 then
		for iter_23_0, iter_23_1 in pairs(var_23_0) do
			iter_23_1:getAssistBossId(var_23_1)
		end
	end

	return var_23_1
end

function var_0_0.isHeroGroupLock(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.type == TowerEnum.TowerType.Boss then
		return false
	end

	local var_24_0 = arg_24_0:getLayerSubEpisodeList(arg_24_1, true)

	if arg_24_0.type == TowerEnum.TowerType.Normal then
		local var_24_1 = TowerConfig.instance:getPermanentEpisodeCo(arg_24_1)

		if var_24_1 and var_24_1.isElite ~= 1 then
			return false
		end

		if var_24_0 then
			for iter_24_0, iter_24_1 in pairs(var_24_0) do
				if iter_24_1.episodeId == arg_24_2 then
					if iter_24_1.status == 1 then
						return true, iter_24_1
					else
						return false
					end
				end
			end
		end

		return false
	end

	if var_24_0 then
		for iter_24_2, iter_24_3 in pairs(var_24_0) do
			if iter_24_3.status == 1 then
				return true, iter_24_3
			end
		end
	end

	return false
end

return var_0_0
