module("modules.logic.versionactivity2_2.eliminate.rpc.EliminateRpc", package.seeall)

slot0 = class("EliminateRpc", BaseRpc)

function slot0.sendStartMatch3WarChessInfoRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Match3WarChessModule_pb.StartMatch3WarChessInfoRequest()
	slot6.id = slot1
	slot6.WarChessCharacterId = slot2

	for slot10, slot11 in ipairs(slot3) do
		slot6.WarChessPieceId:append(slot11)
	end

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveStartMatch3WarChessInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		EliminateChessController.instance:handleEliminateChessInfo(slot2.info)
		EliminateChessController.instance:handleMatch3Tips(slot2.match3tips)
	end
end

function slot0.sendMatch3ChessBoardSwapRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = Match3WarChessModule_pb.Match3ChessBoardSwapRequest()
	slot7.from.x = slot1 - 1
	slot7.from.y = slot2 - 1
	slot7.to.x = slot3 - 1
	slot7.to.y = slot4 - 1

	slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveMatch3ChessBoardSwapReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.success then
			EliminateChessController.instance:handleMovePoint(slot2.movePoint)
			EliminateChessController.instance:handleMatch3Tips(slot2.match3tips)
		end

		EliminateChessController.instance:handleTurnInfo(slot2.turn, slot2.success)
		EliminateLevelController.instance:updatePlayerExtraWinCondition(slot2.extraWinCondition)
	end
end

function slot0.sendGetMatch3WarChessFacadeInfoRequest(slot0, slot1, slot2)
	slot0:sendMsg(Match3WarChessModule_pb.GetMatch3WarChessFacadeInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetMatch3WarChessFacadeInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		EliminateOutsideModel.instance:initTaskInfo(slot2.totalStar, slot2.gainedTaskId)
		EliminateOutsideModel.instance:initMapInfo(slot2.ownedWarChessCharacterId, slot2.ownedWarChessPieceId, slot2.episodeInfo, slot2.unlockSlotId)
	end
end

function slot0.sendGetMatch3WarChessTaskRewardRequest(slot0, slot1)
	slot2 = Match3WarChessModule_pb.GetMatch3WarChessTaskRewardRequest()
	slot2.taskId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetMatch3WarChessTaskRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	EliminateOutsideModel.instance:addGainedTask(slot2.taskId)
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.UpdateTask)
end

function slot0.sendGetMatch3WarChessInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Match3WarChessModule_pb.GetMatch3WarChessInfoRequest()
	slot4.type = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetMatch3WarChessInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		EliminateChessController.instance:handleEliminateChessInfo(slot2.info)

		if slot2.type == EliminateEnum.GetInfoType.All then
			EliminateChessController.instance:handleMatch3Tips(slot2.match3tips)
		end
	end
end

function slot0.sendRefreshMatch3WarChessInfoRequest(slot0, slot1, slot2)
	logNormal("EliminateRpc:sendRefreshMatch3WarChessInfoRequest")
	slot0:sendMsg(Match3WarChessModule_pb.RefreshMatch3WarChessInfoRequest(), slot1, slot2)
end

function slot0.onReceiveRefreshMatch3WarChessInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		EliminateChessController.instance:checkAndSetNeedResetData(slot2)
	end
end

slot0.instance = slot0.New()

return slot0
