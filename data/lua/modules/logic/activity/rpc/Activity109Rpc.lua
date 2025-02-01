module("modules.logic.activity.rpc.Activity109Rpc", package.seeall)

slot0 = class("Activity109Rpc", BaseRpc)

function slot0.sendGetAct109InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity109Module_pb.GetAct109InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct109InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity109Model.instance:onReceiveGetAct109InfoReply(slot2)
		Activity109ChessController.instance:initMapData(slot2.activityId, slot2.map)
	end
end

function slot0.sendAct109StartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity109Module_pb.Act109StartEpisodeRequest()
	slot5.activityId = slot1
	slot5.id = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct109StartEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity109Model.instance:increaseCount(slot2.map.id)
		Activity109ChessController.instance:initMapData(slot2.activityId, slot2.map)
	end
end

function slot0.sendAct109BeginRoundRequest(slot0, slot1, slot2, slot3, slot4)
	Activity109Module_pb.Act109BeginRoundRequest().activityId = slot1

	for slot9, slot10 in ipairs(slot2) do
		slot11 = slot5.operations:add()
		slot11.id = slot10.id
		slot11.moveDirection = slot10.dir
	end

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct109BeginRoundReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end

	ActivityChessGameModel.instance:cleanOptList()
end

function slot0.sendAct109UseItemRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity109Module_pb.Act109UseItemRequest()
	slot6.activityId = slot1
	slot6.x = slot2
	slot6.y = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct109UseItemReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.onReceiveAct109StepPush(slot0, slot1, slot2)
	if slot1 == 0 and Activity109ChessModel.instance:getActId() == slot2.activityId and ActivityChessGameController.instance.event then
		slot3:insertStepList(slot2.steps)
	end
end

function slot0.sendAct109EventEndRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity109Module_pb.Act109EventEndRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct109EventEndReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendAct109AbortRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity109Module_pb.Act109AbortRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct109AbortReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

slot0.instance = slot0.New()

return slot0
