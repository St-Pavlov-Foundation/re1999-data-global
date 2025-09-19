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

function var_0_0.getEpisodeCoList(arg_4_0, arg_4_1)
	if not arg_4_0._episodeDict then
		arg_4_0._episodeDict = {}

		for iter_4_0, iter_4_1 in ipairs(lua_activity180_episode.configList) do
			if not arg_4_0._episodeDict[iter_4_1.activityId] then
				arg_4_0._episodeDict[iter_4_1.activityId] = {}
			end

			table.insert(arg_4_0._episodeDict[iter_4_1.activityId], iter_4_1)
		end
	end

	return arg_4_0._episodeDict[arg_4_1] or {}
end

function var_0_0.getEpisodeCo(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getEpisodeCoList(arg_5_1)

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if iter_5_1.episodeId == arg_5_2 then
			return iter_5_1
		end
	end
end

function var_0_0.getTaskByActId(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._taskDict[arg_6_1]

	if not var_6_0 then
		var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(lua_activity180_task.configList) do
			if iter_6_1.activityId == arg_6_1 then
				table.insert(var_6_0, iter_6_1)
			end
		end

		arg_6_0._taskDict[arg_6_1] = var_6_0
	end

	return var_6_0
end

function var_0_0.getElementList(arg_7_0)
	return lua_activity180_element.configList
end

function var_0_0.getElementCo(arg_8_0, arg_8_1)
	return lua_activity180_element.configDict[arg_8_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
