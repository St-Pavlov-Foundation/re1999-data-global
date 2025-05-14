module("modules.logic.antique.model.AntiqueMo", package.seeall)

local var_0_0 = pureTable("AntiqueMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.getTime = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = tonumber(arg_2_1.antiqueId)
	arg_2_0.getTime = arg_2_1.getTime
end

function var_0_0.reset(arg_3_0, arg_3_1)
	arg_3_0.id = tonumber(arg_3_1.antiqueId)
	arg_3_0.getTime = arg_3_1.getTime
end

return var_0_0
