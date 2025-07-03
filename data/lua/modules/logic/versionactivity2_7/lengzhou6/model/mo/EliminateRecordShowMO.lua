module("modules.logic.versionactivity2_7.lengzhou6.model.mo.EliminateRecordShowMO", package.seeall)

local var_0_0 = class("EliminateRecordShowMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0._eliminateList = {}
	arg_1_0._changeTypeList = {}
	arg_1_0._moveList = {}
	arg_1_0._newList = {}
end

function var_0_0.getEliminate(arg_2_0)
	return arg_2_0._eliminateList
end

function var_0_0.getChangeType(arg_3_0)
	return arg_3_0._changeTypeList
end

function var_0_0.getMove(arg_4_0)
	return arg_4_0._moveList
end

function var_0_0.getNew(arg_5_0)
	return arg_5_0._newList
end

function var_0_0.addEliminate(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	table.insert(arg_6_0._eliminateList, arg_6_1)
	table.insert(arg_6_0._eliminateList, arg_6_2)
	table.insert(arg_6_0._eliminateList, arg_6_3)
end

function var_0_0.addChangeType(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	table.insert(arg_7_0._changeTypeList, arg_7_1)
	table.insert(arg_7_0._changeTypeList, arg_7_2)
	table.insert(arg_7_0._changeTypeList, arg_7_3)
end

function var_0_0.addMove(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	table.insert(arg_8_0._moveList, arg_8_1)
	table.insert(arg_8_0._moveList, arg_8_2)
	table.insert(arg_8_0._moveList, arg_8_3)
	table.insert(arg_8_0._moveList, arg_8_4)
end

function var_0_0.addNew(arg_9_0, arg_9_1, arg_9_2)
	table.insert(arg_9_0._newList, arg_9_1)
	table.insert(arg_9_0._newList, arg_9_2)
end

function var_0_0.reset(arg_10_0)
	tabletool.clear(arg_10_0._eliminateList)
	tabletool.clear(arg_10_0._changeTypeList)
	tabletool.clear(arg_10_0._moveList)
	tabletool.clear(arg_10_0._newList)
end

return var_0_0
