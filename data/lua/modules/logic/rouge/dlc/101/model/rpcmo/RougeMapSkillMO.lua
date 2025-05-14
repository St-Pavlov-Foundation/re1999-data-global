module("modules.logic.rouge.dlc.101.model.rpcmo.RougeMapSkillMO", package.seeall)

local var_0_0 = pureTable("RougeMapSkillMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.useCount = arg_1_1.useCount
	arg_1_0.stepRecord = arg_1_1.stepRecord
end

function var_0_0.getUseCount(arg_2_0)
	return arg_2_0.useCount
end

function var_0_0.getStepRecord(arg_3_0)
	return arg_3_0.stepRecord
end

return var_0_0
