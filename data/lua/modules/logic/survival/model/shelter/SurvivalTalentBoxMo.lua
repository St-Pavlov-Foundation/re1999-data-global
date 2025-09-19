module("modules.logic.survival.model.shelter.SurvivalTalentBoxMo", package.seeall)

local var_0_0 = pureTable("SurvivalTalentBoxMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.groupId = arg_1_1.groupId
	arg_1_0.talents = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.talents) do
		local var_1_0 = SurvivalTalentMo.New()

		var_1_0:init(iter_1_1)
		table.insert(arg_1_0.talents, var_1_0)
	end
end

return var_0_0
