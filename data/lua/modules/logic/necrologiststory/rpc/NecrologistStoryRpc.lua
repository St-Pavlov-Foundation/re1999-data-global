module("modules.logic.necrologiststory.rpc.NecrologistStoryRpc", package.seeall)

local var_0_0 = class("NecrologistStoryRpc", BaseRpc)

function var_0_0.onInit(arg_1_0)
	arg_1_0._sendTypeDict = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._sendTypeDict = nil

	TaskDispatcher.cancelTask(arg_2_0._delaySendUpdateInfo, arg_2_0)
end

function var_0_0.sendGetNecrologistStoryRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = NecrologistStoryModule_pb.GetNecrologistStoryRequest()

	var_3_0.storyId = arg_3_1 or 0

	return arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveGetNecrologistStoryReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		NecrologistStoryModel.instance:updateStoryInfos(arg_4_2.story)
	end
end

function var_0_0.sendUpdateNecrologistStoryRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if not arg_5_3 then
		if not arg_5_0._sendTypeDict then
			arg_5_0._sendTypeDict = {}
		end

		arg_5_0._sendTypeDict[arg_5_1] = arg_5_2

		TaskDispatcher.cancelTask(arg_5_0._delaySendUpdateInfo, arg_5_0)
		TaskDispatcher.runDelay(arg_5_0._delaySendUpdateInfo, arg_5_0, 0.1)

		return
	end

	return arg_5_0:_sendUpdateNecrologistStoryRequest(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
end

function var_0_0._sendUpdateNecrologistStoryRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = NecrologistStoryModule_pb.UpdateNecrologistStoryRequest()

	var_6_0.storyId = arg_6_1

	if arg_6_2 then
		arg_6_2:setNecrologistStoryRequest(var_6_0)
	end

	return arg_6_0:sendMsg(var_6_0, arg_6_3, arg_6_4)
end

function var_0_0.onReceiveUpdateNecrologistStoryReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		NecrologistStoryModel.instance:updateStoryInfo(arg_7_2)
	end
end

function var_0_0._delaySendUpdateInfo(arg_8_0)
	if arg_8_0._sendTypeDict then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._sendTypeDict) do
			arg_8_0:_sendUpdateNecrologistStoryRequest(iter_8_0, iter_8_1)
		end

		arg_8_0._sendTypeDict = nil
	end
end

function var_0_0.sendFinishNecrologistStoryModeRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = NecrologistStoryModule_pb.FinishNecrologistStoryModeRequest()

	var_9_0.storyId = arg_9_1
	var_9_0.modeId = arg_9_2

	return arg_9_0:sendMsg(var_9_0, arg_9_3, arg_9_4)
end

function var_0_0.onReceiveFinishNecrologistStoryModeReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		-- block empty
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
