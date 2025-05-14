module("modules.logic.summon.model.SummonMainPoolMO", package.seeall)

local var_0_0 = pureTable("SummonMainPoolMO")
local var_0_1 = require("modules.logic.summon.model.SummonSpPoolMO")

function var_0_0.onOffTimestamp(arg_1_0)
	local var_1_0 = arg_1_0.onlineTime
	local var_1_1 = arg_1_0.offlineTime

	if not arg_1_0.customPickMO:isValid() then
		return var_1_0, var_1_1
	end

	local var_1_2, var_1_3 = arg_1_0.customPickMO:onOffTimestamp()

	if var_1_2 > 0 then
		var_1_0 = var_1_2
		var_1_1 = var_1_3
	end

	return var_1_0, var_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.poolId
	arg_2_0.luckyBagMO = SummonLuckyBagMO.New()
	arg_2_0.customPickMO = var_0_1.New()

	arg_2_0:update(arg_2_1)
end

function var_0_0.update(arg_3_0, arg_3_1)
	arg_3_0.offlineTime = arg_3_1.offlineTime or 0
	arg_3_0.onlineTime = arg_3_1.onlineTime or 0
	arg_3_0.haveFree = arg_3_1.haveFree or false
	arg_3_0.usedFreeCount = arg_3_1.usedFreeCount or 0

	if arg_3_1.luckyBagInfo then
		arg_3_0.luckyBagMO:update(arg_3_1.luckyBagInfo)
	end

	if arg_3_1.spPoolInfo then
		arg_3_0.customPickMO:update(arg_3_1.spPoolInfo)
	end

	arg_3_0.discountTime = arg_3_1.discountTime or 0
	arg_3_0.canGetGuaranteeSRCount = arg_3_1.canGetGuaranteeSRCount or 0
	arg_3_0.guaranteeSRCountDown = arg_3_1.guaranteeSRCountDown or 0
end

function var_0_0.isOpening(arg_4_0)
	if arg_4_0.offlineTime == 0 and arg_4_0.onlineTime == 0 then
		return true
	end

	local var_4_0 = ServerTime.now()
	local var_4_1, var_4_2 = arg_4_0:onOffTimestamp()

	return var_4_1 <= var_4_0 and var_4_0 <= var_4_2
end

return var_0_0
