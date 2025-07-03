module("modules.logic.fight.model.data.FightMagicCircleInfoData", package.seeall)

local var_0_0 = FightDataClass("FightMagicCircleInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.magicCircleId = arg_1_1.magicCircleId
	arg_1_0.round = arg_1_1.round
	arg_1_0.createUid = arg_1_1.createUid
	arg_1_0.electricLevel = arg_1_1.electricLevel
	arg_1_0.electricProgress = arg_1_1.electricProgress
end

return var_0_0
