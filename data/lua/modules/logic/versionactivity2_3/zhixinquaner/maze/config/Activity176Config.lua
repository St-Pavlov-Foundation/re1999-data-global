module("modules.logic.versionactivity2_3.zhixinquaner.maze.config.Activity176Config", package.seeall)

local var_0_0 = class("Activity176Config", BaseConfig)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity176_bubble",
		"activity176_episode"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getBubbleCo(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = lua_activity176_bubble.configDict[arg_4_1]

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0[arg_4_2]

	if not var_4_1 then
		logError(string.format("纸信圈儿对话配置不存在: activityId = %s, id = %s", arg_4_1, arg_4_2))

		return
	end

	return var_4_1
end

function var_0_0.getElementCo(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = lua_activity176_episode.configDict[arg_5_1]

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0[arg_5_2]

	if var_5_1 and var_5_1.elementId ~= 0 then
		return lua_chapter_map_element.configDict[var_5_1.elementId]
	end
end

function var_0_0.hasElementCo(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0:getElementCo(arg_6_1, arg_6_2) ~= nil
end

function var_0_0.getEpisodeCoByElementId(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = lua_activity176_episode.configDict[arg_7_1]

	if not var_7_0 or not arg_7_2 then
		return
	end

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1.elementId == arg_7_2 then
			return iter_7_1
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
