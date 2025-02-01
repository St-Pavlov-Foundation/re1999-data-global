module("modules.logic.versionactivity2_1.lanshoupa.rpc.Activity164Rpc", package.seeall)

slot0 = class("Activity164Rpc", BaseRpc)

function slot0.sendGetActInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity164Module_pb.GetAct164InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct164InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity164Model.instance:onReceiveGetAct164InfoReply(slot2)
		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.Refresh164MapData)
	end
end

function slot0.sendActStartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity164Module_pb.Act164StartEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct164StartEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ChessRpcController.instance:onReceiveActStartEpisodeReply(slot1, slot2)
	end
end

function slot0.sendActReStartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity164Module_pb.Act164ReStartEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct164ReStartEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ChessGameModel.instance:setGameState(nil)
		ChessGameController.instance:abortGame()
		ChessRpcController.instance:onReceiveActStartEpisodeReply(slot1, slot2)
	end
end

function slot0.sendActBeginRoundRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity164Module_pb.Act164BeginRoundRequest()
	slot6.activityId = slot1
	slot6.episodeId = slot2

	for slot10, slot11 in ipairs(slot3) do
		slot12 = slot6.operations:add()
		slot12.type = slot11.type
		slot12.id = slot11.id
		slot12.direction = slot11.direction
		slot12.param = slot11.param
	end

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct164BeginRoundReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end

	ChessGameModel.instance:addRound()
	ChessGameModel.instance:cleanOptList()
end

function slot0.onReceiveAct164StepPush(slot0, slot1, slot2)
	if slot1 == 0 and ChessModel.instance:getActId() == slot2.activityId and ChessGameController.instance.eventMgr then
		slot3:insertStepList(slot2.steps)
	end
end

function slot0.sendActAbortRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity164Module_pb.Act164AbortRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct164AbortReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ChessGameController.instance:gameOver()
	end
end

function slot0.sendActRollBackRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity164Module_pb.Act164RollbackRequest()
	slot6.activityId = slot1
	slot6.episodeId = slot2
	slot6.type = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct164RollbackReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ChessRpcController.instance:onReceiveActStartEpisodeReply(slot1, slot2)
		ChessGameModel.instance:setGameState(nil)
		ChessGameController.instance:dispatchEvent(ChessGameEvent.RollBack)
		ChessGameModel.instance:addRollBackNum()
	end
end

slot0.instance = slot0.New()

return slot0
