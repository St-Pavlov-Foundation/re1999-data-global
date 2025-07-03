module("modules.logic.fight.model.mo.FightRoundOperRecordMO", package.seeall)

local var_0_0 = pureTable("FightRoundOperRecordMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.clothSkillOpers = {}
	arg_1_0.opers = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.clothSkillOpers) do
		local var_2_0 = {
			skillId = iter_2_1.skillId,
			fromId = iter_2_1.fromId,
			toId = iter_2_1.toId,
			type = iter_2_1.type
		}

		table.insert(arg_2_0.clothSkillOpers, var_2_0)
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.opers) do
		local var_2_1 = FightOperationItemData.New()

		var_2_1:setByProto(iter_2_3)
		table.insert(arg_2_0.opers, var_2_1)
	end
end

return var_0_0
