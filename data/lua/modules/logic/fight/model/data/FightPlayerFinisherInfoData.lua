module("modules.logic.fight.model.data.FightPlayerFinisherInfoData", package.seeall)

local var_0_0 = FightDataClass("FightPlayerFinisherInfoData")

var_0_0.Type = {
	SurvivalTalent = 1,
	Normal = 0
}

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.skills = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.skills) do
		table.insert(arg_1_0.skills, FightPlayerFinisherSkillInfoData.New(iter_1_1))
	end

	arg_1_0.roundUseLimit = arg_1_1.roundUseLimit
	arg_1_0.type = arg_1_1.type
end

return var_0_0
