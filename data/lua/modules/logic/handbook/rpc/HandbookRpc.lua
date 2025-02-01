module("modules.logic.handbook.rpc.HandbookRpc", package.seeall)

slot0 = class("HandbookRpc", BaseRpc)

function slot0.sendGetHandbookInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(HandbookModule_pb.GetHandbookInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetHandbookInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	HandbookModel.instance:setReadInfos(slot2.infos)
	HandbookModel.instance:setFragmentInfo(slot2.elementInfo)
end

function slot0.sendHandbookReadRequest(slot0, slot1, slot2)
	slot3 = HandbookModule_pb.HandbookReadRequest()
	slot3.type = slot1
	slot3.id = slot2

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveHandbookReadReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = {
		isRead = true,
		type = slot2.type,
		id = slot2.id
	}

	HandbookModel.instance:setReadInfo(slot3)
	HandbookController.instance:dispatchEvent(HandbookEvent.OnReadInfoChanged, slot3)
end

slot0.instance = slot0.New()

return slot0
