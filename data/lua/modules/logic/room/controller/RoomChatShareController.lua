module("modules.logic.room.controller.RoomChatShareController", package.seeall)

slot0 = class("RoomChatShareController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
end

function slot0.chatSeekShare(slot0, slot1)
	if not RoomLayoutController.instance:isOpen() then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotOpen)

		return
	end

	if RoomLayoutModel.instance:isNeedRpcGet() then
		RoomRpc.instance:sendGetRoomPlanInfoRequest(slot0._onPlanInfoChatSeekShare, slot0)

		return
	end

	slot0._seekShareMsgMO = slot1

	slot0:_chatSeekShare()
end

function slot0._onPlanInfoChatSeekShare(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:_chatSeekShare()
	end
end

function slot0._chatSeekShare(slot0)
	if RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId):isSharing() then
		slot0:_sendChatSeekShare()

		return
	end

	if slot1:isEmpty() or not slot1:haveEdited() then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotCanShare)

		return
	end

	if RoomLayoutModel.instance:getCanShareCount() <= 0 then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotNum)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanCanShareCount, MsgBoxEnum.BoxType.Yes_No, slot0._sendShareRoomPlanRequest, nil, , slot0, nil, , slot2)
end

function slot0._sendShareRoomPlanRequest(slot0)
	RoomRpc.instance:sendShareRoomPlanRequest(RoomEnum.LayoutUsedPlanId, slot0._onShareRoomPlanReply, slot0)
end

function slot0._onShareRoomPlanReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:_sendChatSeekShare()
	end
end

function slot0._sendChatSeekShare(slot0)
	if not slot0._seekShareMsgMO then
		return
	end

	if RoomLayoutModel.instance:getById(0):isSharing() then
		slot2 = slot0._seekShareMsgMO
		slot0._seekShareMsgMO = nil
		slot3 = slot1:getShareCode()

		ChatRpc.instance:sendSendMsgRequest(slot2.channelType, slot2.senderId, formatLuaLang("room_chat_share_code_content", slot3), ChatEnum.MsgType.RoomShareCode, slot3)
	end
end

function slot0.chatShareCode(slot0, slot1)
	RoomLayoutController.instance:copyShareCodeTxt(slot1.extData)
end

slot0.instance = slot0.New()

return slot0
