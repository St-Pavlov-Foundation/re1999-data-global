module("modules.logic.rouge.model.RougeAssistHeroSingleGroupMO", package.seeall)

local var_0_0 = pureTable("RougeAssistHeroSingleGroupMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = nil
	arg_1_0.heroUid = nil
	arg_1_0.heroId = nil
	arg_1_0._heroMo = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.id = arg_2_1
	arg_2_0.heroUid = arg_2_2 or "0"
	arg_2_0._heroMo = arg_2_3
	arg_2_0.heroId = arg_2_3 and arg_2_3.heroId or 0
end

function var_0_0.getHeroMO(arg_3_0)
	return arg_3_0._heroMo
end

function var_0_0.isTrial(arg_4_0)
	return true
end

return var_0_0
