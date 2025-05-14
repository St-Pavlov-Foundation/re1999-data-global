module("modules.logic.player.model.PlayerClothMO", package.seeall)

local var_0_0 = pureTable("PlayerClothMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = nil
	arg_1_0.clothId = nil
	arg_1_0.level = nil
	arg_1_0.exp = nil
	arg_1_0.has = nil
end

function var_0_0.initFromConfig(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.clothId = arg_2_1.id
	arg_2_0.level = 0
	arg_2_0.exp = 0
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.level = arg_3_1.level
	arg_3_0.exp = arg_3_1.exp
	arg_3_0.has = true
end

return var_0_0
