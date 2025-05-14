module("modules.logic.rouge.model.rpcmo.RougeHeroLifeMO", package.seeall)

local var_0_0 = pureTable("RougeHeroLifeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.heroId = arg_1_1.heroId
	arg_1_0.life = arg_1_1.life
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.heroId = arg_2_1.heroId
	arg_2_0.life = arg_2_1.life
end

return var_0_0
