module("modules.logic.fight.model.mo.FightStatMO", package.seeall)

local var_0_0 = pureTable("FightStatMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.entityId = arg_1_1.heroUid
	arg_1_0.harm = tonumber(arg_1_1.harm)
	arg_1_0.hurt = tonumber(arg_1_1.hurt)
	arg_1_0.heal = tonumber(arg_1_1.heal)
	arg_1_0.cards = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.cards) do
		local var_1_0 = {
			skillId = iter_1_1.skillId,
			useCount = iter_1_1.useCount
		}

		table.insert(arg_1_0.cards, var_1_0)
	end
end

return var_0_0
