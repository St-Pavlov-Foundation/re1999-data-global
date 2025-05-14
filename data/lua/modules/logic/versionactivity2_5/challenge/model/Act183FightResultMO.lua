module("modules.logic.versionactivity2_5.challenge.model.Act183FightResultMO", package.seeall)

local var_0_0 = pureTable("Act183FightResultMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._episodeId = arg_1_1.episodeId
	arg_1_0._heroes = Act183Helper.rpcInfosToList(arg_1_1.heroes, Act183HeroMO)
	arg_1_0._unlockConditions = {}

	tabletool.addValues(arg_1_0._unlockConditions, arg_1_1.unlockConditions)
end

function var_0_0.getHeroes(arg_2_0)
	return arg_2_0._heroes
end

function var_0_0.isConditionPass(arg_3_0, arg_3_1)
	if arg_3_0._unlockConditions then
		return tabletool.indexOf(arg_3_0._unlockConditions, arg_3_1) ~= nil
	end
end

return var_0_0
