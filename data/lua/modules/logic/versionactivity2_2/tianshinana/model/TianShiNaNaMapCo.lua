module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapCo", package.seeall)

local var_0_0 = pureTable("TianShiNaNaMapCo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.path = arg_1_1[1]
	arg_1_0.unitDict = {}
	arg_1_0.nodesDict = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1[2]) do
		local var_1_0 = TianShiNaNaMapUnitCo.New()

		var_1_0:init(iter_1_1)

		arg_1_0.unitDict[var_1_0.id] = var_1_0
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1[3]) do
		local var_1_1 = TianShiNaNaMapNodeCo.New()

		var_1_1:init(iter_1_3)

		if not arg_1_0.nodesDict[var_1_1.x] then
			arg_1_0.nodesDict[var_1_1.x] = {}
		end

		arg_1_0.nodesDict[var_1_1.x][var_1_1.y] = var_1_1
	end
end

function var_0_0.getUnitCo(arg_2_0, arg_2_1)
	return arg_2_0.unitDict[arg_2_1]
end

function var_0_0.getNodeCo(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0.nodesDict[arg_3_1] then
		return
	end

	return arg_3_0.nodesDict[arg_3_1][arg_3_2]
end

return var_0_0
