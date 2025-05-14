module("modules.logic.dungeon.rpc.HeroStoryRpc", package.seeall)

local var_0_0 = class("HeroStoryRpc", BaseRpc)

function var_0_0.sendGetHeroStoryRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = HeroStoryModule_pb.GetHeroStoryRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetHeroStoryReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetHeroStoryReply(arg_2_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UpdateInfo)
end

function var_0_0.sendUnlocHeroStoryRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = HeroStoryModule_pb.UnlocHeroStoryRequest()

	var_3_0.storyId = arg_3_1

	return arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveUnlocHeroStoryReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onUnlocHeroStoryReply(arg_4_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UpdateInfo)
end

function var_0_0.sendGetHeroStoryBonusRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = HeroStoryModule_pb.GetHeroStoryBonusRequest()

	var_5_0.storyId = arg_5_1

	return arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveGetHeroStoryBonusReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetHeroStoryBonusReply(arg_6_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UpdateInfo)
end

function var_0_0.onReceiveHeroStoryUpdatePush(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryUpdatePush(arg_7_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.UpdateInfo)
end

function var_0_0.sendUpdateHeroStoryStatusRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = HeroStoryModule_pb.UpdateHeroStoryStatusRequest()

	var_8_0.storyId = arg_8_1

	return arg_8_0:sendMsg(var_8_0, arg_8_2, arg_8_3)
end

function var_0_0.onReceiveUpdateHeroStoryStatusReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onUpdateHeroStoryStatusReply(arg_9_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.StoryNewChange)
end

function var_0_0.sendExchangeTicketRequest(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = HeroStoryModule_pb.ExchangeTicketRequest()

	return arg_10_0:sendMsg(var_10_0, arg_10_1, arg_10_2)
end

function var_0_0.onReceiveExchangeTicketReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onExchangeTicketReply(arg_11_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ExchangeTick)
end

function var_0_0.sendGetScoreBonusRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = HeroStoryModule_pb.GetScoreBonusRequest()

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		table.insert(var_12_0.bonusId, iter_12_1)
	end

	return arg_12_0:sendMsg(var_12_0, arg_12_2, arg_12_3)
end

function var_0_0.onReceiveGetScoreBonusReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetScoreBonusReply(arg_13_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.GetScoreBonus)
end

function var_0_0.onReceiveHeroStoryScorePush(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryScorePush(arg_14_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ScoreUpdate)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		1116
	})
end

function var_0_0.sendGetChallengeBonusRequest(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = HeroStoryModule_pb.GetChallengeBonusRequest()

	return arg_15_0:sendMsg(var_15_0, arg_15_1, arg_15_2)
end

function var_0_0.onReceiveGetChallengeBonusReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onGetChallengeBonusReply(arg_16_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.GetChallengeBonus)
end

function var_0_0.onReceiveHeroStoryTicketPush(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryTicketPush(arg_17_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.PowerChange)
end

function var_0_0.onReceiveHeroStoryWeekTaskPush(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryWeekTaskPush(arg_18_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.WeekTaskChange)
end

function var_0_0.sendHeroStoryWeekTaskGetRequest(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = HeroStoryModule_pb.HeroStoryWeekTaskGetRequest()

	return arg_19_0:sendMsg(var_19_0, arg_19_1, arg_19_2)
end

function var_0_0.onReceiveHeroStoryWeekTaskGetReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryWeekTaskGetReply(arg_20_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.WeekTaskChange)
end

function var_0_0.sendHeroStoryDispatchRequest(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	local var_21_0 = HeroStoryModule_pb.HeroStoryDispatchRequest()

	var_21_0.storyId = arg_21_1
	var_21_0.dispatchId = arg_21_2

	for iter_21_0, iter_21_1 in ipairs(arg_21_3) do
		table.insert(var_21_0.heroIds, iter_21_1)
	end

	return arg_21_0:sendMsg(var_21_0, arg_21_4, arg_21_5)
end

function var_0_0.onReceiveHeroStoryDispatchReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 ~= 0 then
		return
	end

	local var_22_0 = tonumber(arg_22_2.startTime)
	local var_22_1 = math.floor(var_22_0 / 1000)

	ServerTime.update(var_22_1)
	RoleStoryModel.instance:onHeroStoryDispatchReply(arg_22_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.DispatchSuccess)
end

function var_0_0.sendHeroStoryDispatchResetRequest(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = HeroStoryModule_pb.HeroStoryDispatchResetRequest()

	var_23_0.storyId = arg_23_1
	var_23_0.dispatchId = arg_23_2

	return arg_23_0:sendMsg(var_23_0, arg_23_3, arg_23_4)
end

function var_0_0.onReceiveHeroStoryDispatchResetReply(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.RoleStoryDispatchReset)
	RoleStoryModel.instance:onHeroStoryDispatchResetReply(arg_24_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.DispatchReset)
end

function var_0_0.sendHeroStoryDispatchCompleteRequest(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = HeroStoryModule_pb.HeroStoryDispatchCompleteRequest()

	var_25_0.storyId = arg_25_1
	var_25_0.dispatchId = arg_25_2

	return arg_25_0:sendMsg(var_25_0, arg_25_3, arg_25_4)
end

function var_0_0.onReceiveHeroStoryDispatchCompleteReply(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 ~= 0 then
		return
	end

	RoleStoryModel.instance:onHeroStoryDispatchCompleteReply(arg_26_2)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.DispatchFinish)
	arg_26_0:sendGetHeroStoryRequest()
end

var_0_0.instance = var_0_0.New()

return var_0_0
