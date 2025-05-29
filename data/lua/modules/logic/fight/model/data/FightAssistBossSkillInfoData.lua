module("modules.logic.fight.model.data.FightAssistBossSkillInfoData", package.seeall)

local var_0_0 = FightDataClass("FightAssistBossSkillInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.skillId = arg_1_1.skillId
	arg_1_0.needPower = arg_1_1.needPower
	arg_1_0.powerLow = arg_1_1.powerLow
	arg_1_0.powerHigh = arg_1_1.powerHigh
end

return var_0_0
