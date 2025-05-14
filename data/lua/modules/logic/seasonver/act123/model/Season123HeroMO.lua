module("modules.logic.seasonver.act123.model.Season123HeroMO", package.seeall)

local var_0_0 = pureTable("Season123HeroMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.heroUid = arg_1_1.heroUid
	arg_1_0.hpRate = arg_1_1.hpRate
	arg_1_0.isAssist = arg_1_1.isAssist
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.hpRate = arg_2_1.hpRate
end

return var_0_0
