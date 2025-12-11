module("modules.logic.tower.config.TowerDeepConfig", package.seeall)

local var_0_0 = class("TowerDeepConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.TowerDeepConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"tower_deep_const",
		"tower_deep_task",
		"tower_deep_monster"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "tower_deep_const" then
		arg_3_0._constConfig = arg_3_2
	elseif arg_3_1 == "tower_deep_task" then
		arg_3_0._taskConfig = arg_3_2
	elseif arg_3_1 == "tower_deep_monster" then
		arg_3_0._deepMonsterConfig = arg_3_2
	end
end

function var_0_0.getConstConfigValue(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._constConfig.configDict[arg_4_1]

	if var_4_0 then
		return arg_4_2 and var_4_0.value or tonumber(var_4_0.value)
	end
end

function var_0_0.getConstConfigLangValue(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._constConfig.configDict[arg_5_1]

	if var_5_0 then
		return var_5_0.value2
	end
end

function var_0_0.getTaskConfig(arg_6_0, arg_6_1)
	return arg_6_0._taskConfig.configDict[arg_6_1]
end

function var_0_0.getTaskConfigList(arg_7_0)
	return arg_7_0._taskConfig.configList
end

function var_0_0.getDeepMonsterId(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._deepMonsterConfig.configList) do
		if arg_8_1 >= iter_8_1.startHighDeep and arg_8_1 <= iter_8_1.endHighDeep then
			return iter_8_1.bossId
		end
	end

	return arg_8_0._deepMonsterConfig.configList[1].bossId
end

var_0_0.instance = var_0_0.New()

return var_0_0
