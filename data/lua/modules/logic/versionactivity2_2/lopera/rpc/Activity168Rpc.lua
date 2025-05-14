module("modules.logic.versionactivity2_2.lopera.rpc.Activity168Rpc", package.seeall)

local var_0_0 = class("Activity168Rpc", BaseRpc)

function var_0_0.sendGet168InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity168Module_pb.Get168InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet168InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity168Model.instance:onGetActInfoReply(arg_2_2.act168Episodes)
	end
end

function var_0_0.sendAct168EnterEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity168Module_pb.Act168EnterEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct168EnterEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity168Model.instance:setCurGameState(arg_4_2.act168Episode.act168Game)
		Activity168Model.instance:setCurActionPoint(arg_4_2.act168Episode.act168Game.power)
		Activity168Model.instance:setCurEpisodeId(arg_4_2.act168Episode.episodeId)

		local var_4_0 = Activity168Model.instance:getCurEpisodeId()

		Activity168Model.instance:clearEpisodeItemInfo(var_4_0)

		if arg_4_2.act168Episode.act168Game then
			Activity168Model.instance:onItemInfoUpdate(var_4_0, arg_4_2.act168Episode.act168Game.act168Items)
		end
	end
end

function var_0_0.SetEpisodePushCallback(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._episodePushCb = arg_5_1
	arg_5_0.__episodePushCbObj = arg_5_2
end

function var_0_0.onReceiveAct168EpisodePush(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		Activity168Model.instance:setCurGameState(arg_6_2.act168Episode.act168Game)
		Activity168Model.instance:setCurActionPoint(arg_6_2.act168Episode.act168Game.power)
		Activity168Model.instance:onEpisodeInfoUpdate(arg_6_2.act168Episode)

		if arg_6_0._episodePushCb then
			arg_6_0._episodePushCb(arg_6_0.__episodePushCbObj)
		end
	end
end

function var_0_0.sendAct168StoryRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = Activity168Module_pb.Act168StoryRequest()

	var_7_0.activityId = arg_7_1

	arg_7_0:sendMsg(var_7_0, arg_7_2, arg_7_3)
end

function var_0_0.onReceiveAct168StoryReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		Activity168Model.instance:onEpisodeInfoUpdate(arg_8_2.act168Episode)
	end
end

function var_0_0.sendStartAct168BattleRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = Activity168Module_pb.StartAct168BattleRequest()

	var_9_0.activityId = arg_9_1

	local var_9_1 = FightModel.instance:getFightParam()

	DungeonRpc.instance:packStartDungeonRequest(var_9_0.startDungeonRequest, var_9_1.chapterId, var_9_1.episodeId, var_9_1, var_9_1.multiplication, nil, nil, false)
	arg_9_0:sendMsg(var_9_0, arg_9_2, arg_9_3)
end

function var_0_0.onReceiveStartAct168BattleReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		local var_10_0 = Activity168Model.instance:getCurBattleEpisodeId()
		local var_10_1 = Season166HeroGroupModel.instance:getEpisodeConfigId(var_10_0)
		local var_10_2 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

		if var_10_2 and DungeonModel.isBattleEpisode(var_10_2) then
			DungeonFightController.instance:onReceiveStartDungeonReply(arg_10_1, arg_10_2.startDungeonReply)
		end
	end
end

function var_0_0.onReceiveAct168BattleFinishPush(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		local var_11_0 = Activity168Model.instance:getCurEpisodeId()
		local var_11_1 = Activity168Model.instance:getCurActId()

		if Activity168Config.instance:getEpisodeCfg(var_11_1, var_11_0).storyClear ~= 0 then
			arg_11_0:sendAct168StoryRequest(var_11_1)
		end
	end
end

function var_0_0.sendAct168GameMoveRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = Activity168Module_pb.Act168GameMoveRequest()

	var_12_0.activityId = arg_12_1
	var_12_0.dir = arg_12_2

	arg_12_0:sendMsg(var_12_0, arg_12_3, arg_12_4)
end

function var_0_0.onReceiveAct168GameMoveReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		Activity168Model.instance:setCurActionPoint(arg_13_2.act168Game.power)
		Activity168Model.instance:setCurGameState(arg_13_2.act168Game)
	end
end

function var_0_0.sendAct168GameSelectOptionRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = Activity168Module_pb.Act168GameSelectOptionRequest()

	var_14_0.activityId = arg_14_1
	var_14_0.option = arg_14_2

	arg_14_0:sendMsg(var_14_0, arg_14_3, arg_14_4)
end

function var_0_0.onReceiveAct168GameSelectOptionReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		Activity168Model.instance:setCurActionPoint(arg_15_2.act168Game.power)
		Activity168Model.instance:setCurGameState(arg_15_2.act168Game)
	end
end

function var_0_0.sendAct168GameComposeItemRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = Activity168Module_pb.Act168GameComposeItemRequest()

	var_16_0.activityId = arg_16_1
	var_16_0.composeType = arg_16_2

	arg_16_0:sendMsg(var_16_0, arg_16_3, arg_16_4)
end

function var_0_0.onReceiveAct168GameComposeItemReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveAct168GameItemChangePush(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		local var_18_0 = Activity168Model.instance:getCurEpisodeId()

		Activity168Model.instance:onItemInfoUpdate(var_18_0, arg_18_2.updateAct168Items, arg_18_2.deleteAct168Items, true)
	end
end

function var_0_0.sendAct168GameSettleRequest(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = Activity168Module_pb.Act168GameSettleRequest()

	var_19_0.activityId = arg_19_1

	arg_19_0:sendMsg(var_19_0, arg_19_2, arg_19_3)
end

function var_0_0.onReceiveAct168GameSettleReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == 0 then
		-- block empty
	end
end

function var_0_0.SetGameSettlePushCallback(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._onGameSettlePush = arg_21_1
	arg_21_0._settlePushCallbackObj = arg_21_2
end

function var_0_0.onReceiveAct168GameSettlePush(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 == 0 then
		Activity168Model.instance:setCurActionPoint(arg_22_2.power)

		local var_22_0 = {
			settleReason = arg_22_2.settleReason,
			episodeId = arg_22_2.episodeId,
			power = arg_22_2.power,
			cellCount = arg_22_2.cellCount,
			totalItems = arg_22_2.totalAct168Items
		}

		if arg_22_0._onGameSettlePush then
			arg_22_0._onGameSettlePush(arg_22_0._settlePushCallbackObj, var_22_0)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
