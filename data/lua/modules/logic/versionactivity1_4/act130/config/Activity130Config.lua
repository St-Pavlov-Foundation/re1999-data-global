module("modules.logic.versionactivity1_4.act130.config.Activity130Config", package.seeall)

local var_0_0 = class("Activity130Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._act130EpisodeConfig = nil
	arg_1_0._act130DecryptConfig = nil
	arg_1_0._act130OperGroupConfig = nil
	arg_1_0._act130ElementConfig = nil
	arg_1_0._act130DialogList = nil
	arg_1_0._act130TaskConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity130_episode",
		"activity130_decrypt",
		"activity130_oper_group",
		"activity130_element",
		"activity130_dialog",
		"activity130_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity130_episode" then
		arg_3_0._act130EpisodeConfig = arg_3_2
	elseif arg_3_1 == "activity130_decrypt" then
		arg_3_0._act130DecryptConfig = arg_3_2
	elseif arg_3_1 == "activity130_oper_group" then
		arg_3_0._act130OperGroupConfig = arg_3_2
	elseif arg_3_1 == "activity130_element" then
		arg_3_0._act130ElementConfig = arg_3_2
	elseif arg_3_1 == "activity130_dialog" then
		arg_3_0:_initDialog()
	elseif arg_3_1 == "activity130_task" then
		arg_3_0._act130TaskConfig = arg_3_2
	end
end

function var_0_0.getActivity130EpisodeCos(arg_4_0, arg_4_1)
	return arg_4_0._act130EpisodeConfig.configDict[arg_4_1]
end

function var_0_0.getActivity130EpisodeCo(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0._act130EpisodeConfig.configDict[arg_5_1][arg_5_2]
end

function var_0_0.getActivity130DecryptCos(arg_6_0, arg_6_1)
	return arg_6_0._act130DecryptConfig.configDict[arg_6_1]
end

function var_0_0.getActivity130DecryptCo(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0._act130DecryptConfig.configDict[arg_7_1][arg_7_2]
end

function var_0_0.getActivity130OperateGroupCos(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0._act130OperGroupConfig.configDict[arg_8_1][arg_8_2]
end

function var_0_0.getActivity130ElementCo(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0._act130ElementConfig.configDict[arg_9_1][arg_9_2]
end

function var_0_0.getActivity130DialogCo(arg_10_0, arg_10_1, arg_10_2)
	return lua_activity130_dialog.configDict[arg_10_1][arg_10_2]
end

function var_0_0._initDialog(arg_11_0)
	arg_11_0._act130DialogList = {}

	local var_11_0
	local var_11_1 = "0"

	for iter_11_0, iter_11_1 in ipairs(lua_activity130_dialog.configList) do
		local var_11_2 = arg_11_0._act130DialogList[iter_11_1.id]

		if not var_11_2 then
			var_11_2 = {
				optionParamList = {}
			}
			var_11_0 = var_11_1
			arg_11_0._act130DialogList[iter_11_1.id] = var_11_2
		end

		if not string.nilorempty(iter_11_1.option_param) then
			table.insert(var_11_2.optionParamList, tonumber(iter_11_1.option_param))
		end

		if iter_11_1.type == "selector" then
			var_11_0 = iter_11_1.param
			var_11_2[var_11_0] = var_11_2[var_11_0] or {}
			var_11_2[var_11_0].type = iter_11_1.type
			var_11_2[var_11_0].option_param = iter_11_1.option_param
		elseif iter_11_1.type == "selectorend" then
			var_11_0 = var_11_1
		elseif iter_11_1.type == "random" then
			local var_11_3 = iter_11_1.param

			var_11_2[var_11_3] = var_11_2[var_11_3] or {}
			var_11_2[var_11_3].type = iter_11_1.type
			var_11_2[var_11_3].option_param = iter_11_1.option_param

			table.insert(var_11_2[var_11_3], iter_11_1)
		else
			var_11_2[var_11_0] = var_11_2[var_11_0] or {}

			table.insert(var_11_2[var_11_0], iter_11_1)
		end
	end
end

function var_0_0.getDialog(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._act130DialogList[arg_12_1]

	return var_12_0 and var_12_0[arg_12_2]
end

function var_0_0.getOptionParamList(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._act130DialogList[arg_13_1]

	return var_13_0 and var_13_0.optionParamList
end

function var_0_0.getActivity130TaskCo(arg_14_0, arg_14_1)
	return arg_14_0._act130TaskConfig.configDict[arg_14_1]
end

function var_0_0.getTaskByActId(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._act130TaskConfig.configList) do
		if iter_15_1.activityId == arg_15_1 then
			table.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

function var_0_0.getOperGroup(arg_16_0, arg_16_1, arg_16_2)
	return arg_16_0._act130OperGroupConfig.configDict[arg_16_1][arg_16_2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
