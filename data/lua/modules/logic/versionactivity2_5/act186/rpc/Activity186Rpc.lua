module("modules.logic.versionactivity2_5.act186.rpc.Activity186Rpc", package.seeall)

local var_0_0 = class("Activity186Rpc", BaseRpc)

function var_0_0.sendGetAct186InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity186Module_pb.GetAct186InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct186InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity186Model.instance:setActInfo(arg_2_2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.UpdateInfo)
	Activity186Controller.instance:dispatchEvent(Activity186Event.RefreshRed)
end

function var_0_0.sendFinishAct186TaskRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Activity186Module_pb.FinishAct186TaskRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.taskId = arg_3_2

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveFinishAct186TaskReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	Activity186Model.instance:onFinishAct186Task(arg_4_2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.FinishTask, arg_4_2)
end

function var_0_0.sendGetAct186MilestoneRewardRequest(arg_5_0, arg_5_1)
	local var_5_0 = Activity186Module_pb.GetAct186MilestoneRewardRequest()

	var_5_0.activityId = arg_5_1

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveGetAct186MilestoneRewardReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	Activity186Model.instance:onGetAct186MilestoneReward(arg_6_2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.GetMilestoneReward)
end

function var_0_0.sendGetAct186DailyCollectionRequest(arg_7_0, arg_7_1)
	local var_7_0 = Activity186Module_pb.GetAct186DailyCollectionRequest()

	var_7_0.activityId = arg_7_1

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveGetAct186DailyCollectionReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	Activity186Model.instance:onGetAct186DailyCollection(arg_8_2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.GetDailyCollection)
end

function var_0_0.onReceiveAct186TaskPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	Activity186Model.instance:onAct186TaskPush(arg_9_2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.UpdateTask)
end

function var_0_0.onReceiveAct186LikePush(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	Activity186Model.instance:onAct186LikePush(arg_10_2)
end

function var_0_0.sendFinishAct186ATypeGameRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = Activity186Module_pb.FinishAct186ATypeGameRequest()

	var_11_0.activityId = arg_11_1
	var_11_0.gameId = arg_11_2
	var_11_0.rewardId = arg_11_3

	arg_11_0:sendMsg(var_11_0)
end

function var_0_0.onReceiveFinishAct186ATypeGameReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	Activity186Model.instance:onFinishAct186Game(arg_12_2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.FinishGame)
end

function var_0_0.sendAct186BTypeGamePlayRequest(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = Activity186Module_pb.Act186BTypeGamePlayRequest()

	var_13_0.activityId = arg_13_1
	var_13_0.gameId = arg_13_2

	arg_13_0:sendMsg(var_13_0)
end

function var_0_0.onReceiveAct186BTypeGamePlayReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	Activity186Model.instance:onBTypeGamePlay(arg_14_2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.PlayGame)
end

function var_0_0.sendFinishAct186BTypeGameRequest(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = Activity186Module_pb.FinishAct186BTypeGameRequest()

	var_15_0.activityId = arg_15_1
	var_15_0.gameId = arg_15_2

	arg_15_0:sendMsg(var_15_0)
end

function var_0_0.onReceiveFinishAct186BTypeGameReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end

	Activity186Model.instance:onFinishAct186Game(arg_16_2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.FinishGame)
end

function var_0_0.sendGetAct186OnceBonusRequest(arg_17_0, arg_17_1)
	local var_17_0 = Activity186Module_pb.GetAct186OnceBonusRequest()

	var_17_0.activityId = arg_17_1

	arg_17_0:sendMsg(var_17_0)
end

function var_0_0.onReceiveGetAct186OnceBonusReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end

	Activity186Model.instance:onGetOnceBonusReply(arg_18_2)
	Activity186Controller.instance:dispatchEvent(Activity186Event.GetOnceBonus)
end

var_0_0.instance = var_0_0.New()

return var_0_0
