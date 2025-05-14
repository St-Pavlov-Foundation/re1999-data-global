module("modules.logic.versionactivity1_4.act131.config.Activity131Config", package.seeall)

local var_0_0 = class("Activity131Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._act131EpisodeConfig = nil
	arg_1_0._act131ElementConfig = nil
	arg_1_0._act131DialogConfig = nil
	arg_1_0._act131DialogList = nil
	arg_1_0._act131TaskConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity131_episode",
		"activity131_element",
		"activity131_dialog",
		"activity131_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity131_episode" then
		arg_3_0._act131EpisodeConfig = arg_3_2
	elseif arg_3_1 == "activity131_element" then
		arg_3_0._act131ElementConfig = arg_3_2
	elseif arg_3_1 == "activity131_dialog" then
		arg_3_0._act131DialogConfig = arg_3_2

		arg_3_0:_initDialog()
	elseif arg_3_1 == "activity131_task" then
		arg_3_0._act131TaskConfig = arg_3_2
	end
end

function var_0_0.getActivity131EpisodeCos(arg_4_0, arg_4_1)
	return arg_4_0._act131EpisodeConfig.configDict[arg_4_1]
end

function var_0_0.getActivity131EpisodeCo(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0._act131EpisodeConfig.configDict[arg_5_1][arg_5_2]
end

function var_0_0.getActivity131ElementCo(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0._act131ElementConfig.configDict[arg_6_1][arg_6_2]
end

function var_0_0.getActivity131DialogCo(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0._act131DialogConfig.configDict[arg_7_1][arg_7_2]
end

function var_0_0.getActivity131DialogGroup(arg_8_0, arg_8_1)
	return arg_8_0._act131DialogConfig.configDict[arg_8_1]
end

function var_0_0._initDialog(arg_9_0)
	arg_9_0._act131DialogList = {}

	local var_9_0
	local var_9_1 = "0"

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._act131DialogConfig.configList) do
		local var_9_2 = arg_9_0._act131DialogList[iter_9_1.id]

		if not var_9_2 then
			var_9_2 = {
				optionParamList = {}
			}
			var_9_0 = var_9_1
			arg_9_0._act131DialogList[iter_9_1.id] = var_9_2
		end

		if not string.nilorempty(iter_9_1.option_param) then
			table.insert(var_9_2.optionParamList, tonumber(iter_9_1.option_param))
		end

		if iter_9_1.type == "selector" then
			var_9_0 = iter_9_1.param
			var_9_2[var_9_0] = var_9_2[var_9_0] or {}
			var_9_2[var_9_0].type = iter_9_1.type
			var_9_2[var_9_0].option_param = iter_9_1.option_param
		elseif iter_9_1.type == "selectorend" then
			var_9_0 = var_9_1
		elseif iter_9_1.type == "random" then
			local var_9_3 = iter_9_1.param

			var_9_2[var_9_3] = var_9_2[var_9_3] or {}
			var_9_2[var_9_3].type = iter_9_1.type
			var_9_2[var_9_3].option_param = iter_9_1.option_param

			table.insert(var_9_2[var_9_3], iter_9_1)
		else
			var_9_2[var_9_0] = var_9_2[var_9_0] or {}

			table.insert(var_9_2[var_9_0], iter_9_1)
		end
	end
end

function var_0_0.getDialog(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._act131DialogList[arg_10_1]

	return var_10_0 and var_10_0[arg_10_2]
end

function var_0_0.getOptionParamList(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._act131DialogList[arg_11_1]

	return var_11_0 and var_11_0.optionParamList
end

function var_0_0.getActivity131TaskCo(arg_12_0, arg_12_1)
	return arg_12_0._act131TaskConfig.configDict[arg_12_1]
end

function var_0_0.getTaskByActId(arg_13_0, arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0._act131TaskConfig.configList) do
		if iter_13_1.activityId == arg_13_1 then
			table.insert(var_13_0, iter_13_1)
		end
	end

	return var_13_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
