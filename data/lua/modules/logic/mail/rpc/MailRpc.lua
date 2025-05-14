module("modules.logic.mail.rpc.MailRpc", package.seeall)

local var_0_0 = class("MailRpc", BaseRpc)

function var_0_0.sendGetAllMailsRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = MailModule_pb.GetAllMailsRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetAllMailsReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_2.mails) do
			table.insert(var_2_0, iter_2_1)
		end

		MailModel.instance:onGetMailItemList(var_2_0, true)
		MailController.instance:initInfo()
	end
end

function var_0_0.sendReadMailRequest(arg_3_0, arg_3_1)
	local var_3_0 = MailModule_pb.ReadMailRequest()

	var_3_0.incrId = arg_3_1

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveReadMailReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		local var_4_0 = tonumber(arg_4_2.incrId)

		MailModel.instance:readMail(var_4_0)
	end
end

function var_0_0.sendReadMailBatchRequest(arg_5_0, arg_5_1)
	local var_5_0 = MailModule_pb.ReadMailBatchRequest()

	var_5_0.type = arg_5_1

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveReadMailBatchReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(arg_6_2.incrIds) do
			table.insert(var_6_0, tonumber(iter_6_1))
		end

		MailModel.instance:readAllMail(var_6_0)
	end
end

function var_0_0.onReceiveNewMailPush(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		local var_7_0 = {
			arg_7_2.mail
		}

		MailModel.instance:addMailModel(var_7_0)
	end
end

function var_0_0.onReceiveDeleteMailsPush(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_2.incrIds) do
			table.insert(var_8_0, tonumber(iter_8_1))
		end

		MailModel.instance:delMail(var_8_0)
	end
end

function var_0_0.sendDeleteMailBatchRequest(arg_9_0, arg_9_1)
	local var_9_0 = MailModule_pb.DeleteMailBatchRequest()

	var_9_0.type = arg_9_1

	arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveDeleteMailBatchReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in ipairs(arg_10_2.incrIds) do
			table.insert(var_10_0, tonumber(iter_10_1))
		end

		MailModel.instance:delMail(var_10_0)
	end
end

function var_0_0.sendMarkMailJumpRequest(arg_11_0, arg_11_1)
	local var_11_0 = MailModule_pb.MarkMailJumpRequest()

	var_11_0.incrId = arg_11_1

	arg_11_0:sendMsg(var_11_0)
end

function var_0_0.onReceiveMarkMailJumpReply(arg_12_0, arg_12_1, arg_12_2)
	return
end

function var_0_0.onReceiveAutoReadMailPush(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_2.incrIds) do
			MailModel.instance:readMail(tonumber(iter_13_1))
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
