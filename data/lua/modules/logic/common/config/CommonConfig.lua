module("modules.logic.common.config.CommonConfig", package.seeall)

local var_0_0 = class("CommonConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"const",
		"cpu_level",
		"gpu_level",
		"toast",
		"messagebox",
		"gm_command",
		"activity155_drop",
		"activity155_const"
	}
end

function var_0_0.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "cpu_level" then
		arg_2_0._cpuLevelDict = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_2.configList) do
			local var_2_0 = arg_2_0:_getStr(iter_2_1.name)

			arg_2_0._cpuLevelDict[var_2_0] = iter_2_1.level
		end
	elseif arg_2_1 == "gpu_level" then
		arg_2_0._gpuLevelDict = {}

		for iter_2_2, iter_2_3 in ipairs(arg_2_2.configList) do
			local var_2_1 = arg_2_0:_getStr(iter_2_3.name)

			arg_2_0._gpuLevelDict[var_2_1] = iter_2_3.level
		end
	end
end

function var_0_0.getCPULevel(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_0:_getStr(arg_3_1)

	if LuaUtil.isEmptyStr(arg_3_1) then
		return ModuleEnum.Performance.Undefine
	end

	local var_3_0 = arg_3_0._cpuLevelDict[arg_3_1]

	if var_3_0 then
		return var_3_0
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0._cpuLevelDict) do
		if string.find(iter_3_0, arg_3_1) or string.find(arg_3_1, iter_3_0) then
			return iter_3_1
		end
	end

	return ModuleEnum.Performance.Undefine
end

function var_0_0.getGPULevel(arg_4_0, arg_4_1)
	arg_4_1 = arg_4_0:_getStr(arg_4_1)

	if LuaUtil.isEmptyStr(arg_4_1) then
		return ModuleEnum.Performance.Undefine
	end

	local var_4_0 = arg_4_0._gpuLevelDict[arg_4_1]

	if var_4_0 then
		return var_4_0
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0._gpuLevelDict) do
		if string.find(iter_4_0, arg_4_1) or string.find(arg_4_1, iter_4_0) then
			return iter_4_1
		end
	end

	return ModuleEnum.Performance.Undefine
end

function var_0_0._getStr(arg_5_0, arg_5_1)
	return string.gsub(string.lower(arg_5_1), "%s+", "")
end

function var_0_0.getConstNum(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getConstStr(arg_6_1)

	if string.nilorempty(var_6_0) then
		return 0
	else
		return tonumber(var_6_0)
	end
end

function var_0_0.getConstStr(arg_7_0, arg_7_1)
	local var_7_0 = lua_const.configDict[arg_7_1]

	if not var_7_0 then
		printError("const not exist: ", arg_7_1)

		return nil
	end

	local var_7_1 = var_7_0.value

	if not string.nilorempty(var_7_1) then
		return var_7_1
	end

	return var_7_0.value2
end

function var_0_0.getAct155CurrencyRatio(arg_8_0)
	local var_8_0 = lua_activity155_const.configDict[1]
	local var_8_1 = string.splitToNumber(var_8_0.value2, "#")

	return var_8_1 and var_8_1[2] or 0
end

function var_0_0.getAct155EpisodeDisplay(arg_9_0)
	local var_9_0 = lua_activity155_const.configDict[3]
	local var_9_1 = string.splitToNumber(var_9_0.value2, "#")

	return var_9_1[1], var_9_1[2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
