module("modules.logic.rouge.model.rpcmo.RougeBattleHeroMO", package.seeall)

local var_0_0 = pureTable("RougeBattleHeroMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.index = arg_1_1.index
	arg_1_0.heroId = arg_1_1.heroId
	arg_1_0.equipUid = arg_1_1.equipUid
	arg_1_0.supportHeroId = arg_1_1.supportHeroId
	arg_1_0.supportHeroSkill = arg_1_1.supportHeroSkill
end

return var_0_0
