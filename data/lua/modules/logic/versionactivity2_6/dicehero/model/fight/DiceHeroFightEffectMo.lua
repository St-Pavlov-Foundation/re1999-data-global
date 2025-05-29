module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightEffectMo", package.seeall)

local var_0_0 = pureTable("DiceHeroFightEffectMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.effectType = arg_1_1.effectType
	arg_1_0.fromId = arg_1_1.fromId
	arg_1_0.targetId = arg_1_1.targetId
	arg_1_0.effectNum = tonumber(arg_1_1.effectNum) or 0
	arg_1_0.extraData = arg_1_1.extraData
	arg_1_0.nextFightStep = DiceHeroFightStepMo.New()

	arg_1_0.nextFightStep:init(arg_1_1.nextFightStep)

	arg_1_0.buff = DiceHeroFightBuffMo.New()

	arg_1_0.buff:init(arg_1_1.buff)

	arg_1_0.targetIds = arg_1_1.targetIds
	arg_1_0.skillCards = arg_1_1.skillCards
	arg_1_0.diceBox = arg_1_1.diceBox
	arg_1_0.parent = arg_1_2
end

return var_0_0
