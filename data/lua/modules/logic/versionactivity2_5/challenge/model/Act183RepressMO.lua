module("modules.logic.versionactivity2_5.challenge.model.Act183RepressMO", package.seeall)

local var_0_0 = pureTable("Act183RepressMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._ruleIndex = arg_1_1.ruleIndex
	arg_1_0._heroIndex = arg_1_1.heroIndex or 0
end

function var_0_0.hasRepress(arg_2_0)
	return arg_2_0._ruleIndex ~= 0
end

function var_0_0.getRuleIndex(arg_3_0)
	return arg_3_0._ruleIndex
end

function var_0_0.getHeroIndex(arg_4_0)
	return arg_4_0._heroIndex
end

return var_0_0
