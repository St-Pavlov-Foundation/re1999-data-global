module("modules.logic.social.rpc.ChatRpc", package.seeall)

slot0 = class("ChatRpc", BaseRpc)

function slot0.sendSendMsgRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot8 = ChatModule_pb.SendMsgRequest()
	slot8.channelType = slot1
	slot8.recipientId = slot2
	slot8.content = slot3
	slot8.msgType = slot4 or 0
	slot8.extData = slot5 or ""

	slot0:sendMsg(slot8, slot6, slot7)
end

function slot0.onReceiveSendMsgReply(slot0, slot1, slot2)
	if slot1 == 0 and not string.nilorempty(slot2.message) then
		GameFacade.showMessageBox(MessageBoxIdDefine.ForbidSendMessage, MsgBoxEnum.BoxType.Yes, nil, , , , , , slot2.message)
	end
end

function slot0.sendDeleteOfflineMsgRequest(slot0)
	slot0:sendMsg(ChatModule_pb.DeleteOfflineMsgRequest())
end

function slot0.onReceiveDeleteOfflineMsgReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.onReceiveChatMsgPush(slot0, slot1, slot2)
	if slot1 == 0 and slot2.msg and #slot3 > 0 then
		slot5 = false

		for slot9, slot10 in ipairs(slot3) do
			if slot10.senderId ~= PlayerModel.instance:getMyUserId() then
				slot5 = true
			end

			SocialMessageModel.instance:addSocialMessage(slot10)
		end

		if slot5 then
			slot0:sendDeleteOfflineMsgRequest()
		end
	end
end

function slot0.sendGetReportTypeRequest(slot0, slot1, slot2)
	slot0:sendMsg(ChatModule_pb.GetReportTypeRequest(), slot1, slot2)
end

function slot0.onReceiveGetReportTypeReply(slot0)
end

function slot0.sendReportRequest(slot0, slot1, slot2, slot3)
	slot4 = ChatModule_pb.ReportRequest()
	slot4.reportedUserId = slot1
	slot4.reportTypeId = slot2
	slot4.content = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveReportReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialController.instance:dispatchEvent(SocialEvent.InformSuccessReply)
	else
		SocialController.instance:dispatchEvent(SocialEvent.InformFailReply)
	end
end

function slot0.sendWordTestRequest(slot0, slot1, slot2, slot3)
	slot4 = ChatModule_pb.WordTestRequest()
	slot4.content = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveWordTestReply(slot0, slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
