module("modules.logic.activity.model.ActivityType172InfoMo", package.seeall)

local var_0_0 = pureTable("ActivityType172InfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.useItemTaskIds = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.useItemTaskIds = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(arg_2_0.useItemTaskIds, iter_2_1)
	end
end

function var_0_0.update(arg_3_0, arg_3_1)
	arg_3_0.useItemTaskIds = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(arg_3_0.useItemTaskIds, iter_3_1)
	end
end

return var_0_0
