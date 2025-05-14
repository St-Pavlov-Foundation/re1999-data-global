module("modules.logic.weekwalk.model.WeekwalkPrayInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkPrayInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.sacrificeHeroId = arg_1_1.sacrificeHeroId
	arg_1_0.blessingHeroId = arg_1_1.blessingHeroId
	arg_1_0.heroAttribute = arg_1_1.heroAttribute
	arg_1_0.heroExAttribute = arg_1_1.heroExAttribute
	arg_1_0.passiveSkills = arg_1_1.passiveSkills
end

return var_0_0
