module("modules.logic.rouge.model.RougeNewReddotNOMO", package.seeall)

local var_0_0 = pureTable("RougeNewReddotNOMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.type = arg_1_1.type
	arg_1_0.idNum = #arg_1_1.ids
	arg_1_0.idMap = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.ids) do
		arg_1_0.idMap[iter_1_1] = iter_1_1
	end
end

function var_0_0.removeId(arg_2_0, arg_2_1)
	if arg_2_1 == 0 then
		arg_2_0.idMap = {}
		arg_2_0.idNum = 0
	end

	if arg_2_0.idMap[arg_2_1] then
		arg_2_0.idMap[arg_2_1] = nil
		arg_2_0.idNum = arg_2_0.idNum - 1
	end
end

return var_0_0
