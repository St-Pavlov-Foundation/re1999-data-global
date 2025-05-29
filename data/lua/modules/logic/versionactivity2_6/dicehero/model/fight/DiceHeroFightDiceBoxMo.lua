module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightDiceBoxMo", package.seeall)

local var_0_0 = pureTable("DiceHeroFightDiceBoxMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.capacity = arg_1_1.capacity
	arg_1_0.dices = {}
	arg_1_0.dicesByUid = arg_1_0.dicesByUid or {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.dices) do
		arg_1_0.dices[iter_1_0] = arg_1_0.dicesByUid[iter_1_1.uid] or DiceHeroFightDiceMo.New()

		arg_1_0.dices[iter_1_0]:init(iter_1_1, iter_1_0)

		arg_1_0.dicesByUid[iter_1_1.uid] = arg_1_0.dices[iter_1_0]
	end

	arg_1_0.resetTimes = arg_1_1.resetTimes
	arg_1_0.maxResetTimes = arg_1_1.maxResetTimes
end

function var_0_0.getDiceMoByUid(arg_2_0, arg_2_1)
	return arg_2_0.dicesByUid[arg_2_1]
end

return var_0_0
