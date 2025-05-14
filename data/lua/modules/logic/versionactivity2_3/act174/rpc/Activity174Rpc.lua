module("modules.logic.versionactivity2_3.act174.rpc.Activity174Rpc", package.seeall)

local var_0_0 = class("Activity174Rpc", BaseRpc)

function var_0_0.sendGetAct174InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity174Module_pb.GetAct174InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct174InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity174Model.instance:setActInfo(arg_2_2.activityId, arg_2_2.info)
	end
end

function var_0_0.sendStart174GameRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = Activity174Module_pb.Start174GameRequest()

	var_3_0.activityId = arg_3_1

	arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveStart174GameReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity174Model.instance:updateGameInfo(arg_4_2.activityId, arg_4_2.gameInfo)
	end
end

function var_0_0.sendFresh174ShopRequest(arg_5_0, arg_5_1)
	local var_5_0 = Activity174Module_pb.Fresh174ShopRequest()

	var_5_0.activityId = arg_5_1

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveFresh174ShopReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		Activity174Model.instance:updateShopInfo(arg_6_2.activityId, arg_6_2.shopInfo, arg_6_2.coin)
		Activity174Controller.instance:dispatchEvent(Activity174Event.FreshShopReply)
	end
end

function var_0_0.sendBuyIn174ShopRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = Activity174Module_pb.BuyIn174ShopRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.index = arg_7_2

	arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveBuyIn174ShopReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		Activity174Model.instance:getActInfo(arg_8_2.activityId):getGameInfo():buyInShopReply(arg_8_2.gameInfo)
		Activity174Controller.instance:dispatchEvent(Activity174Event.BuyInShopReply)
	end
end

function var_0_0.sendChangeAct174TeamRequest(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = Activity174Module_pb.ChangeAct174TeamRequest()

	var_9_0.activityId = arg_9_1

	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		local var_9_1 = Activity174Module_pb.Act174TeamInfo()

		var_9_1.index = iter_9_1.index

		for iter_9_2, iter_9_3 in ipairs(iter_9_1.battleHeroInfo) do
			if iter_9_3.heroId then
				local var_9_2 = Activity174Module_pb.Act174BattleHero()

				var_9_2.index = iter_9_3.index
				var_9_2.heroId = iter_9_3.heroId
				var_9_2.itemId = iter_9_3.itemId or 0
				var_9_2.priorSkill = iter_9_3.priorSkill or 0

				table.insert(var_9_1.battleHeroInfo, var_9_2)
			end
		end

		table.insert(var_9_0.teamInfo, var_9_1)
	end

	arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveChangeAct174TeamReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		Activity174Model.instance:updateTeamInfo(arg_10_2.activityId, arg_10_2.teamInfo)
	end
end

function var_0_0.sendSwitchAct174TeamRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_0.from = arg_11_2
	arg_11_0.to = arg_11_3

	local var_11_0 = Activity174Module_pb.SwitchAct174TeamRequest()

	var_11_0.activityId = arg_11_1
	var_11_0.beforeIndex = arg_11_2
	var_11_0.afterIndex = arg_11_3

	arg_11_0:sendMsg(var_11_0, arg_11_4, arg_11_5)
end

function var_0_0.onReceiveSwitchAct174TeamReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		if arg_12_0.from then
			Activity174Model.instance:getActInfo(arg_12_2.activityId):getGameInfo():exchangeTempCollection(arg_12_0.from, arg_12_0.to)

			arg_12_0.from = nil
			arg_12_0.to = nil
		end

		Activity174Model.instance:updateTeamInfo(arg_12_2.activityId, arg_12_2.teamInfo)
	end
end

function var_0_0.sendSelectAct174ForceBagRequest(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = Activity174Module_pb.SelectAct174ForceBagRequest()

	var_13_0.activityId = arg_13_1
	var_13_0.index = arg_13_2

	arg_13_0:sendMsg(var_13_0, arg_13_3, arg_13_4)
end

function var_0_0.onReceiveSelectAct174ForceBagReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		Activity174Model.instance:updateGameInfo(arg_14_2.activityId, arg_14_2.gameInfo, true)
	end
end

function var_0_0.sendStartAct174FightMatchRequest(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = Activity174Module_pb.StartAct174FightMatchRequest()

	var_15_0.activityId = arg_15_1

	arg_15_0:sendMsg(var_15_0, arg_15_2, arg_15_3)
end

function var_0_0.onReceiveStartAct174FightMatchReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == 0 then
		Activity174Model.instance:updateGameInfo(arg_16_2.activityId, arg_16_2.gameInfo)
	end
end

function var_0_0.sendBetHpBeforeAct174FightRequest(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = Activity174Module_pb.BetHpBeforeAct174FightRequest()

	var_17_0.activityId = arg_17_1
	var_17_0.bet = arg_17_2

	arg_17_0:sendMsg(var_17_0, arg_17_3, arg_17_4)
end

function var_0_0.onReceiveBetHpBeforeAct174FightReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		Activity174Model.instance:updateIsBet(arg_18_2.activityId, arg_18_2.bet)
	end
end

function var_0_0.sendStartAct174FightRequest(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = Activity174Module_pb.StartAct174FightRequest()

	var_19_0.activityId = arg_19_1

	arg_19_0:sendMsg(var_19_0, arg_19_2, arg_19_3)
end

function var_0_0.onReceiveStartAct174FightReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == 0 then
		Activity174Model.instance:updateGameInfo(arg_20_2.activityId, arg_20_2.gameInfo)
	end
end

function var_0_0.sendEnterNextAct174FightRequest(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = Activity174Module_pb.EnterNextAct174FightRequest()

	var_21_0.activityId = arg_21_1

	arg_21_0:sendMsg(var_21_0, arg_21_2, arg_21_3)
end

function var_0_0.onReceiveEnterNextAct174FightReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 == 0 then
		if arg_22_2.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Model.instance:endGameReply(arg_22_2.activityId, arg_22_2.gameEndInfo)
		else
			Activity174Model.instance:updateGameInfo(arg_22_2.activityId, arg_22_2.gameInfo)
		end
	end
end

function var_0_0.sendEndAct174GameRequest(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = Activity174Module_pb.EndAct174GameRequest()

	var_23_0.activityId = arg_23_1

	arg_23_0:sendMsg(var_23_0, arg_23_2, arg_23_3)
end

function var_0_0.onReceiveEndAct174GameReply(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 == 0 then
		Activity174Model.instance:endGameReply(arg_24_2.activityId, arg_24_2.gameEndInfo)
	end
end

function var_0_0.sendEnterEndLessAct174FightRequest(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	local var_25_0 = Activity174Module_pb.EnterEndLessAct174FightRequest()

	var_25_0.activityId = arg_25_1
	var_25_0.enter = arg_25_2
	var_25_0.level = arg_25_3

	arg_25_0:sendMsg(var_25_0, arg_25_4, arg_25_5)
end

function var_0_0.onReceiveEnterEndLessAct174FightReply(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 == 0 then
		if arg_26_2.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Model.instance:endGameReply(arg_26_2.activityId, arg_26_2.gameEndInfo)
		else
			Activity174Model.instance:updateGameInfo(arg_26_2.activityId, arg_26_2.gameInfo)
		end
	end
end

function var_0_0.onReceiveAct174GameInfoUpdatePush(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == 0 then
		Activity174Model.instance:updateGameInfo(arg_27_2.activityId, arg_27_2.gameInfo, true)
	end
end

function var_0_0.onReceiveAct174TriggerEffectPush(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 == 0 then
		Activity174Model.instance:triggerEffectPush(arg_28_2.activityId, arg_28_2.effectId, arg_28_2.param)
	end
end

function var_0_0.sendViewFightAct174Request(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = Activity174Module_pb.ViewFightAct174Request()

	var_29_0.activityId = Activity174Model.instance:getCurActId()
	var_29_0.index = arg_29_1
	var_29_0.round = arg_29_2

	arg_29_0:sendMsg(var_29_0)
end

function var_0_0.onReceiveViewFightAct174Reply(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 == 0 then
		FightDataModel.instance.douQuQuMgr:cacheFightProto(arg_30_2)
		FightMsgMgr.sendMsg(FightMsgId.FightAct174Reply, arg_30_2)
	end
end

function var_0_0.onReceiveAct174FightRoundInfo(arg_31_0, arg_31_1, arg_31_2)
	FightMgr.instance:playGMDouQuQu(arg_31_2)
end

function var_0_0.sendChangeSeasonEndAct174Request(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = Activity174Module_pb.ChangeSeasonEndAct174Request()

	var_32_0.activityId = arg_32_1

	arg_32_0:sendMsg(var_32_0, arg_32_2, arg_32_3)
end

function var_0_0.onReceiveChangeSeasonEndAct174Reply(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_1 == 0 then
		if arg_33_2.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Model.instance:endGameReply(arg_33_2.activityId, arg_33_2.gameEndInfo)
		else
			Activity174Model.instance:updateGameInfo(arg_33_2.activityId, arg_33_2.gameInfo)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
