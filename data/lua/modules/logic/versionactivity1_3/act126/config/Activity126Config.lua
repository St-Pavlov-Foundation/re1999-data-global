module("modules.logic.versionactivity1_3.act126.config.Activity126Config", package.seeall)

local var_0_0 = class("Activity126Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity126_buff",
		"activity126_const",
		"activity126_dreamland",
		"activity126_dreamland_card",
		"activity126_episode_daily",
		"activity126_star",
		"activity126_horoscope"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity126_dreamland" then
		arg_3_0:_dealDreamlandTask()
	end
end

function var_0_0.getConst(arg_4_0, arg_4_1, arg_4_2)
	return lua_activity126_const.configDict[arg_4_1][arg_4_2]
end

function var_0_0.getHoroscopeConfig(arg_5_0, arg_5_1, arg_5_2)
	return lua_activity126_horoscope.configDict[arg_5_2][arg_5_1]
end

function var_0_0.getStarConfig(arg_6_0, arg_6_1, arg_6_2)
	return lua_activity126_star.configDict[arg_6_2][arg_6_1]
end

function var_0_0._dealDreamlandTask(arg_7_0)
	arg_7_0._taskDic = {}

	for iter_7_0, iter_7_1 in ipairs(lua_activity126_dreamland.configList) do
		local var_7_0 = string.splitToNumber(iter_7_1.battleIds, "#")

		for iter_7_2, iter_7_3 in ipairs(var_7_0) do
			arg_7_0._taskDic[iter_7_3] = iter_7_1
		end
	end
end

function var_0_0.getDramlandTask(arg_8_0, arg_8_1)
	if arg_8_0._taskeDic then
		return arg_8_0._taskDic[arg_8_1]
	end

	arg_8_0:_dealDreamlandTask()

	return arg_8_0._taskDic[arg_8_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
