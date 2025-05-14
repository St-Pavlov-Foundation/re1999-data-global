module("modules.logic.bossrush.rpc.BossRushRpc", package.seeall)

local var_0_0 = class("BossRushRpc", Activity128Rpc)

function var_0_0.ctor(arg_1_0)
	Activity128Rpc.instance = arg_1_0
end

local function var_0_1(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activityId

	if not BossRushConfig.instance:checkActivityId(var_2_0) then
		return false
	end

	if arg_2_0 ~= 0 then
		return false
	end

	return true
end

function var_0_0.sendGet128InfosRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = BossRushConfig.instance:getActivityId()

	Activity128Rpc.sendGet128InfosRequest(arg_3_0, var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.sendAct128GetTotalRewardsRequest(arg_4_0, arg_4_1)
	local var_4_0 = BossRushConfig.instance:getActivityId()

	Activity128Rpc.sendAct128GetTotalRewardsRequest(arg_4_0, var_4_0, arg_4_1)
end

function var_0_0.sendAct128DoublePointRequest(arg_5_0, arg_5_1)
	local var_5_0 = BossRushConfig.instance:getActivityId()

	Activity128Rpc.sendAct128DoublePointRequest(arg_5_0, var_5_0, arg_5_1)
end

function var_0_0.sendAct128GetTotalSingleRewardRequest(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = BossRushConfig.instance:getActivityId()

	Activity128Rpc.sendAct128GetTotalSingleRewardRequest(arg_6_0, var_6_0, arg_6_1, arg_6_2)
end

function var_0_0._onReceiveGet128InfosReply(arg_7_0, arg_7_1, arg_7_2)
	if not var_0_1(arg_7_1, arg_7_2) then
		return
	end

	BossRushModel.instance:onReceiveGet128InfosReply(arg_7_2)
end

function var_0_0._onReceiveAct128GetTotalRewardsReply(arg_8_0, arg_8_1, arg_8_2)
	if not var_0_1(arg_8_1, arg_8_2) then
		return
	end

	BossRushModel.instance:onReceiveAct128GetTotalRewardsReply(arg_8_2)
end

function var_0_0._onReceiveAct128DoublePointReply(arg_9_0, arg_9_1, arg_9_2)
	if not var_0_1(arg_9_1, arg_9_2) then
		return
	end

	BossRushModel.instance:onReceiveAct128DoublePointReply(arg_9_2)
end

function var_0_0._onReceiveAct128InfoUpdatePush(arg_10_0, arg_10_1, arg_10_2)
	if not var_0_1(arg_10_1, arg_10_2) then
		return
	end

	BossRushModel.instance:onReceiveAct128InfoUpdatePush(arg_10_2)
end

function var_0_0._onReceiveAct128GetTotalSingleRewardReply(arg_11_0, arg_11_1, arg_11_2)
	if not var_0_1(arg_11_1, arg_11_2) then
		return
	end

	BossRushModel.instance:onReceiveAct128SingleRewardReply(arg_11_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
