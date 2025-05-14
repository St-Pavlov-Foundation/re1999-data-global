module("modules.logic.tower.model.TowerEpisodeMo", package.seeall)

local var_0_0 = pureTable("TowerEpisodeMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.towerType = arg_1_1

	arg_1_0:initEpisode(arg_1_2)
end

function var_0_0.initEpisode(arg_2_0, arg_2_1)
	arg_2_0.episodeList = {}
	arg_2_0.preEpisodeDict = {}
	arg_2_0.normalEpisodeCountDict = {}
	arg_2_0.configDict = arg_2_1.configDict

	local var_2_0

	for iter_2_0, iter_2_1 in pairs(arg_2_1.configList) do
		local var_2_1 = iter_2_1.towerId
		local var_2_2 = arg_2_0.preEpisodeDict[var_2_1]

		if not var_2_2 then
			var_2_2 = {}
			arg_2_0.preEpisodeDict[var_2_1] = var_2_2
		end

		var_2_2[iter_2_1.preLayerId] = iter_2_1.layerId
	end

	local var_2_3
	local var_2_4
	local var_2_5

	for iter_2_2, iter_2_3 in pairs(arg_2_0.preEpisodeDict) do
		local var_2_6 = arg_2_0.episodeList[iter_2_2]

		if not var_2_6 then
			var_2_6 = {}
			arg_2_0.episodeList[iter_2_2] = var_2_6
		end

		local var_2_7 = iter_2_3[0]
		local var_2_8 = arg_2_0:getEpisodeDict(iter_2_2)

		while var_2_7 ~= nil do
			if var_2_8[var_2_7].openRound > 0 and arg_2_0.normalEpisodeCountDict[iter_2_2] == nil then
				arg_2_0.normalEpisodeCountDict[iter_2_2] = #var_2_6
			end

			table.insert(var_2_6, var_2_7)

			var_2_7 = iter_2_3[var_2_7]
		end

		if arg_2_0.normalEpisodeCountDict[iter_2_2] == nil then
			arg_2_0.normalEpisodeCountDict[iter_2_2] = #var_2_6
		end
	end
end

function var_0_0.getEpisodeList(arg_3_0, arg_3_1)
	return arg_3_0.episodeList[arg_3_1]
end

function var_0_0.getEpisodeDict(arg_4_0, arg_4_1)
	return arg_4_0.configDict[arg_4_1]
end

function var_0_0.getEpisodeConfig(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getEpisodeDict(arg_5_1)
	local var_5_1 = var_5_0 and var_5_0[arg_5_2]

	if var_5_1 == nil and arg_5_2 ~= 0 then
		logError(string.format("episode config is nil, towerType:%s,towerId:%s,layer:%s", arg_5_0.towerType, arg_5_1, arg_5_2))
	end

	return var_5_1
end

function var_0_0.getNextEpisodeLayer(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.preEpisodeDict[arg_6_1]

	return var_6_0 and var_6_0[arg_6_2]
end

function var_0_0.getEpisodeIndex(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:getEpisodeConfig(arg_7_1, arg_7_2)

	if not var_7_0 then
		return 0
	end

	local var_7_1 = var_7_0.openRound > 0
	local var_7_2 = arg_7_0:getEpisodeList(arg_7_1)
	local var_7_3 = tabletool.indexOf(var_7_2, arg_7_2)

	if not arg_7_3 then
		var_7_3 = var_7_3 - (var_7_1 and arg_7_0.normalEpisodeCountDict[arg_7_1] or 0)
	end

	return var_7_3
end

function var_0_0.getSpEpisodes(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = arg_8_0.normalEpisodeCountDict[arg_8_1]

	if var_8_1 then
		local var_8_2 = arg_8_0:getEpisodeList(arg_8_1)

		for iter_8_0 = var_8_1 + 1, #var_8_2 do
			table.insert(var_8_0, var_8_2[iter_8_0])
		end
	end

	return var_8_0
end

function var_0_0.getLayerCount(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.normalEpisodeCountDict[arg_9_1] or 0

	if arg_9_2 then
		var_9_0 = #arg_9_0:getEpisodeList(arg_9_1) - var_9_0
	end

	return var_9_0
end

function var_0_0.isPassAllUnlockLayers(arg_10_0, arg_10_1)
	local var_10_0 = TowerModel.instance:getTowerInfoById(arg_10_0.towerType, arg_10_1)
	local var_10_1 = var_10_0 and var_10_0.passLayerId or 0
	local var_10_2 = arg_10_0:getNextEpisodeLayer(arg_10_1, var_10_1)

	if not var_10_2 then
		return true
	end

	local var_10_3 = arg_10_0:getEpisodeConfig(arg_10_1, var_10_2)

	if not var_10_3 then
		return true
	end

	if not (var_10_3.openRound > 0) then
		return false
	end

	return not var_10_0:isSpLayerOpen(var_10_2)
end

return var_0_0
