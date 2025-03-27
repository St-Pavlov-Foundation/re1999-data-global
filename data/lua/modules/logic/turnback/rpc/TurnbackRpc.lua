module("modules.logic.turnback.rpc.TurnbackRpc", package.seeall)

slot0 = class("TurnbackRpc", BaseRpc)

function slot0.sendGetTurnbackInfoRequest(slot0)
	return slot0:sendMsg(TurnbackModule_pb.GetTurnbackInfoRequest())
end

function slot0.onReceiveGetTurnbackInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TurnbackModel.instance:setTurnbackInfo(slot2.info)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshView)
	end
end

function slot0.sendTurnbackFirstShowRequest(slot0, slot1)
	slot2 = TurnbackModule_pb.TurnbackFirstShowRequest()
	slot2.id = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveTurnbackFirstShowReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendTurnbackBonusPointRequest(slot0, slot1)
	slot2 = TurnbackModule_pb.TurnbackBonusPointRequest()
	slot2.id = slot1.id
	slot2.bonusPointId = slot1.bonusPointId

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveTurnbackBonusPointReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TurnbackModel.instance:updateHasGetTaskBonus(slot2)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshTaskRewardItem)
	end
end

function slot0.sendTurnbackOnceBonusRequest(slot0, slot1)
	slot2 = TurnbackModule_pb.TurnbackOnceBonusRequest()
	slot2.id = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveTurnbackOnceBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TurnbackModel.instance:setOnceBonusGetState()
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshOnceBonusGetState)
	end
end

function slot0.sendTurnbackSignInRequest(slot0, slot1, slot2)
	slot3 = TurnbackModule_pb.TurnbackSignInRequest()
	slot3.id = slot1
	slot3.day = slot2

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveTurnbackSignInReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TurnbackSignInModel.instance:updateSignInInfoState(slot2.day, TurnbackEnum.SignInState.HasGet)

		if TurnbackModel.instance:isNewType() and slot2.day ~= 1 then
			TurnbackModel.instance:setLastGetSigninReward(slot2.day)
		end

		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshSignInScroll)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshSignInItem)
	end
end

function slot0.onReceiveTurnbackAdditionPush(slot0, slot1, slot2)
	if slot1 == 0 and TurnbackModel.instance:getCurTurnbackMoWithNilError() and slot3.id == slot2.id then
		slot3:setRemainAdditionCount(slot2.remainAdditionCount)
	end
end

function slot0.sendBuyDoubleBonusRequest(slot0, slot1)
	slot2 = TurnbackModule_pb.BuyDoubleBonusRequest()
	slot2.id = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveBuyDoubleBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TurnbackController.instance:showPopupView(slot2.doubleBonus)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.AfterBuyDoubleReward)
		uv0.instance:sendGetTurnbackInfoRequest()
	end
end

function slot0.sendFinishReadTaskRequest(slot0, slot1)
	return TaskRpc.instance:sendFinishReadTaskRequest(slot1)
end

slot0.instance = slot0.New()

return slot0
