module("modules.logic.summon.rpc.SummonRpc", package.seeall)

slot0 = class("SummonRpc", BaseRpc)

function slot0.sendSummonRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	SummonModule_pb.SummonRequest().poolId = slot1
	slot7.guideId = slot3 or 0
	slot7.stepId = slot4 or 0
	slot7.count = slot2

	slot0:sendMsg(slot7, slot5, slot6)

	SummonController.instance.isWaitingSummonResult = true

	SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolHistorySummonRequest, slot1)
end

function slot0.onReceiveSummonReply(slot0, slot1, slot2)
	SummonController.instance.isWaitingSummonResult = false

	if slot1 ~= 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonFailed)
		slot0:sendGetSummonInfoRequest()

		return
	end

	slot3 = slot2.summonResult

	SDKChannelEventModel.instance:addTotalSummonCount(#slot3)
	SDKChannelEventModel.instance:onSummonResult(slot3)
	SummonController.instance:summonSuccess(slot3)
end

function slot0.sendGetSummonInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(SummonModule_pb.GetSummonInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetSummonInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	SummonController.instance:updateSummonInfo(slot2)
	SDKChannelEventModel.instance:updateTotalSummonCount(slot2.totalSummonCount)
end

function slot0.sendSummonQueryTokenRequest(slot0)
	slot0:sendMsg(SummonModule_pb.SummonQueryTokenRequest())
end

function slot0.onReceiveSummonQueryTokenReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	SummonPoolHistoryController.instance:updateSummonQueryToken(slot2)
end

function slot0.sendOpenLuckyBagRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = SummonModule_pb.OpenLuckyBagRequest()
	slot5.luckyBagId = slot1
	slot5.heroId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveOpenLuckyBagReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onLuckyBagOpened)
		slot0:sendGetSummonInfoRequest()
	end
end

function slot0.sendChooseDoubleUpHeroRequest(slot0, slot1, slot2, slot3, slot4)
	SummonModule_pb.ChooseMultiUpHeroRequest().poolId = slot1

	for slot9, slot10 in ipairs(slot2) do
		slot5.heroIds:append(slot10)
	end

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveChooseMultiUpHeroReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onCustomPicked)
		slot0:sendGetSummonInfoRequest()
	end
end

slot0.instance = slot0.New()

return slot0
