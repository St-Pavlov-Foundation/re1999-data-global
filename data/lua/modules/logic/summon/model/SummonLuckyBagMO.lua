module("modules.logic.summon.model.SummonLuckyBagMO", package.seeall)

local var_0_0 = pureTable("SummonLuckyBagMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.luckyBagId = 0
	arg_1_0.summonTimes = 0
	arg_1_0.openedTimes = 0
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.luckyBagId = arg_2_1.luckyBagId or 0
	arg_2_0.summonTimes = arg_2_1.count or 0
	arg_2_0.openedTimes = arg_2_1.openLBTimes or 0
end

function var_0_0.isGot(arg_3_0)
	return arg_3_0.luckyBagId ~= nil and arg_3_0.luckyBagId ~= 0 or arg_3_0.openedTimes > 0
end

function var_0_0.isOpened(arg_4_0)
	return arg_4_0.openedTimes > 0
end

return var_0_0
