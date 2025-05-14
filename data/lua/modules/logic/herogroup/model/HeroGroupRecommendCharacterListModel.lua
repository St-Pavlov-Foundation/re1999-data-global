module("modules.logic.herogroup.model.HeroGroupRecommendCharacterListModel", package.seeall)

local var_0_0 = class("HeroGroupRecommendCharacterListModel", ListScrollModel)

function var_0_0.setCharacterList(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_1 = HeroGroupRecommendCharacterMO.New()

		var_1_1:init(iter_1_1)
		table.insert(var_1_0, var_1_1)
	end

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		return arg_2_0.rate > arg_2_1.rate
	end)

	for iter_1_2 = #arg_1_1 + 1, 5 do
		local var_1_2 = HeroGroupRecommendCharacterMO.New()

		var_1_2:init()
		table.insert(var_1_0, var_1_2)
	end

	arg_1_0:setList(var_1_0)

	if #var_1_0 > 0 then
		for iter_1_3, iter_1_4 in ipairs(arg_1_0._scrollViews) do
			iter_1_4:selectCell(1, true)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
