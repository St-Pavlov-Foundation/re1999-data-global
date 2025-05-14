module("modules.logic.versionactivity2_2.tianshinana.rpc.Activity167Rpc", package.seeall)

local var_0_0 = class("Activity167Rpc", BaseRpc)

function var_0_0.sendGetAct167InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity167Module_pb.GetAct167InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct167InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		TianShiNaNaModel.instance.currEpisodeId = arg_2_2.currEpisodeId

		TianShiNaNaModel.instance:initInfo(arg_2_2.episodes)
	end
end

function var_0_0.sendAct167StartEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity167Module_pb.Act167StartEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct167StartEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		TianShiNaNaModel.instance:initDatas(arg_4_2.episodeId, arg_4_2.scene)
	end
end

function var_0_0.sendAct167ReStartEpisodeRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity167Module_pb.Act167ReStartEpisodeRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.episodeId = arg_5_2
	TianShiNaNaModel.instance.sceneLevelLoadFinish = false

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveAct167ReStartEpisodeReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		TianShiNaNaModel.instance.sceneLevelLoadFinish = true

		TianShiNaNaModel.instance:resetScene(arg_6_2.scene, true)
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.ResetScene)
	else
		TianShiNaNaModel.instance.waitStartFlow = false
	end
end

function var_0_0.sendAct167BeginRoundRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = Activity167Module_pb.Act167BeginRoundRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.episodeId = arg_7_2

	for iter_7_0, iter_7_1 in ipairs(arg_7_3) do
		table.insert(var_7_0.operations, iter_7_1)
	end

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveAct167BeginRoundReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.RoundFail)
	end
end

function var_0_0.sendAct167AbortRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = Activity167Module_pb.Act167AbortRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.episodeId = arg_9_2

	arg_9_0:sendMsg(var_9_0, arg_9_3, arg_9_4)
end

function var_0_0.onReceiveAct167AbortReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendAct167RollbackRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = Activity167Module_pb.Act167RollbackRequest()

	var_11_0.activityId = arg_11_1
	var_11_0.episodeId = arg_11_2

	arg_11_0:sendMsg(var_11_0, arg_11_3, arg_11_4)
end

function var_0_0.onReceiveAct167RollbackReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		TianShiNaNaModel.instance:resetScene(arg_12_2.scene)
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.ResetScene)
	end
end

function var_0_0.onReceiveAct167StepPush(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		TianShiNaNaController.instance:buildFlow(arg_13_2.steps)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
