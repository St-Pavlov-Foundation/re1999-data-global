module("modules.logic.versionactivity1_9.roomgift.config.RoomGiftConfig", package.seeall)

local var_0_0 = class("RoomGiftConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity159",
		"activity159_critter"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

local function var_0_1(arg_4_0)
	local var_4_0

	if not string.nilorempty(arg_4_0) then
		var_4_0 = lua_activity159_critter.configDict[arg_4_0]
	end

	if not var_4_0 then
		logError(string.format("RoomGiftConfig.getRoomGiftSpineCfg error, no cfg, name:%s", arg_4_0))
	end

	return var_4_0
end

function var_0_0.getAllRoomGiftSpineList(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(lua_activity159_critter.configList) do
		var_5_0[#var_5_0 + 1] = iter_5_1.name
	end

	return var_5_0
end

function var_0_0.getRoomGiftSpineRes(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = var_0_1(arg_6_1)

	if var_6_1 then
		var_6_0 = var_6_1.res
	end

	return var_6_0
end

function var_0_0.getRoomGiftSpineAnim(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1 = var_0_1(arg_7_1)

	if var_7_1 then
		var_7_0 = var_7_1.anim
	end

	return var_7_0
end

function var_0_0.getRoomGiftSpineStartPos(arg_8_0, arg_8_1)
	local var_8_0 = {
		0,
		0,
		0
	}
	local var_8_1 = var_0_1(arg_8_1)

	if var_8_1 then
		var_8_0 = string.splitToNumber(var_8_1.startPos, "#")
	end

	return var_8_0
end

function var_0_0.getRoomGiftSpineScale(arg_9_0, arg_9_1)
	local var_9_0 = 1
	local var_9_1 = var_0_1(arg_9_1)

	if var_9_1 then
		var_9_0 = var_9_1.scale
	end

	return var_9_0
end

local function var_0_2(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if arg_10_0 and arg_10_1 then
		local var_10_1 = lua_activity159.configDict[arg_10_0]

		var_10_0 = var_10_1 and var_10_1[arg_10_1]
	end

	if not var_10_0 and arg_10_2 then
		logError(string.format("RoomGiftConfig:getActivity159Cfg error, cfg is nil, actId:%s  day:%s", arg_10_0, arg_10_1))
	end

	return var_10_0
end

function var_0_0.getRoomGiftBonus(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0
	local var_11_1 = var_0_2(arg_11_1, arg_11_2)

	if var_11_1 then
		var_11_0 = var_11_1.bonus
	end

	return var_11_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
