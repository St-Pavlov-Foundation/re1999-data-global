module("modules.logic.mail.rpc.MailRpc", package.seeall)

slot0 = class("MailRpc", BaseRpc)

function slot0.sendGetAllMailsRequest(slot0, slot1, slot2)
	return slot0:sendMsg(MailModule_pb.GetAllMailsRequest(), slot1, slot2)
end

function slot0.onReceiveGetAllMailsReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = {}

		for slot7, slot8 in ipairs(slot2.mails) do
			table.insert(slot3, slot8)
		end

		MailModel.instance:onGetMailItemList(slot3, true)
		MailController.instance:initInfo()
	end
end

function slot0.sendReadMailRequest(slot0, slot1)
	slot2 = MailModule_pb.ReadMailRequest()
	slot2.incrId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveReadMailReply(slot0, slot1, slot2)
	if slot1 == 0 then
		MailModel.instance:readMail(tonumber(slot2.incrId))
	end
end

function slot0.sendReadMailBatchRequest(slot0, slot1)
	slot2 = MailModule_pb.ReadMailBatchRequest()
	slot2.type = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveReadMailBatchReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = {}

		for slot7, slot8 in ipairs(slot2.incrIds) do
			table.insert(slot3, tonumber(slot8))
		end

		MailModel.instance:readAllMail(slot3)
	end
end

function slot0.onReceiveNewMailPush(slot0, slot1, slot2)
	if slot1 == 0 then
		MailModel.instance:addMailModel({
			slot2.mail
		})
	end
end

function slot0.onReceiveDeleteMailsPush(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = {}

		for slot7, slot8 in ipairs(slot2.incrIds) do
			table.insert(slot3, tonumber(slot8))
		end

		MailModel.instance:delMail(slot3)
	end
end

function slot0.sendDeleteMailBatchRequest(slot0, slot1)
	slot2 = MailModule_pb.DeleteMailBatchRequest()
	slot2.type = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveDeleteMailBatchReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = {}

		for slot7, slot8 in ipairs(slot2.incrIds) do
			table.insert(slot3, tonumber(slot8))
		end

		MailModel.instance:delMail(slot3)
	end
end

function slot0.sendMarkMailJumpRequest(slot0, slot1)
	slot2 = MailModule_pb.MarkMailJumpRequest()
	slot2.incrId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveMarkMailJumpReply(slot0, slot1, slot2)
end

function slot0.onReceiveAutoReadMailPush(slot0, slot1, slot2)
	if slot1 == 0 then
		for slot6, slot7 in ipairs(slot2.incrIds) do
			MailModel.instance:readMail(tonumber(slot7))
		end
	end
end

slot0.instance = slot0.New()

return slot0
