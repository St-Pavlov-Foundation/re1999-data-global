module("modules.logic.dispatch.model.DispatchInfoMo", package.seeall)

local var_0_0 = pureTable("DispatchInfoMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.elementId

	arg_1_0:updateMO(arg_1_1)
end

function var_0_0.updateMO(arg_2_0, arg_2_1)
	arg_2_0.dispatchId = arg_2_1.dispatchId
	arg_2_0.endTime = Mathf.Floor(tonumber(arg_2_1.endTime) / 1000)
	arg_2_0.heroIdList = arg_2_1.heroIdList
end

function var_0_0.getDispatchId(arg_3_0)
	return arg_3_0.dispatchId
end

function var_0_0.getHeroIdList(arg_4_0)
	return arg_4_0.heroIdList
end

function var_0_0.getRemainTime(arg_5_0)
	return Mathf.Max(arg_5_0.endTime - ServerTime.now(), 0)
end

function var_0_0.getRemainTimeStr(arg_6_0)
	local var_6_0 = arg_6_0:getRemainTime()
	local var_6_1 = math.floor(var_6_0 / TimeUtil.OneHourSecond)
	local var_6_2 = math.floor(var_6_0 % TimeUtil.OneHourSecond / TimeUtil.OneMinuteSecond)
	local var_6_3 = var_6_0 % TimeUtil.OneMinuteSecond

	return string.format("%02d : %02d : %02d", var_6_1, var_6_2, var_6_3)
end

function var_0_0.isRunning(arg_7_0)
	return arg_7_0.endTime > ServerTime.now()
end

function var_0_0.isFinish(arg_8_0)
	return arg_8_0.endTime <= ServerTime.now()
end

return var_0_0
