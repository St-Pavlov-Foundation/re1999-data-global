module("modules.logic.versionactivity1_9.fairyland.rpc.FairyLandRpc", package.seeall)

slot0 = class("FairyLandRpc", BaseRpc)

function slot0.sendGetFairylandInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(FairylandModule_pb.GetFairylandInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetFairylandInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	FairyLandModel.instance:onGetFairylandInfoReply(slot2)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.UpdateInfo)
end

function slot0.sendResolvePuzzleRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = FairylandModule_pb.ResolvePuzzleRequest()
	slot5.passPuzzleId = slot1
	slot5.answer = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveResolvePuzzleReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	FairyLandModel.instance:onResolvePuzzleReply(slot2)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.ResolveSuccess)
end

function slot0.sendRecordDialogRequest(slot0, slot1, slot2, slot3)
	slot4 = FairylandModule_pb.RecordDialogRequest()
	slot4.dialogId = slot1

	FairyLandModel.instance:setFinishDialog(slot1)

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRecordDialogReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	FairyLandModel.instance:onRecordDialogReply(slot2)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.DialogFinish)
end

function slot0.sendRecordElementRequest(slot0, slot1, slot2, slot3)
	slot4 = FairylandModule_pb.RecordElementRequest()
	slot4.elementId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRecordElementReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	FairyLandModel.instance:onRecordElementReply(slot2)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.ElementFinish)
end

slot0.instance = slot0.New()

return slot0
