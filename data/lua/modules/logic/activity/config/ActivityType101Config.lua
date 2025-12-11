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
		"linkage_activity",
		"activity101_festival_const"
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

local function var_0_1(arg_4_0)
	if not _G.lua_activity101_festival_const then
		return
	end

	return lua_activity101_festival_const.configDict[arg_4_0]
end

function var_0_0.__initDoubleFestival(arg_5_0)
	local var_5_0 = arg_5_0.__activity101_doublefestivals

	if var_5_0 then
		return var_5_0
	end

	local var_5_1 = {}

	arg_5_0.__activity101_doublefestivals = var_5_1

	for iter_5_0, iter_5_1 in ipairs(lua_activity101_doublefestival.configList) do
		local var_5_2 = iter_5_1.activityId
		local var_5_3 = iter_5_1.day

		var_5_1[var_5_2] = var_5_1[var_5_2] or {}
		var_5_1[var_5_2][var_5_3] = iter_5_1
	end

	return var_5_1
end

function var_0_0.getDoubleFestivalCOByDay(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:__initDoubleFestival()

	local var_6_0 = arg_6_0.__activity101_doublefestivals[arg_6_1]

	if not var_6_0 then
		return
	end

	return var_6_0[arg_6_2]
end

function var_0_0.__initSpringSign(arg_7_0)
	local var_7_0 = arg_7_0.__activity101_springsign

	if var_7_0 then
		return var_7_0
	end

	local var_7_1 = {}

	arg_7_0.__activity101_springsign = var_7_1

	for iter_7_0, iter_7_1 in ipairs(lua_activity101_springsign.configList) do
		local var_7_2 = iter_7_1.activityId
		local var_7_3 = iter_7_1.day

		var_7_1[var_7_2] = var_7_1[var_7_2] or {}
		var_7_1[var_7_2][var_7_3] = iter_7_1
	end

	return var_7_1
end

function var_0_0.getSpringSignByDay(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:__initSpringSign()

	local var_8_0 = arg_8_0.__activity101_springsign[arg_8_1]

	if not var_8_0 then
		return
	end

	return var_8_0[arg_8_2]
end

function var_0_0.getSpringSignMaxDay(arg_9_0, arg_9_1)
	arg_9_0:__initSpringSign()

	local var_9_0 = arg_9_0.__activity101_springsign[arg_9_1]

	if not var_9_0 then
		return 0
	end

	return #var_9_0
end

function var_0_0.__initMoonFestivalSign(arg_10_0)
	local var_10_0 = arg_10_0.__v2a1_activity101_moonfestivalsign

	if var_10_0 then
		return var_10_0
	end

	local var_10_1 = {}

	arg_10_0.__v2a1_activity101_moonfestivalsign = var_10_1

	for iter_10_0, iter_10_1 in ipairs(v2a1_activity101_moonfestivalsign.configList) do
		local var_10_2 = iter_10_1.activityId
		local var_10_3 = iter_10_1.day

		var_10_1[var_10_2] = var_10_1[var_10_2] or {}
		var_10_1[var_10_2][var_10_3] = iter_10_1
	end

	return var_10_1
end

function var_0_0.getMoonFestivalSignMaxDay(arg_11_0, arg_11_1)
	arg_11_0:__initSpringSign()

	local var_11_0 = arg_11_0.__v2a1_activity101_moonfestivalsign[arg_11_1]

	if not var_11_0 then
		return 0
	end

	return #var_11_0
end

function var_0_0.getMoonFestivalByDay(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:__initMoonFestivalSign()

	local var_12_0 = arg_12_0.__v2a1_activity101_moonfestivalsign[arg_12_1]

	if not var_12_0 then
		return
	end

	return var_12_0[arg_12_2]
end

function var_0_0.getMoonFestivalTaskCO(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getSpBonusCO(arg_13_1)

	if not var_13_0 then
		return
	end

	return var_13_0[1]
end

function var_0_0.getSpBonusCO(arg_14_0, arg_14_1)
	return lua_activity101_sp_bonus.configDict[arg_14_1]
end

function var_0_0.__linkageActivity(arg_15_0)
	local var_15_0 = arg_15_0.__linkage_activity

	if var_15_0 then
		return var_15_0
	end

	local var_15_1 = {}

	arg_15_0.__linkage_activity = var_15_1

	for iter_15_0, iter_15_1 in ipairs(lua_linkage_activity.configList) do
		var_15_1[iter_15_1.activityId] = iter_15_1
	end

	return var_15_1
end

function var_0_0.getLinkageActivityCO(arg_16_0, arg_16_1)
	arg_16_0:__linkageActivity()

	return arg_16_0.__linkage_activity[arg_16_1]
end

function var_0_0.getRoleSignActIdList(arg_17_0)
	return ActivityConfig.instance:getConstAsNumList(1, "#", {})
end

function var_0_0.getVersionSummonActIdList(arg_18_0)
	return ActivityConfig.instance:getConstAsNumList(6, "#", {})
end

function var_0_0.getConstAsNum(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = var_0_1(arg_19_1)

	if not var_19_0 then
		return arg_19_2
	end

	return tonumber(var_19_0.strValue) or arg_19_2
end

function var_0_0.getDayCOs(arg_20_0, arg_20_1)
	return lua_activity101.configDict[arg_20_1]
end

function var_0_0.getDayCO(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getDayCOs(arg_21_1)

	if not var_21_0 then
		return
	end

	return var_21_0[arg_21_2]
end

function var_0_0.getSignMaxDay(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getDayCOs(arg_22_1)

	if not var_22_0 then
		return 0
	end

	return #var_22_0
end

function var_0_0.getDayBonusList(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:getDayCO(arg_23_1, arg_23_2)

	if not var_23_0 then
		return {}
	end

	if string.nilorempty(var_23_0.bonus) then
		return {}
	end

	return GameUtil.splitString2(var_23_0.bonus, true)
end

function var_0_0.getDoubleDanJumpId(arg_24_0)
	return arg_24_0:getConstAsNum(1, 0)
end

function var_0_0.getDoubleDanSkinId(arg_25_0)
	return arg_25_0:getConstAsNum(2, 309502)
end

function var_0_0.getDoubleDanActId(arg_26_0)
	return ActivityConfig.instance:getConstAsNum(8, 13311)
end

var_0_0.instance = var_0_0.New()

return var_0_0
