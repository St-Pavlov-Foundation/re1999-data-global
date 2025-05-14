module("modules.logic.versionactivity2_2.eliminate.rpc.EliminateRpc", package.seeall)

local var_0_0 = class("EliminateRpc", BaseRpc)

function var_0_0.sendStartMatch3WarChessInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	local var_1_0 = Match3WarChessModule_pb.StartMatch3WarChessInfoRequest()

	var_1_0.id = arg_1_1
	var_1_0.WarChessCharacterId = arg_1_2

	for iter_1_0, iter_1_1 in ipairs(arg_1_3) do
		var_1_0.WarChessPieceId:append(iter_1_1)
	end

	arg_1_0:sendMsg(var_1_0, arg_1_4, arg_1_5)
end

function var_0_0.onReceiveStartMatch3WarChessInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		EliminateChessController.instance:handleEliminateChessInfo(arg_2_2.info)
		EliminateChessController.instance:handleMatch3Tips(arg_2_2.match3tips)
	end
end

function var_0_0.sendMatch3ChessBoardSwapRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	local var_3_0 = Match3WarChessModule_pb.Match3ChessBoardSwapRequest()

	var_3_0.from.x = arg_3_1 - 1
	var_3_0.from.y = arg_3_2 - 1
	var_3_0.to.x = arg_3_3 - 1
	var_3_0.to.y = arg_3_4 - 1

	arg_3_0:sendMsg(var_3_0, arg_3_5, arg_3_6)
end

function var_0_0.onReceiveMatch3ChessBoardSwapReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		if arg_4_2.success then
			EliminateChessController.instance:handleMovePoint(arg_4_2.movePoint)
			EliminateChessController.instance:handleMatch3Tips(arg_4_2.match3tips)
		end

		EliminateChessController.instance:handleTurnInfo(arg_4_2.turn, arg_4_2.success)
		EliminateLevelController.instance:updatePlayerExtraWinCondition(arg_4_2.extraWinCondition)
	end
end

function var_0_0.sendGetMatch3WarChessFacadeInfoRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Match3WarChessModule_pb.GetMatch3WarChessFacadeInfoRequest()

	arg_5_0:sendMsg(var_5_0, arg_5_1, arg_5_2)
end

function var_0_0.onReceiveGetMatch3WarChessFacadeInfoReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		local var_6_0 = arg_6_2.ownedWarChessCharacterId
		local var_6_1 = arg_6_2.ownedWarChessPieceId
		local var_6_2 = arg_6_2.episodeInfo
		local var_6_3 = arg_6_2.unlockSlotId
		local var_6_4 = arg_6_2.totalStar
		local var_6_5 = arg_6_2.gainedTaskId

		EliminateOutsideModel.instance:initTaskInfo(var_6_4, var_6_5)
		EliminateOutsideModel.instance:initMapInfo(var_6_0, var_6_1, var_6_2, var_6_3)
	end
end

function var_0_0.sendGetMatch3WarChessTaskRewardRequest(arg_7_0, arg_7_1)
	local var_7_0 = Match3WarChessModule_pb.GetMatch3WarChessTaskRewardRequest()

	var_7_0.taskId = arg_7_1

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveGetMatch3WarChessTaskRewardReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	local var_8_0 = arg_8_2.taskId

	EliminateOutsideModel.instance:addGainedTask(var_8_0)
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.UpdateTask)
end

function var_0_0.sendGetMatch3WarChessInfoRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = Match3WarChessModule_pb.GetMatch3WarChessInfoRequest()

	var_9_0.type = arg_9_1

	arg_9_0:sendMsg(var_9_0, arg_9_2, arg_9_3)
end

function var_0_0.onReceiveGetMatch3WarChessInfoReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		local var_10_0 = arg_10_2.type
		local var_10_1 = arg_10_2.info

		EliminateChessController.instance:handleEliminateChessInfo(var_10_1)

		if var_10_0 == EliminateEnum.GetInfoType.All then
			EliminateChessController.instance:handleMatch3Tips(arg_10_2.match3tips)
		end
	end
end

function var_0_0.sendRefreshMatch3WarChessInfoRequest(arg_11_0, arg_11_1, arg_11_2)
	logNormal("EliminateRpc:sendRefreshMatch3WarChessInfoRequest")

	local var_11_0 = Match3WarChessModule_pb.RefreshMatch3WarChessInfoRequest()

	arg_11_0:sendMsg(var_11_0, arg_11_1, arg_11_2)
end

function var_0_0.onReceiveRefreshMatch3WarChessInfoReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		EliminateChessController.instance:checkAndSetNeedResetData(arg_12_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
