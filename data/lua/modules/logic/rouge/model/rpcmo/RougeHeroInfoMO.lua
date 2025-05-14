module("modules.logic.rouge.model.rpcmo.RougeHeroInfoMO", package.seeall)

local var_0_0 = pureTable("RougeHeroInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:update(arg_1_1)
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.heroId = arg_2_1.heroId
	arg_2_0.stressValue = arg_2_1.stressValue
	arg_2_0.stressValueLimit = arg_2_1.stressValueLimit
end

function var_0_0.getStressValue(arg_3_0)
	return arg_3_0.stressValue or 0
end

function var_0_0.getStressRange(arg_4_0)
	local var_4_0 = arg_4_0:getStressValueLimit()

	return 0, var_4_0
end

function var_0_0.getStressValueLimit(arg_5_0)
	return arg_5_0.stressValueLimit or 0
end

return var_0_0
