module("modules.logic.versionactivity2_7.lengzhou6.rpc.LengZhou6Rpc", package.seeall)

local var_0_0 = class("LengZhou6Rpc", BaseRpc)

function var_0_0.sendGetAct190InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity190Module_pb.GetAct190InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct190InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	LengZhou6Model.instance:onGetActInfo(arg_2_2)
	LengZhou6Controller.instance:openLengZhou6LevelView()
end

function var_0_0.sendAct190FinishEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity190Module_pb.Act190FinishEpisodeRequest()

	var_3_0.activityId = LengZhou6Model.instance:getCurActId()
	var_3_0.episodeId = arg_3_1
	var_3_0.progress = arg_3_2 or ""

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct190FinishEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	LengZhou6Controller.instance:onFinishEpisode(arg_4_2)
end

function var_0_0.onReceiveAct190EpisodePush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	LengZhou6Model.instance:onPushActInfo(arg_5_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
