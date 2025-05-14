module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.rpc.Activity116Rpc", package.seeall)

local var_0_0 = class("Activity116Rpc", BaseRpc)

function var_0_0.sendGet116InfosRequest(arg_1_0)
	local var_1_0 = Activity116Module_pb.Get116InfosRequest()

	var_1_0.activityId = VersionActivity1_2Enum.ActivityId.Building

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGet116InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		VersionActivity1_2DungeonModel.instance:onReceiveGet116InfosReply(arg_2_2)
	end
end

function var_0_0.onReceiveAct116InfoUpdatePush(arg_3_0, arg_3_1, arg_3_2)
	VersionActivity1_2DungeonModel.instance:onReceiveAct116InfoUpdatePush(arg_3_2)
end

function var_0_0.sendUpgradeElementRequest(arg_4_0, arg_4_1)
	local var_4_0 = Activity116Module_pb.UpgradeElementRequest()

	var_4_0.activityId = VersionActivity1_2Enum.ActivityId.Building
	var_4_0.elementId = arg_4_1

	arg_4_0:sendMsg(var_4_0)
end

function var_0_0.onReceiveUpgradeElementReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		VersionActivity1_2DungeonModel.instance:onReceiveUpgradeElementReply(arg_5_2)
	end
end

function var_0_0.sendBuildTrapRequest(arg_6_0, arg_6_1)
	local var_6_0 = Activity116Module_pb.BuildTrapRequest()

	var_6_0.activityId = VersionActivity1_2Enum.ActivityId.Building
	var_6_0.trapId = arg_6_1

	arg_6_0:sendMsg(var_6_0)
end

function var_0_0.onReceiveBuildTrapReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		VersionActivity1_2DungeonModel.instance:onReceiveBuildTrapReply(arg_7_2)
	end
end

function var_0_0.sendPutTrapRequest(arg_8_0, arg_8_1)
	local var_8_0 = Activity116Module_pb.PutTrapRequest()

	var_8_0.activityId = VersionActivity1_2Enum.ActivityId.Building
	var_8_0.trapId = arg_8_1

	arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceivePutTrapReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		VersionActivity1_2DungeonModel.instance:onReceivePutTrapReply(arg_9_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
