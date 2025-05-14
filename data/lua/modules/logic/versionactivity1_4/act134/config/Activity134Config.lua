module("modules.logic.versionactivity1_4.act134.config.Activity134Config", package.seeall)

local var_0_0 = class("Activity134Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity134_task",
		"activity134_bonus",
		"activity134_story"
	}
end

function var_0_0.ctor(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity134_task" then
		arg_3_0:_initTaskConfig()
	elseif arg_3_1 == "activity134_bonus" then
		arg_3_0:_initBonusConfig()
	elseif arg_3_1 == "activity134_story" then
		arg_3_0:_initStoryConfig()
	end
end

function var_0_0._initTaskConfig(arg_4_0)
	arg_4_0._taskConfig = {}

	for iter_4_0, iter_4_1 in ipairs(lua_activity134_task.configList) do
		table.insert(arg_4_0._taskConfig, iter_4_1)
	end
end

function var_0_0.getTaskConfig(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._taskConfig) do
		if iter_5_1.id == arg_5_1 then
			return iter_5_1
		end
	end
end

function var_0_0._initBonusConfig(arg_6_0)
	arg_6_0._bonusConfig = {}

	local var_6_0 = 1

	for iter_6_0, iter_6_1 in ipairs(lua_activity134_bonus.configList) do
		arg_6_0._bonusConfig[var_6_0] = iter_6_1
		var_6_0 = var_6_0 + 1
	end
end

function var_0_0.getBonusAllConfig(arg_7_0)
	return arg_7_0._bonusConfig
end

function var_0_0.getBonusConfig(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._bonusConfig[arg_8_1]

	if var_8_0 and var_8_0.id == arg_8_1 then
		return var_8_0
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._bonusConfig) do
		if iter_8_1.id == arg_8_1 then
			return iter_8_1
		end
	end

	return var_8_0
end

function var_0_0._initStoryConfig(arg_9_0)
	arg_9_0._storyConfig = {}

	for iter_9_0, iter_9_1 in ipairs(lua_activity134_story.configList) do
		arg_9_0._storyConfig[iter_9_1.id] = iter_9_1
	end
end

function var_0_0.getStoryConfig(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._storyConfig[arg_10_1]

	if not var_10_0 then
		logError("[1.4运营活动下半场尘封记录数据错误] 找不到对应的故事配置:id = " .. arg_10_1)

		return
	end

	return var_10_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
