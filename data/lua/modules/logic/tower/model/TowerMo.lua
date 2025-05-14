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
end

function var_0_0.updateOpenSpLayer(arg_3_0, arg_3_1)
	arg_3_0.openSpLayerDict = {}

	if arg_3_1 then
		for iter_3_0 = 1, #arg_3_1 do
			arg_3_0.openSpLayerDict[arg_3_1[iter_3_0]] = 1
		end
	end
end

function var_0_0.isSpLayerOpen(arg_4_0, arg_4_1)
	return arg_4_0.openSpLayerDict[arg_4_1] ~= nil
end

function var_0_0.hasNewSpLayer(arg_5_0, arg_5_1)
	local var_5_0 = false

	for iter_5_0, iter_5_1 in pairs(arg_5_0.openSpLayerDict) do
		if TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossSpOpen, arg_5_0.towerId, arg_5_1, TowerEnum.LockKey) == TowerEnum.LockKey then
			var_5_0 = true

			break
		end
	end

	return var_5_0
end

function var_0_0.clearSpLayerNewTag(arg_6_0, arg_6_1)
	local var_6_0 = false

	for iter_6_0, iter_6_1 in pairs(arg_6_0.openSpLayerDict) do
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossSpOpen, arg_6_0.towerId, arg_6_1, TowerEnum.UnlockKey)
	end

	return var_6_0
end

function var_0_0.isLayerUnlock(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 == nil then
		arg_7_2 = TowerModel.instance:getEpisodeMoByTowerType(arg_7_0.type)
	end

	if not arg_7_2 then
		return false
	end

	local var_7_0 = arg_7_2:getEpisodeConfig(arg_7_0.towerId, arg_7_1)

	if not var_7_0 then
		return false
	end

	return arg_7_0:isLayerPass(var_7_0.preLayerId, arg_7_2)
end

function var_0_0.isLayerPass(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 == nil then
		arg_8_2 = TowerModel.instance:getEpisodeMoByTowerType(arg_8_0.type)
	end

	if not arg_8_2 then
		return false
	end

	return arg_8_2:getEpisodeIndex(arg_8_0.towerId, arg_8_1, true) <= arg_8_2:getEpisodeIndex(arg_8_0.towerId, arg_8_0.passLayerId, true)
end

function var_0_0.updateLayerInfos(arg_9_0, arg_9_1)
	arg_9_0.layerSubEpisodeMap = arg_9_0.layerSubEpisodeMap or {}

	if arg_9_1 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			local var_9_0 = {}

			for iter_9_2 = 1, #iter_9_1.episodeNOs do
				local var_9_1 = TowerSubEpisodeMo.New()

				var_9_1:updateInfo(iter_9_1.episodeNOs[iter_9_2])
				table.insert(var_9_0, var_9_1)
			end

			arg_9_0.layerSubEpisodeMap[iter_9_1.layerId] = var_9_0
		end
	end
end

function var_0_0.resetLayerInfos(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0 = 1, #arg_10_1.episodeNOs do
		local var_10_1 = TowerSubEpisodeMo.New()

		var_10_1:updateInfo(arg_10_1.episodeNOs[iter_10_0])
		table.insert(var_10_0, var_10_1)
	end

	arg_10_0.layerSubEpisodeMap[arg_10_1.layerId] = var_10_0
end

function var_0_0.resetLayerScore(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0.layerScoreMap[arg_11_1.layerId] = arg_11_1.currHighScore
	end
end

function var_0_0.updateHistoryHighScore(arg_12_0, arg_12_1)
	arg_12_0.historyHighScore = arg_12_1
end

function var_0_0.getHistoryHighScore(arg_13_0)
	return arg_13_0.historyHighScore or 0
end

function var_0_0.updateLayerScore(arg_14_0, arg_14_1)
	arg_14_0.layerScoreMap = {}

	if arg_14_1 then
		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			arg_14_0.layerScoreMap[iter_14_1.layerId] = iter_14_1.currHighScore
		end
	end
end

function var_0_0.getLayerScore(arg_15_0, arg_15_1)
	return arg_15_0.layerScoreMap[arg_15_1] or 0
end

function var_0_0.getLayerSubEpisodeList(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0.layerSubEpisodeMap[arg_16_1] and not arg_16_2 then
		logError("该层没有子关卡信息：" .. arg_16_1)
	end

	return arg_16_0.layerSubEpisodeMap[arg_16_1]
end

function var_0_0.getSubEpisodeMoByEpisodeId(arg_17_0, arg_17_1)
	arg_17_0.layerSubEpisodeMap = arg_17_0.layerSubEpisodeMap or {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0.layerSubEpisodeMap) do
		for iter_17_2, iter_17_3 in ipairs(iter_17_1) do
			if iter_17_3.episodeId == arg_17_1 then
				return iter_17_3, iter_17_0
			end
		end
	end
end

function var_0_0.getSubEpisodePassCount(arg_18_0, arg_18_1)
	local var_18_0 = 0
	local var_18_1 = arg_18_0:getLayerSubEpisodeList(arg_18_1, true) or {}

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		if iter_18_1.status == TowerEnum.PassEpisodeState.Pass then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0
end

function var_0_0.getTaskGroupId(arg_19_0)
	local var_19_0 = TowerModel.instance:getTowerOpenInfo(arg_19_0.type, arg_19_0.towerId)

	if var_19_0 == nil then
		return
	end

	local var_19_1 = TowerConfig.instance:getBossTimeTowerConfig(arg_19_0.towerId, var_19_0.round)

	return var_19_1 and var_19_1.taskGroupId
end

function var_0_0.getBanHeroAndBoss(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0.type == TowerEnum.TowerType.Boss then
		return
	end

	local var_20_0 = {}
	local var_20_1 = {}
	local var_20_2 = arg_20_0:getLayerSubEpisodeList(arg_20_1, true)

	if not var_20_2 then
		return var_20_0, var_20_1
	end

	if arg_20_0.type == TowerEnum.TowerType.Normal then
		local var_20_3 = TowerConfig.instance:getPermanentEpisodeCo(arg_20_1)

		if var_20_3 and var_20_3.isElite == 1 then
			for iter_20_0, iter_20_1 in pairs(var_20_2) do
				iter_20_1:getHeros(var_20_0)
				iter_20_1:getAssistBossId(var_20_1)
			end
		end
	else
		local var_20_4 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

		if var_20_4 then
			for iter_20_2 = 1, 3 do
				local var_20_5 = TowerConfig.instance:getTowerLimitedTimeCoList(var_20_4.towerId, iter_20_2)

				if var_20_5 then
					for iter_20_3, iter_20_4 in pairs(var_20_5) do
						local var_20_6 = arg_20_0:getLayerSubEpisodeList(iter_20_4.layerId, true)

						if var_20_6 then
							for iter_20_5, iter_20_6 in pairs(var_20_6) do
								iter_20_6:getHeros(var_20_0)
								iter_20_6:getAssistBossId(var_20_1)
							end
						end
					end
				end
			end
		end
	end

	return var_20_0, var_20_1
end

function var_0_0.getBanAssistBosss(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getLayerSubEpisodeList(arg_21_1, true)
	local var_21_1 = {}

	if var_21_0 then
		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			iter_21_1:getAssistBossId(var_21_1)
		end
	end

	return var_21_1
end

function var_0_0.isHeroGroupLock(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.type == TowerEnum.TowerType.Boss then
		return false
	end

	local var_22_0 = arg_22_0:getLayerSubEpisodeList(arg_22_1, true)

	if arg_22_0.type == TowerEnum.TowerType.Normal then
		local var_22_1 = TowerConfig.instance:getPermanentEpisodeCo(arg_22_1)

		if var_22_1 and var_22_1.isElite ~= 1 then
			return false
		end

		if var_22_0 then
			for iter_22_0, iter_22_1 in pairs(var_22_0) do
				if iter_22_1.episodeId == arg_22_2 then
					if iter_22_1.status == 1 then
						return true, iter_22_1.heroIds, iter_22_1.assistBossId
					else
						return false
					end
				end
			end
		end

		return false
	end

	if var_22_0 then
		for iter_22_2, iter_22_3 in pairs(var_22_0) do
			if iter_22_3.status == 1 then
				return true, iter_22_3.heroIds, iter_22_3.assistBossId
			end
		end
	end

	return false
end

return var_0_0
