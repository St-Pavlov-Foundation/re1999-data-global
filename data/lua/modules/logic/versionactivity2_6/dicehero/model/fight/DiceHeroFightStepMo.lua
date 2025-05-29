module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightStepMo", package.seeall)

local var_0_0 = pureTable("DiceHeroFightStepMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.actionType = arg_1_1.actionType
	arg_1_0.reasonId = arg_1_1.reasonId
	arg_1_0.fromId = arg_1_1.fromId
	arg_1_0.toId = arg_1_1.toId
	arg_1_0.effect = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.effect) do
		arg_1_0.effect[iter_1_0] = DiceHeroFightEffectMo.New()

		arg_1_0.effect[iter_1_0]:init(iter_1_1, arg_1_0)
	end

	arg_1_0.isByCard = false
	arg_1_0.isByHero = false

	if arg_1_0.actionType == 1 then
		local var_1_0 = DiceHeroFightModel.instance:getGameData()
		local var_1_1 = var_1_0.skillCardsBySkillId[tonumber(arg_1_0.reasonId)]

		arg_1_0.isByCard = var_1_1 and var_1_1.co.type ~= DiceHeroEnum.CardType.Hero
		arg_1_0.isByHero = var_1_0.allyHero.uid == arg_1_0.fromId
	end
end

return var_0_0
