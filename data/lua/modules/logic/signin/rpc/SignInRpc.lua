module("modules.logic.signin.rpc.SignInRpc", package.seeall)

slot0 = class("SignInRpc", BaseRpc)

function slot0.sendGetSignInInfoRequest(slot0, slot1, slot2)
	slot0:sendMsg(SignInModule_pb.GetSignInInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetSignInInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SignInModel.instance:setSignInInfo(slot2)
		SignInController.instance:dispatchEvent(SignInEvent.GetSignInInfo)
	end
end

function slot0.sendSignInRequest(slot0)
	slot0:sendMsg(SignInModule_pb.SignInRequest())
end

function slot0.onReceiveSignInReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SignInModel.instance:setSignDayRewardGet(slot2)
		SignInController.instance:dispatchEvent(SignInEvent.GetSignInReply)
		ChargeRpc.instance:sendGetMonthCardInfoRequest()
	end
end

function slot0.sendSignInAddupRequest(slot0, slot1)
	slot2 = SignInModule_pb.SignInAddupRequest()
	slot2.id = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveSignInAddupReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SignInModel.instance:setSignTotalRewardGet(slot2.id)
		SignInController.instance:dispatchEvent(SignInEvent.GetSignInAddUp)
	end
end

function slot0.sendSignInHistoryRequest(slot0, slot1)
	slot2 = SignInModule_pb.SignInHistoryRequest()
	slot2.month = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveSignInHistoryReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SignInModel.instance:setSignInHistory(slot2)
		SignInController.instance:dispatchEvent(SignInEvent.GetHistorySignInSuccess, slot2.month)
	end
end

function slot0.sendGetHeroBirthdayRequest(slot0, slot1)
	slot2 = SignInModule_pb.GetHeroBirthdayRequest()
	slot2.heroId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetHeroBirthdayReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SignInModel.instance:setHeroBirthdayGet(slot2.heroId)
		SignInModel.instance:addSignInBirthdayCount(slot2.heroId)
		SignInController.instance:dispatchEvent(SignInEvent.GetHeroBirthday)
	end
end

function slot0.sendSignInTotalRewardRequest(slot0, slot1, slot2, slot3)
	slot4 = SignInModule_pb.SignInTotalRewardRequest()
	slot4.id = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSignInTotalRewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SignInModel.instance:onReceiveSignInTotalRewardReply(slot2)
		SignInController.instance:dispatchEvent(SignInEvent.OnSignInTotalRewardReply, slot2.id)
	end
end

function slot0.sendSignInTotalRewardAllRequest(slot0, slot1, slot2)
	return slot0:sendMsg(SignInModule_pb.SignInTotalRewardAllRequest(), slot1, slot2)
end

function slot0.onReceiveSignInTotalRewardAllReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SignInModel.instance:onReceiveSignInTotalRewardAllReply(slot2)
		SignInController.instance:dispatchEvent(SignInEvent.OnReceiveSignInTotalRewardAllReply)
	end
end

slot0.instance = slot0.New()

return slot0
