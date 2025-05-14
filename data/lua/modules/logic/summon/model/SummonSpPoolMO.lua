module("modules.logic.summon.model.SummonSpPoolMO", package.seeall)

local var_0_0 = pureTable("SummonSpPoolMO", SummonCustomPickMO)

function var_0_0.ctor(arg_1_0)
	arg_1_0.type = 0
	arg_1_0.openTime = 0

	SummonCustomPickMO.ctor(arg_1_0)
end

function var_0_0.isValid(arg_2_0)
	return arg_2_0.type ~= 0
end

function var_0_0.update(arg_3_0, arg_3_1)
	SummonCustomPickMO.update(arg_3_0, arg_3_1)

	arg_3_0.type = arg_3_1.type
	arg_3_0.openTime = tonumber(arg_3_1.openTime) or 0
end

function var_0_0.isOpening(arg_4_0)
	if not arg_4_0:isValid() then
		return nil
	end

	local var_4_0 = ServerTime.now()

	return var_4_0 >= arg_4_0:onlineTs() and var_4_0 <= arg_4_0:offlineTs()
end

function var_0_0.onlineTs(arg_5_0)
	return arg_5_0.openTime / 1000
end

function var_0_0.offlineTs(arg_6_0)
	if arg_6_0:onlineTs() <= 0 then
		return 0
	end

	local var_6_0 = SummonConfig.instance:getDurationByPoolType(arg_6_0.type)

	if var_6_0 <= 0 then
		return 0
	end

	return arg_6_0:onlineTs() + var_6_0
end

function var_0_0.onOffTimestamp(arg_7_0)
	return arg_7_0:onlineTs(), arg_7_0:offlineTs()
end

return var_0_0
