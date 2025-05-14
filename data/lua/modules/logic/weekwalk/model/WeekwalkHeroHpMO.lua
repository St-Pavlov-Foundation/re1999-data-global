module("modules.logic.weekwalk.model.WeekwalkHeroHpMO", package.seeall)

local var_0_0 = pureTable("WeekwalkHeroHpMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.heroId = arg_1_1.heroId
	arg_1_0.hp = arg_1_1.hp
	arg_1_0.buff = arg_1_1.buff
end

function var_0_0.setValue(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.heroId = arg_2_1
	arg_2_0.buff = arg_2_2
	arg_2_0.hp = arg_2_3
end

return var_0_0
