module("modules.logic.reddot.model.RedDotInfoMo", package.seeall)

local var_0_0 = pureTable("RedDotInfoMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.uid = tonumber(arg_1_1.id)
	arg_1_0.value = tonumber(arg_1_1.value)
	arg_1_0.time = arg_1_1.time
	arg_1_0.ext = arg_1_1.ext
end

function var_0_0.reset(arg_2_0, arg_2_1)
	arg_2_0.value = tonumber(arg_2_1.value)
	arg_2_0.time = arg_2_1.time
	arg_2_0.ext = arg_2_1.ext
end

return var_0_0
