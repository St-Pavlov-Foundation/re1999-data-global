module("modules.logic.survival.view.map.SurvivalHeroGroupFightView_Rule", package.seeall)

local var_0_0 = class("SurvivalHeroGroupFightView_Rule", HeroGroupFightViewRule)

function var_0_0._getRuleList(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.super._getRuleList(arg_1_0, arg_1_1)

	return SurvivalShelterModel.instance:addExRule(var_1_0)
end

return var_0_0
