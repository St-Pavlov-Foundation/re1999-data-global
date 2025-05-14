module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.rpc.Activity121Rpc", package.seeall)

local var_0_0 = class("Activity121Rpc", BaseRpc)

function var_0_0.sendGet121InfosRequest(arg_1_0)
	local var_1_0 = Activity121Module_pb.Get121InfosRequest()

	var_1_0.activityId = VersionActivityEnum.ActivityId.Act121

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGet121InfosReply(arg_2_0, arg_2_1, arg_2_2)
	VersionActivity1_2NoteModel.instance:onReceiveGet121InfosReply(arg_2_1, arg_2_2)
end

function var_0_0.sendGet121BonusRequest(arg_3_0, arg_3_1)
	local var_3_0 = Activity121Module_pb.Get121BonusRequest()

	var_3_0.activityId = VersionActivityEnum.ActivityId.Act121
	var_3_0.storyId = arg_3_1

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveGet121BonusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		VersionActivity1_2NoteModel.instance:onReceiveGet121BonusReply(arg_4_2)
	end
end

function var_0_0.onReceiveAct121UpdatePush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		VersionActivity1_2NoteModel.instance:onReceiveAct121UpdatePush(arg_5_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
