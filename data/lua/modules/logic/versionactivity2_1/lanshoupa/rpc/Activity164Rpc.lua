module("modules.logic.versionactivity2_1.lanshoupa.rpc.Activity164Rpc", package.seeall)

local var_0_0 = class("Activity164Rpc", BaseRpc)

function var_0_0.sendGetActInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity164Module_pb.GetAct164InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct164InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity164Model.instance:onReceiveGetAct164InfoReply(arg_2_2)
		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.Refresh164MapData)
	end
end

function var_0_0.sendActStartEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity164Module_pb.Act164StartEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct164StartEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		ChessRpcController.instance:onReceiveActStartEpisodeReply(arg_4_1, arg_4_2)
	end
end

function var_0_0.sendActReStartEpisodeRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity164Module_pb.Act164ReStartEpisodeRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.episodeId = arg_5_2

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveAct164ReStartEpisodeReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		ChessGameModel.instance:setGameState(nil)
		ChessGameController.instance:abortGame()
		ChessRpcController.instance:onReceiveActStartEpisodeReply(arg_6_1, arg_6_2)
	end
end

function var_0_0.sendActBeginRoundRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = Activity164Module_pb.Act164BeginRoundRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.episodeId = arg_7_2

	for iter_7_0, iter_7_1 in ipairs(arg_7_3) do
		local var_7_1 = var_7_0.operations:add()

		var_7_1.type = iter_7_1.type
		var_7_1.id = iter_7_1.id
		var_7_1.direction = iter_7_1.direction
		var_7_1.param = iter_7_1.param
	end

	arg_7_0:sendMsg(var_7_0, arg_7_4, arg_7_5)
end

function var_0_0.onReceiveAct164BeginRoundReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		-- block empty
	end

	ChessGameModel.instance:addRound()
	ChessGameModel.instance:cleanOptList()
end

function var_0_0.onReceiveAct164StepPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 and ChessModel.instance:getActId() == arg_9_2.activityId then
		local var_9_0 = ChessGameController.instance.eventMgr

		if var_9_0 then
			var_9_0:insertStepList(arg_9_2.steps)
		end
	end
end

function var_0_0.sendActAbortRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = Activity164Module_pb.Act164AbortRequest()

	var_10_0.activityId = arg_10_1
	var_10_0.episodeId = arg_10_2

	arg_10_0:sendMsg(var_10_0, arg_10_3, arg_10_4)
end

function var_0_0.onReceiveAct164AbortReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		ChessGameController.instance:gameOver()
	end
end

function var_0_0.sendActRollBackRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	local var_12_0 = Activity164Module_pb.Act164RollbackRequest()

	var_12_0.activityId = arg_12_1
	var_12_0.episodeId = arg_12_2
	var_12_0.type = arg_12_3

	arg_12_0:sendMsg(var_12_0, arg_12_4, arg_12_5)
end

function var_0_0.onReceiveAct164RollbackReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		ChessRpcController.instance:onReceiveActStartEpisodeReply(arg_13_1, arg_13_2)
		ChessGameModel.instance:setGameState(nil)
		ChessGameController.instance:dispatchEvent(ChessGameEvent.RollBack)
		ChessGameModel.instance:addRollBackNum()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
