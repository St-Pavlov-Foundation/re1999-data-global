module("modules.logic.gift.model.GiftInsightHeroChoiceModel", package.seeall)

local var_0_0 = class("GiftInsightHeroChoiceModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._curHeroId = 0
end

function var_0_0.setCurHeroId(arg_2_0, arg_2_1)
	arg_2_0._curHeroId = arg_2_1
end

function var_0_0.getCurHeroId(arg_3_0)
	return arg_3_0._curHeroId
end

function var_0_0.getFitHeros(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = {}
	local var_4_2 = HeroModel.instance:getAllHero()
	local var_4_3 = ItemConfig.instance:getInsightItemCo(arg_4_1)

	for iter_4_0, iter_4_1 in pairs(var_4_2) do
		local var_4_4 = string.splitToNumber(var_4_3.heroRares, "#")

		for iter_4_2, iter_4_3 in pairs(var_4_4) do
			if iter_4_1.config.rare + 1 == iter_4_3 then
				if iter_4_1.rank < var_4_3.heroRank + 1 then
					table.insert(var_4_0, iter_4_1)
				else
					table.insert(var_4_1, iter_4_1)
				end
			end
		end
	end

	table.sort(var_4_0, var_0_0._sortFunc)
	table.sort(var_4_1, var_0_0._sortFunc)

	return var_4_0, var_4_1
end

function var_0_0._sortFunc(arg_5_0, arg_5_1)
	if arg_5_0.config.rare ~= arg_5_1.config.rare then
		return arg_5_0.config.rare > arg_5_1.config.rare
	elseif arg_5_0.rank ~= arg_5_1.rank then
		return arg_5_0.rank > arg_5_1.rank
	elseif arg_5_0.level ~= arg_5_1.level then
		return arg_5_0.level > arg_5_1.level
	else
		return arg_5_0.heroId > arg_5_1.heroId
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
