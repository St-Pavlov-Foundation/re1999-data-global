module("modules.logic.versionactivity2_6.xugouji.rpc.Activity188Rpc", package.seeall)

local var_0_0 = class("Activity188Rpc", BaseRpc)

function var_0_0.sendGet188InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity188Module_pb.GetAct188InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct188InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity188Model.instance:onGetActInfoReply(arg_2_2.episodes)
	end
end

function var_0_0.sendAct188EnterEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity188Module_pb.Act188EnterEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct188EnterEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		local var_4_0 = arg_4_2.act188Game
		local var_4_1 = arg_4_2.episodeId

		Activity188Model.instance:clearGameInfo()
		Activity188Model.instance:setTurn(true)
		Activity188Model.instance:setCurEpisodeId(var_4_1)
		Activity188Model.instance:onAct188GameInfoUpdate(var_4_0)
	end
end

function var_0_0.SetEpisodePushCallback(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._episodePushCb = arg_5_1
	arg_5_0._episodePushCbObj = arg_5_2
end

function var_0_0.onReceiveAct188EpisodePush(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		local var_6_0 = arg_6_2.episodes

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			local var_6_1 = iter_6_1.episodeId
			local var_6_2 = iter_6_1.isFinished

			Activity188Model.instance:onEpisodeInfoUpdate(var_6_1, var_6_2)
		end

		if arg_6_0._episodePushCb then
			arg_6_0._episodePushCb(arg_6_0._episodePushCbObj)
		end
	end
end

function var_0_0.sendAct188StoryRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = Activity188Module_pb.Act188StoryRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.episodeId = arg_7_2

	arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveAct188StoryReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		local var_8_0 = arg_8_2.episodeId

		Activity188Model.instance:onStoryEpisodeFinish(var_8_0)
	end
end

function var_0_0.sendAct188ReverseCardRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = Activity188Module_pb.Act188ReverseCardRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.episodeId = arg_9_2
	var_9_0.uid = arg_9_3

	arg_9_0:sendMsg(var_9_0, arg_9_4, arg_9_5)
end

function var_0_0.onReceiveAct188ReverseCardReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveAct188StepPush(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		local var_11_0 = arg_11_2.steps

		XugoujiGameStepController.instance:insertStepList(var_11_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
