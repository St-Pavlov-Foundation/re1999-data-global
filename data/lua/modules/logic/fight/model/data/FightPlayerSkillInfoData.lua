module("modules.logic.fight.model.data.FightPlayerSkillInfoData", package.seeall)

local var_0_0 = FightDataClass("FightPlayerSkillInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.skillId = arg_1_1.skillId
	arg_1_0.cd = arg_1_1.cd
	arg_1_0.needPower = arg_1_1.needPower
	arg_1_0.type = arg_1_1.type
end

return var_0_0
