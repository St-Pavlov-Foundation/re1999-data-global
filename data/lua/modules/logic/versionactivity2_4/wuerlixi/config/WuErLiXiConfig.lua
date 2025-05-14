module("modules.logic.versionactivity2_4.wuerlixi.config.WuErLiXiConfig", package.seeall)

local var_0_0 = class("WuErLiXiConfig", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._taskDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity180_episode",
		"activity180_task",
		"activity180_element"
	}
end

function var_0_0.getMapCo(arg_3_0, arg_3_1)
	local var_3_0 = addGlobalModule("modules.configs.wuerlixi.lua_wuerlixi_map_" .. tostring(arg_3_1), "lua_wuerlixi_map_" .. tostring(arg_3_1))

	if not var_3_0 then
		logError("乌尔里希地图配置不存在" .. arg_3_1)

		return
	end

	return var_3_0
end

function var_0_0.getEpisodeByMapId(arg_4_0, arg_4_1)
	if not arg_4_0._mapIdToEpisodeCo then
		arg_4_0._mapIdToEpisodeCo = {}

		for iter_4_0, iter_4_1 in ipairs(lua_activity180_episode.configList) do
			arg_4_0._mapIdToEpisodeCo[iter_4_1.mapId] = iter_4_1
		end
	end

	return arg_4_0._mapIdToEpisodeCo[arg_4_1]
end

function var_0_0.getEpisodeCoList(arg_5_0, arg_5_1)
	if not arg_5_0._episodeDict then
		arg_5_0._episodeDict = {}

		for iter_5_0, iter_5_1 in ipairs(lua_activity180_episode.configList) do
			if not arg_5_0._episodeDict[iter_5_1.activityId] then
				arg_5_0._episodeDict[iter_5_1.activityId] = {}
			end

			table.insert(arg_5_0._episodeDict[iter_5_1.activityId], iter_5_1)
		end
	end

	return arg_5_0._episodeDict[arg_5_1] or {}
end

function var_0_0.getEpisodeCo(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getEpisodeCoList(arg_6_1)

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if iter_6_1.episodeId == arg_6_2 then
			return iter_6_1
		end
	end
end

function var_0_0.getTaskByActId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._taskDict[arg_7_1]

	if not var_7_0 then
		var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(lua_activity180_task.configList) do
			if iter_7_1.activityId == arg_7_1 then
				table.insert(var_7_0, iter_7_1)
			end
		end

		arg_7_0._taskDict[arg_7_1] = var_7_0
	end

	return var_7_0
end

function var_0_0.getElementList(arg_8_0)
	return lua_activity180_element.configList
end

function var_0_0.getElementCo(arg_9_0, arg_9_1)
	return lua_activity180_element.configDict[arg_9_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
