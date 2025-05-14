module("modules.logic.versionactivity1_3.chess.rpc.Activity122Rpc", package.seeall)

local var_0_0 = class("Activity122Rpc", BaseRpc)

function var_0_0.sendGetActInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity122Module_pb.GetAct122InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct122InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity122Model.instance:onReceiveGetAct122InfoReply(arg_2_2)
	end
end

function var_0_0.sendActStartEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity122Module_pb.Act122StartEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct122StartEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity122Model.instance:onReceiveAct122StartEpisodeReply(arg_4_2)
		Va3ChessRpcController.instance:onReceiveActStartEpisodeReply(arg_4_1, arg_4_2)
	end
end

function var_0_0.sendActBeginRoundRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity122Module_pb.Act122BeginRoundRequest()

	var_5_0.activityId = arg_5_1

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_1 = var_5_0.operations:add()

		var_5_1.id = iter_5_1.id
		var_5_1.moveDirection = iter_5_1.dir
	end

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveAct122BeginRoundReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		-- block empty
	end

	Va3ChessGameModel.instance:cleanOptList()
end

function var_0_0.sendActUseItemRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = Activity122Module_pb.Act122UseItemRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.x = arg_7_2
	var_7_0.y = arg_7_3

	arg_7_0:sendMsg(var_7_0, arg_7_4, arg_7_5)
end

function var_0_0.onReceiveAct122UseItemReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveAct122StepPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 and Va3ChessModel.instance:getActId() == arg_9_2.activityId then
		local var_9_0 = Va3ChessGameController.instance.event

		if var_9_0 then
			var_9_0:insertStepList(arg_9_2.steps)
		end
	end
end

function var_0_0.sendActEventEndRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = Activity122Module_pb.Act122EventEndRequest()

	var_10_0.activityId = arg_10_1

	arg_10_0:sendMsg(var_10_0, arg_10_2, arg_10_3)
end

function var_0_0.onReceiveAct122EventEndReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendActAbortRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = Activity122Module_pb.Act122AbortRequest()

	var_12_0.activityId = arg_12_1

	arg_12_0:sendMsg(var_12_0, arg_12_2, arg_12_3)
end

function var_0_0.onReceiveAct122AbortReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		Va3ChessGameController.instance:gameOver()
	end
end

function var_0_0.sendAct122CheckPointRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = Activity122Module_pb.Act122CheckPointRequest()

	var_14_0.activityId = arg_14_1
	var_14_0.lastCheckPoint = arg_14_2

	arg_14_0:sendMsg(var_14_0, arg_14_3, arg_14_4)
end

function var_0_0.onReceiveAct122CheckPointReply(arg_15_0, arg_15_1, arg_15_2)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
