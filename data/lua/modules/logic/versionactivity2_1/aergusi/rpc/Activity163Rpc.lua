module("modules.logic.versionactivity2_1.aergusi.rpc.Activity163Rpc", package.seeall)

local var_0_0 = class("Activity163Rpc", BaseRpc)

var_0_0.instance = var_0_0.New()

function var_0_0.sendGet163InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity163Module_pb.Get163InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet163InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	AergusiModel.instance:setEpisodeInfos(arg_2_2.actInfo.episodeInfo)
	AergusiModel.instance:setReadClueList(arg_2_2.actInfo.readClueIds)
	AergusiController.instance:dispatchEvent(AergusiEvent.ActInfoUpdate)
end

function var_0_0.onReceiveAct163InfoPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	AergusiModel.instance:setEpisodeInfos(arg_3_2.actInfo.episodeInfo)
	AergusiController.instance:dispatchEvent(AergusiEvent.ActInfoUpdate)
end

function var_0_0.sendAct163StartEvidenceRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = Activity163Module_pb.Act163StartEvidenceRequest()

	var_4_0.activityId = arg_4_1
	var_4_0.episodeId = arg_4_2

	return arg_4_0:sendMsg(var_4_0, arg_4_3, arg_4_4)
end

function var_0_0.onReceiveAct163StartEvidenceReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	AergusiModel.instance:setEpisodeUnlockAutoTipProcess(arg_5_2.progress)
	AergusiModel.instance:setEvidenceInfo(arg_5_2.episodeId, arg_5_2.evidenceInfo)
	AergusiController.instance:dispatchEvent(AergusiEvent.StartEpisode)
end

function var_0_0.sendAct163EvidenceOperationRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	local var_6_0 = Activity163Module_pb.Act163EvidenceOperationRequest()

	var_6_0.activityId = arg_6_1
	var_6_0.episodeId = arg_6_2
	var_6_0.operationType = arg_6_3
	var_6_0.params = arg_6_4

	return arg_6_0:sendMsg(var_6_0, arg_6_5, arg_6_6)
end

function var_0_0.onReceiveAct163EvidenceOperationReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	AergusiModel.instance:setEvidenceInfo(arg_7_2.episodeId, arg_7_2.evidenceInfo)
	AergusiController.instance:dispatchEvent(AergusiEvent.StartOperation, arg_7_2.operationType, arg_7_2.operationResult)
end

function var_0_0.sendAct163ReadClueRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = Activity163Module_pb.Act163ReadClueRequest()

	var_8_0.activityId = arg_8_1
	var_8_0.clueId = arg_8_2

	return arg_8_0:sendMsg(var_8_0, arg_8_3, arg_8_4)
end

function var_0_0.onReceiveAct163ReadClueReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	AergusiModel.instance:setClueReaded(arg_9_2.clueId)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnClueReadUpdate, arg_9_2.clueId)
end

return var_0_0
