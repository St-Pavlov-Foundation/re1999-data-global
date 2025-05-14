module("modules.logic.versionactivity2_3.act174.model.Act174BadgeMO", package.seeall)

local var_0_0 = pureTable("Act174BadgeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.config = arg_1_1
	arg_1_0.id = arg_1_1.id
	arg_1_0.count = 0
	arg_1_0.act = false
	arg_1_0.sp = false
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.count = arg_2_1.count
	arg_2_0.act = arg_2_1.act
	arg_2_0.sp = arg_2_1.sp
end

function var_0_0.getState(arg_3_0)
	if arg_3_0.sp then
		return Activity174Enum.BadgeState.Sp
	elseif arg_3_0.act then
		return Activity174Enum.BadgeState.Light
	end

	return Activity174Enum.BadgeState.Normal
end

return var_0_0
