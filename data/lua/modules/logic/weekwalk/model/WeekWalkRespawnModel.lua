module("modules.logic.weekwalk.model.WeekWalkRespawnModel", package.seeall)

local var_0_0 = class("WeekWalkRespawnModel", ListScrollModel)

function var_0_0.setRespawnList(arg_1_0)
	local var_1_0 = WeekWalkModel.instance:getInfo()

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.WeekWalk)

	local var_1_1 = CharacterBackpackCardListModel.instance:getCharacterCardList()
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_3 = var_1_0:getHeroHp(iter_1_1.heroId)

		if var_1_3 and var_1_3 <= 0 then
			table.insert(var_1_2, iter_1_1)
		end
	end

	arg_1_0:setList(var_1_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
