module("modules.logic.investigate.rpc.InvestigateRpc", package.seeall)

slot0 = class("InvestigateRpc", BaseRpc)

function slot0.sendGetInvestigateRequest(slot0)
	slot0:sendMsg(InvestigateModule_pb.GetInvestigateRequest())
end

function slot0.onReceiveGetInvestigateReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	InvestigateOpinionModel.instance:initOpinionInfo(slot2.info)
end

function slot0.sendPutClueRequest(slot0, slot1, slot2)
	slot3 = InvestigateModule_pb.PutClueRequest()
	slot3.id = slot1
	slot3.clueId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceivePutClueReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.id
	slot4 = slot2.clueId

	InvestigateOpinionModel.instance:setLinkedStatus(slot4, true)
	InvestigateController.instance:dispatchEvent(InvestigateEvent.LinkedOpinionSuccess, slot4)
end

function slot0.onReceiveInvestigateInfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	InvestigateOpinionModel.instance:initOpinionInfo(slot2.info)
end

slot0.instance = slot0.New()

return slot0
