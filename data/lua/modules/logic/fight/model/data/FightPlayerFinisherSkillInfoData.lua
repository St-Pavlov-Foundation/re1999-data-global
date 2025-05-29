module("modules.logic.fight.model.data.FightPlayerFinisherSkillInfoData", package.seeall)

local var_0_0 = FightDataClass("FightPlayerFinisherSkillInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.skillId = arg_1_1.skillId
	arg_1_0.needPower = arg_1_1.needPower
end

return var_0_0
