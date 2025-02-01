module("modules.logic.versionactivity2_2.tianshinana.rpc.Activity167Rpc", package.seeall)

slot0 = class("Activity167Rpc", BaseRpc)

function slot0.sendGetAct167InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity167Module_pb.GetAct167InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct167InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TianShiNaNaModel.instance.currEpisodeId = slot2.currEpisodeId

		TianShiNaNaModel.instance:initInfo(slot2.episodes)
	end
end

function slot0.sendAct167StartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity167Module_pb.Act167StartEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct167StartEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TianShiNaNaModel.instance:initDatas(slot2.episodeId, slot2.scene)
	end
end

function slot0.sendAct167ReStartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity167Module_pb.Act167ReStartEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2
	TianShiNaNaModel.instance.sceneLevelLoadFinish = false

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct167ReStartEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TianShiNaNaModel.instance.sceneLevelLoadFinish = true

		TianShiNaNaModel.instance:resetScene(slot2.scene, true)
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.ResetScene)
	else
		TianShiNaNaModel.instance.waitStartFlow = false
	end
end

function slot0.sendAct167BeginRoundRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity167Module_pb.Act167BeginRoundRequest()
	slot4.activityId = slot1
	slot4.episodeId = slot2

	for slot8, slot9 in ipairs(slot3) do
		table.insert(slot4.operations, slot9)
	end

	slot0:sendMsg(slot4)
end

function slot0.onReceiveAct167BeginRoundReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.RoundFail)
	end
end

function slot0.sendAct167AbortRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity167Module_pb.Act167AbortRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct167AbortReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendAct167RollbackRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity167Module_pb.Act167RollbackRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct167RollbackReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TianShiNaNaModel.instance:resetScene(slot2.scene)
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.ResetScene)
	end
end

function slot0.onReceiveAct167StepPush(slot0, slot1, slot2)
	if slot1 == 0 then
		TianShiNaNaController.instance:buildFlow(slot2.steps)
	end
end

slot0.instance = slot0.New()

return slot0
