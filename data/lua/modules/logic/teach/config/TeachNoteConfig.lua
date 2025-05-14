module("modules.logic.teach.config.TeachNoteConfig", package.seeall)

local var_0_0 = class("TeachNoteConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.topicConfig = nil
	arg_1_0.levelConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"instruction_topic",
		"instruction_level"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "instruction_topic" then
		arg_3_0.topicConfig = arg_3_2
	elseif arg_3_1 == "instruction_level" then
		arg_3_0.levelConfig = arg_3_2
	end
end

function var_0_0.getInstructionTopicCos(arg_4_0)
	return arg_4_0.topicConfig.configDict
end

function var_0_0.getInstructionLevelCos(arg_5_0)
	return arg_5_0.levelConfig.configDict
end

function var_0_0.getInstructionTopicCO(arg_6_0, arg_6_1)
	return arg_6_0.topicConfig.configDict[arg_6_1]
end

function var_0_0.getInstructionLevelCO(arg_7_0, arg_7_1)
	return arg_7_0.levelConfig.configDict[arg_7_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
