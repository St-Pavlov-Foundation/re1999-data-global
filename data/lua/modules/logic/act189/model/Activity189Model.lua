module("modules.logic.act189.model.Activity189Model", package.seeall)

local var_0_0 = class("Activity189Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._actInfo = {}
end

function var_0_0.getActMO(arg_3_0, arg_3_1)
	return ActivityModel.instance:getActMO(arg_3_1)
end

function var_0_0.getRealStartTimeStamp(arg_4_0, arg_4_1)
	return arg_4_0:getActMO(arg_4_1):getRealStartTimeStamp()
end

function var_0_0.getRealEndTimeStamp(arg_5_0, arg_5_1)
	return arg_5_0:getActMO(arg_5_1):getRealEndTimeStamp()
end

function var_0_0.getRemainTimeSec(arg_6_0, arg_6_1)
	return ActivityModel.instance:getRemainTimeSec(arg_6_1) or 0
end

function var_0_0.onReceiveGetAct189InfoReply(arg_7_0, arg_7_1)
	arg_7_0._actInfo[arg_7_1.activityId] = arg_7_1
end

function var_0_0.onReceiveGetAct189OnceBonusReply(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._actInfo[arg_8_1.activityId]

	if not var_8_0 then
		return
	end

	rawset(var_8_0, "hasGetOnceBonus", true)
end

function var_0_0.isClaimed(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._actInfo[arg_9_1]

	if not var_9_0 then
		return false
	end

	return var_9_0.hasGetOnceBonus
end

function var_0_0.isClaimable(arg_10_0, arg_10_1)
	if not arg_10_0._actInfo[arg_10_1] then
		return false
	end

	return not arg_10_0:isClaimed(arg_10_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
