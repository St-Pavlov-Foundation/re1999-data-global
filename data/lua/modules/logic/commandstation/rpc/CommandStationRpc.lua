module("modules.logic.commandstation.rpc.CommandStationRpc", package.seeall)

local var_0_0 = class("CommandStationRpc", BaseRpc)

function var_0_0.sendGetCommandPostInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = CommandPostModule_pb.GetCommandPostInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetCommandPostInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.eventList
	local var_2_1 = arg_2_2.tasks
	local var_2_2 = arg_2_2.catchTasks
	local var_2_3 = arg_2_2.gainBonus
	local var_2_4 = arg_2_2.paper
	local var_2_5 = arg_2_2.catchNum

	CommandStationModel.instance:updateEventList(var_2_0)
	CommandStationTaskListModel.instance:initServerData(var_2_1, var_2_2)

	CommandStationModel.instance.paper = var_2_4
	CommandStationModel.instance.catchNum = var_2_5
	CommandStationModel.instance.gainBonus = {
		unpack(var_2_3)
	}

	CommandStationController.instance:dispatchEvent(CommandStationEvent.OnGetCommandPostInfo)
end

function var_0_0.sendFinishCommandPostEventRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = CommandPostModule_pb.FinishCommandPostEventRequest()

	var_3_0.id = arg_3_1

	arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveFinishCommandPostEventReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.id

	CommandStationModel.instance:setEventFinish(var_4_0)
end

function var_0_0.sendCommandPostDispatchRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = CommandPostModule_pb.CommandPostDispatchRequest()

	var_5_0.eventId = arg_5_1

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		table.insert(var_5_0.heroIds, iter_5_1)
	end

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveCommandPostDispatchReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.event

	CommandStationModel.instance:updateEventInfo(var_6_0)
end

function var_0_0.sendCommandPostBonusAllRequest(arg_7_0)
	local var_7_0 = CommandPostModule_pb.CommandPostBonusAllRequest()

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveCommandPostBonusAllReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	local var_8_0 = arg_8_2.bonusId

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		table.insert(CommandStationModel.instance.gainBonus, iter_8_1)
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.OnBonusUpdate)
end

function var_0_0.sendCommandPostPaperRequest(arg_9_0)
	local var_9_0 = CommandPostModule_pb.CommandPostPaperRequest()

	arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveCommandPostPaperReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = arg_10_2.paper

	CommandStationModel.instance.paper = var_10_0

	CommandStationController.instance:dispatchEvent(CommandStationEvent.OnPaperUpdate)
end

function var_0_0.sendCommandPostEventReadRequest(arg_11_0, arg_11_1)
	local var_11_0 = CommandPostModule_pb.CommandPostEventReadRequest()

	var_11_0.id = arg_11_1

	arg_11_0:sendMsg(var_11_0)
end

function var_0_0.onReceiveCommandPostEventReadReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	local var_12_0 = arg_12_2.id

	CommandStationModel.instance:setEventRead(var_12_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
