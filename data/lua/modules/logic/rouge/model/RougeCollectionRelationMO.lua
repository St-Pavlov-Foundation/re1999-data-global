module("modules.logic.rouge.model.RougeCollectionRelationMO", package.seeall)

local var_0_0 = pureTable("RougeCollectionRelationMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.effectIndex = tonumber(arg_1_1.effectIndex)
	arg_1_0.showType = tonumber(arg_1_1.showType)

	arg_1_0:updateTrueCollectionIds(arg_1_1.trueGuids)
end

function var_0_0.updateTrueCollectionIds(arg_2_0, arg_2_1)
	arg_2_0.trueIds = {}

	if arg_2_1 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			table.insert(arg_2_0.trueIds, tonumber(iter_2_1))
		end
	end
end

function var_0_0.getTrueCollectionIds(arg_3_0)
	return arg_3_0.trueIds
end

return var_0_0
