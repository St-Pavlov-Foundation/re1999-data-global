module("modules.logic.social.rpc.ChatRpc", package.seeall)

local var_0_0 = class("ChatRpc", BaseRpc)

function var_0_0.sendSendMsgRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = ChatModule_pb.SendMsgRequest()

	var_1_0.channelType = arg_1_1
	var_1_0.recipientId = arg_1_2
	var_1_0.content = arg_1_3
	var_1_0.msgType = arg_1_4 or 0
	var_1_0.extData = arg_1_5 or ""

	arg_1_0:sendMsg(var_1_0, arg_1_6, arg_1_7)
end

function var_0_0.onReceiveSendMsgReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 and not string.nilorempty(arg_2_2.message) then
		GameFacade.showMessageBox(MessageBoxIdDefine.ForbidSendMessage, MsgBoxEnum.BoxType.Yes, nil, nil, nil, nil, nil, nil, arg_2_2.message)
	end
end

function var_0_0.sendDeleteOfflineMsgRequest(arg_3_0)
	local var_3_0 = ChatModule_pb.DeleteOfflineMsgRequest()

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveDeleteOfflineMsgReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveChatMsgPush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		local var_5_0 = arg_5_2.msg

		if var_5_0 and #var_5_0 > 0 then
			local var_5_1 = PlayerModel.instance:getMyUserId()
			local var_5_2 = false

			for iter_5_0, iter_5_1 in ipairs(var_5_0) do
				if iter_5_1.senderId ~= var_5_1 then
					var_5_2 = true
				end

				SocialMessageModel.instance:addSocialMessage(iter_5_1)
			end

			if var_5_2 then
				arg_5_0:sendDeleteOfflineMsgRequest()
			end
		end
	end
end

function var_0_0.sendGetReportTypeRequest(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = ChatModule_pb.GetReportTypeRequest()

	arg_6_0:sendMsg(var_6_0, arg_6_1, arg_6_2)
end

function var_0_0.onReceiveGetReportTypeReply(arg_7_0)
	return
end

function var_0_0.sendReportRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = ChatModule_pb.ReportRequest()

	var_8_0.reportedUserId = arg_8_1
	var_8_0.reportTypeId = arg_8_2
	var_8_0.content = arg_8_3

	arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveReportReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		SocialController.instance:dispatchEvent(SocialEvent.InformSuccessReply)
	else
		SocialController.instance:dispatchEvent(SocialEvent.InformFailReply)
	end
end

function var_0_0.sendWordTestRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = ChatModule_pb.WordTestRequest()

	var_10_0.content = arg_10_1

	arg_10_0:sendMsg(var_10_0, arg_10_2, arg_10_3)
end

function var_0_0.onReceiveWordTestReply(arg_11_0, arg_11_1, arg_11_2)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
