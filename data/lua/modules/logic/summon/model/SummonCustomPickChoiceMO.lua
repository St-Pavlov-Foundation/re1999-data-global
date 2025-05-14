module("modules.logic.summon.model.SummonCustomPickChoiceMO", package.seeall)

local var_0_0 = pureTable("SummonCustomPickChoiceMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.ownNum = 0
	arg_1_0.exSkillLevel = 0
	arg_1_0.rank = 0

	arg_1_0:initSkillLevel()
end

function var_0_0.initSkillLevel(arg_2_0)
	local var_2_0 = HeroConfig.instance:getHeroCO(arg_2_0.id)
	local var_2_1 = 0
	local var_2_2 = var_2_0.duplicateItem

	if not string.nilorempty(var_2_2) then
		local var_2_3 = string.split(var_2_2, "|")[1]

		if var_2_3 then
			local var_2_4 = string.splitToNumber(var_2_3, "#")

			var_2_1 = ItemModel.instance:getItemQuantity(var_2_4[1], var_2_4[2])
		end
	end

	local var_2_5 = HeroModel.instance:getByHeroId(arg_2_0.id)

	arg_2_0.ownNum = 0
	arg_2_0.exSkillLevel = 0

	if var_2_5 then
		arg_2_0.exSkillLevel = var_2_5.exSkillLevel
		arg_2_0.ownNum = arg_2_0.exSkillLevel + 1 + var_2_1
		arg_2_0.rank = var_2_5.rank
	end
end

function var_0_0.hasHero(arg_3_0)
	return arg_3_0.ownNum > 0
end

function var_0_0.getSkillLevel(arg_4_0)
	return arg_4_0.exSkillLevel
end

return var_0_0
