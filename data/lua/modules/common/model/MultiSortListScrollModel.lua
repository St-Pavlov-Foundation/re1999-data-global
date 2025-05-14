module("modules.common.model.MultiSortListScrollModel", package.seeall)

local var_0_0 = class("MultiSortListScrollModel", ListScrollModel)

function var_0_0.initSort(arg_1_0)
	arg_1_0._addSortNum = 0
	arg_1_0._curSortType = nil
	arg_1_0._curSortAscending = nil
	arg_1_0._sortFuncList = {}
	arg_1_0._sortAscendingList = {}
	arg_1_0._sortList = {}
	arg_1_0._firstSort = nil
	arg_1_0._lastSort = nil
	arg_1_0._ipair = ipairs

	function arg_1_0._tableSort(arg_2_0, arg_2_1)
		return var_0_0._sortFunc(arg_2_0, arg_2_1, arg_1_0)
	end
end

function var_0_0.getSortState(arg_3_0, arg_3_1)
	return (arg_3_0._curSortType == arg_3_1 and arg_3_0._curSortAscending or arg_3_0._sortAscendingList[arg_3_1]) and 1 or -1
end

function var_0_0.addOtherSort(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._firstSort = arg_4_1
	arg_4_0._lastSort = arg_4_2
end

function var_0_0.addSortType(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0._sortFuncList[arg_5_1] then
		logError("sortType already exist")

		return
	end

	if not arg_5_2 then
		logError("sortFunc is nil")

		return
	end

	arg_5_0._sortFuncList[arg_5_1] = arg_5_2
	arg_5_0._sortAscendingList[arg_5_1] = arg_5_3 == true
	arg_5_0._addSortNum = arg_5_0._addSortNum + 1
end

function var_0_0.setCurSortType(arg_6_0, arg_6_1)
	if not arg_6_0._sortFuncList[arg_6_1] then
		logError("sortType is not exist")

		return
	end

	if arg_6_0._curSortType == arg_6_1 then
		arg_6_0._curSortAscending = not arg_6_0._curSortAscending
	else
		arg_6_0._curSortAscending = arg_6_0._sortAscendingList[arg_6_1]
		arg_6_0._curSortType = arg_6_1
	end

	arg_6_0:_doSort()
end

function var_0_0.getCurSortType(arg_7_0)
	return arg_7_0._curSortType
end

function var_0_0.setSortList(arg_8_0, arg_8_1)
	arg_8_0._sortList = arg_8_1

	arg_8_0:_doSort()
end

function var_0_0._doSort(arg_9_0)
	if not arg_9_0._sortList then
		return
	end

	if arg_9_0._curSortType then
		if arg_9_0._addSortNum ~= #arg_9_0._sortFuncList then
			logError("sortFuncList is not complete")

			return
		end

		table.sort(arg_9_0._sortList, arg_9_0._tableSort)
	end

	arg_9_0:setList(arg_9_0._sortList)
end

function var_0_0._sortFunc(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if arg_10_2._firstSort then
		var_10_0 = arg_10_2._firstSort(arg_10_0, arg_10_1, arg_10_2)
	end

	if var_10_0 ~= nil then
		return var_10_0
	end

	local var_10_1 = arg_10_2._sortFuncList[arg_10_2._curSortType](arg_10_0, arg_10_1, arg_10_2._curSortAscending, arg_10_2)

	if var_10_1 ~= nil then
		return var_10_1
	end

	for iter_10_0, iter_10_1 in arg_10_2._ipair(arg_10_2._sortFuncList) do
		if iter_10_0 ~= arg_10_2._curSortType then
			local var_10_2 = iter_10_1(arg_10_0, arg_10_1, arg_10_2._sortAscendingList[iter_10_0], arg_10_2)

			if var_10_2 ~= nil then
				return var_10_2
			end
		end
	end

	local var_10_3 = arg_10_2._lastSort and arg_10_2._lastSort(arg_10_0, arg_10_1, arg_10_2) or nil

	if var_10_3 ~= nil then
		return var_10_3
	end

	return false
end

return var_0_0
