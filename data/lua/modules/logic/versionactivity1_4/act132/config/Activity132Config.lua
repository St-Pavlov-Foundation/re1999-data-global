module("modules.logic.versionactivity1_4.act132.config.Activity132Config", package.seeall)

local var_0_0 = class("Activity132Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.clueDict = {}
	arg_1_0.collectDict = {}
	arg_1_0.contentDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity132_clue",
		"activity132_collect",
		"activity132_content"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("on%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_1, arg_3_2)
	end
end

function var_0_0.onactivity132_clueConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.clueDict = arg_4_2.configDict
end

function var_0_0.onactivity132_collectConfigLoaded(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.collectDict = arg_5_2.configDict
end

function var_0_0.onactivity132_contentConfigLoaded(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.contentDict = arg_6_2.configDict
end

function var_0_0.getCollectConfig(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.collectDict[arg_7_1]
	local var_7_1 = var_7_0 and var_7_0[arg_7_2]

	if not var_7_1 then
		logError(string.format("can not find collect! activityId:%s collectId:%s", arg_7_1, arg_7_2))
	end

	return var_7_1
end

function var_0_0.getClueConfig(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.clueDict[arg_8_1]
	local var_8_1 = var_8_0 and var_8_0[arg_8_2]

	if not var_8_1 then
		logError(string.format("can not find clue config! activityId:%s clueId:%s", arg_8_1, arg_8_2))
	end

	return var_8_1
end

function var_0_0.getContentConfig(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.contentDict[arg_9_1]
	local var_9_1 = var_9_0 and var_9_0[arg_9_2]

	if not var_9_1 then
		logError(string.format("can not find content config! activityId:%s contentId:%s", arg_9_1, arg_9_2))
	end

	return var_9_1
end

function var_0_0.getCollectDict(arg_10_0, arg_10_1)
	return arg_10_0.collectDict[arg_10_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
