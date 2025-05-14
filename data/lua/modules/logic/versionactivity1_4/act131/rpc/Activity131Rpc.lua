module("modules.logic.versionactivity1_4.act131.rpc.Activity131Rpc", package.seeall)

local var_0_0 = class("Activity131Rpc", BaseRpc)

var_0_0.instance = var_0_0.New()

function var_0_0.sendGet131InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity131Module_pb.Get131InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet131InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity131Model.instance:setInfos(arg_2_2.infos)
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnGetInfoSuccess)
end

function var_0_0.sendAct131StoryRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity131Module_pb.Act131StoryRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct131StoryReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	Activity131Model.instance:updateProgress(arg_4_2.episodeId, arg_4_2.progress)
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnStoryFinishedSuccess)
end

function var_0_0.sendAct131GeneralRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = Activity131Module_pb.Act131GeneralRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.episodeId = arg_5_2
	var_5_0.elementId = arg_5_3

	arg_5_0:sendMsg(var_5_0, arg_5_4, arg_5_5)
end

function var_0_0.onReceiveAct131GeneralReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnGeneralGameSuccess)
end

function var_0_0.sendAct131DialogRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = Activity131Module_pb.Act131DialogRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.episodeId = arg_7_2
	var_7_0.elementId = arg_7_3
	var_7_0.option = arg_7_4

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveAct131DialogReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnDialogMarkSuccess)
end

function var_0_0.sendAct131DialogHistoryRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = Activity131Module_pb.Act131DialogHistoryRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.episodeId = arg_9_2
	var_9_0.elementId = arg_9_3

	for iter_9_0, iter_9_1 in ipairs(arg_9_4) do
		table.insert(var_9_0.historylist, iter_9_1)
	end

	arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveAct131DialogHistoryReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnDialogHistorySuccess)
end

function var_0_0.onReceiveAct131ElementsPush(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	Activity131Model.instance:updateInfos(arg_11_2.act131Info)
	Activity131Model.instance:refreshLogDics()
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnElementUpdate)
end

function var_0_0.sendAct131RestartEpisodeRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = Activity131Module_pb.Act131RestartEpisodeRequest()

	var_12_0.activityId = arg_12_1
	var_12_0.episodeId = arg_12_2

	arg_12_0:sendMsg(var_12_0, arg_12_3, arg_12_4)
end

function var_0_0.onReceiveAct131RestartEpisodeReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end

	Activity131Model.instance:updateInfos(arg_13_2.infos)
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnRestartEpisodeSuccess)
end

function var_0_0.sendBeforeAct131BattleRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = Activity131Module_pb.BeforeAct131BattleRequest()

	var_14_0.activityId = arg_14_1
	var_14_0.episodeId = arg_14_2
	var_14_0.elementId = arg_14_3

	arg_14_0:sendMsg(var_14_0)
end

function var_0_0.onReceiveBeforeAct131BattleReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnBattleBeforeSucess, arg_15_2.elementId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
