module("modules.logic.survival.model.rewardinherit.SurvivalPosSelectMo", package.seeall)

local var_0_0 = pureTable("SurvivalPosSelectMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.cache = {}
	arg_1_0.dataList = {}
end

function var_0_0.addToEmptyPos(arg_2_0, arg_2_1)
	table.insert(arg_2_0.dataList, arg_2_1)
end

function var_0_0.addToPos(arg_3_0, arg_3_1, arg_3_2)
	table.insert(arg_3_0.dataList, arg_3_1, arg_3_2)
end

function var_0_0.removeFromPos(arg_4_0, arg_4_1)
	table.remove(arg_4_0.dataList, arg_4_1)
end

function var_0_0.removeByValue(arg_5_0, arg_5_1)
	tabletool.removeValue(arg_5_0.dataList, arg_5_1)
end

function var_0_0.removeAll(arg_6_0)
	tabletool.clear(arg_6_0.dataList)
end

function var_0_0.isSelect(arg_7_0, arg_7_1)
	return tabletool.indexOf(arg_7_0.dataList, arg_7_1) ~= nil
end

function var_0_0.Record(arg_8_0)
	tabletool.clear(arg_8_0.cache)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.dataList) do
		arg_8_0.cache[iter_8_0] = iter_8_1
	end
end

function var_0_0.Revert(arg_9_0)
	tabletool.clear(arg_9_0.dataList)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.cache) do
		arg_9_0.dataList[iter_9_0] = iter_9_1
	end
end

function var_0_0.clear(arg_10_0)
	tabletool.clear(arg_10_0.dataList)
	tabletool.clear(arg_10_0.cache)
end

return var_0_0
