module("modules.logic.dialogue.rpc.DialogueRpc", package.seeall)

slot0 = class("DialogueRpc", BaseRpc)

function slot0.sendGetDialogInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(DialogModule_pb.GetDialogInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetDialogInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	DialogueModel.instance:initDialogue(slot2.dialogIds)
end

function slot0.sendRecordDialogInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = DialogModule_pb.RecordDialogInfoRequest()
	slot4.dialogId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRecordDialogInfoReplay(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	DialogueModel.instance:updateDialogueInfo(slot2.dialogId)
end

slot0.instance = slot0.New()

return slot0
