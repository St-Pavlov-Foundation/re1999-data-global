module("modules.logic.versionactivity2_1.aergusi.rpc.Activity163Rpc", package.seeall)

slot0 = class("Activity163Rpc", BaseRpc)
slot0.instance = slot0.New()

function slot0.sendGet163InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity163Module_pb.Get163InfosRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet163InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AergusiModel.instance:setEpisodeInfos(slot2.actInfo.episodeInfo)
	AergusiModel.instance:setReadClueList(slot2.actInfo.readClueIds)
	AergusiController.instance:dispatchEvent(AergusiEvent.ActInfoUpdate)
end

function slot0.onReceiveAct163InfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AergusiModel.instance:setEpisodeInfos(slot2.actInfo.episodeInfo)
	AergusiController.instance:dispatchEvent(AergusiEvent.ActInfoUpdate)
end

function slot0.sendAct163StartEvidenceRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity163Module_pb.Act163StartEvidenceRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct163StartEvidenceReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AergusiModel.instance:setEpisodeUnlockAutoTipProcess(slot2.progress)
	AergusiModel.instance:setEvidenceInfo(slot2.episodeId, slot2.evidenceInfo)
	AergusiController.instance:dispatchEvent(AergusiEvent.StartEpisode)
end

function slot0.sendAct163EvidenceOperationRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = Activity163Module_pb.Act163EvidenceOperationRequest()
	slot7.activityId = slot1
	slot7.episodeId = slot2
	slot7.operationType = slot3
	slot7.params = slot4

	return slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveAct163EvidenceOperationReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AergusiModel.instance:setEvidenceInfo(slot2.episodeId, slot2.evidenceInfo)
	AergusiController.instance:dispatchEvent(AergusiEvent.StartOperation, slot2.operationType, slot2.operationResult)
end

function slot0.sendAct163ReadClueRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity163Module_pb.Act163ReadClueRequest()
	slot5.activityId = slot1
	slot5.clueId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct163ReadClueReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AergusiModel.instance:setClueReaded(slot2.clueId)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnClueReadUpdate, slot2.clueId)
end

return slot0
