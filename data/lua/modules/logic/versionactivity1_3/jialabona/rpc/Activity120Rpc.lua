module("modules.logic.versionactivity1_3.jialabona.rpc.Activity120Rpc", package.seeall)

slot0 = class("Activity120Rpc", BaseRpc)

function slot0.sendGetActInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity120Module_pb.GetAct120InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct120InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity120Model.instance:onReceiveGetAct120InfoReply(slot2)
		JiaLaBoNaController.instance:dispatchEvent(JiaLaBoNaEvent.Refresh120MapData)
	end
end

function slot0.sendActStartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity120Module_pb.Act120StartEpisodeRequest()
	slot5.activityId = slot1
	slot5.id = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct120StartEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Va3ChessGameModel.instance:clearLastMapRound()
		Activity120Model.instance:increaseCount(slot2.map.id)
		Va3ChessRpcController.instance:onReceiveActStartEpisodeReply(slot1, slot2)
	end
end

function slot0.sendActBeginRoundRequest(slot0, slot1, slot2, slot3, slot4)
	Activity120Module_pb.Act120BeginRoundRequest().activityId = slot1

	for slot9, slot10 in ipairs(slot2) do
		slot11 = slot5.operations:add()
		slot11.id = slot10.id
		slot11.moveDirection = slot10.dir
	end

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct120BeginRoundReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end

	Va3ChessGameModel.instance:cleanOptList()
end

function slot0.sendActUseItemRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity120Module_pb.Act120UseItemRequest()
	slot6.activityId = slot1
	slot6.x = slot2
	slot6.y = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct120UseItemReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.onReceiveAct120StepPush(slot0, slot1, slot2)
	if slot1 == 0 and Va3ChessModel.instance:getActId() == slot2.activityId and Va3ChessGameController.instance.event then
		slot3:insertStepList(slot2.steps)
	end
end

function slot0.sendActEventEndRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity120Module_pb.Act120EventEndRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct120EventEndReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendActAbortRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity120Module_pb.Act120AbortRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct120AbortReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Va3ChessGameController.instance:gameOver()
	end
end

function slot0.sendActCheckPointRequest(slot0, slot1, slot2, slot3, slot4)
	Activity120Module_pb.Act120CheckPointRequest().activityId = slot1
	slot5.lastCheckPoint = slot2 and true or false

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct120CheckPointReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity120Model.instance:increaseCount(slot2.map.id)
		Va3ChessRpcController.instance:onReceiveActStartEpisodeReply(slot1, slot2)
	end
end

slot0.instance = slot0.New()

return slot0
