module("modules.logic.activity.rpc.Activity109Rpc", package.seeall)

local var_0_0 = class("Activity109Rpc", BaseRpc)

function var_0_0.sendGetAct109InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity109Module_pb.GetAct109InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct109InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity109Model.instance:onReceiveGetAct109InfoReply(arg_2_2)
		Activity109ChessController.instance:initMapData(arg_2_2.activityId, arg_2_2.map)
	end
end

function var_0_0.sendAct109StartEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity109Module_pb.Act109StartEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct109StartEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity109Model.instance:increaseCount(arg_4_2.map.id)
		Activity109ChessController.instance:initMapData(arg_4_2.activityId, arg_4_2.map)
	end
end

function var_0_0.sendAct109BeginRoundRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity109Module_pb.Act109BeginRoundRequest()

	var_5_0.activityId = arg_5_1

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_1 = var_5_0.operations:add()

		var_5_1.id = iter_5_1.id
		var_5_1.moveDirection = iter_5_1.dir
	end

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveAct109BeginRoundReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		-- block empty
	end

	ActivityChessGameModel.instance:cleanOptList()
end

function var_0_0.sendAct109UseItemRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = Activity109Module_pb.Act109UseItemRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.x = arg_7_2
	var_7_0.y = arg_7_3

	arg_7_0:sendMsg(var_7_0, arg_7_4, arg_7_5)
end

function var_0_0.onReceiveAct109UseItemReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveAct109StepPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 and Activity109ChessModel.instance:getActId() == arg_9_2.activityId then
		local var_9_0 = ActivityChessGameController.instance.event

		if var_9_0 then
			var_9_0:insertStepList(arg_9_2.steps)
		end
	end
end

function var_0_0.sendAct109EventEndRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = Activity109Module_pb.Act109EventEndRequest()

	var_10_0.activityId = arg_10_1

	arg_10_0:sendMsg(var_10_0, arg_10_2, arg_10_3)
end

function var_0_0.onReceiveAct109EventEndReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendAct109AbortRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = Activity109Module_pb.Act109AbortRequest()

	var_12_0.activityId = arg_12_1

	arg_12_0:sendMsg(var_12_0, arg_12_2, arg_12_3)
end

function var_0_0.onReceiveAct109AbortReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		-- block empty
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
