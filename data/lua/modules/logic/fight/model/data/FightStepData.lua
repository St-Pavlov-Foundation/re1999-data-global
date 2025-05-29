module("modules.logic.fight.model.data.FightStepData", package.seeall)

local var_0_0 = FightDataClass("FightStepData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.actType = arg_1_1.actType
	arg_1_0.fromId = arg_1_1.fromId
	arg_1_0.toId = arg_1_1.toId
	arg_1_0.actId = arg_1_1.actId
	arg_1_0.actEffect = arg_1_0:buildActEffect(arg_1_1.actEffect)
	arg_1_0.cardIndex = arg_1_1.cardIndex
	arg_1_0.supportHeroId = arg_1_1.supportHeroId
end

function var_0_0.buildActEffect(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_1 = FightActEffectData.New(iter_2_1)

		table.insert(var_2_0, var_2_1)
	end

	return var_2_0
end

return var_0_0
