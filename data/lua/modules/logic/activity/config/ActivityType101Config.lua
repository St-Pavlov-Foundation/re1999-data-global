module("modules.logic.activity.config.ActivityType101Config", package.seeall)

local var_0_0 = class("ActivityType101Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity101_doublefestival",
		"activity101_springsign",
		"activity101_sp_bonus",
		"v2a1_activity101_moonfestivalsign",
		"linkage_activity"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity101_doublefestival" then
		arg_3_0.__activity101_doublefestivals = nil

		arg_3_0:__initDoubleFestival()
	elseif arg_3_1 == "activity101_springsign" then
		arg_3_0.__activity101_springsign = nil

		arg_3_0:__initSpringSign()
	elseif arg_3_1 == "v2a1_activity101_moonfestivalsign" then
		arg_3_0.__v2a1_activity101_moonfestivalsign = nil

		arg_3_0:__initMoonFestivalSign()
	elseif arg_3_1 == "linkage_activity" then
		arg_3_0.__linkage_activity = nil

		arg_3_0:__linkageActivity()
	end
end

function var_0_0.__initDoubleFestival(arg_4_0)
	local var_4_0 = arg_4_0.__activity101_doublefestivals

	if var_4_0 then
		return var_4_0
	end

	local var_4_1 = {}

	arg_4_0.__activity101_doublefestivals = var_4_1

	for iter_4_0, iter_4_1 in ipairs(lua_activity101_doublefestival.configList) do
		local var_4_2 = iter_4_1.activityId
		local var_4_3 = iter_4_1.day

		var_4_1[var_4_2] = var_4_1[var_4_2] or {}
		var_4_1[var_4_2][var_4_3] = iter_4_1
	end

	return var_4_1
end

function var_0_0.getDoubleFestivalCOByDay(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:__initDoubleFestival()

	local var_5_0 = arg_5_0.__activity101_doublefestivals[arg_5_1]

	if not var_5_0 then
		return
	end

	return var_5_0[arg_5_2]
end

function var_0_0.__initSpringSign(arg_6_0)
	local var_6_0 = arg_6_0.__activity101_springsign

	if var_6_0 then
		return var_6_0
	end

	local var_6_1 = {}

	arg_6_0.__activity101_springsign = var_6_1

	for iter_6_0, iter_6_1 in ipairs(lua_activity101_springsign.configList) do
		local var_6_2 = iter_6_1.activityId
		local var_6_3 = iter_6_1.day

		var_6_1[var_6_2] = var_6_1[var_6_2] or {}
		var_6_1[var_6_2][var_6_3] = iter_6_1
	end

	return var_6_1
end

function var_0_0.getSpringSignByDay(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:__initSpringSign()

	local var_7_0 = arg_7_0.__activity101_springsign[arg_7_1]

	if not var_7_0 then
		return
	end

	return var_7_0[arg_7_2]
end

function var_0_0.getSpringSignMaxDay(arg_8_0, arg_8_1)
	arg_8_0:__initSpringSign()

	local var_8_0 = arg_8_0.__activity101_springsign[arg_8_1]

	if not var_8_0 then
		return 0
	end

	return #var_8_0
end

function var_0_0.__initMoonFestivalSign(arg_9_0)
	local var_9_0 = arg_9_0.__v2a1_activity101_moonfestivalsign

	if var_9_0 then
		return var_9_0
	end

	local var_9_1 = {}

	arg_9_0.__v2a1_activity101_moonfestivalsign = var_9_1

	for iter_9_0, iter_9_1 in ipairs(v2a1_activity101_moonfestivalsign.configList) do
		local var_9_2 = iter_9_1.activityId
		local var_9_3 = iter_9_1.day

		var_9_1[var_9_2] = var_9_1[var_9_2] or {}
		var_9_1[var_9_2][var_9_3] = iter_9_1
	end

	return var_9_1
end

function var_0_0.getMoonFestivalSignMaxDay(arg_10_0, arg_10_1)
	arg_10_0:__initSpringSign()

	local var_10_0 = arg_10_0.__v2a1_activity101_moonfestivalsign[arg_10_1]

	if not var_10_0 then
		return 0
	end

	return #var_10_0
end

function var_0_0.getMoonFestivalByDay(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:__initMoonFestivalSign()

	local var_11_0 = arg_11_0.__v2a1_activity101_moonfestivalsign[arg_11_1]

	if not var_11_0 then
		return
	end

	return var_11_0[arg_11_2]
end

function var_0_0.getMoonFestivalTaskCO(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getSpBonusCO(arg_12_1)

	if not var_12_0 then
		return
	end

	return var_12_0[1]
end

function var_0_0.getSpBonusCO(arg_13_0, arg_13_1)
	return lua_activity101_sp_bonus.configDict[arg_13_1]
end

function var_0_0.__linkageActivity(arg_14_0)
	local var_14_0 = arg_14_0.__linkage_activity

	if var_14_0 then
		return var_14_0
	end

	local var_14_1 = {}

	arg_14_0.__linkage_activity = var_14_1

	for iter_14_0, iter_14_1 in ipairs(lua_linkage_activity.configList) do
		var_14_1[iter_14_1.activityId] = iter_14_1
	end

	return var_14_1
end

function var_0_0.getLinkageActivityCO(arg_15_0, arg_15_1)
	arg_15_0:__linkageActivity()

	return arg_15_0.__linkage_activity[arg_15_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
