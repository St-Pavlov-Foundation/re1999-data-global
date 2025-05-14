module("modules.logic.activity.rpc.Activity101Rpc", package.seeall)

local var_0_0 = class("Activity101Rpc", BaseRpc)

function var_0_0.sendGet101InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity101Module_pb.Get101InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet101InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		ActivityType101Model.instance:setType101Info(arg_2_2)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshNorSignActivity)
	end
end

function var_0_0.sendGet101BonusRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity101Module_pb.Get101BonusRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveGet101BonusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		ActivityType101Model.instance:setBonusGet(arg_4_2)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshNorSignActivity)
	end
end

function var_0_0.sendGet101SpBonusRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity101Module_pb.Get101SpBonusRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.id = arg_5_2

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveGet101SpBonusReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		ActivityType101Model.instance:setSpBonusGet(arg_6_2)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshNorSignActivity)
	end
end

function var_0_0.sendGetAct186SpBonusInfoRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = Activity101Module_pb.GetAct186SpBonusInfoRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.act186ActivityId = arg_7_2

	arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveGetAct186SpBonusInfoReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		Activity186Model.instance:onGetAct186SpBonusInfo(arg_8_2)
		Activity186Controller.instance:dispatchEvent(Activity186Event.SpBonusStageChange)
	end
end

function var_0_0.sendAcceptAct186SpBonusRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = Activity101Module_pb.AcceptAct186SpBonusRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.act186ActivityId = arg_9_2

	arg_9_0:sendMsg(var_9_0, arg_9_3, arg_9_4)
end

function var_0_0.onReceiveAcceptAct186SpBonusReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		Activity186Model.instance:onAcceptAct186SpBonus(arg_10_2)
		Activity186Controller.instance:dispatchEvent(Activity186Event.SpBonusStageChange)
		Activity186Controller.instance:dispatchEvent(Activity186Event.RefreshRed)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
