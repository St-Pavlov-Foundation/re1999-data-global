module("modules.logic.fight.model.data.FightItemPlayerSkillInfoData", package.seeall)

local var_0_0 = FightDataClass("FightItemPlayerSkillInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.skillId = arg_1_1.skillId
	arg_1_0.itemId = arg_1_1.itemId
	arg_1_0.cd = arg_1_1.cd
	arg_1_0.count = arg_1_1.count
end

return var_0_0
