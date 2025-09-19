module("modules.logic.survival.model.map.SurvivalHeroSingleGroupMO", package.seeall)

local var_0_0 = class("SurvivalHeroSingleGroupMO", HeroSingleGroupMO)

function var_0_0.getHeroMO(arg_1_0)
	return SurvivalMapModel.instance:getSceneMo().teamInfo:getHeroMo(arg_1_0.heroUid)
end

return var_0_0
