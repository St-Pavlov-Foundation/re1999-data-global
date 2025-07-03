module("modules.logic.gm.model.GMCommandHistoryModel", package.seeall)

local var_0_0 = class("GMCommandHistoryModel")
local var_0_1 = "|@|"
local var_0_2 = 30

function var_0_0._initCommandList(arg_1_0)
	if arg_1_0._commandList then
		return
	end

	local var_1_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewHistory, "")

	arg_1_0._commandList = string.split(var_1_0, var_0_1) or {}
end

function var_0_0.getCommandHistory(arg_2_0)
	arg_2_0:_initCommandList()

	return arg_2_0._commandList
end

function var_0_0.addCommandHistory(arg_3_0, arg_3_1)
	arg_3_0:_initCommandList()
	tabletool.removeValue(arg_3_0._commandList, arg_3_1)
	table.insert(arg_3_0._commandList, 1, arg_3_1)
	arg_3_0:_saveCommandList()
end

function var_0_0.removeCommandHistory(arg_4_0, arg_4_1)
	arg_4_0:_initCommandList()
	tabletool.removeValue(arg_4_0._commandList, arg_4_1)
	arg_4_0:_saveCommandList()
end

function var_0_0._saveCommandList(arg_5_0)
	while #arg_5_0._commandList > var_0_2 do
		table.remove(arg_5_0._commandList, #arg_5_0._commandList)
	end

	local var_5_0 = table.concat(arg_5_0._commandList, var_0_1)

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewHistory, var_5_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
