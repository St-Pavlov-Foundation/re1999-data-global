module("modules.logic.character.model.recommed.CharacterRecommedHeroListModel", package.seeall)

local var_0_0 = class("CharacterRecommedHeroListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._levelAscend = false
	arg_2_0._rareAscend = false
end

function var_0_0.setMoList(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(CharacterRecommedModel.instance:getAllHeroRecommendMos()) do
		if iter_3_1:isOwnHero() then
			table.insert(var_3_0, iter_3_1)
		end
	end

	arg_3_0._selectheroId = arg_3_1

	arg_3_0:_sortByLevel(var_3_0)
	arg_3_0:setList(var_3_0)
end

function var_0_0.selectById(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getById(arg_4_1)
	local var_4_1 = arg_4_0:getIndex(var_4_0)

	arg_4_0:selectCell(var_4_1, true)
end

function var_0_0._sortByLevel(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or arg_5_0:getList()

	table.sort(arg_5_1, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0.heroId
		local var_6_1 = arg_6_1.heroId

		if not arg_6_0 or not arg_6_1 then
			return var_6_1 < var_6_0
		end

		local var_6_2 = arg_6_0:isFavor()

		if var_6_2 ~= arg_6_1:isFavor() then
			return var_6_2
		end

		local var_6_3 = arg_6_0:getHeroLevel()
		local var_6_4 = arg_6_1:getHeroLevel()

		if var_6_3 ~= var_6_4 then
			if arg_5_0._levelAscend then
				return var_6_3 < var_6_4
			else
				return var_6_4 < var_6_3
			end
		end

		local var_6_5 = arg_6_0:getHeroConfig().rare
		local var_6_6 = arg_6_1:getHeroConfig().rare

		if var_6_5 ~= var_6_6 then
			return var_6_6 < var_6_5
		end

		local var_6_7 = arg_6_0:getExSkillLevel()
		local var_6_8 = arg_6_1:getExSkillLevel()

		if var_6_7 ~= var_6_8 then
			return var_6_8 < var_6_7
		end

		return var_6_1 < var_6_0
	end)
end

function var_0_0._sortByRare(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or arg_7_0:getList()

	table.sort(arg_7_1, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0.heroId
		local var_8_1 = arg_8_1.heroId

		if not arg_8_0 or not arg_8_1 then
			return var_8_1 < var_8_0
		end

		local var_8_2 = arg_8_0:isFavor()

		if var_8_2 ~= arg_8_1:isFavor() then
			return var_8_2
		end

		local var_8_3 = arg_8_0:getHeroConfig().rare
		local var_8_4 = arg_8_1:getHeroConfig().rare

		if var_8_3 ~= var_8_4 then
			if arg_7_0._rareAscend then
				return var_8_3 < var_8_4
			else
				return var_8_4 < var_8_3
			end
		end

		local var_8_5 = arg_8_0:getHeroLevel()
		local var_8_6 = arg_8_1:getHeroLevel()

		if var_8_5 ~= var_8_6 then
			return var_8_6 < var_8_5
		end

		local var_8_7 = arg_8_0:getExSkillLevel()
		local var_8_8 = arg_8_1:getExSkillLevel()

		if var_8_7 ~= var_8_8 then
			return var_8_8 < var_8_7
		end

		return var_8_1 < var_8_0
	end)
end

function var_0_0.setSortLevel(arg_9_0)
	arg_9_0._levelAscend = not arg_9_0._levelAscend

	arg_9_0:_sortByLevel()
	arg_9_0:onModelUpdate()
end

function var_0_0.setSortByRare(arg_10_0)
	arg_10_0._rareAscend = not arg_10_0._rareAscend

	arg_10_0:_sortByRare()
	arg_10_0:onModelUpdate()
end

function var_0_0.getSortStatus(arg_11_0)
	return arg_11_0._levelAscend, arg_11_0._rareAscend
end

var_0_0.instance = var_0_0.New()

return var_0_0
