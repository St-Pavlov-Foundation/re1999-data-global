module("modules.logic.versionactivity1_3.chess.rpc.Activity122Rpc", package.seeall)

slot0 = class("Activity122Rpc", BaseRpc)

function slot0.sendGetActInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity122Module_pb.GetAct122InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct122InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity122Model.instance:onReceiveGetAct122InfoReply(slot2)
	end
end

function slot0.sendActStartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity122Module_pb.Act122StartEpisodeRequest()
	slot5.activityId = slot1
	slot5.id = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct122StartEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity122Model.instance:onReceiveAct122StartEpisodeReply(slot2)
		Va3ChessRpcController.instance:onReceiveActStartEpisodeReply(slot1, slot2)
	end
end

function slot0.sendActBeginRoundRequest(slot0, slot1, slot2, slot3, slot4)
	Activity122Module_pb.Act122BeginRoundRequest().activityId = slot1

	for slot9, slot10 in ipairs(slot2) do
		slot11 = slot5.operations:add()
		slot11.id = slot10.id
		slot11.moveDirection = slot10.dir
	end

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct122BeginRoundReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end

	Va3ChessGameModel.instance:cleanOptList()
end

function slot0.sendActUseItemRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity122Module_pb.Act122UseItemRequest()
	slot6.activityId = slot1
	slot6.x = slot2
	slot6.y = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct122UseItemReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.onReceiveAct122StepPush(slot0, slot1, slot2)
	if slot1 == 0 and Va3ChessModel.instance:getActId() == slot2.activityId and Va3ChessGameController.instance.event then
		slot3:insertStepList(slot2.steps)
	end
end

function slot0.sendActEventEndRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity122Module_pb.Act122EventEndRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct122EventEndReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendActAbortRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity122Module_pb.Act122AbortRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct122AbortReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Va3ChessGameController.instance:gameOver()
	end
end

function slot0.sendAct122CheckPointRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity122Module_pb.Act122CheckPointRequest()
	slot5.activityId = slot1
	slot5.lastCheckPoint = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct122CheckPointReply(slot0, slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
