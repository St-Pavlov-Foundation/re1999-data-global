module("modules.logic.versionactivity1_5.act142.rpc.Activity142Rpc", package.seeall)

slot0 = class("Activity142Rpc", BaseRpc)

function slot0.sendGetActInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity142Module_pb.GetAct142InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct142InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity142Model.instance:onReceiveGetAct142InfoReply(slot2)
	end
end

function slot0.sendActStartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity142Module_pb.Act142StartEpisodeRequest()
	slot5.activityId = slot1
	slot5.id = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct142StartEpisodeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if slot2.map and (not slot2.episodeId or slot2.episodeId == 0) then
		Activity142Model.instance:onReceiveAct142StartEpisodeReply(slot2)
		Va3ChessRpcController.instance:onReceiveActStartEpisodeReply(slot1, slot2)
	end
end

function slot0.sendActAbortRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity142Module_pb.Act142AbortRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct142AbortReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Va3ChessGameController.instance:gameOver()
	end
end

function slot0.sendActEventEndRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity142Module_pb.Act142EventEndRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct142EventEndReply(slot0, slot1, slot2)
end

function slot0.sendActUseItemRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity142Module_pb.Act142UseItemRequest()
	slot6.activityId = slot1
	slot6.x = slot2
	slot6.y = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct142UseItemReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendAct142UseFireballRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot9 = Activity142Module_pb.Act142UseFireballRequest()
	slot9.activityId = slot1
	slot9.x = slot2
	slot9.y = slot3
	slot9.x2 = slot4
	slot9.y2 = slot5
	slot9.killedObjectId = slot6

	slot0:sendMsg(slot9, slot7, slot8)
end

function slot0.onReceiveAct142UseFireballReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Va3ChessGameModel.instance:setFireBallCount(slot2.fireballNum)
	end
end

function slot0.sendActBeginRoundRequest(slot0, slot1, slot2, slot3, slot4)
	Activity142Module_pb.Act142BeginRoundRequest().activityId = slot1

	for slot9, slot10 in ipairs(slot2) do
		slot11 = slot5.operations:add()
		slot11.id = slot10.id
		slot11.moveDirection = slot10.dir
	end

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct142BeginRoundReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end

	Va3ChessGameModel.instance:cleanOptList()
end

function slot0.onReceiveAct142StepPush(slot0, slot1, slot2)
	if slot1 == 0 and Va3ChessModel.instance:getActId() == slot2.activityId and Va3ChessGameController.instance.event then
		slot3:insertStepList(slot2.steps)
	end
end

function slot0.sendAct142CheckPointRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity142Module_pb.Act142CheckPointRequest()
	slot5.activityId = slot1
	slot5.lastCheckPoint = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct142CheckPointReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = slot2.map
		slot5 = slot2.activityId

		Va3ChessController.instance:initMapData(slot5, slot3)
		Va3ChessGameController.instance:enterChessGame(slot5, slot3.mapId, ViewName.Activity142GameView)

		if slot3.fragileTilebases then
			Va3ChessGameModel.instance:updateFragileTilebases(slot5, slot3.fragileTilebases)
		end

		if slot3.brokenTilebases then
			Va3ChessGameModel.instance:updateBrokenTilebases(slot5, slot3.brokenTilebases)
		end

		Activity142Controller.instance:dispatchEvent(Activity142Event.Back2CheckPoint)
	end
end

function slot0.sendGetAct142CollectionsRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity142Module_pb.GetAct142CollectionsRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct142CollectionsReply(slot0, slot1, slot2)
	if slot1 == 0 and Activity142Model.instance:getActivityId() == slot2.activityId then
		for slot7, slot8 in ipairs(slot2.collectionIds) do
			Activity142Model.instance:setHasCollection(slot8)
		end
	end
end

slot0.instance = slot0.New()

return slot0
