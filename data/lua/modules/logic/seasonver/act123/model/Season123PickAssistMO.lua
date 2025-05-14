module("modules.logic.seasonver.act123.model.Season123PickAssistMO", package.seeall)

local var_0_0 = pureTable("Season123PickAssistMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.heroUid
	arg_1_0.assistMO = Season123AssistHeroMO.New()

	arg_1_0.assistMO:init(arg_1_1)

	arg_1_0.heroMO = Season123HeroUtils.createHeroMOByAssistMO(arg_1_0.assistMO, true)
end

function var_0_0.getId(arg_2_0)
	return arg_2_0.id
end

function var_0_0.isSameHero(arg_3_0, arg_3_1)
	local var_3_0 = false

	if arg_3_1 then
		var_3_0 = arg_3_0:getId() == arg_3_1:getId()
	end

	return var_3_0
end

function var_0_0.getPlayerInfo(arg_4_0)
	return {
		userId = arg_4_0.assistMO.userId,
		name = arg_4_0.assistMO.name,
		level = arg_4_0.assistMO.userLevel,
		portrait = arg_4_0.assistMO.portrait,
		bg = arg_4_0.assistMO.bg
	}
end

return var_0_0
