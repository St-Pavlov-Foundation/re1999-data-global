module("modules.logic.herogroup.model.HeroGroupRecommendCharacterMO", package.seeall)

local var_0_0 = pureTable("HeroGroupRecommendCharacterMO")

function var_0_0.init(arg_1_0, arg_1_1)
	if not arg_1_1 or not arg_1_1.rate then
		arg_1_0.isEmpty = true
		arg_1_0.heroRecommendInfos = {}

		return
	end

	arg_1_0.heroId = arg_1_1.heroId
	arg_1_0.heroRecommendInfos = arg_1_1.infos
	arg_1_0.rate = arg_1_1.rate
end

return var_0_0
