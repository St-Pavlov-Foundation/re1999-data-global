module("modules.logic.weekwalk.model.BattleInfoMO", package.seeall)

local var_0_0 = pureTable("BattleInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.battleId = arg_1_1.battleId
	arg_1_0.star = arg_1_1.star
	arg_1_0.maxStar = arg_1_1.maxStar
	arg_1_0.heroIds = {}
	arg_1_0.heroGroupSelect = arg_1_1.heroGroupSelect or 0
	arg_1_0.elementId = arg_1_1.elementId

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.heroIds) do
		table.insert(arg_1_0.heroIds, iter_1_1)
	end
end

function var_0_0.setIndex(arg_2_0, arg_2_1)
	arg_2_0.index = arg_2_1
end

return var_0_0
