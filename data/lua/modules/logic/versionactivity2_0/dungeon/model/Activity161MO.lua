module("modules.logic.versionactivity2_0.dungeon.model.Activity161MO", package.seeall)

local var_0_0 = pureTable("Activity161MO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.state = 0
	arg_1_0.cdBeginTime = nil
	arg_1_0.config = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1.id
	arg_2_0.state = arg_2_1.state
	arg_2_0.cdBeginTime = tonumber(arg_2_1.mainElementCdBeginTime)
	arg_2_0.config = arg_2_2
end

function var_0_0.isInCdTime(arg_3_0)
	if arg_3_0.cdBeginTime and arg_3_0.cdBeginTime > 0 then
		return ServerTime.now() - arg_3_0.cdBeginTime / 1000 < arg_3_0.config.mainElementCd
	end

	return false
end

function var_0_0.getRemainUnlockTime(arg_4_0)
	if arg_4_0.cdBeginTime and arg_4_0.cdBeginTime > 0 then
		local var_4_0 = arg_4_0.cdBeginTime / 1000 + arg_4_0.config.mainElementCd

		return Mathf.Max(var_4_0 - ServerTime.now(), 0)
	end

	return 0
end

function var_0_0.updateInfo(arg_5_0, arg_5_1)
	arg_5_0.state = arg_5_1.state
	arg_5_0.cdBeginTime = tonumber(arg_5_1.mainElementCdBeginTime)
end

return var_0_0
