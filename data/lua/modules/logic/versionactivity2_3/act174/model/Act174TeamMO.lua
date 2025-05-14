module("modules.logic.versionactivity2_3.act174.model.Act174TeamMO", package.seeall)

local var_0_0 = pureTable("Act174TeamMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.index = arg_1_1.index
	arg_1_0.battleHeroInfo = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.battleHeroInfo) do
		arg_1_0.battleHeroInfo[iter_1_0] = arg_1_0:creatBattleHero(iter_1_1)
	end
end

function var_0_0.creatBattleHero(arg_2_0, arg_2_1)
	return {
		index = arg_2_1.index,
		heroId = arg_2_1.heroId,
		itemId = arg_2_1.itemId,
		priorSkill = arg_2_1.priorSkill
	}
end

function var_0_0.notEmpty(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.battleHeroInfo) do
		if iter_3_1.heroId and iter_3_1.heroId ~= 0 then
			return true
		end
	end

	return false
end

return var_0_0
