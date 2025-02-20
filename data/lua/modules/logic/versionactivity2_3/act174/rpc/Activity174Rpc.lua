module("modules.logic.versionactivity2_3.act174.rpc.Activity174Rpc", package.seeall)

slot0 = class("Activity174Rpc", BaseRpc)

function slot0.sendGetAct174InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity174Module_pb.GetAct174InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct174InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:setActInfo(slot2.activityId, slot2.info)
	end
end

function slot0.sendStart174GameRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity174Module_pb.Start174GameRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveStart174GameReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:updateGameInfo(slot2.activityId, slot2.gameInfo)
	end
end

function slot0.sendFresh174ShopRequest(slot0, slot1)
	slot2 = Activity174Module_pb.Fresh174ShopRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveFresh174ShopReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:updateShopInfo(slot2.activityId, slot2.shopInfo, slot2.coin)
		Activity174Controller.instance:dispatchEvent(Activity174Event.FreshShopReply)
	end
end

function slot0.sendBuyIn174ShopRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity174Module_pb.BuyIn174ShopRequest()
	slot5.activityId = slot1
	slot5.index = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveBuyIn174ShopReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:getActInfo(slot2.activityId):getGameInfo():buyInShopReply(slot2.gameInfo)
		Activity174Controller.instance:dispatchEvent(Activity174Event.BuyInShopReply)
	end
end

function slot0.sendChangeAct174TeamRequest(slot0, slot1, slot2)
	Activity174Module_pb.ChangeAct174TeamRequest().activityId = slot1

	for slot7, slot8 in ipairs(slot2) do
		Activity174Module_pb.Act174TeamInfo().index = slot8.index

		for slot13, slot14 in ipairs(slot8.battleHeroInfo) do
			if slot14.heroId then
				slot15 = Activity174Module_pb.Act174BattleHero()
				slot15.index = slot14.index
				slot15.heroId = slot14.heroId
				slot15.itemId = slot14.itemId or 0
				slot15.priorSkill = slot14.priorSkill or 0

				table.insert(slot9.battleHeroInfo, slot15)
			end
		end

		table.insert(slot3.teamInfo, slot9)
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveChangeAct174TeamReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:updateTeamInfo(slot2.activityId, slot2.teamInfo)
	end
end

function slot0.sendSwitchAct174TeamRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.from = slot2
	slot0.to = slot3
	slot6 = Activity174Module_pb.SwitchAct174TeamRequest()
	slot6.activityId = slot1
	slot6.beforeIndex = slot2
	slot6.afterIndex = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveSwitchAct174TeamReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot0.from then
			Activity174Model.instance:getActInfo(slot2.activityId):getGameInfo():exchangeTempCollection(slot0.from, slot0.to)

			slot0.from = nil
			slot0.to = nil
		end

		Activity174Model.instance:updateTeamInfo(slot2.activityId, slot2.teamInfo)
	end
end

function slot0.sendSelectAct174ForceBagRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity174Module_pb.SelectAct174ForceBagRequest()
	slot5.activityId = slot1
	slot5.index = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveSelectAct174ForceBagReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:updateGameInfo(slot2.activityId, slot2.gameInfo, true)
	end
end

function slot0.sendStartAct174FightMatchRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity174Module_pb.StartAct174FightMatchRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveStartAct174FightMatchReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:updateGameInfo(slot2.activityId, slot2.gameInfo)
	end
end

function slot0.sendBetHpBeforeAct174FightRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity174Module_pb.BetHpBeforeAct174FightRequest()
	slot5.activityId = slot1
	slot5.bet = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveBetHpBeforeAct174FightReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:updateIsBet(slot2.activityId, slot2.bet)
	end
end

function slot0.sendStartAct174FightRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity174Module_pb.StartAct174FightRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveStartAct174FightReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:updateGameInfo(slot2.activityId, slot2.gameInfo)
	end
end

function slot0.sendEnterNextAct174FightRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity174Module_pb.EnterNextAct174FightRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveEnterNextAct174FightReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Model.instance:endGameReply(slot2.activityId, slot2.gameEndInfo)
		else
			Activity174Model.instance:updateGameInfo(slot2.activityId, slot2.gameInfo)
		end
	end
end

function slot0.sendEndAct174GameRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity174Module_pb.EndAct174GameRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveEndAct174GameReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:endGameReply(slot2.activityId, slot2.gameEndInfo)
	end
end

function slot0.sendEnterEndLessAct174FightRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity174Module_pb.EnterEndLessAct174FightRequest()
	slot6.activityId = slot1
	slot6.enter = slot2
	slot6.level = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveEnterEndLessAct174FightReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Model.instance:endGameReply(slot2.activityId, slot2.gameEndInfo)
		else
			Activity174Model.instance:updateGameInfo(slot2.activityId, slot2.gameInfo)
		end
	end
end

function slot0.onReceiveAct174GameInfoUpdatePush(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:updateGameInfo(slot2.activityId, slot2.gameInfo, true)
	end
end

function slot0.onReceiveAct174TriggerEffectPush(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity174Model.instance:triggerEffectPush(slot2.activityId, slot2.effectId, slot2.param)
	end
end

function slot0.sendViewFightAct174Request(slot0, slot1, slot2)
	slot3 = Activity174Module_pb.ViewFightAct174Request()
	slot3.activityId = Activity174Model.instance:getCurActId()
	slot3.index = slot1
	slot3.round = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveViewFightAct174Reply(slot0, slot1, slot2)
	if slot1 == 0 then
		FightDataModel.instance.douQuQuMgr:cacheFightProto(slot2)
		FightMsgMgr.sendMsg(FightMsgId.FightAct174Reply, slot2)
	end
end

function slot0.onReceiveAct174FightRoundInfo(slot0, slot1, slot2)
	FightMgr.instance:playGMDouQuQu(slot2)
end

function slot0.sendChangeSeasonEndAct174Request(slot0, slot1, slot2, slot3)
	slot4 = Activity174Module_pb.ChangeSeasonEndAct174Request()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveChangeSeasonEndAct174Reply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Model.instance:endGameReply(slot2.activityId, slot2.gameEndInfo)
		else
			Activity174Model.instance:updateGameInfo(slot2.activityId, slot2.gameInfo)
		end
	end
end

slot0.instance = slot0.New()

return slot0
