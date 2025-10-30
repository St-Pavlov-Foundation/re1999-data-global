module("modules.logic.commandstation.model.CommandPostEventInfoMO", package.seeall)

local var_0_0 = pureTable("CommandPostEventInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.hasInit = true
	arg_1_0.id = arg_1_1.id
	arg_1_0.state = arg_1_1.state
	arg_1_0.heroIds = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.heroIds) do
		table.insert(arg_1_0.heroIds, iter_1_1)
	end

	arg_1_0.startTime = tonumber(arg_1_1.startTime / 1000)
	arg_1_0.endTime = tonumber(arg_1_1.endTime / 1000)
	arg_1_0.read = arg_1_1.read
end

function var_0_0.isFinished(arg_2_0)
	if not arg_2_0.endTime then
		return false
	end

	return ServerTime.now() >= arg_2_0.endTime
end

function var_0_0.hasGetReward(arg_3_0)
	return arg_3_0.state == CommandStationEnum.EventState.GetReward
end

function var_0_0.getTimeInfo(arg_4_0)
	local var_4_0 = arg_4_0.endTime - ServerTime.now()

	return math.max(var_4_0, 0), arg_4_0.endTime - arg_4_0.startTime
end

return var_0_0
