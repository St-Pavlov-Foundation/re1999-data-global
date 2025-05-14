module("modules.logic.versionactivity2_5.challenge.rpc.Activity183Rpc", package.seeall)

local var_0_0 = class("Activity183Rpc", BaseRpc)

function var_0_0.sendAct183GetInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity183Module_pb.Act183GetInfoRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveAct183GetInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Act183Model.instance:init(arg_2_2.activityId, arg_2_2.actInfo)
end

function var_0_0.sendAct183ResetGroupRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Activity183Module_pb.Act183ResetGroupRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.groupId = arg_3_2

	return arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveAct183ResetGroupReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.activityId
	local var_4_1 = arg_4_2.group

	Act183Controller.instance:updateResetGroupEpisodeInfo(var_4_0, var_4_1)
end

function var_0_0.sendAct183ResetEpisodeRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Activity183Module_pb.Act183ResetEpisodeRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.episodeId = arg_5_2

	return arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveAct183ResetEpisodeReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.group

	Act183Controller.instance:updateResetEpisodeInfo(var_6_0)
end

function var_0_0.sendAct183ChooseRepressRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	local var_7_0 = Activity183Module_pb.Act183ChooseRepressRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.episodeId = arg_7_2
	var_7_0.ruleIndex = arg_7_3
	var_7_0.heroIndex = arg_7_4

	return arg_7_0:sendMsg(var_7_0, arg_7_5, arg_7_6)
end

function var_0_0.onReceiveAct183ChooseRepressReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	local var_8_0 = arg_8_2.episodeId
	local var_8_1 = arg_8_2.repress

	Act183Controller.instance:updateChooseRepressInfo(var_8_0, var_8_1)
end

function var_0_0.sendAct183GetRecordRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = Activity183Module_pb.Act183GetRecordRequest()

	var_9_0.activityId = arg_9_1

	return arg_9_0:sendMsg(var_9_0, arg_9_2, arg_9_3)
end

function var_0_0.onReceiveAct183GetRecordReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = arg_10_2.activityId
	local var_10_1 = Act183Helper.rpcInfosToList(arg_10_2.groupList, Act183GroupEpisodeRecordMO, var_10_0)

	Act183ReportListModel.instance:init(var_10_0, var_10_1)
end

function var_0_0.sendAct183ReplaceResultRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = Activity183Module_pb.Act183ReplaceResultRequest()

	var_11_0.activityId = arg_11_1
	var_11_0.episodeId = arg_11_2

	return arg_11_0:sendMsg(var_11_0, arg_11_3, arg_11_4)
end

function var_0_0.onReceiveAct183ReplaceResultReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	local var_12_0 = arg_12_2.activityId
	local var_12_1 = arg_12_2.episode
	local var_12_2 = var_12_1.episodeId
	local var_12_3 = Act183Model.instance:getEpisodeMo(var_12_0, var_12_2)

	if var_12_3 then
		var_12_3:init(var_12_1)
	end
end

function var_0_0.onReceiveAct183BadgeNumUpdatePush(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end

	local var_13_0 = arg_13_2.activityId
	local var_13_1 = arg_13_2.badgeNum

	Act183Model.instance:getActInfo():updateBadgeNum(var_13_1)
	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateBadgeNum)
	Act183Controller.instance:dispatchEvent(Act183Event.RefreshMedalReddot)
end

function var_0_0.onReceiveAct183BattleFinishPush(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	local var_14_0 = arg_14_2.activityId
	local var_14_1
	local var_14_2 = Act183EpisodeMO.New()

	var_14_2:init(arg_14_2.episode)

	local var_14_3

	if arg_14_2:HasField("fightResult") then
		var_14_3 = Act183FightResultMO.New()

		var_14_3:init(arg_14_2.fightResult)
	end

	local var_14_4

	if arg_14_2:HasField("record") then
		var_14_4 = Act183GroupEpisodeRecordMO.New()

		var_14_4:init(arg_14_2.record)
	end

	local var_14_5 = {
		activityId = var_14_0,
		episodeMo = var_14_2,
		groupFinished = arg_14_2.groupFinished,
		win = arg_14_2.win,
		record = var_14_4,
		reChallenge = arg_14_2.reChallenge,
		fightResultMo = var_14_3,
		params = arg_14_2.params
	}

	Act183Model.instance:recordBattleFinishedInfo(var_14_5)
end

var_0_0.instance = var_0_0.New()

return var_0_0
