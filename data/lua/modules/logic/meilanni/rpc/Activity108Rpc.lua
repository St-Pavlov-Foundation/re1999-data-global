module("modules.logic.meilanni.rpc.Activity108Rpc", package.seeall)

local var_0_0 = class("Activity108Rpc", BaseRpc)

function var_0_0.sendGet108InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity108Module_pb.Get108InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet108InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.activityId
	local var_2_1 = arg_2_2.infos

	MeilanniModel.instance:updateMapList(var_2_1)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.getInfo)
end

function var_0_0.sendResetMapRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity108Module_pb.ResetMapRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.mapId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveResetMapReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.activityId
	local var_4_1 = arg_4_2.info

	MeilanniModel.instance:updateMapInfo(var_4_1)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.resetMap)
	MeilanniController.instance:statStart()
end

function var_0_0.sendDialogEventSelectRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0._selectEventId = arg_5_2

	local var_5_0 = Activity108Module_pb.DialogEventSelectRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.eventId = arg_5_2

	for iter_5_0, iter_5_1 in ipairs(arg_5_3) do
		table.insert(var_5_0.historylist, iter_5_1)
	end

	var_5_0.option = arg_5_4

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveDialogEventSelectReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.activityId
	local var_6_1 = arg_6_2.info

	if arg_6_2:HasField("mapInfo") then
		local var_6_2 = MeilanniModel.instance:getMapInfo(arg_6_2.mapInfo.mapId)
		local var_6_3 = var_6_2:getExcludeRules()
		local var_6_4 = var_6_2:getThreat()

		MeilanniModel.instance:updateMapExcludeRules(arg_6_2.mapInfo)

		local var_6_5 = var_6_2:getExcludeRules()

		if #var_6_3 ~= #var_6_5 then
			MeilanniController.instance:dispatchEvent(MeilanniEvent.updateExcludeRules, {
				var_6_3,
				var_6_5,
				var_6_4
			})
		end
	end

	MeilanniModel.instance:updateEpisodeInfo(var_6_1)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.episodeInfoUpdate, arg_6_0._selectEventId)
end

function var_0_0.sendEnterFightEventRequest(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = Activity108Module_pb.EnterFightEventRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.eventId = arg_7_2

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveEnterFightEventReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	local var_8_0 = arg_8_2.activityId
	local var_8_1 = arg_8_2.eventId

	MeilanniController.instance:enterFight(var_8_1)
end

function var_0_0.sendEpisodeConfirmRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = Activity108Module_pb.EpisodeConfirmRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.episodeId = arg_9_2

	arg_9_0:sendMsg(var_9_0, arg_9_3, arg_9_4)
end

function var_0_0.onReceiveEpisodeConfirmReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = arg_10_2.activityId
	local var_10_1 = arg_10_2.episodeId

	MeilanniController.instance:dispatchEvent(MeilanniEvent.episodeInfoUpdate)
end

function var_0_0.sendGet108BonusRequest(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = Activity108Module_pb.Get108BonusRequest()

	var_11_0.activityId = arg_11_1
	var_11_0.id = arg_11_2

	arg_11_0:sendMsg(var_11_0)
end

function var_0_0.onReceiveGet108BonusReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	local var_12_0 = arg_12_2.activityId
	local var_12_1 = arg_12_2.id

	MeilanniController.instance:dispatchEvent(MeilanniEvent.bonusReply)
end

function var_0_0.onReceiveEpisodeUpdatePush(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end

	local var_13_0 = arg_13_2.activityId
	local var_13_1 = arg_13_2.info

	MeilanniModel.instance:updateEpisodeInfo(var_13_1)
end

function var_0_0.onReceiveInfoUpdatePush(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	local var_14_0 = arg_14_2.activityId
	local var_14_1 = arg_14_2.infos

	MeilanniModel.instance:updateMapList(var_14_1)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.getInfo)
end

var_0_0.instance = var_0_0.New()

return var_0_0
