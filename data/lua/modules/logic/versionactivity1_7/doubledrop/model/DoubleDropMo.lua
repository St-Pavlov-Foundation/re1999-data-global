module("modules.logic.versionactivity1_7.doubledrop.model.DoubleDropMo", package.seeall)

local var_0_0 = pureTable("DoubleDropMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.activityId
	arg_1_0.totalCount = arg_1_1.totalCount
	arg_1_0.dailyCount = arg_1_1.dailyCount

	arg_1_0:initConfig()
end

function var_0_0.initConfig(arg_2_0)
	if arg_2_0.config then
		return
	end

	arg_2_0.config = DoubleDropConfig.instance:getAct153Co(arg_2_0.id)
end

function var_0_0.isDoubleTimesout(arg_3_0)
	if not arg_3_0.config then
		return true
	end

	local var_3_0, var_3_1 = arg_3_0:getDailyRemainTimes()

	return var_3_0 == 0, var_3_0, var_3_1
end

function var_0_0.getDailyRemainTimes(arg_4_0)
	local var_4_0 = arg_4_0.dailyCount or 0
	local var_4_1 = arg_4_0.config.dailyLimit or 0
	local var_4_2 = arg_4_0.config.totalLimit - arg_4_0.totalCount
	local var_4_3 = var_4_1 - var_4_0

	if var_4_2 < var_4_1 then
		var_4_3 = math.min(var_4_3, var_4_2)
	end

	if var_4_3 < 0 then
		var_4_3 = 0
	end

	return var_4_3, var_4_1
end

return var_0_0
