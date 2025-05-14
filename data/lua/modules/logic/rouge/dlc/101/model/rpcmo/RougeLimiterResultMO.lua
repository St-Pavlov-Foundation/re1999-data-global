module("modules.logic.rouge.dlc.101.model.rpcmo.RougeLimiterResultMO", package.seeall)

local var_0_0 = pureTable("RougeLimiterResultMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.addEmblem = tonumber(arg_1_1.addEmblem)
	arg_1_0.useLimitBuffIds = {}

	tabletool.addValues(arg_1_0.useLimitBuffIds, arg_1_1.useLimitBuffIds)
end

function var_0_0.getLimiterAddEmblem(arg_2_0)
	return arg_2_0.addEmblem or 0
end

function var_0_0.getLimiterUseBuffIds(arg_3_0)
	return arg_3_0.useLimitBuffIds
end

function var_0_0.setPreEmbleCount(arg_4_0, arg_4_1)
	arg_4_0.preEmbleCount = arg_4_1 or 0
end

function var_0_0.getPreEmbleCount(arg_5_0)
	return arg_5_0.preEmbleCount or 0
end

return var_0_0
