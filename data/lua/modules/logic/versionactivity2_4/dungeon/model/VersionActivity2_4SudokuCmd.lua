module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4SudokuCmd", package.seeall)

local var_0_0 = class("VersionActivity2_4SudokuCmd")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._idx = arg_1_1
	arg_1_0._oriNum = arg_1_2
	arg_1_0._newNum = arg_1_3
	arg_1_0._undo = false
end

function var_0_0.getIdx(arg_2_0)
	return arg_2_0._idx
end

function var_0_0.getOriNum(arg_3_0)
	return arg_3_0._oriNum
end

function var_0_0.getNewNum(arg_4_0)
	return arg_4_0._newNum
end

function var_0_0.isUndo(arg_5_0)
	return arg_5_0._undo
end

function var_0_0.undo(arg_6_0)
	arg_6_0._newNum, arg_6_0._oriNum = arg_6_0._oriNum, arg_6_0._newNum
	arg_6_0._undo = true
end

return var_0_0
