module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5DispatchMo", package.seeall)

local var_0_0 = pureTable("DispatchMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.config = VersionActivity1_5DungeonConfig.instance:getDispatchCo(arg_1_0.id)

	arg_1_0:update(arg_1_1)
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.endTime = Mathf.Floor(tonumber(arg_2_1.endTime) / 1000)
	arg_2_0.heroIdList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.heroIds) do
		table.insert(arg_2_0.heroIdList, iter_2_1)
	end
end

function var_0_0.isFinish(arg_3_0)
	return arg_3_0.endTime <= ServerTime.now()
end

function var_0_0.isRunning(arg_4_0)
	return arg_4_0.endTime > ServerTime.now()
end

function var_0_0.getRemainTime(arg_5_0)
	return Mathf.Max(arg_5_0.endTime - ServerTime.now(), 0)
end

function var_0_0.getRemainTimeStr(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getRemainTime()
	local var_6_1 = math.floor(var_6_0 / TimeUtil.OneHourSecond)
	local var_6_2 = math.floor(var_6_0 % TimeUtil.OneHourSecond / 60)
	local var_6_3 = var_6_0 % 60

	return string.format("%02d : %02d : %02d", var_6_1, var_6_2, var_6_3)
end

return var_0_0
