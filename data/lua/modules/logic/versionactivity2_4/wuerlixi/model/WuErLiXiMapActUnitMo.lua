module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapActUnitMo", package.seeall)

local var_0_0 = pureTable("WuErLiXiMapActUnitMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.type = 0
	arg_1_0.count = 0
	arg_1_0.dir = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local var_2_0 = string.splitToNumber(arg_2_1, "#")

	arg_2_0.type = var_2_0[1]
	arg_2_0.count = var_2_0[2]
	arg_2_0.dir = var_2_0[3]
	arg_2_0.id = var_2_0[4] or var_2_0[1]
end

return var_0_0
