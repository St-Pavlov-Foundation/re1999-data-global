module("modules.logic.versionactivity2_2.tianshinana.config.TianShiNaNaConfig", package.seeall)

local var_0_0 = class("TianShiNaNaConfig", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._mapCos = {}
	arg_1_0._taskDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity167_episode",
		"activity167_task",
		"activity167_bubble"
	}
end

function var_0_0.getMapCo(arg_3_0, arg_3_1)
	if not arg_3_0._mapCos[arg_3_1] then
		local var_3_0 = TianShiNaNaMapCo.New()
		local var_3_1 = addGlobalModule("modules.configs.tianshinana.lua_tianshinana_map_" .. tostring(arg_3_1), "lua_tianshinana_map_" .. tostring(arg_3_1))

		if not var_3_1 then
			logError("天使娜娜地图配置不存在" .. arg_3_1)

			return
		end

		var_3_0:init(var_3_1)

		arg_3_0._mapCos[arg_3_1] = var_3_0
	end

	return arg_3_0._mapCos[arg_3_1]
end

function var_0_0.getEpisodeByMapId(arg_4_0, arg_4_1)
	if not arg_4_0._mapIdToEpisodeCo then
		arg_4_0._mapIdToEpisodeCo = {}

		for iter_4_0, iter_4_1 in ipairs(lua_activity167_episode.configList) do
			arg_4_0._mapIdToEpisodeCo[iter_4_1.mapId] = iter_4_1
		end
	end

	return arg_4_0._mapIdToEpisodeCo[arg_4_1]
end

function var_0_0.getEpisodeCoList(arg_5_0, arg_5_1)
	if not arg_5_0._episodeDict then
		arg_5_0._episodeDict = {}

		for iter_5_0, iter_5_1 in ipairs(lua_activity167_episode.configList) do
			if not arg_5_0._episodeDict[iter_5_1.activityId] then
				arg_5_0._episodeDict[iter_5_1.activityId] = {}
			end

			table.insert(arg_5_0._episodeDict[iter_5_1.activityId], iter_5_1)
		end
	end

	return arg_5_0._episodeDict[arg_5_1] or {}
end

function var_0_0.getBubbleCo(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = lua_activity167_bubble.configDict[arg_6_1]

	if not var_6_0 then
		return
	end

	return var_6_0[arg_6_2]
end

function var_0_0.getTaskByActId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._taskDict[arg_7_1]

	if not var_7_0 then
		var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(lua_activity167_task.configList) do
			if iter_7_1.activityId == arg_7_1 then
				table.insert(var_7_0, iter_7_1)
			end
		end

		arg_7_0._taskDict[arg_7_1] = var_7_0
	end

	return var_7_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
