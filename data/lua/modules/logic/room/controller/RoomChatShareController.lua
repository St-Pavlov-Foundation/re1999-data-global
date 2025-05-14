module("modules.logic.room.controller.RoomChatShareController", package.seeall)

local var_0_0 = class("RoomChatShareController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.chatSeekShare(arg_4_0, arg_4_1)
	if not RoomLayoutController.instance:isOpen() then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotOpen)

		return
	end

	if RoomLayoutModel.instance:isNeedRpcGet() then
		RoomRpc.instance:sendGetRoomPlanInfoRequest(arg_4_0._onPlanInfoChatSeekShare, arg_4_0)

		return
	end

	arg_4_0._seekShareMsgMO = arg_4_1

	arg_4_0:_chatSeekShare()
end

function var_0_0._onPlanInfoChatSeekShare(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 == 0 then
		arg_5_0:_chatSeekShare()
	end
end

function var_0_0._chatSeekShare(arg_6_0)
	local var_6_0 = RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId)

	if var_6_0:isSharing() then
		arg_6_0:_sendChatSeekShare()

		return
	end

	if var_6_0:isEmpty() or not var_6_0:haveEdited() then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotCanShare)

		return
	end

	local var_6_1 = RoomLayoutModel.instance:getCanShareCount()

	if var_6_1 <= 0 then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotNum)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanCanShareCount, MsgBoxEnum.BoxType.Yes_No, arg_6_0._sendShareRoomPlanRequest, nil, nil, arg_6_0, nil, nil, var_6_1)
end

function var_0_0._sendShareRoomPlanRequest(arg_7_0)
	RoomRpc.instance:sendShareRoomPlanRequest(RoomEnum.LayoutUsedPlanId, arg_7_0._onShareRoomPlanReply, arg_7_0)
end

function var_0_0._onShareRoomPlanReply(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 == 0 then
		arg_8_0:_sendChatSeekShare()
	end
end

function var_0_0._sendChatSeekShare(arg_9_0)
	if not arg_9_0._seekShareMsgMO then
		return
	end

	local var_9_0 = RoomLayoutModel.instance:getById(0)

	if var_9_0:isSharing() then
		local var_9_1 = arg_9_0._seekShareMsgMO

		arg_9_0._seekShareMsgMO = nil

		local var_9_2 = var_9_0:getShareCode()
		local var_9_3 = ChatEnum.MsgType.RoomShareCode
		local var_9_4 = formatLuaLang("room_chat_share_code_content", var_9_2)

		ChatRpc.instance:sendSendMsgRequest(var_9_1.channelType, var_9_1.senderId, var_9_4, var_9_3, var_9_2)
	end
end

function var_0_0.chatShareCode(arg_10_0, arg_10_1)
	RoomLayoutController.instance:copyShareCodeTxt(arg_10_1.extData)
end

var_0_0.instance = var_0_0.New()

return var_0_0
