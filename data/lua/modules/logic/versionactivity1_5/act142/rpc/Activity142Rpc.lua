module("modules.logic.versionactivity1_5.act142.rpc.Activity142Rpc", package.seeall)

local var_0_0 = class("Activity142Rpc", BaseRpc)

function var_0_0.sendGetActInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity142Module_pb.GetAct142InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct142InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity142Model.instance:onReceiveGetAct142InfoReply(arg_2_2)
	end
end

function var_0_0.sendActStartEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity142Module_pb.Act142StartEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct142StartEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	if arg_4_2.map and (not arg_4_2.episodeId or arg_4_2.episodeId == 0) then
		Activity142Model.instance:onReceiveAct142StartEpisodeReply(arg_4_2)
		Va3ChessRpcController.instance:onReceiveActStartEpisodeReply(arg_4_1, arg_4_2)
	end
end

function var_0_0.sendActAbortRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = Activity142Module_pb.Act142AbortRequest()

	var_5_0.activityId = arg_5_1

	arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveAct142AbortReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		Va3ChessGameController.instance:gameOver()
	end
end

function var_0_0.sendActEventEndRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = Activity142Module_pb.Act142EventEndRequest()

	var_7_0.activityId = arg_7_1

	arg_7_0:sendMsg(var_7_0, arg_7_2, arg_7_3)
end

function var_0_0.onReceiveAct142EventEndReply(arg_8_0, arg_8_1, arg_8_2)
	return
end

function var_0_0.sendActUseItemRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = Activity142Module_pb.Act142UseItemRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.x = arg_9_2
	var_9_0.y = arg_9_3

	arg_9_0:sendMsg(var_9_0, arg_9_4, arg_9_5)
end

function var_0_0.onReceiveAct142UseItemReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendAct142UseFireballRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7, arg_11_8)
	local var_11_0 = Activity142Module_pb.Act142UseFireballRequest()

	var_11_0.activityId = arg_11_1
	var_11_0.x = arg_11_2
	var_11_0.y = arg_11_3
	var_11_0.x2 = arg_11_4
	var_11_0.y2 = arg_11_5
	var_11_0.killedObjectId = arg_11_6

	arg_11_0:sendMsg(var_11_0, arg_11_7, arg_11_8)
end

function var_0_0.onReceiveAct142UseFireballReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		Va3ChessGameModel.instance:setFireBallCount(arg_12_2.fireballNum)
	end
end

function var_0_0.sendActBeginRoundRequest(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = Activity142Module_pb.Act142BeginRoundRequest()

	var_13_0.activityId = arg_13_1

	for iter_13_0, iter_13_1 in ipairs(arg_13_2) do
		local var_13_1 = var_13_0.operations:add()

		var_13_1.id = iter_13_1.id
		var_13_1.moveDirection = iter_13_1.dir
	end

	arg_13_0:sendMsg(var_13_0, arg_13_3, arg_13_4)
end

function var_0_0.onReceiveAct142BeginRoundReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		-- block empty
	end

	Va3ChessGameModel.instance:cleanOptList()
end

function var_0_0.onReceiveAct142StepPush(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 and Va3ChessModel.instance:getActId() == arg_15_2.activityId then
		local var_15_0 = Va3ChessGameController.instance.event

		if var_15_0 then
			var_15_0:insertStepList(arg_15_2.steps)
		end
	end
end

function var_0_0.sendAct142CheckPointRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = Activity142Module_pb.Act142CheckPointRequest()

	var_16_0.activityId = arg_16_1
	var_16_0.lastCheckPoint = arg_16_2

	arg_16_0:sendMsg(var_16_0, arg_16_3, arg_16_4)
end

function var_0_0.onReceiveAct142CheckPointReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		local var_17_0 = arg_17_2.map
		local var_17_1 = var_17_0.mapId
		local var_17_2 = arg_17_2.activityId

		Va3ChessController.instance:initMapData(var_17_2, var_17_0)
		Va3ChessGameController.instance:enterChessGame(var_17_2, var_17_1, ViewName.Activity142GameView)

		if var_17_0.fragileTilebases then
			Va3ChessGameModel.instance:updateFragileTilebases(var_17_2, var_17_0.fragileTilebases)
		end

		if var_17_0.brokenTilebases then
			Va3ChessGameModel.instance:updateBrokenTilebases(var_17_2, var_17_0.brokenTilebases)
		end

		Activity142Controller.instance:dispatchEvent(Activity142Event.Back2CheckPoint)
	end
end

function var_0_0.sendGetAct142CollectionsRequest(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = Activity142Module_pb.GetAct142CollectionsRequest()

	var_18_0.activityId = arg_18_1

	arg_18_0:sendMsg(var_18_0, arg_18_2, arg_18_3)
end

function var_0_0.onReceiveGetAct142CollectionsReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == 0 and Activity142Model.instance:getActivityId() == arg_19_2.activityId then
		for iter_19_0, iter_19_1 in ipairs(arg_19_2.collectionIds) do
			Activity142Model.instance:setHasCollection(iter_19_1)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
