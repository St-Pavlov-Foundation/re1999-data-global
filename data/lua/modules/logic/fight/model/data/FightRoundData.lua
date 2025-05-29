module("modules.logic.fight.model.data.FightRoundData", package.seeall)

local var_0_0 = FightDataClass("FightRoundData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.fightStep = arg_1_0:buildFightStep(arg_1_1.fightStep)
	arg_1_0.actPoint = arg_1_1.actPoint
	arg_1_0.isFinish = arg_1_1.isFinish
	arg_1_0.moveNum = arg_1_1.moveNum
	arg_1_0.power = arg_1_1.power
	arg_1_0.useCardList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.useCardList) do
		table.insert(arg_1_0.useCardList, iter_1_1)
	end

	arg_1_0.curRound = arg_1_1.curRound
	arg_1_0.lastChangeHeroUid = arg_1_1.lastChangeHeroUid
end

function var_0_0.buildFightStep(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_1 = FightStepData.New(iter_2_1)

		table.insert(var_2_0, var_2_1)
	end

	return var_2_0
end

return var_0_0
