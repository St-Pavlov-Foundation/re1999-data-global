module("framework.core.datastruct.PriorityQueue", package.seeall)

local var_0_0 = class("PriorityQueue")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._compareFunc = arg_1_1
	arg_1_0._dataList = {}
	arg_1_0._markRemoveDict = {}
	arg_1_0._removeCount = 0
end

function var_0_0.getFirst(arg_2_0)
	arg_2_0:_disposeMarkRemove()

	return arg_2_0._dataList[1]
end

function var_0_0.getFirstAndRemove(arg_3_0)
	arg_3_0:_disposeMarkRemove()

	local var_3_0 = arg_3_0._dataList[1]
	local var_3_1 = #arg_3_0._dataList

	arg_3_0._dataList[1] = arg_3_0._dataList[var_3_1]
	arg_3_0._dataList[var_3_1] = nil

	arg_3_0:_sink(1)

	return var_3_0
end

function var_0_0.add(arg_4_0, arg_4_1)
	local var_4_0 = #arg_4_0._dataList + 1

	arg_4_0._dataList[var_4_0] = arg_4_1

	arg_4_0:_float(var_4_0)
end

function var_0_0.getSize(arg_5_0)
	return #arg_5_0._dataList - arg_5_0._removeCount
end

function var_0_0.markRemove(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._dataList) do
		if not arg_6_0._markRemoveDict[iter_6_1] and arg_6_1(iter_6_1) then
			local var_6_0 = type(iter_6_1)
			local var_6_1 = var_6_0 == "table" or var_6_0 == "userdata" or var_6_0 == "function"

			if not var_6_1 then
				logWarn("PriorityQueue mark remove warnning, type = " .. var_6_0 .. ", value = " .. tostring(iter_6_1))
			end

			local var_6_2 = var_6_1 and iter_6_1 or {
				iter_6_1
			}

			arg_6_0._dataList[iter_6_0] = var_6_2
			arg_6_0._markRemoveDict[var_6_2] = true
			arg_6_0._removeCount = arg_6_0._removeCount + 1
		end
	end
end

function var_0_0._sink(arg_7_0, arg_7_1)
	local var_7_0 = #arg_7_0._dataList

	while var_7_0 >= 2 * arg_7_1 do
		local var_7_1 = 2 * arg_7_1

		if var_7_0 >= var_7_1 + 1 and not arg_7_0._compareFunc(arg_7_0._dataList[var_7_1], arg_7_0._dataList[var_7_1 + 1]) then
			var_7_1 = var_7_1 + 1
		end

		if arg_7_0._compareFunc(arg_7_0._dataList[arg_7_1], arg_7_0._dataList[var_7_1]) then
			break
		end

		arg_7_0:_swap(arg_7_1, var_7_1)

		arg_7_1 = var_7_1
	end
end

function var_0_0._float(arg_8_0, arg_8_1)
	while arg_8_1 > 1 do
		local var_8_0 = bit.rshift(arg_8_1, 1)

		if not arg_8_0._compareFunc(arg_8_0._dataList[arg_8_1], arg_8_0._dataList[var_8_0]) then
			break
		end

		arg_8_0:_swap(arg_8_1, var_8_0)

		arg_8_1 = var_8_0
	end
end

function var_0_0._swap(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._dataList[arg_9_1]

	arg_9_0._dataList[arg_9_1] = arg_9_0._dataList[arg_9_2]
	arg_9_0._dataList[arg_9_2] = var_9_0
end

function var_0_0._disposeMarkRemove(arg_10_0)
	while #arg_10_0._dataList > 0 and arg_10_0._markRemoveDict[arg_10_0._dataList[1]] do
		arg_10_0._markRemoveDict[arg_10_0._dataList[1]] = nil
		arg_10_0._removeCount = arg_10_0._removeCount - 1

		local var_10_0 = #arg_10_0._dataList

		arg_10_0._dataList[1] = arg_10_0._dataList[var_10_0]
		arg_10_0._dataList[var_10_0] = nil

		arg_10_0:_sink(1)
	end
end

return var_0_0
