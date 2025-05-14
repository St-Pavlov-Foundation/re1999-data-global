module("modules.logic.rouge.dlc.101.model.rpcmo.RougeGameLimiterMO", package.seeall)

local var_0_0 = pureTable("RougeGameLimiterMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.riskId = arg_1_1.riskId
	arg_1_0.riskValue = arg_1_1.riskValue
	arg_1_0.limitIds = tabletool.copy(arg_1_1.limitIds)
	arg_1_0.limitBuffIds = tabletool.copy(arg_1_1.limitBuffIds)
end

function var_0_0.getLimiterIds(arg_2_0)
	return arg_2_0.limitIds
end

function var_0_0.getLimiterBuffIds(arg_3_0)
	return arg_3_0.limitBuffIds
end

function var_0_0.getRiskValue(arg_4_0)
	return arg_4_0.riskValue
end

return var_0_0
