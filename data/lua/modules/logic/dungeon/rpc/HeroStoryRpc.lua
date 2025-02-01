module("modules.logic.dungeon.rpc.HeroStoryRpc", package.seeall)

slot0 = class("HeroStoryRpc", BaseRpc)

function slot0.sendGetHeroStoryRequest(slot0, slot1, slot2)
	return slot0:sendMsg(HeroStoryModule_pb.GetHeroStoryRequest(), slot1, slot2)
end

function slot0.onReceiveGetHeroStoryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetHeroStoryReply(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UpdateInfo)
end

function slot0.sendUnlocHeroStoryRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroStoryModule_pb.UnlocHeroStoryRequest()
	slot4.storyId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveUnlocHeroStoryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onUnlocHeroStoryReply(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UpdateInfo)
end

function slot0.sendGetHeroStoryBonusRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroStoryModule_pb.GetHeroStoryBonusRequest()
	slot4.storyId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetHeroStoryBonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetHeroStoryBonusReply(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UpdateInfo)
end

function slot0.onReceiveHeroStoryUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryUpdatePush(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UpdateInfo)
end

function slot0.sendUpdateHeroStoryStatusRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroStoryModule_pb.UpdateHeroStoryStatusRequest()
	slot4.storyId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveUpdateHeroStoryStatusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onUpdateHeroStoryStatusReply(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.StoryNewChange)
end

function slot0.sendExchangeTicketRequest(slot0, slot1, slot2)
	return slot0:sendMsg(HeroStoryModule_pb.ExchangeTicketRequest(), slot1, slot2)
end

function slot0.onReceiveExchangeTicketReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onExchangeTicketReply(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ExchangeTick)
end

function slot0.sendGetScoreBonusRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroStoryModule_pb.GetScoreBonusRequest()

	for slot8, slot9 in ipairs(slot1) do
		table.insert(slot4.bonusId, slot9)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetScoreBonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetScoreBonusReply(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.GetScoreBonus)
end

function slot0.onReceiveHeroStoryScorePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryScorePush(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ScoreUpdate)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		1116
	})
end

function slot0.sendGetChallengeBonusRequest(slot0, slot1, slot2)
	return slot0:sendMsg(HeroStoryModule_pb.GetChallengeBonusRequest(), slot1, slot2)
end

function slot0.onReceiveGetChallengeBonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetChallengeBonusReply(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.GetChallengeBonus)
end

function slot0.onReceiveHeroStoryTicketPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryTicketPush(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.PowerChange)
end

function slot0.onReceiveHeroStoryWeekTaskPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryWeekTaskPush(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.WeekTaskChange)
end

function slot0.sendHeroStoryWeekTaskGetRequest(slot0, slot1, slot2)
	return slot0:sendMsg(HeroStoryModule_pb.HeroStoryWeekTaskGetRequest(), slot1, slot2)
end

function slot0.onReceiveHeroStoryWeekTaskGetReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryWeekTaskGetReply(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.WeekTaskChange)
end

function slot0.sendHeroStoryDispatchRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = HeroStoryModule_pb.HeroStoryDispatchRequest()
	slot6.storyId = slot1
	slot6.dispatchId = slot2

	for slot10, slot11 in ipairs(slot3) do
		table.insert(slot6.heroIds, slot11)
	end

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveHeroStoryDispatchReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ServerTime.update(math.floor(tonumber(slot2.startTime) / 1000))
	RoleStoryModel.instance:onHeroStoryDispatchReply(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.DispatchSuccess)
end

function slot0.sendHeroStoryDispatchResetRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = HeroStoryModule_pb.HeroStoryDispatchResetRequest()
	slot5.storyId = slot1
	slot5.dispatchId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveHeroStoryDispatchResetReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.RoleStoryDispatchReset)
	RoleStoryModel.instance:onHeroStoryDispatchResetReply(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.DispatchReset)
end

function slot0.sendHeroStoryDispatchCompleteRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = HeroStoryModule_pb.HeroStoryDispatchCompleteRequest()
	slot5.storyId = slot1
	slot5.dispatchId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveHeroStoryDispatchCompleteReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryDispatchCompleteReply(slot2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.DispatchFinish)
	slot0:sendGetHeroStoryRequest()
end

slot0.instance = slot0.New()

return slot0
