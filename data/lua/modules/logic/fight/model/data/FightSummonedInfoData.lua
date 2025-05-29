module("modules.logic.fight.model.data.FightSummonedInfoData", package.seeall)

local var_0_0 = FightDataClass("FightSummonedInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.summonedId = arg_1_1.summonedId
	arg_1_0.level = arg_1_1.level
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.fromUid = arg_1_1.fromUid
end

return var_0_0
