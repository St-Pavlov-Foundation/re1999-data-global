module("modules.logic.versionactivity2_1.activity165.rpc.Activity165Rpc", package.seeall)

local var_0_0 = class("Activity165Rpc", BaseRpc)

function var_0_0.onReceiveAct165StoryInfo(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 == 0 then
		Activity165Model.instance:onGetStoryInfo(arg_1_2)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165StoryInfo, arg_1_2)
	end
end

function var_0_0.sendAct165GetInfoRequest(arg_2_0, arg_2_1)
	local var_2_0 = Activity165Module_pb.Act165GetInfoRequest()

	var_2_0.activityId = arg_2_1

	arg_2_0:sendMsg(var_2_0)
end

function var_0_0.onReceiveAct165GetInfoReply(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		Activity165Model.instance:onGetInfo(arg_3_2.activityId, arg_3_2.storyInfos)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165GetInfoReply, arg_3_2)
		Activity165Controller.instance:dispatchEvent(Activity165Event.refreshStoryReddot)
	end
end

function var_0_0.sendAct165ModifyKeywordRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = Activity165Module_pb.Act165ModifyKeywordRequest()

	var_4_0.activityId = arg_4_1
	var_4_0.storyId = arg_4_2

	for iter_4_0, iter_4_1 in pairs(arg_4_3) do
		var_4_0.keywordIds:append(iter_4_1)
	end

	arg_4_0:sendMsg(var_4_0)
end

function var_0_0.onReceiveAct165ModifyKeywordReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		Activity165Model.instance:onModifyKeywordCallback(arg_5_2.activityId, arg_5_2.storyInfo)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165ModifyKeywordReply, arg_5_2)
	end
end

function var_0_0.sendAct165GenerateEndingRequest(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = Activity165Module_pb.Act165GenerateEndingRequest()

	var_6_0.activityId = arg_6_1
	var_6_0.storyId = arg_6_2

	arg_6_0:sendMsg(var_6_0)
end

function var_0_0.onReceiveAct165GenerateEndingReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		Activity165Model.instance:onGenerateEnding(arg_7_2.activityId, arg_7_2.storyId, arg_7_2.endingInfo)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165GenerateEndingReply, arg_7_2)
	end
end

function var_0_0.sendAct165RestartRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = Activity165Module_pb.Act165RestartRequest()

	var_8_0.activityId = arg_8_1
	var_8_0.storyId = arg_8_2
	var_8_0.stepId = arg_8_3

	arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveAct165RestartReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		Activity165Model.instance:onRestart(arg_9_2.activityId, arg_9_2.storyInfo)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165RestartReply, arg_9_2)
	end
end

function var_0_0.sendAct165GainMilestoneRewardRequest(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = Activity165Module_pb.Act165GainMilestoneRewardRequest()

	var_10_0.activityId = arg_10_1
	var_10_0.storyId = arg_10_2

	arg_10_0:sendMsg(var_10_0)
end

function var_0_0.onReceiveAct165GainMilestoneRewardReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		Activity165Model.instance:onGetReward(arg_11_2.activityId, arg_11_2.storyId, arg_11_2.gainedEndingCount)
		Activity165Controller.instance:dispatchEvent(Activity165Event.Act165GainMilestoneRewardReply, arg_11_2)
		Activity165Controller.instance:dispatchEvent(Activity165Event.refreshStoryReddot)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
