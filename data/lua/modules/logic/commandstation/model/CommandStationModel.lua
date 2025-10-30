module("modules.logic.commandstation.model.CommandStationModel", package.seeall)

local var_0_0 = class("CommandStationModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.paper = 0
	arg_1_0.gainBonus = {}
	arg_1_0._eventList = {}
	arg_1_0.catchNum = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.updateEventList(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0:updateEventInfo(iter_3_1)
	end
end

function var_0_0.updateEventInfo(arg_4_0, arg_4_1)
	arg_4_0._eventList[arg_4_1.id] = arg_4_0._eventList[arg_4_1.id] or CommandPostEventInfoMO.New()

	arg_4_0._eventList[arg_4_1.id]:init(arg_4_1)
end

function var_0_0.getDispatchEventInfo(arg_5_0, arg_5_1)
	local var_5_0 = lua_copost_event.configDict[arg_5_1]

	if var_5_0 and var_5_0.eventType == CommandStationEnum.EventType.Dispatch then
		local var_5_1 = arg_5_0._eventList[arg_5_1]

		if var_5_1 and var_5_1.hasInit and var_5_1.state ~= CommandStationEnum.EventState.NotDispatch then
			return var_5_1
		end
	end
end

function var_0_0.getDispatchEventState(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getDispatchEventInfo(arg_6_1)

	if var_6_0 then
		if var_6_0:hasGetReward() then
			return CommandStationEnum.DispatchState.GetReward
		end

		if not var_6_0:isFinished() then
			return CommandStationEnum.DispatchState.InProgress
		end

		return CommandStationEnum.DispatchState.Completed
	end

	return CommandStationEnum.DispatchState.NotStart
end

function var_0_0.isEventRead(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._eventList[arg_7_1]

	return var_7_0 and var_7_0.read
end

function var_0_0.getEventState(arg_8_0, arg_8_1)
	local var_8_0 = lua_copost_event.configDict[arg_8_1]

	if var_8_0 and var_8_0.eventType == CommandStationEnum.EventType.Dispatch then
		logError(string.format("getEventState error, id = %d", arg_8_1))

		return nil
	end

	local var_8_1 = arg_8_0._eventList[arg_8_1]

	return var_8_1 and var_8_1.state
end

function var_0_0.setEventFinish(arg_9_0, arg_9_1)
	arg_9_0._eventList[arg_9_1] = arg_9_0._eventList[arg_9_1] or CommandPostEventInfoMO.New()
	arg_9_0._eventList[arg_9_1].state = CommandStationEnum.EventState.GetReward
end

function var_0_0.setEventRead(arg_10_0, arg_10_1)
	arg_10_0._eventList[arg_10_1] = arg_10_0._eventList[arg_10_1] or CommandPostEventInfoMO.New()
	arg_10_0._eventList[arg_10_1].read = true
end

function var_0_0.getAllEventHeroList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0._eventList) do
		if iter_11_1.heroIds and not iter_11_1:hasGetReward() then
			for iter_11_2, iter_11_3 in ipairs(iter_11_1.heroIds) do
				var_11_0[iter_11_3] = iter_11_3
			end
		end
	end

	return var_11_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
