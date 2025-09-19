module("modules.logic.survival.model.shelter.SurvivalShelterHeroMo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterHeroMo")

function var_0_0.setDefault(arg_1_0, arg_1_1)
	arg_1_0.heroId = arg_1_1
	arg_1_0.health = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.HeroHealthMax)
	arg_1_0.status = SurvivalEnum.HeroStatu.Normal
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.heroId = arg_2_1.heroId
	arg_2_0.health = arg_2_1.health
	arg_2_0.status = arg_2_1.status
end

function var_0_0.getCurState(arg_3_0)
	local var_3_0 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.HeroHealthMax)
	local var_3_1 = string.splitToNumber(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.HeroHealth2), "#") or {}
	local var_3_2 = string.splitToNumber(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.HeroHealth3), "#") or {}
	local var_3_3 = (var_3_1[1] or 0) / 1000
	local var_3_4 = (var_3_2[1] or 0) / 1000
	local var_3_5 = 0
	local var_3_6 = var_3_4 * var_3_0
	local var_3_7 = var_3_3 * var_3_0

	if arg_3_0.health == 0 then
		return 0, var_3_5
	elseif var_3_4 >= arg_3_0.health / var_3_0 then
		local var_3_8 = arg_3_0.health / var_3_6

		return 1, var_3_8
	elseif var_3_3 >= arg_3_0.health / var_3_0 then
		local var_3_9 = (arg_3_0.health - var_3_6) / (var_3_7 - var_3_6)

		return 2, var_3_9
	else
		local var_3_10 = (arg_3_0.health - var_3_7) / (var_3_0 - var_3_7)

		return 3, var_3_10
	end
end

return var_0_0
