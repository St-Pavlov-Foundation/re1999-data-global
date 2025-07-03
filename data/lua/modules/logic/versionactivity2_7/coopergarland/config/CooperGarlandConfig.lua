module("modules.logic.versionactivity2_7.coopergarland.config.CooperGarlandConfig", package.seeall)

local var_0_0 = class("CooperGarlandConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity192_const",
		"activity192_episode",
		"activity192_task",
		"activity192_game",
		"activity192_map",
		"activity192_component_type"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._actTaskDict = {}
	arg_2_0._actEpisodeDict = {}
	arg_2_0._map2ComponentList = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

function var_0_0.activity192_mapConfigLoaded(arg_4_0, arg_4_1)
	arg_4_0._map2ComponentList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.configList) do
		local var_4_0 = iter_4_1.mapId
		local var_4_1 = arg_4_0._map2ComponentList[var_4_0]

		if not var_4_1 then
			var_4_1 = {}
			arg_4_0._map2ComponentList[var_4_0] = var_4_1
		end

		var_4_1[#var_4_1 + 1] = iter_4_1.componentId
	end
end

function var_0_0.getAct192ConstCfg(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = lua_activity192_const.configDict[arg_5_1]

	if not var_5_0 and arg_5_2 then
		logError(string.format("CooperGarlandConfig:getAct192ConstCfg error, cfg is nil, constId:%s", arg_5_1))
	end

	return var_5_0
end

function var_0_0.getAct192Const(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0
	local var_6_1 = arg_6_0:getAct192ConstCfg(arg_6_1, true)

	if var_6_1 then
		var_6_0 = var_6_1.value

		if arg_6_2 then
			var_6_0 = tonumber(var_6_0)
		end
	end

	return var_6_0
end

function var_0_0.getAct192EpisodeCfg(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = lua_activity192_episode.configDict[arg_7_1] and lua_activity192_episode.configDict[arg_7_1][arg_7_2]

	if not var_7_0 and arg_7_3 then
		logError(string.format("CooperGarlandConfig:getAct192EpisodeCfg error, cfg is nil, actId:%s, episodeId:%s", arg_7_1, arg_7_2))
	end

	return var_7_0
end

function var_0_0.getEpisodeIdList(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}

	if lua_activity192_episode.configDict[arg_8_1] then
		var_8_0 = arg_8_0._actEpisodeDict[arg_8_1]

		if not var_8_0 then
			var_8_0 = {}
			arg_8_0._actEpisodeDict = var_8_0

			for iter_8_0, iter_8_1 in ipairs(lua_activity192_episode.configList) do
				if arg_8_1 == iter_8_1.activityId and not iter_8_1.isExtra then
					var_8_0[#var_8_0 + 1] = iter_8_1.episodeId
				end
			end
		end
	elseif arg_8_2 then
		logError(string.format("CooperGarlandConfig:getEpisodeIdList error, cfg is nil, actId:%s", arg_8_1))
	end

	return var_8_0
end

function var_0_0.getEpisodeName(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getAct192EpisodeCfg(arg_9_1, arg_9_2, true)

	return var_9_0 and var_9_0.name or ""
end

function var_0_0.getGameId(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getAct192EpisodeCfg(arg_10_1, arg_10_2, true)

	return var_10_0 and var_10_0.gameId
end

function var_0_0.isGameEpisode(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getGameId(arg_11_1, arg_11_2)

	return var_11_0 and var_11_0 ~= 0
end

function var_0_0.getStoryBefore(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getAct192EpisodeCfg(arg_12_1, arg_12_2, true)

	return var_12_0 and var_12_0.storyBefore
end

function var_0_0.getStoryClear(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getAct192EpisodeCfg(arg_13_1, arg_13_2, true)

	return var_13_0 and var_13_0.storyClear
end

function var_0_0.getExtraEpisode(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0
	local var_14_1 = lua_activity192_episode.configDict[arg_14_1]

	if var_14_1 then
		for iter_14_0, iter_14_1 in pairs(var_14_1) do
			if iter_14_1.isExtra then
				var_14_0 = iter_14_0

				break
			end
		end
	elseif arg_14_2 then
		logError(string.format("CooperGarlandConfig:getExtraEpisode error, cfg is nil, actId:%s", arg_14_1))
	end

	return var_14_0
end

function var_0_0.isExtraEpisode(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getAct192EpisodeCfg(arg_15_1, arg_15_2, true)

	return var_15_0 and var_15_0.isExtra
end

function var_0_0.getAct192TaskCfg(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = lua_activity192_task.configDict[arg_16_2]

	if arg_16_3 then
		if var_16_0 then
			if var_16_0.activityId ~= arg_16_1 then
				logError(string.format("CooperGarlandConfig:getAct192TaskCfg error, actId error, actId:%s, taskId:%s, cfg actId:%s", arg_16_1, arg_16_2, var_16_0.activityId))
			end
		else
			logError(string.format("CooperGarlandConfig:getAct192TaskCfg error, cfg is nil, actId:%s, taskId:%s", arg_16_1, arg_16_2))
		end
	end

	return var_16_0
end

function var_0_0.getTaskList(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._actTaskDict[arg_17_1]

	if not var_17_0 then
		var_17_0 = {}
		arg_17_0._actTaskDict = var_17_0

		for iter_17_0, iter_17_1 in pairs(lua_activity192_task.configDict) do
			if arg_17_1 == iter_17_1.activityId then
				var_17_0[#var_17_0 + 1] = iter_17_1
			end
		end
	end

	return var_17_0
end

function var_0_0.getAct192GameCfg(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = lua_activity192_game.configDict[arg_18_1]

	if not var_18_0 and arg_18_2 then
		logError(string.format("CooperGarlandConfig:getAct192GameCfg error, cfg is nil, gameId:%s", arg_18_1))
	end

	return var_18_0
end

function var_0_0.getMapId(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:getAct192GameCfg(arg_19_1, true)

	return var_19_0 and var_19_0.maps[arg_19_2]
end

function var_0_0.getMaxRound(arg_20_0, arg_20_1)
	local var_20_0 = 0
	local var_20_1 = arg_20_0:getAct192GameCfg(arg_20_1, true)

	if var_20_1 then
		var_20_0 = #var_20_1.maps
	end

	return var_20_0
end

function var_0_0.getRemoveCount(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getAct192GameCfg(arg_21_1, true)

	return var_21_0 and var_21_0.removeCount[arg_21_2]
end

function var_0_0.getPanelImage(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getAct192GameCfg(arg_22_1, true)

	return var_22_0 and var_22_0.panelImage
end

function var_0_0.getScenePath(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getAct192GameCfg(arg_23_1, true)

	return var_23_0 and var_23_0.scenePath
end

function var_0_0.getCubeOpenAnim(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getAct192GameCfg(arg_24_1, true)

	return var_24_0 and var_24_0.cubeOpenAnim
end

function var_0_0.getCubeSwitchAnim(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getAct192GameCfg(arg_25_1, true)

	return var_25_0 and var_25_0.cubeSwitchAnim
end

function var_0_0.getAct192MapComponentCfg(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = lua_activity192_map.configDict[arg_26_1] and lua_activity192_map.configDict[arg_26_1][arg_26_2]

	if not var_26_0 and arg_26_3 then
		logError(string.format("CooperGarlandConfig:getAct192MapComponentCfg error, cfg is nil, mapId:%s, componentId:%s", arg_26_1, arg_26_2))
	end

	return var_26_0
end

function var_0_0.getMapComponentList(arg_27_0, arg_27_1)
	return arg_27_0._map2ComponentList and arg_27_0._map2ComponentList[arg_27_1] or {}
end

function var_0_0.getMapComponentType(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:getAct192MapComponentCfg(arg_28_1, arg_28_2, true)

	return var_28_0 and var_28_0.componentType
end

function var_0_0.getMapComponentSize(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = 0
	local var_29_1 = 0
	local var_29_2 = arg_29_0:getAct192MapComponentCfg(arg_29_1, arg_29_2, true)

	if var_29_2 then
		var_29_0 = var_29_2.width
		var_29_1 = var_29_2.height
	end

	return var_29_0, var_29_1
end

function var_0_0.getMapComponentColliderSize(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = 0
	local var_30_1 = 0
	local var_30_2 = arg_30_0:getAct192MapComponentCfg(arg_30_1, arg_30_2, true)

	if var_30_2 then
		var_30_0 = var_30_2.colliderWidth
		var_30_1 = var_30_2.colliderHeight
	end

	return var_30_0, var_30_1
end

function var_0_0.getMapComponentColliderOffset(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = 0
	local var_31_1 = 0
	local var_31_2 = arg_31_0:getAct192MapComponentCfg(arg_31_1, arg_31_2, true)

	if var_31_2 then
		var_31_0 = var_31_2.colliderOffsetX
		var_31_1 = var_31_2.colliderOffsetY
	end

	return var_31_0, var_31_1
end

function var_0_0.getMapComponentScale(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:getAct192MapComponentCfg(arg_32_1, arg_32_2, true)

	return var_32_0 and var_32_0.scale
end

function var_0_0.getMapComponentPos(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0
	local var_33_1
	local var_33_2 = arg_33_0:getAct192MapComponentCfg(arg_33_1, arg_33_2, true)

	if var_33_2 then
		var_33_0 = var_33_2.posX
		var_33_1 = var_33_2.posY
	end

	return var_33_0, var_33_1
end

function var_0_0.getMapComponentRotation(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0:getAct192MapComponentCfg(arg_34_1, arg_34_2, true)

	return var_34_0 and var_34_0.rotation
end

function var_0_0.getMapComponentExtraParams(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0:getAct192MapComponentCfg(arg_35_1, arg_35_2, true)

	return var_35_0 and var_35_0.extraParams
end

function var_0_0.getStoryCompId(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0:getMapComponentList(arg_36_1)

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		local var_36_1 = arg_36_0:getMapComponentType(arg_36_1, iter_36_1)
		local var_36_2 = arg_36_0:getMapComponentExtraParams(arg_36_1, iter_36_1)

		if var_36_1 == CooperGarlandEnum.ComponentType.Story and tonumber(var_36_2) == arg_36_2 then
			return iter_36_1
		end
	end
end

function var_0_0.getAct192ComponentTypeCfg(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = lua_activity192_component_type.configDict[arg_37_1]

	if not var_37_0 and arg_37_2 then
		logError(string.format("CooperGarlandConfig:getAct192ComponentTypeCfg error, cfg is nil, componentType:%s", arg_37_1))
	end

	return var_37_0
end

function var_0_0.getAllComponentResPath(arg_38_0)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs(lua_activity192_component_type.configList) do
		var_38_0[#var_38_0 + 1] = iter_38_1.path
	end

	return var_38_0
end

function var_0_0.getComponentTypePath(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:getAct192ComponentTypeCfg(arg_39_1, true)

	return var_39_0 and var_39_0.path
end

var_0_0.instance = var_0_0.New()

return var_0_0
