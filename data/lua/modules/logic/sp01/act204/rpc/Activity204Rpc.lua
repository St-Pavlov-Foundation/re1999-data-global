module("modules.logic.sp01.act204.rpc.Activity204Rpc", package.seeall)

local var_0_0 = class("Activity204Rpc", BaseRpc)

function var_0_0.sendGetAct204InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity204Module_pb.GetAct204InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct204InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity204Model.instance:setActInfo(arg_2_2)
	Activity204Controller.instance:dispatchEvent(Activity204Event.UpdateInfo)
	Activity204Controller.instance:dispatchEvent(Activity204Event.RefreshRed)
end

function var_0_0.sendFinishAct204TaskRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Activity204Module_pb.FinishAct204TaskRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.taskId = arg_3_2

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveFinishAct204TaskReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	Activity204Model.instance:onFinishAct204Task(arg_4_2)
	Activity204Controller.instance:dispatchEvent(Activity204Event.FinishTask, arg_4_2)
end

function var_0_0.sendGetAct204MilestoneRewardRequest(arg_5_0, arg_5_1)
	local var_5_0 = Activity204Module_pb.GetAct204MilestoneRewardRequest()

	var_5_0.activityId = arg_5_1

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveGetAct204MilestoneRewardReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	Activity204Model.instance:onGetAct204MilestoneReward(arg_6_2)
	Activity204Controller.instance:dispatchEvent(Activity204Event.GetMilestoneReward)
end

function var_0_0.sendGetAct204DailyCollectionRequest(arg_7_0, arg_7_1)
	local var_7_0 = Activity204Module_pb.GetAct204DailyCollectionRequest()

	var_7_0.activityId = arg_7_1

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveGetAct204DailyCollectionReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	Activity204Model.instance:onGetAct204DailyCollection(arg_8_2)
	Activity204Controller.instance:dispatchEvent(Activity204Event.GetDailyCollection)
end

function var_0_0.onReceiveAct204TaskPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	Activity204Model.instance:onAct204TaskPush(arg_9_2)
	Activity204Controller.instance:dispatchEvent(Activity204Event.UpdateTask)
end

function var_0_0.sendGetAct204OnceBonusRequest(arg_10_0, arg_10_1)
	local var_10_0 = Activity204Module_pb.GetAct204OnceBonusRequest()

	var_10_0.activityId = arg_10_1

	arg_10_0:sendMsg(var_10_0)
end

function var_0_0.onReceiveGetAct204OnceBonusReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	Activity204Model.instance:onGetOnceBonusReply(arg_11_2)
	Activity204Controller.instance:dispatchEvent(Activity204Event.GetOnceBonus)
end

var_0_0.instance = var_0_0.New()

return var_0_0
