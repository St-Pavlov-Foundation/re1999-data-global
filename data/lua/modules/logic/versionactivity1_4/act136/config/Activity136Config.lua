module("modules.logic.versionactivity1_4.act136.config.Activity136Config", package.seeall)

local var_0_0 = class("Activity136Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.Id2HeroIdDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity136"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

function var_0_0.activity136ConfigLoaded(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1.configList) do
		local var_4_0 = string.splitToNumber(iter_4_1.heroIds, "#")

		arg_4_0.Id2HeroIdDict[iter_4_1.activityId] = var_4_0
	end
end

function var_0_0.getCfg(arg_5_0, arg_5_1)
	return lua_activity136.configDict[arg_5_1]
end

function var_0_0.getCfgWithNilError(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getCfg(arg_6_1)

	if not var_6_0 then
		logError("Activity136Config:getCfgWithNilError:cfg nil, id:" .. (arg_6_1 or "nil"))
	end

	return var_6_0
end

function var_0_0.getSelfSelectCharacterIdList(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.Id2HeroIdDict[arg_7_1]

	if not var_7_0 then
		var_7_0 = {}

		logError("Activity136Config:getSelfSelectCharacterIdList error, no heroIds data, id:" .. (arg_7_1 or "nil"))
	end

	return var_7_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
