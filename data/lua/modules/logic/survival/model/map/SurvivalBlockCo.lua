module("modules.logic.survival.model.map.SurvivalBlockCo", package.seeall)

local var_0_0 = pureTable("SurvivalBlockCo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.pos = SurvivalHexNode.New(arg_1_1[1], arg_1_1[2])
	arg_1_0.walkable = arg_1_1[3]
	arg_1_0.dir = arg_1_1[4]
	arg_1_0.assetPath = arg_1_2[arg_1_1[5]]
	arg_1_0.exNodes = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1[6]) do
		table.insert(arg_1_0.exNodes, SurvivalHexNode.New(iter_1_1[1] + arg_1_0.pos.q, iter_1_1[2] + arg_1_0.pos.r))
	end
end

function var_0_0.getRange(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1, var_2_2, var_2_3 = arg_2_0:getSelfRange()

	if not arg_2_1 then
		return var_2_0, var_2_1, var_2_2, var_2_3
	else
		return math.min(arg_2_1, var_2_0), math.max(arg_2_2, var_2_1), math.min(arg_2_3, var_2_2), math.max(arg_2_4, var_2_3)
	end
end

function var_0_0.getSelfRange(arg_3_0)
	local var_3_0 = arg_3_0.pos.q + arg_3_0.pos.r / 2
	local var_3_1 = -arg_3_0.pos.r
	local var_3_2 = var_3_0
	local var_3_3 = var_3_0
	local var_3_4 = var_3_1
	local var_3_5 = var_3_1

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.exNodes) do
		local var_3_6 = iter_3_1.q + iter_3_1.r / 2
		local var_3_7 = -iter_3_1.r

		var_3_2 = math.min(var_3_2, var_3_6)
		var_3_3 = math.max(var_3_3, var_3_6)
		var_3_4 = math.min(var_3_4, var_3_7)
		var_3_5 = math.max(var_3_5, var_3_7)
	end

	return var_3_2, var_3_3, var_3_4, var_3_5
end

return var_0_0
