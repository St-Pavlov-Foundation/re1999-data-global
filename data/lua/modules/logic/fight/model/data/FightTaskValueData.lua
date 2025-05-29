module("modules.logic.fight.model.data.FightTaskValueData", package.seeall)

local var_0_0 = FightDataClass("FightTaskValueData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.index = arg_1_1.index
	arg_1_0.progress = arg_1_1.progress
	arg_1_0.maxProgress = arg_1_1.maxProgress
	arg_1_0.finished = arg_1_1.finished
end

return var_0_0
