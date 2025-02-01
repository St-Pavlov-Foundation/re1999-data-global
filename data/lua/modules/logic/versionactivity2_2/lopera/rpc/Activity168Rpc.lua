module("modules.logic.versionactivity2_2.lopera.rpc.Activity168Rpc", package.seeall)

slot0 = class("Activity168Rpc", BaseRpc)

function slot0.sendGet168InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity168Module_pb.Get168InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet168InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity168Model.instance:onGetActInfoReply(slot2.act168Episodes)
	end
end

function slot0.sendAct168EnterEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity168Module_pb.Act168EnterEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct168EnterEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity168Model.instance:setCurGameState(slot2.act168Episode.act168Game)
		Activity168Model.instance:setCurActionPoint(slot2.act168Episode.act168Game.power)
		Activity168Model.instance:setCurEpisodeId(slot2.act168Episode.episodeId)
		Activity168Model.instance:clearEpisodeItemInfo(Activity168Model.instance:getCurEpisodeId())

		if slot2.act168Episode.act168Game then
			Activity168Model.instance:onItemInfoUpdate(slot3, slot2.act168Episode.act168Game.act168Items)
		end
	end
end

function slot0.SetEpisodePushCallback(slot0, slot1, slot2)
	slot0._episodePushCb = slot1
	slot0.__episodePushCbObj = slot2
end

function slot0.onReceiveAct168EpisodePush(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity168Model.instance:setCurGameState(slot2.act168Episode.act168Game)
		Activity168Model.instance:setCurActionPoint(slot2.act168Episode.act168Game.power)
		Activity168Model.instance:onEpisodeInfoUpdate(slot2.act168Episode)

		if slot0._episodePushCb then
			slot0._episodePushCb(slot0.__episodePushCbObj)
		end
	end
end

function slot0.sendAct168StoryRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity168Module_pb.Act168StoryRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct168StoryReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity168Model.instance:onEpisodeInfoUpdate(slot2.act168Episode)
	end
end

function slot0.sendStartAct168BattleRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity168Module_pb.StartAct168BattleRequest()
	slot4.activityId = slot1
	slot5 = FightModel.instance:getFightParam()

	DungeonRpc.instance:packStartDungeonRequest(slot4.startDungeonRequest, slot5.chapterId, slot5.episodeId, slot5, slot5.multiplication, nil, , false)
	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveStartAct168BattleReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot4 = Season166HeroGroupModel.instance:getEpisodeConfigId(Activity168Model.instance:getCurBattleEpisodeId())

		if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and DungeonModel.isBattleEpisode(slot5) then
			DungeonFightController.instance:onReceiveStartDungeonReply(slot1, slot2.startDungeonReply)
		end
	end
end

function slot0.onReceiveAct168BattleFinishPush(slot0, slot1, slot2)
	if slot1 == 0 and Activity168Config.instance:getEpisodeCfg(Activity168Model.instance:getCurActId(), Activity168Model.instance:getCurEpisodeId()).storyClear ~= 0 then
		slot0:sendAct168StoryRequest(slot4)
	end
end

function slot0.sendAct168GameMoveRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity168Module_pb.Act168GameMoveRequest()
	slot5.activityId = slot1
	slot5.dir = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct168GameMoveReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity168Model.instance:setCurActionPoint(slot2.act168Game.power)
		Activity168Model.instance:setCurGameState(slot2.act168Game)
	end
end

function slot0.sendAct168GameSelectOptionRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity168Module_pb.Act168GameSelectOptionRequest()
	slot5.activityId = slot1
	slot5.option = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct168GameSelectOptionReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity168Model.instance:setCurActionPoint(slot2.act168Game.power)
		Activity168Model.instance:setCurGameState(slot2.act168Game)
	end
end

function slot0.sendAct168GameComposeItemRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity168Module_pb.Act168GameComposeItemRequest()
	slot5.activityId = slot1
	slot5.composeType = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct168GameComposeItemReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.onReceiveAct168GameItemChangePush(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity168Model.instance:onItemInfoUpdate(Activity168Model.instance:getCurEpisodeId(), slot2.updateAct168Items, slot2.deleteAct168Items, true)
	end
end

function slot0.sendAct168GameSettleRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity168Module_pb.Act168GameSettleRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct168GameSettleReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.SetGameSettlePushCallback(slot0, slot1, slot2)
	slot0._onGameSettlePush = slot1
	slot0._settlePushCallbackObj = slot2
end

function slot0.onReceiveAct168GameSettlePush(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity168Model.instance:setCurActionPoint(slot2.power)

		if slot0._onGameSettlePush then
			slot0._onGameSettlePush(slot0._settlePushCallbackObj, {
				settleReason = slot2.settleReason,
				episodeId = slot2.episodeId,
				power = slot2.power,
				cellCount = slot2.cellCount,
				totalItems = slot2.totalAct168Items
			})
		end
	end
end

slot0.instance = slot0.New()

return slot0
