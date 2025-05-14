module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4SudokuModel", package.seeall)

local var_0_0 = class("VersionActivity2_4SudokuModel", BaseModel)
local var_0_1 = "modules.configs.sudoku.lua_sudoku_%s"
local var_0_2 = "lua_sudoku_%s"

function var_0_0.onInit(arg_1_0)
	arg_1_0._operateCmdList = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:init()
end

function var_0_0.init(arg_3_0)
	arg_3_0._curSelectItemIdx = 0
end

function var_0_0.selectItem(arg_4_0, arg_4_1)
	arg_4_0._curSelectItemIdx = arg_4_1
end

function var_0_0.getSelectedItem(arg_5_0)
	return arg_5_0._curSelectItemIdx
end

function var_0_0.selectKeyboardItem(arg_6_0, arg_6_1)
	arg_6_0._curSelectKeyboardIdx = arg_6_1
end

function var_0_0.getSelectedKeyboardItem(arg_7_0)
	return arg_7_0._curSelectKeyboardIdx
end

function var_0_0.pushCmd(arg_8_0, arg_8_1)
	arg_8_0._operateCmdList[#arg_8_0._operateCmdList + 1] = arg_8_1
end

function var_0_0.popCmd(arg_9_0)
	if #arg_9_0._operateCmdList == 0 then
		return nil
	end

	local var_9_0 = arg_9_0._operateCmdList[#arg_9_0._operateCmdList]

	arg_9_0._operateCmdList[#arg_9_0._operateCmdList] = nil

	return var_9_0
end

function var_0_0.clearCmd(arg_10_0)
	arg_10_0._operateCmdList = {}
end

function var_0_0.getSudokuCfg(arg_11_0, arg_11_1)
	return (addGlobalModule(string.format(var_0_1, arg_11_1), string.format("lua_chessgame_group_", arg_11_1)))
end

var_0_0.instance = var_0_0.New()

return var_0_0
