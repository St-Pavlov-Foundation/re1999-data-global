module("modules.logic.versionactivity2_4.pinball.config.PinballConfig", package.seeall)

local var_0_0 = class("PinballConfig", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._mapCos = {}
	arg_1_0._taskDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity178_building",
		"activity178_building_hole",
		"activity178_const",
		"activity178_episode",
		"activity178_talent",
		"activity178_task",
		"activity178_score",
		"activity178_resource",
		"activity178_marbles"
	}
end

function var_0_0.getTaskByActId(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._taskDict[arg_3_1]

	if not var_3_0 then
		var_3_0 = {}

		for iter_3_0, iter_3_1 in ipairs(lua_activity178_task.configList) do
			if iter_3_1.activityId == arg_3_1 then
				table.insert(var_3_0, iter_3_1)
			end
		end

		arg_3_0._taskDict[arg_3_1] = var_3_0
	end

	return var_3_0
end

function var_0_0.getMapCo(arg_4_0, arg_4_1)
	if not arg_4_0._mapCos[arg_4_1] then
		local var_4_0 = PinballMapCo.New()
		local var_4_1 = addGlobalModule("modules.configs.pinball.lua_pinball_map_" .. tostring(arg_4_1), "lua_pinball_map_" .. tostring(arg_4_1))

		if not var_4_1 then
			logError("弹珠地图配置不存在" .. arg_4_1)

			return
		end

		var_4_0:init(var_4_1)

		arg_4_0._mapCos[arg_4_1] = var_4_0
	end

	return arg_4_0._mapCos[arg_4_1]
end

function var_0_0.getConstValue(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = lua_activity178_const.configDict[arg_5_1][arg_5_2]

	if var_5_0 then
		return var_5_0.value, var_5_0.value2
	else
		return 0, ""
	end
end

function var_0_0.getAllHoleCo(arg_6_0, arg_6_1)
	return lua_activity178_building_hole.configDict[arg_6_1] or {}
end

function var_0_0.getTalentCoByRoot(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(lua_activity178_talent.configDict[arg_7_1]) do
		if iter_7_1.root == arg_7_2 then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function var_0_0.getAllBuildingCo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = lua_activity178_building.configDict[arg_8_1]
	local var_8_1 = {}

	if not var_8_0 then
		return var_8_1
	end

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1[1] and iter_8_1[1].size == arg_8_2 and iter_8_1[1].type ~= PinballEnum.BuildingType.MainCity then
			table.insert(var_8_1, iter_8_1[1])
		end
	end

	return var_8_1
end

function var_0_0.getScoreLevel(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = lua_activity178_score.configDict[arg_9_1]

	if not var_9_0 then
		return 0, 0, 0
	end

	local var_9_1 = 1
	local var_9_2 = 0
	local var_9_3 = 0

	while true do
		local var_9_4 = var_9_0[var_9_1 + 1]

		if not var_9_4 then
			var_9_2 = var_9_0[var_9_1].value
			var_9_3 = var_9_2

			break
		end

		if arg_9_2 >= var_9_4.value then
			var_9_1 = var_9_1 + 1
		else
			var_9_2 = var_9_0[var_9_1].value
			var_9_3 = var_9_4.value

			break
		end
	end

	return var_9_1, var_9_2, var_9_3
end

function var_0_0.getRandomEpisode(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._episodeByType then
		arg_10_0._episodeByType = {}

		for iter_10_0, iter_10_1 in pairs(lua_activity178_episode.configList) do
			arg_10_0._episodeByType[iter_10_1.type] = arg_10_0._episodeByType[iter_10_1.type] or {}

			table.insert(arg_10_0._episodeByType[iter_10_1.type], iter_10_1)
		end
	end

	if not arg_10_0._episodeByType[arg_10_1] then
		return
	end

	local var_10_0 = {}

	for iter_10_2, iter_10_3 in pairs(arg_10_0._episodeByType[arg_10_1]) do
		if iter_10_3.condition <= PinballModel.instance.maxProsperity and iter_10_3.condition2 >= PinballModel.instance.maxProsperity then
			table.insert(var_10_0, iter_10_3)
		end
	end

	local var_10_1 = #var_10_0

	if var_10_1 <= 0 then
		return
	end

	local var_10_2 = math.random(1, var_10_1)
	local var_10_3 = var_10_0[var_10_2]

	if var_10_1 > 1 and var_10_3.id == arg_10_2 then
		local var_10_4 = var_10_2 + 1

		if var_10_1 < var_10_4 then
			var_10_4 = 1
		end

		var_10_3 = var_10_0[var_10_4]
	end

	return var_10_3
end

var_0_0.instance = var_0_0.New()

return var_0_0
