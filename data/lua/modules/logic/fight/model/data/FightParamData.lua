module("modules.logic.fight.model.data.FightParamData", package.seeall)

local var_0_0 = FightDataClass("FightParamData")

var_0_0.ParamKey = {
	ProgressSkill = 1,
	ProgressId = 2
}

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		arg_1_0[iter_1_1.key] = iter_1_1.value
	end
end

return var_0_0
