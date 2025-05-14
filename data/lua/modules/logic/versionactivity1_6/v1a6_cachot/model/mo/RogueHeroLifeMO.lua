module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueHeroLifeMO", package.seeall)

local var_0_0 = pureTable("RogueHeroLifeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.heroId = arg_1_1.heroId
	arg_1_0.life = arg_1_1.life
	arg_1_0.lifePercent = arg_1_1.life / 10
end

return var_0_0
