module("modules.logic.versionactivity1_6.act148.config.Activity148Config", package.seeall)

local var_0_0 = class("Activity148Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._cfgDict = {}
	arg_1_0._activityConstDict = {}
	arg_1_0._skillTypeCfgDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity148",
		"activity148_const",
		"activity148_skill_type"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity148" then
		arg_3_0:initAct148CfgDict(arg_3_2)
	elseif arg_3_1 == "activity148_const" then
		arg_3_0._activityConstDict = arg_3_2.configDict
	elseif arg_3_1 == "activity148_skill_type" then
		arg_3_0._skillTypeCfgDict = arg_3_2.configDict
	end
end

function var_0_0.initAct148CfgDict(arg_4_0, arg_4_1)
	arg_4_0._cfgDict = arg_4_1.configDict
	arg_4_0._skillTypeDict = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._cfgDict) do
		local var_4_0 = iter_4_1.type

		if not arg_4_0._skillTypeDict[var_4_0] then
			arg_4_0._skillTypeDict[var_4_0] = {}
		end

		local var_4_1 = iter_4_1.level

		arg_4_0._skillTypeDict[var_4_0][var_4_1] = iter_4_1
	end
end

function var_0_0.getAct148Cfg(arg_5_0, arg_5_1)
	return arg_5_0._cfgDict[arg_5_1]
end

function var_0_0.getAct148CfgByTypeLv(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_2 or not arg_6_1 then
		return nil
	end

	local var_6_0 = arg_6_0._skillTypeDict[arg_6_1]

	return var_6_0 and var_6_0[arg_6_2]
end

function var_0_0.getAct148ConstValue(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0._activityConstDict[arg_7_2][arg_7_1].value
end

function var_0_0.getAct148CfgDictByType(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return nil
	end

	return arg_8_0._skillTypeDict[arg_8_1]
end

function var_0_0.getAct148SkillTypeCfg(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return nil
	end

	return arg_9_0._skillTypeCfgDict[arg_9_1]
end

function var_0_0.getAct148SkillPointCost(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = 0

	if arg_10_2 == 0 then
		return var_10_0
	end

	local var_10_1 = arg_10_0._skillTypeDict[arg_10_1]

	if not var_10_1 then
		return var_10_0
	end

	for iter_10_0 = 1, arg_10_2 do
		local var_10_2 = var_10_1[iter_10_0].cost

		var_10_0 = var_10_0 + string.splitToNumber(var_10_2, "#")[3]
	end

	return var_10_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
