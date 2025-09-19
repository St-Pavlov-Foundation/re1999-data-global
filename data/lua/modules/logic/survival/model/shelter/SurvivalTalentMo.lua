module("modules.logic.survival.model.shelter.SurvivalTalentMo", package.seeall)

local var_0_0 = pureTable("SurvivalTalentMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.talentId = arg_1_1.talentId
	arg_1_0.attrs = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.permAttrs) do
		table.insert(arg_1_0.attrs, {
			attrId = iter_1_1.attrId,
			value = iter_1_1.value
		})
	end
end

return var_0_0
