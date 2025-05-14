module("modules.logic.versionactivity1_5.peaceulu.config.PeaceUluConfig", package.seeall)

local var_0_0 = class("PeaceUluConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._act145taskList = {}
	arg_1_0._act145bonusList = {}
	arg_1_0._act145voiceList = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity145_task",
		"activity145_task_bonus",
		"activity145_game",
		"activity145_const",
		"activity145_movement"
	}
end

function var_0_0.onInit(arg_3_0)
	return
end

function var_0_0.onConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "activity145_task_bonus" then
		for iter_4_0, iter_4_1 in ipairs(arg_4_2.configList) do
			table.insert(arg_4_0._act145bonusList, iter_4_1)
		end
	elseif arg_4_1 == "activity145_task" then
		for iter_4_2, iter_4_3 in ipairs(arg_4_2.configList) do
			table.insert(arg_4_0._act145taskList, iter_4_3)
		end
	elseif arg_4_1 == "activity145_movement" then
		for iter_4_4, iter_4_5 in ipairs(arg_4_2.configList) do
			table.insert(arg_4_0._act145voiceList, iter_4_5)
		end
	end
end

function var_0_0.getBonusCoList(arg_5_0)
	return arg_5_0._act145bonusList
end

function var_0_0.getBonusCount(arg_6_0)
	return #arg_6_0._act145bonusList
end

function var_0_0.getVoiceList(arg_7_0)
	return arg_7_0._act145voiceList
end

function var_0_0.getVoiceConfigByType(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._act145voiceList) do
		if arg_8_1 == iter_8_1.type then
			return iter_8_1
		end
	end
end

function var_0_0.getMaxProgress(arg_9_0)
	local var_9_0 = arg_9_0._act145bonusList[#arg_9_0._act145bonusList]

	return string.split(var_9_0.needProgress, "#")[3]
end

function var_0_0.getProgressByIndex(arg_10_0, arg_10_1)
	if arg_10_1 < 1 and arg_10_1 > #arg_10_0._act145bonusList then
		return
	end

	local var_10_0 = arg_10_0._act145bonusList[arg_10_1]
	local var_10_1 = string.split(var_10_0.needProgress, "#")

	return tonumber(var_10_1[3])
end

function var_0_0.getTaskCoList(arg_11_0)
	return arg_11_0._act145taskList
end

function var_0_0.getTaskCo(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._act145taskList) do
		if iter_12_1.id == arg_12_1 then
			return iter_12_1
		end
	end

	return arg_12_0._act145taskList[arg_12_1]
end

function var_0_0.getGameTimes(arg_13_0)
	return 3
end

var_0_0.instance = var_0_0.New()

return var_0_0
