module("modules.logic.story.rpc.StoryRpc", package.seeall)

local var_0_0 = class("StoryRpc", BaseRpc)

function var_0_0.sendGetStoryRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = StoryModule_pb.GetStoryRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetStoryReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		StoryModel.instance:setStoryList(arg_2_2)
	end
end

function var_0_0.sendUpdateStoryRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = StoryModule_pb.UpdateStoryRequest()

	var_3_0.storyId = arg_3_1
	var_3_0.stepId = arg_3_2
	var_3_0.favor = arg_3_3

	StoryModel.instance:updateStoryList(var_3_0)
	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveUpdateStoryReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendGetStoryFinishRequest(arg_5_0, arg_5_1)
	local var_5_0 = StoryModule_pb.GetStoryFinishRequest()

	var_5_0.storyId = arg_5_1

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveGetStoryFinishReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveStoryFinishPush(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		StoryController.instance:setStoryFinished(arg_7_2.storyId)
		StoryController.instance:dispatchEvent(StoryEvent.FinishFromServer, arg_7_2.storyId)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
