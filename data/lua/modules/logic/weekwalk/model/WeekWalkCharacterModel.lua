module("modules.logic.weekwalk.model.WeekWalkCharacterModel", package.seeall)

local var_0_0 = class("WeekWalkCharacterModel", CharacterModel)

function var_0_0._setCharacterCardList(arg_1_0, arg_1_1)
	WeekWalkCardListModel.instance:setCharacterList(arg_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
