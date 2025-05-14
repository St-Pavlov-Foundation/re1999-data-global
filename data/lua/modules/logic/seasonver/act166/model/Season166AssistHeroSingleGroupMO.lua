module("modules.logic.seasonver.act166.model.Season166AssistHeroSingleGroupMO", package.seeall)

local var_0_0 = class("Season166AssistHeroSingleGroupMO", Season166HeroSingleGroupMO)

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = nil
	arg_1_0.heroUid = nil
	arg_1_0.heroId = nil
	arg_1_0._heroMo = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.heroUid = 0
	arg_2_0._heroMo = arg_2_2.heroMO
	arg_2_0.heroId = arg_2_2 and arg_2_2.heroId or 0
	arg_2_0.userId = arg_2_2 and arg_2_2.userId or 0
	arg_2_0.pickAssistHeroMO = arg_2_2
	arg_2_0.isAssist = true
end

function var_0_0.getHeroMO(arg_3_0)
	return arg_3_0._heroMo
end

function var_0_0.isTrial(arg_4_0)
	return true
end

return var_0_0
